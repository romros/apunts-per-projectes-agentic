---
servei: okr
categoria: domini
depen_de: []
depen_de_recomanat:
  - docs
incompatible_amb: []
requisits_projecte: []
aporta_agents:
  - okr-curator
aporta_commands: []
aporta_skills:
  - estat
escriu_a:
  - .claude/agents/okr-curator.md
  - .claude/skills/estat/
  - "[directori-okr]/"
nota_territorial: "okr/ és territori exclusiu d'okr-curator. doc-curator NO gestiona fitxers dins d'okr/ excepte si el projecte ho declara explícitament al CLAUDE.md."
---

# Servei OKR

## Descripció

Sistema de gestió d'objectius (OKR) per a projectes agentics. Manté la font de veritat de l'estat del projecte (CSVs), valida integritat referencial, i proporciona auditabilitat completa via historial de canvis.

**Activar quan**: el projecte té objectius formals i un roadmap que cal rastrejar. Normalment es necessita quan el volum de feina fa difícil recordar "on som" sense un sistema explícit.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/okr-curator.md` | `.claude/agents/okr-curator.md` |
| `plantilles/tasca.md` | `[directori-okr]/plantilles/tasca.md` — plantilla canònica de tasques |
| `plantilles/BOARD.md` | `[directori-okr]/BOARD.md` — esquelet del board |
| `skills/estat/SKILL.md` | `.claude/skills/estat/SKILL.md` → `/estat` |

---

## Dependències

Cap. El Servei OKR gestiona els seus propis fitxers de tasques (`.md` a `actual/` i `fetes/`). No necessita Servei Docs per funcionar.

*(Nota: si el projecte usa Servei Docs, doc-curator pot inventariar els fitxers de tasques. Recomanat però no obligatori.)*

---

## Estructura OKR recomanada

El projecte declara els paths concrets al seu `CLAUDE.md`. Patró recomanat:

```
<directori-okr>/
  okrs.csv, krs.csv, tasques.csv, history.csv
  tasques/actual/, tasques/fetes/
  roadmap.md
```

---

## Activació manual

```bash
# 1. Copiar agent
cp <path>/agents/okr-curator.md .claude/agents/okr-curator.md

# 2. Crear estructura OKR (adapta els paths al teu projecte)
mkdir -p okr/tasques/actual okr/tasques/fetes

# 3. Inicialitzar CSVs
echo "id,objectiu,confidence,estat" > okr/okrs.csv
echo "okr_id,kr_num,descripcio,tasca_id,estat" > okr/krs.csv
echo "id,nom,okr_id,estat,data_tancament" > okr/tasques.csv
echo "data,tipus,id,camp,valor_anterior,valor_nou" > okr/history.csv

# 4. Declarar paths al CLAUDE.md del projecte
# ## Servei OKR
# Paths: okr/okrs.csv, okr/krs.csv, okr/tasques.csv, okr/history.csv
# Tasques actives: okr/tasques/actual/ (màxim 1)
```

---

## Relació amb PM

OKR-curator és la **memòria**, PM és el **frontal**. PM proposa transicions, curator les executa o les veta. Llegir `serveis/pm/coordinacio-pm-okr.md`.
