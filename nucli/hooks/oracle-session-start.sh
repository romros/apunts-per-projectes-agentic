#!/usr/bin/env bash
# oracle-session-start.sh — SessionStart hook
# Oracle compara el seu MODEL.md amb l'estat real del projecte i injecta divergències.
#
# Instal·lació: copiar a .claude/hooks/session-start.sh (o afegir al session-start existent)
# No necessita registrar-se a settings.json — session-start.sh s'executa automàticament.

set -euo pipefail

ROOT="${CLAUDE_PROJECT_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
ORACLE_MEMORY="$ROOT/.claude/agent-memory/oracle"
MODEL="$ORACLE_MEMORY/MODEL.md"
PENDING="$ROOT/.claude/oracle-review-pending"

echo "=== ORACLE AUDIT ==="
echo ""

# 1. Oracle review pendent?
if [[ -f "$PENDING" ]]; then
  echo "🔴 ORACLE GATE ACTIU: Hi ha canvis arquitectònics pendents de revisió."
  echo "   Fitxers:"
  while IFS= read -r line; do
    echo "     - $line"
  done < "$PENDING"
  echo "   Invoca /oracle amb el context dels canvis."
  echo ""
fi

# 2. MODEL.md existent?
if [[ ! -f "$MODEL" ]]; then
  echo "⚠️ Oracle no té MODEL.md. El sistema arquitectònic no té memòria viva."
  echo "   Crea .claude/agent-memory/oracle/MODEL.md (plantilla a nucli/plantilles/oracle-memory/)"
  echo ""
else
  # 3. Agents nous no al MODEL?
  AGENTS_DIR="$ROOT/.claude/agents"
  if [[ -d "$AGENTS_DIR" ]]; then
    NEW_AGENTS=""
    while IFS= read -r agent_file; do
      agent_name=$(basename "$agent_file" .md)
      if ! grep -q "$agent_name" "$MODEL" 2>/dev/null; then
        NEW_AGENTS="$NEW_AGENTS $agent_name"
      fi
    done < <(find "$AGENTS_DIR" -name "*.md" -type f)

    if [[ -n "$NEW_AGENTS" ]]; then
      echo "⚠️ Agents no reflectits al MODEL.md d'oracle:$NEW_AGENTS"
      echo "   Considera actualitzar .claude/agent-memory/oracle/MODEL.md"
      echo ""
    fi
  fi

  # 4. Última actualització del MODEL
  if command -v git &>/dev/null && git -C "$ROOT" rev-parse HEAD &>/dev/null; then
    LAST_MODEL_COMMIT=$(git -C "$ROOT" log --oneline -1 -- ".claude/agent-memory/oracle/MODEL.md" 2>/dev/null | head -1)
    if [[ -z "$LAST_MODEL_COMMIT" ]]; then
      echo "ℹ️ MODEL.md existeix però mai s'ha commitejat. Considera fer-ho per tenir traçabilitat."
      echo ""
    fi
  fi
fi

# 5. Report d'auditoria cron recent?
AUDITS_DIR="$ROOT/.claude/agent-memory/oracle/audits"
if [[ -d "$AUDITS_DIR" ]]; then
  LATEST_AUDIT=$(ls "$AUDITS_DIR"/*.md 2>/dev/null | sort -r | head -1)
  if [[ -n "$LATEST_AUDIT" ]]; then
    AUDIT_DATE=$(basename "$LATEST_AUDIT" .md)
    AUDIT_AGE_DAYS=$(( ( $(date +%s) - $(date -d "$AUDIT_DATE" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$AUDIT_DATE" +%s 2>/dev/null || echo 0) ) / 86400 ))
    if [[ "$AUDIT_AGE_DAYS" -le 2 ]]; then
      echo "📋 Auditoria oracle recent ($AUDIT_DATE):"
      grep -E "^(REVISAR|TENSIONS|NET|Auditoria)" "$LATEST_AUDIT" | head -3 | sed 's/^/   /'
      echo ""
    fi
  fi
fi

echo "=== FI ORACLE AUDIT ==="
