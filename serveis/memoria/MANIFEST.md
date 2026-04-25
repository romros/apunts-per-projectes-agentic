# Servei Memòria

## Descripció

Pipeline de memòria persistent per a agents Claude Code. Permet que els agents recordin decisions, preferències i lliçons entre sessions, sense cap MCP extern — tot és local, basat en fitxers, git-trackeable.

**Obligatori per a qualsevol projecte que usa els agents base.** Sense memòria, els agents comencen de zero a cada sessió.

**Compatibilitat**: Unix/Mac/Linux natiu. Windows requereix Git Bash o WSL. Els scripts detecten `python3` o `python` automàticament. Si descarregues els scripts via PowerShell, assegura't que es guarden sense BOM (UTF-8 sense BOM); si no, usa `curl` des de Git Bash.

---

## Arquitectura

```
.claude/agent-memory/
├── flash.jsonl          ← escriptura concurrent (agents → aquí, atòmica)
├── short-term.csv       ← processada (0 tokens LLM, cron cada 5 min)
├── flash-archive/       ← arxiu de flash processats
├── logs/                ← logs del procés automàtic
├── shared/
│   ├── flash-remember/scripts/remember.sh   ← com escriure memòria
│   └── flash-recall/scripts/recall.sh       ← com llegir context
└── <agent>/
    ├── MEMORY.md        ← índex de skills de l'agent
    └── <skill>/
        └── SKILL.md     ← memòria a llarg termini
```

**Pipeline**: `flash.jsonl` → (cron 5min, 0 tokens) → `short-term.csv` → (mem-curator, LLM) → `skills/SKILL.md`

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/mem-curator.md` | `.claude/agents/mem-curator.md` |
| `scripts/flash-remember/scripts/remember.sh` | `.claude/agent-memory/shared/flash-remember/scripts/remember.sh` |
| `scripts/flash-recall/scripts/recall.sh` | `.claude/agent-memory/shared/flash-recall/scripts/recall.sh` |
| `scripts/process-flash/scripts/process-flash.sh` | `.claude/agent-memory/mem-curator/process-flash/scripts/process-flash.sh` |
| `scripts/check-threshold/scripts/check-threshold.sh` | `.claude/agent-memory/mem-curator/consolidate/scripts/check-threshold.sh` |

---

## Dependències

Cap. El Servei Memòria no depèn d'altres serveis.

---

## Activació manual

```bash
# 1. Crear estructura de directoris
mkdir -p .claude/agent-memory/shared/flash-remember/scripts
mkdir -p .claude/agent-memory/shared/flash-recall/scripts
mkdir -p .claude/agent-memory/mem-curator/process-flash/scripts
mkdir -p .claude/agent-memory/mem-curator/consolidate/scripts
mkdir -p .claude/agent-memory/flash-archive
mkdir -p .claude/agent-memory/logs
mkdir -p .claude/agents

# 2. Copiar scripts (des del path del servei o des de la URL raw del repo)
cp <path-servei>/scripts/flash-remember/scripts/remember.sh \
   .claude/agent-memory/shared/flash-remember/scripts/remember.sh
cp <path-servei>/scripts/flash-recall/scripts/recall.sh \
   .claude/agent-memory/shared/flash-recall/scripts/recall.sh
cp <path-servei>/scripts/process-flash/scripts/process-flash.sh \
   .claude/agent-memory/mem-curator/process-flash/scripts/process-flash.sh
cp <path-servei>/scripts/check-threshold/scripts/check-threshold.sh \
   .claude/agent-memory/mem-curator/consolidate/scripts/check-threshold.sh

# 3. Fer els scripts executables
chmod +x .claude/agent-memory/shared/flash-remember/scripts/remember.sh
chmod +x .claude/agent-memory/shared/flash-recall/scripts/recall.sh
chmod +x .claude/agent-memory/mem-curator/process-flash/scripts/process-flash.sh
chmod +x .claude/agent-memory/mem-curator/consolidate/scripts/check-threshold.sh

# 4. Inicialitzar fitxers de dades
touch .claude/agent-memory/flash.jsonl
echo "ts,agent,content,tags,session_hash,consolidated" \
  > .claude/agent-memory/short-term.csv

# 5. Copiar agent
cp <path-servei>/agents/mem-curator.md .claude/agents/mem-curator.md

# 6. (Opcional) Configurar cron per a process-flash cada 5 minuts
# crontab -e → afegir:
# */5 * * * * cd /path/al/projecte && bash .claude/agent-memory/mem-curator/process-flash/scripts/process-flash.sh >> .claude/agent-memory/logs/cron.log 2>&1
```

---

## Com usen la memòria els agents

```bash
# Escriure memòria (des de qualsevol agent)
bash .claude/agent-memory/shared/flash-remember/scripts/remember.sh \
  --agent <nom-agent> --content "<text>" --tags "<tag1,tag2>"

# Llegir context (a l'inici de sessió)
bash .claude/agent-memory/shared/flash-recall/scripts/recall.sh --agent <nom-agent>
```

**Quan recordar**: preferències de l'usuari, decisions consolidades, lliçons apreses, convencions descobertes al projecte.

**Quan NO recordar**: coses derivables llegint fitxers, estat efímer de la sessió, duplicats.

---

## Inicialització per agent

Per cada agent nou al projecte, crea:

```bash
mkdir -p .claude/agent-memory/<nom-agent>
echo "# Memory Index — <nom-agent>\n\n(Buit. S'omplirà a mesura que mem-curator consolidi lliçons.)" \
  > .claude/agent-memory/<nom-agent>/MEMORY.md
```
