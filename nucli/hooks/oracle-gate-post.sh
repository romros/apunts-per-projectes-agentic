#!/usr/bin/env bash
# oracle-gate-post.sh — PostToolUse hook
# Detecta canvis a fitxers arquitectònics i marca revisió oracle pendent.
#
# Instal·lació: copiar a .claude/hooks/oracle-gate-post.sh
# Registrar a .claude/settings.json (veure settings-example.json)

set -euo pipefail

# Llegir JSON de stdin
INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Només per a Edit i Write
if [[ "$TOOL_NAME" != "Edit" && "$TOOL_NAME" != "Write" ]]; then
  exit 0
fi

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Patrons arquitectònics — CUSTOMITZA AL CLAUDE.md DEL PROJECTE
# Afegeix o elimina patrons segons el teu projecte
ARCH_PATTERNS=(
  ".claude/agents/"    # Agents del sistema
  "domain/"            # Contractes de domini
  "CLAUDE.md"          # Invariants i regles del projecte
  "contracts/"         # Contractes explícits (si aplica)
)

IS_ARCH=false
MATCHED_PATTERN=""
for pattern in "${ARCH_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -q "$pattern"; then
    IS_ARCH=true
    MATCHED_PATTERN="$pattern"
    break
  fi
done

if [[ "$IS_ARCH" == "true" ]]; then
  # Marcar revisió oracle com a pendent
  ROOT="${CLAUDE_PROJECT_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
  MARKER="$ROOT/.claude/oracle-review-pending"
  echo "$FILE_PATH" >> "$MARKER"

  # Injectar advertència al context
  python3 -c "
import json
print(json.dumps({
  'hookSpecificOutput': {
    'hookEventName': 'PostToolUse',
    'additionalContext': '⚠️ ORACLE GATE: Has modificat un fitxer arquitectònic (${FILE_PATH}). Consulta oracle amb /oracle abans del commit. Quan hagis consultat, executa: rm .claude/oracle-review-pending'
  }
}))
"
fi

exit 0
