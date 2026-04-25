#!/usr/bin/env bash
# process-flash: flash.jsonl → short-term.csv (determinista, 0 tokens LLM)

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BASE="$ROOT/.claude/agent-memory"
FLASH="$BASE/flash.jsonl"
SHORT_TERM="$BASE/short-term.csv"
ARCHIVE_DIR="$BASE/flash-archive"
THRESHOLD=${FLASH_THRESHOLD:-20}

mkdir -p "$ARCHIVE_DIR"
mkdir -p "$BASE/logs"
mkdir -p "$BASE/proposals"

# Si no hi ha flash o és buit, sortir
[[ ! -f "$FLASH" ]] && echo "[process-flash] flash.jsonl no existeix, res a fer" && exit 0
[[ ! -s "$FLASH" ]] && echo "[process-flash] flash.jsonl buit, res a fer" && exit 0

LINES=$(wc -l < "$FLASH")
echo "[process-flash] processant $LINES entrades de flash.jsonl"

BASE="$BASE" FLASH_THRESHOLD="$THRESHOLD" python3 << 'PYEOF'
import json, csv, hashlib, os, sys
from pathlib import Path
from datetime import datetime, timezone
from collections import Counter

base = Path(os.environ.get('BASE', '.claude/agent-memory'))
flash_path = base / 'flash.jsonl'
short_term_path = base / 'short-term.csv'
archive_dir = base / 'flash-archive'
threshold = int(os.environ.get('FLASH_THRESHOLD', '20'))
DECAY_DAYS = int(os.environ.get('FLASH_DECAY_DAYS', '30'))

# --- Llegir flash ---
entries = []
with open(flash_path) as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        try:
            entries.append(json.loads(line))
        except json.JSONDecodeError:
            print(f"[process-flash] WARN: línia invàlida ignorada: {line[:60]}", file=sys.stderr)

if not entries:
    print("[process-flash] cap entrada vàlida al flash")
    sys.exit(0)

# --- Llegir short-term existent ---
existing = []
existing_hashes = set()
if short_term_path.exists():
    with open(short_term_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            existing.append(row)
            existing_hashes.add(row.get('session_hash', ''))

# --- Deduplicar per hash de content ---
new_entries = []
for e in entries:
    content_hash = hashlib.md5(
        f"{e.get('agent','')}{e.get('content','')}".encode()
    ).hexdigest()[:8]
    if content_hash not in existing_hashes:
        new_entries.append({
            'ts': e.get('ts', datetime.now(timezone.utc).isoformat() + 'Z'),
            'agent': e.get('agent', 'unknown'),
            'content': e.get('content', ''),
            'tags': ','.join(e.get('tags', [])),
            'session_hash': content_hash,
            'consolidated': 'false'
        })
        existing_hashes.add(content_hash)

print(f"[process-flash] {len(entries)} entrades flash → {len(new_entries)} noves (dedup eliminà {len(entries)-len(new_entries)})")

# --- Decay: NOMÉS entrades ja consolidades ---
now = datetime.now(timezone.utc)
decayed = []
surviving = []
force_consolidate_agents = set()

for row in existing:
    is_consolidated = row.get('consolidated', 'false') == 'true'
    try:
        ts_str = row['ts'].replace('Z', '+00:00')
        age_days = (now - datetime.fromisoformat(ts_str)).days
    except Exception:
        surviving.append(row)
        continue

    if is_consolidated and age_days > DECAY_DAYS:
        decayed.append(row)
    elif not is_consolidated and age_days > DECAY_DAYS:
        surviving.append(row)
        force_consolidate_agents.add(row.get('agent', 'unknown'))
    else:
        surviving.append(row)

if decayed:
    print(f"[process-flash] decay: {len(decayed)} entrades consolidades eliminades (>{DECAY_DAYS} dies)")
if force_consolidate_agents:
    for agent in force_consolidate_agents:
        print(f"[process-flash] FORCE_CONSOLIDATE:{agent} — entrades >30 dies sense consolidar")

existing = surviving

# --- Escriure short-term.csv ---
all_entries = existing + new_entries
fieldnames = ['ts', 'agent', 'content', 'tags', 'session_hash', 'consolidated']

for row in all_entries:
    if 'consolidated' not in row:
        row['consolidated'] = 'false'

with open(short_term_path, 'w', newline='') as f:
    writer = csv.DictWriter(f, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(all_entries)

# --- Detectar agents que superen el llindar (no consolidades) ---
agent_unconsolidated = Counter(
    r['agent'] for r in all_entries
    if r.get('consolidated', 'false') == 'false'
)
for agent, count in agent_unconsolidated.items():
    if count >= threshold:
        print(f"CONSOLIDATE:{agent}")

# --- Arxivar flash ---
ts = datetime.now(timezone.utc).strftime('%Y-%m-%d-%H-%M')
archive_path = archive_dir / f"{ts}.jsonl"
import shutil
shutil.move(str(flash_path), str(archive_path))
flash_path.touch()
print(f"[process-flash] flash arxivat a flash-archive/{ts}.jsonl")

PYEOF
