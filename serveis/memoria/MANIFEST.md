```yaml
servei: memoria
categoria: infraestructura
depen_de: []
depen_de_recomanat: []
incompatible_amb: []
requisits_projecte: []
aporta_agents:
  - mem-curator
aporta_commands: []
aporta_skills: []
escriu_a:
  - .claude/agent-memory/
```

# Servei Memòria

## Descripció

Pipeline de memòria persistent per a agents Claude Code. Permet que els agents recordin decisions, preferències i lliçons entre sessions, sense cap MCP extern — tot és local, basat en fitxers.

**Obligatori per a qualsevol projecte que usa els agents base.** Sense memòria, els agents comencen de zero a cada sessió.

**Compatibilitat**: qualsevol entorn on corri Claude Code. No requereix bash, cron ni cap eina del sistema operatiu — els agents escriuen directament als fitxers.

---

## Arquitectura

```
.claude/agent-memory/
├── flash.jsonl       ← cua d'escriptura (agents → aquí)
├── short-term.csv    ← processada per mem-curator
├── flash-archive/    ← arxiu de flash processats
└── <agent>/
    ├── MEMORY.md     ← índex de skills de l'agent
    └── <skill>/
        └── SKILL.md  ← memòria a llarg termini
```

**Pipeline**: `flash.jsonl` → (mem-curator quan cal) → `short-term.csv` → (mem-curator, LLM) → `skills/SKILL.md`

---

## Com escriure memòria (qualsevol agent)

Afegeix una línia JSON a `.claude/agent-memory/flash.jsonl` amb l'eina Write/Edit:

```json
{"ts": "2026-04-25T10:00:00Z", "agent": "NOM_AGENT", "content": "TEXT A RECORDAR", "tags": ["tag1", "tag2"]}
```

**Regla**: abans d'escriure, comprova quantes entrades té `flash.jsonl`. Si supera 20, invoca `@mem-curator` per consolidar primer.

**Quan recordar**: preferències de l'usuari, decisions consolidades, lliçons apreses, convencions descobertes.

**Quan NO recordar**: coses derivables llegint fitxers, estat efímer de la sessió, duplicats de coses ja consolidades.

---

## Com llegir context (qualsevol agent)

Al inici de sessió, llegeix directament:

1. `.claude/agent-memory/<agent>/MEMORY.md` — índex de skills (llarg termini)
2. Les últimes files de `.claude/agent-memory/short-term.csv` on `agent=<nom>` (recent)

```
Camps de short-term.csv: ts, agent, content, tags, session_hash, consolidated
```

---

## Quan consolidar

Invoca `@mem-curator` quan:
- `flash.jsonl` supera 20 entrades
- L'usuari ho demana explícitament
- Al final d'una sessió llarga amb moltes escriptures

El mem-curator llegeix `flash.jsonl`, processa, escriu a `short-term.csv`, i consolida en skills quan cal.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/mem-curator.md` | `.claude/agents/mem-curator.md` |

---

## Dependències

Cap.

---

## Activació ràpida

Enganxa a Claude Code:

```
Instal·la el Servei Memòria: crea .claude/agent-memory/ amb flash.jsonl buit i short-term.csv amb capçalera (ts,agent,content,tags,session_hash,consolidated). Copia l'agent: https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/serveis/memoria/agents/mem-curator.md → .claude/agents/mem-curator.md. Crea .claude/agent-memory/mem-curator/MEMORY.md buit.
```

---

## Inicialització per agent nou

Per cada agent nou, crea:

```
.claude/agent-memory/<nom-agent>/MEMORY.md
```

Contingut inicial: `# Memory Index — <nom-agent>\n\n(Buit.)`

---

## Scripts bash opcionals (Unix/Linux/Mac)

Per a projectes que volen automatització via cron, els scripts originals estan a `extras/scripts-bash-unix/`. No son necessaris per al funcionament bàsic.
