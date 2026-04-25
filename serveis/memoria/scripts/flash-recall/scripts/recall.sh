#!/usr/bin/env bash
# flash-recall: recupera context de memòria per a un agent
# Mostra: session checkpoint (si fresc) + skills actuals + short-term recent
# Ús: recall.sh --agent <nom> [--limit 10]

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
MEMORY_BASE="$ROOT/.claude/agent-memory"
SHORT_TERM="$MEMORY_BASE/short-term.csv"

AGENT=""
LIMIT=10

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent) AGENT="$2"; shift 2 ;;
    --limit) LIMIT="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

[[ -z "$AGENT" ]] && echo "Error: --agent required" >&2 && exit 1

CHECKPOINT="$MEMORY_BASE/checkpoints/$AGENT-current.md"

echo "=== MEMORY BRIEFING: $AGENT ==="
echo ""

# --- Session checkpoint (si existeix i és fresc <24h) ---
if [[ -f "$CHECKPOINT" ]]; then
  python3 << PYEOF
import re, subprocess
from datetime import datetime, timezone

with open('$CHECKPOINT') as f:
    content = f.read()

ts_match = re.search(r'\*\*Escrit:\*\* (.+)', content)
head_match = re.search(r'head_commit: (\w+)', content)

if ts_match:
    ts_str = ts_match.group(1).strip()
    try:
        ts = datetime.fromisoformat(ts_str.replace('Z', '+00:00'))
        age_hours = (datetime.now(timezone.utc) - ts).total_seconds() / 3600
    except:
        age_hours = 0

    # Commits de distància
    commit_distance = 0
    if head_match:
        try:
            r = subprocess.run(
                ['git', 'rev-list', '--count', f'{head_match.group(1)}..HEAD'],
                capture_output=True, text=True, cwd='$ROOT'
            )
            commit_distance = int(r.stdout.strip()) if r.returncode == 0 else 0
        except:
            pass

    if age_hours <= 24:
        if commit_distance >= 5:
            label = f"STALE ({commit_distance} commits nous)"
        else:
            label = f"FRESC ({commit_distance} commits nous)"
        print(f"## Session Checkpoint [{label}]")
        in_body = False
        for line in content.split('\n'):
            if line.startswith('# Session Checkpoint'):
                in_body = True
            if in_body:
                print(f"  {line}")
        print("")
PYEOF
fi

# --- Skills actuals ---
MEMORY_MD="$MEMORY_BASE/$AGENT/MEMORY.md"
if [[ -f "$MEMORY_MD" ]]; then
  echo "## Skills actuals"
  grep '^\- \[' "$MEMORY_MD" | while IFS= read -r line; do
    echo "  $line"
  done || true
  echo ""
else
  echo "## Skills actuals: cap MEMORY.md trobat per agent '$AGENT'"
  echo ""
fi

# --- Short-term recent ---
if [[ -f "$SHORT_TERM" ]]; then
  COUNT=$(python3 -c "
import csv
with open('$SHORT_TERM') as f:
    rows = [r for r in csv.DictReader(f) if r.get('agent','') == '$AGENT']
print(len(rows))
")
  echo "## Short-term recent (últimes $LIMIT de $COUNT entrades per $AGENT)"
  python3 -c "
import csv
with open('$SHORT_TERM') as f:
    rows = [r for r in csv.DictReader(f) if r.get('agent','') == '$AGENT']
for row in rows[-$LIMIT:]:
    tags = row.get('tags','')
    tag_str = ' [' + tags + ']' if tags else ''
    print(f\"  [{row['ts']}]{tag_str} {row['content']}\")
"
else
  echo "## Short-term: buit"
fi

# --- Conflictes pendents de resolució ---
PROPOSALS_DIR="$MEMORY_BASE/proposals"
if [[ -d "$PROPOSALS_DIR" ]]; then
  CONFLICTS=$(grep -rl "status: CONFLICT" "$PROPOSALS_DIR" 2>/dev/null | wc -l) || true
  if [[ "$CONFLICTS" -gt 0 ]]; then
    echo "## CONFLICTES DE MEMÒRIA PENDENTS ($CONFLICTS)"
    python3 << PYEOF
import os, re
from pathlib import Path
from datetime import datetime, timezone

proposals_dir = Path('$PROPOSALS_DIR')
now = datetime.now(timezone.utc)
oldest_days = 0

for f in sorted(proposals_dir.glob('*.md')):
    content = f.read_text()
    if 'status: CONFLICT' not in content:
        continue
    agent = re.search(r'^agent:\s*(.+)', content, re.MULTILINE)
    skill = re.search(r'^skill:\s*(.+)', content, re.MULTILINE)
    ts = re.search(r'^ts:\s*(.+)', content, re.MULTILINE)
    agent_s = agent.group(1).strip() if agent else '?'
    skill_s = skill.group(1).strip() if skill else '?'
    age_str = ''
    if ts:
        try:
            t = datetime.fromisoformat(ts.group(1).strip().replace('Z', '+00:00'))
            days = (now - t).days
            oldest_days = max(oldest_days, days)
            age_str = f' ({days}d)'
        except:
            pass
    print(f'  - [{agent_s}/{skill_s}]{age_str} {f.name}')

if oldest_days >= 7:
    print(f'  El més antic porta {oldest_days} dies sense resoldre')
PYEOF
    echo "  → Resol amb: @mem-curator conflictes"
    echo ""
  fi
fi

# --- Claude Code auto-memory (MEMORY.md) ---
ESCAPED_ROOT=$(echo "$ROOT" | sed 's|[/_]|-|g')
CLAUDE_MEMORY="$HOME/.claude/projects/$ESCAPED_ROOT/memory/MEMORY.md"
if [[ -f "$CLAUDE_MEMORY" ]]; then
  echo "## Claude Code Memory (context global)"
  cat "$CLAUDE_MEMORY"
  echo ""
fi

echo ""
echo "=== END BRIEFING ==="
