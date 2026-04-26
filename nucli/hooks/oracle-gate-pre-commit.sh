#!/usr/bin/env bash
# oracle-gate-pre-commit.sh — PreToolUse hook per a git commit
# Bloqueja el commit si hi ha canvis arquitectònics pendents de revisió oracle.
#
# Instal·lació: copiar a .claude/hooks/oracle-gate-pre-commit.sh
# Registrar a .claude/settings.json (veure settings-example.json)

set -euo pipefail

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")
COMMAND=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")

# Només per a Bash amb git commit
if [[ "$TOOL_NAME" != "Bash" ]]; then
  exit 0
fi

if ! echo "$COMMAND" | grep -qE "^git commit"; then
  exit 0
fi

ROOT="${CLAUDE_PROJECT_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
MARKER="$ROOT/.claude/oracle-review-pending"

if [[ -f "$MARKER" ]]; then
  PENDING_FILES=$(cat "$MARKER" | sort -u | tr '\n' ', ' | sed 's/,$//')

  python3 -c "
import json
print(json.dumps({
  'hookSpecificOutput': {
    'hookEventName': 'PreToolUse',
    'permissionDecision': 'deny',
    'permissionDecisionReason': '🔴 ORACLE GATE: Hi ha canvis arquitectònics pendents de revisió. Fitxers: ${PENDING_FILES}. Invoca /oracle amb el context dels canvis. Quan hagis consultat i registrat la decisió a docs/decisions.md, executa: rm .claude/oracle-review-pending'
  }
}))
"
  exit 0
fi

exit 0
