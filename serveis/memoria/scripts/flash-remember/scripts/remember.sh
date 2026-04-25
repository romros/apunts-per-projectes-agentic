#!/usr/bin/env bash
# flash-remember: append atòmic a flash.jsonl
# Ús: remember.sh --agent <nom> --content "<text>" [--tags "<tag1,tag2>"]

set -euo pipefail

FLASH_FILE="$(git rev-parse --show-toplevel)/.claude/agent-memory/flash.jsonl"

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
