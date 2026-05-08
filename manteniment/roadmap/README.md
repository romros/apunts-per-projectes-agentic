# Roadmap intern dapunts-per-projectes-agentic

> **Atenció**: Això NO és el Servei OKR del catàleg.
> És la gestió interna del repo `apunts-per-projectes-agentic`.
> Si busques l'Equip OKR per al teu projecte, mira `equips/okr/`.

Sistema de roadmap per al fundator. Versió deliberadament simple: sense CSVs, sense okr-curator, sense OKRs formals. Un sol mantenidor, un sol fitxer de veritat per roadmap.

---

## Estructura

```
manteniment/roadmap/
  actual/
    roadmap.md          ← roadmap actiu (un sol roadmap obert a la vegada)
    tasques/
      actual/           ← tasques obertes
      fetes/            ← tasques tancades
  fets/
    RL01/roadmap.md     ← roadmaps tancats
    RL02/roadmap.md
```

---

## Format de `roadmap.md`

```markdown
# RL0X — [Títol]

**Obert:** YYYY-MM-DD
**Trigger:** [quin dels 3 criteris ha activat l'obertura]
**Bump previst:** PATCH / MINOR / MAJOR

## Problema
[Quin problema concret ha provocat obrir-lo. 2-4 frases.]

## Criteri de tancament
[Com sabré que ha acabat. Concret i verificable. Sense criteri, no s'obre.]

## Tasques
| ID | Títol | Estat |
|----|-------|-------|
| rl0X-01 | ... | actiu / pendent / done |

## Notes de tancament
[S'omplen al tancar. Oracle gate, decisions preses, bump aplicat.]
```

---

## Format de tasca (`rl0X-01-nom.md`)

```markdown
# TASCA — rl0X-01: [Títol]

**Roadmap:** RL0X
**Criteri DONE:** [com es verifica que aquesta tasca ha acabat]

## Context
[Per qué cal fer-ho ara. Fitxers concrets si cal.]

## Objectiu
[Entregable concret.]

## Execució
[Passos si hi ha ordre important. Lliure si no.]

## Lliurable
[Fitxers creats o modificats.]

## Artifacts
[Notes finals. S'omplen al tancar.]
```
