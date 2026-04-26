#!/usr/bin/env bash
# oracle-audit.sh — Cron arquitectònic (Capa 5)
# Oracle revisa el sistema entre sessions i deixa un report per a la propera.
#
# Configuració cron (Linux/Mac):
#   0 9 * * * cd /path/al/projecte && bash .claude/agent-memory/oracle/scripts/oracle-audit.sh
#
# Windows: afegir com a Task Scheduler amb Git Bash
#
# Prerequisit: claude CLI instal·lada i autenticada
# Ref: https://code.claude.com/docs/en/model-config

set -euo pipefail

ROOT="${CLAUDE_PROJECT_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
ORACLE_MEMORY="$ROOT/.claude/agent-memory/oracle"
AUDITS_DIR="$ORACLE_MEMORY/audits"
TODAY=$(date +"%Y-%m-%d")
REPORT="$AUDITS_DIR/$TODAY.md"
MARKER="$ROOT/.claude/oracle-review-pending"

mkdir -p "$AUDITS_DIR"

# Verificar que claude CLI existeix
if ! command -v claude &>/dev/null; then
  echo "[oracle-audit] claude CLI no trobada. Instal·la Claude Code per usar el cron arquitectònic." >&2
  exit 1
fi

# Condició per executar l'auditoria (B — reformulada per oracle)
# Surt sense cridar claude si: cap commit nou + cap predicció vençuda + cap agent nou
LAST_AUDIT_FILE=$(ls "$AUDITS_DIR"/*.md 2>/dev/null | sort -r | head -1)
SKIP=true

if command -v git &>/dev/null && git -C "$ROOT" rev-parse HEAD &>/dev/null; then
  if [[ -n "$LAST_AUDIT_FILE" ]]; then
    LAST_AUDIT_DATE=$(basename "$LAST_AUDIT_FILE" .md)
    # Commits des de l'última auditoria?
    COMMITS_SINCE=$(git -C "$ROOT" log --since="$LAST_AUDIT_DATE" --oneline 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$COMMITS_SINCE" -gt 0 ]]; then SKIP=false; fi

    # Agents modificats des de l'última auditoria?
    AGENTS_MODIFIED=$(git -C "$ROOT" diff --name-only HEAD~"$COMMITS_SINCE" HEAD 2>/dev/null | grep ".claude/agents/" | wc -l | tr -d ' ')
    if [[ "$AGENTS_MODIFIED" -gt 0 ]]; then SKIP=false; fi
  else
    SKIP=false  # Primera execució — sempre auditar
  fi
fi

# Prediccions vençudes?
if [[ -f "$ORACLE_MEMORY/PREDICTIONS.md" ]]; then
  if grep -q "$(date +"%Y-%m")" "$ORACLE_MEMORY/PREDICTIONS.md" 2>/dev/null; then
    SKIP=false
  fi
fi

if [[ "$SKIP" == "true" ]]; then
  echo "[oracle-audit] Cap canvi des de l'última auditoria. Saltant (0 tokens)."
  exit 0
fi

# Construir el prompt d'auditoria
PROMPT=$(cat <<'EOF'
Ets oracle, l'agent de criteri arquitectònic del projecte. Fas una auditoria autònoma del sistema.

Llegeix:
1. `.claude/agent-memory/oracle/MODEL.md` — el teu model actual del sistema
2. Els fitxers de `.claude/agents/` modificats en els últims 7 dies
3. `docs/decisions.md` si existeix

Fes:
1. Compara el MODEL.md amb l'estat real del codi. Hi ha divergències?
2. Hi ha tensions noves que no estan al MODEL.md ni a docs/decisions.md?
3. Hi ha alguna decisió a PREDICTIONS.md que pots revisar?

Escriu un report breu (màx 20 línies) amb:
- Divergències detectades (si n'hi ha)
- Tensions noves (si n'hi ha)
- Actualitzacions recomanades al MODEL.md (si cal)
- Estat general: NET / TENSIONS MENORS / REVISAR

Si tot està bé, escriu simplement: "Auditoria [data]: NET. Cap divergència detectada."
EOF
)

# Executar oracle en mode no-interactiu
echo "[oracle-audit] Executant auditoria arquitectònica ($TODAY)..."
RESULT=$(cd "$ROOT" && claude --model sonnet -p "$PROMPT" 2>/dev/null || echo "ERROR: No s'ha pogut executar l'auditoria")

# Guardar report
cat > "$REPORT" <<REPORT_EOF
# Auditoria Oracle — $TODAY

$RESULT
REPORT_EOF

echo "[oracle-audit] Report guardat a: $REPORT"

# Si el report conté "REVISAR", crear marca per al SessionStart
if echo "$RESULT" | grep -q "REVISAR"; then
  echo "oracle-audit-$TODAY" >> "$MARKER"
  echo "[oracle-audit] Tensió detectada — marcada per al proper SessionStart"
fi

# Commit del report
if command -v git &>/dev/null && git -C "$ROOT" rev-parse HEAD &>/dev/null; then
  git -C "$ROOT" add "$REPORT"
  git -C "$ROOT" commit -m "audit(oracle): auditoria arquitectònica $TODAY" --no-verify 2>/dev/null || true
fi

echo "[oracle-audit] Completat."
