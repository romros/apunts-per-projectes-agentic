---
name: estat
description: Mostra l'estat actual del projecte — OKR actiu, tasca en curs, DoD pendent, pròxima fase.
disable-model-invocation: true
---

Genera un resum de l'estat actual del projecte. Llegeix els fitxers reals — no assumeixis res de sessions anteriors.

## Passos (en ordre)

1. Llegeix el fitxer d'OKRs (`okrs.csv` o equivalent declarat al `CLAUDE.md`)
2. Llegeix la secció DYNAMIC del roadmap actiu
3. Llegeix la tasca activa a `tasques/actual/`
4. Llegeix l'historial de tasques (`tasques.csv`)

## Format de sortida

```
### Estat del projecte — [data d'avui]

**OKR actiu:** [id — nom] ([confidence]%)

**Tasca activa:** `[id]` — [títol]
**Estat:** [estat]
**Objectiu:** [objectiu en 2 línies màxim]
**DoD pendent:** [checks no completats]

**Pròxima fase:** [breu descripció]

**Deutes oberts:** [llista breu; si no n'hi ha: "cap"]
```

Respon NOMÉS amb el resum. No expliquis el procés.
