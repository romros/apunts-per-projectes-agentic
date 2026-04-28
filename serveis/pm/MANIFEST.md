---
servei: pm
categoria: domini
depen_de:
  - okr
depen_de_recomanat: []
incompatible_amb: []
requisits_projecte: []
aporta_agents:
  - pm
aporta_commands: []
aporta_skills:
  - tasca-seguent
escriu_a:
  - .claude/agents/pm.md
  - .claude/skills/tasca-seguent/
  - docs/coordinacio-pm-okr.md
---

# Servei PM

## Descripció

Product Manager agentic per al projecte. Gestiona el flux de treball: defineix tasques dinàmicament a partir de resultats reals, coordina agents, valida lliuraments. L'únic agent amb dret a no saber — i amb consciència temporal del projecte.

**Activar quan**: el volum de tasques i decisions justifica un agent dedicat a la coordinació. En projectes petits que comencen, l'orquestrador pot fer aquesta funció directament.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/pm.md` | `.claude/agents/pm.md` |
| `coordinacio-pm-okr.md` | `docs/coordinacio-pm-okr.md` (recomanat — és un doc de referència, no un agent) |
| `skills/tasca-seguent/SKILL.md` | `.claude/skills/tasca-seguent/SKILL.md` → `/tasca-seguent` |

---

## Dependències

- **Servei OKR** — PM treballa sobre les tasques i l'estat gestionat per OKR-curator
- **Format de tasques**: `serveis/okr/plantilles/tasca.md` — PM defineix tasques seguint aquest esquema

---

## Activació manual

```bash
# 1. Copiar agent i document de coordinació
cp <path>/agents/pm.md .claude/agents/pm.md
cp <path>/coordinacio-pm-okr.md docs/coordinacio-pm-okr.md

# 2. Declarar al CLAUDE.md del projecte
# ## Servei PM
# PM no modifica codi ni decisions arquitectòniques.
# Coordinació amb OKR-curator: docs/coordinacio-pm-okr.md
# Format de tasques: [path al format de tasca del projecte]
```

---

## Relació amb OKR-curator

PM i OKR-curator son una unitat funcional. Activar PM sense OKR és tenir un coordinador sense memòria de l'estat. Activar OKR sense PM és tenir memòria sense coordinació.

Llegir `coordinacio-pm-okr.md` per al protocol de coordinació.
