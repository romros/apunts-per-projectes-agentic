#!/usr/bin/env bash
# check-threshold: comprova si algun agent supera el llindar a short-term.csv
# Emet "CONSOLIDATE:<agent>" per cada agent que supera el llindar
# Exit 0 si cal consolidar, exit 1 si no cal

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
SHORT_TERM="$ROOT/.claude/agent-memory/short-term.csv"
THRESHOLD=${FLASH_THRESHOLD:-20}

[[ ! -f "$SHORT_TERM" ]] && exit 1

python3 << PYEOF
import csv, sys, os
from collections import Counter

threshold = int(os.environ.get('FLASH_THRESHOLD', '20'))
short_term = '$SHORT_TERM'

with open(short_term) as f:
    rows = list(csv.DictReader(f))

# Comptar només entrades no consolidades
counts = Counter(
    r['agent'] for r in rows
    if r.get('consolidated', 'false') == 'false'
)

needs_consolidation = False
for agent, count in sorted(counts.items()):
    if count >= threshold:
        print(f"CONSOLIDATE:{agent}")
        needs_consolidation = True

sys.exit(0 if needs_consolidation else 1)
PYEOF
