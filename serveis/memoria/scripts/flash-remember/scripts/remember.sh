#!/usr/bin/env bash
# flash-remember: append atòmic a flash.jsonl
# Ús: remember.sh --agent <nom> --content "<text>" [--tags "<tag1,tag2>"]

set -euo pipefail

# Troba el root del projecte: git si disponible, fallback a CLAUDE_PROJECT_ROOT o directori actual
if git rev-parse --show-toplevel 2>/dev/null; then
  ROOT="$(git rev-parse --show-toplevel)"
else
  ROOT="${CLAUDE_PROJECT_ROOT:-$(pwd)}"
fi
FLASH_FILE="$ROOT/.claude/agent-memory/flash.jsonl"

# Parse args
AGENT=""
CONTENT=""
TAGS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)   AGENT="$2";   shift 2 ;;
    --content) CONTENT="$2"; shift 2 ;;
    --tags)    TAGS="$2";    shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

[[ -z "$AGENT" ]]   && echo "Error: --agent required" >&2 && exit 1
[[ -z "$CONTENT" ]] && echo "Error: --content required" >&2 && exit 1

TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Escriu JSON en una sola línia (append atòmic)
python3 -c "
import json, sys
entry = {
    'ts': '$TS',
    'agent': '$AGENT',
    'content': sys.argv[1],
    'tags': [t.strip() for t in '$TAGS'.split(',') if t.strip()]
}
print(json.dumps(entry, ensure_ascii=False))
" "$CONTENT" >> "$FLASH_FILE"

echo "OK: flash escrit [agent=$AGENT tags=$TAGS]"
