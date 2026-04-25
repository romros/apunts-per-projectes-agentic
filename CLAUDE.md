# CLAUDE.md — apunts-per-projectes-agentic

Instruccions per a Claude Code quan treballes **dins** d'aquest repo (manteniment, construcció de fases).

> Si has arribat aquí llegint una URL externa per fer agentic un altre projecte,
> **aquest no és el fitxer que busques**. Llegeix `WIZARD.md`.

---

## Rol dins del repo

Ets el mantenidor del manual. La teva feina és construir i mantenir les peces del llavor:
- Fitxers de nucli (`nucli/`)
- Serveis modulars (`serveis/`)
- Scripts d'activació (`scripts/`)
- Plantilles parametritzables (`plantilles/`)
- Documentació operativa (aquest fitxer, `MANIFEST.md`, `NORMES_GLOBALS.md`, `WIZARD.md`)

## Regles de manteniment

- **Audiència de cada fitxer**: `README.md` → humans. Tots els altres → Claude Code agents.
- **Cap fitxer entra al repo sense haver provat el seu valor en un projecte real.**
- **`WIZARD.md` és el punt d'entrada per a agents externs.** No barregis el seu rol amb `CLAUDE.md`.
- Quan afegeixes un servei nou a `serveis/`, actualitza `MANIFEST.md` (taula d'estat).
- **Els agents no porten `model:` al frontmatter.** El projecte destí decideix el model via sessió o override local. Cap agent del llavor imposa versió de model. Si es vol especificar, usar àlies oficials: `sonnet`, `opus`, `haiku`.
- **Cada agent porta el seu propi calibratge d'esforç** (taula específica del rol). El wizard no toca el contingut — només copia.
- **Valors oficials d'`effort`**: `low`, `medium`, `high`, `xhigh`, `max`. El valor `normal` **no és oficial** — usar `medium`. Mapejament: estàndard→medium, intensiu→high.
- **`skills` al frontmatter**: només per contingut compartit (≥2 agents), volàtil, o referencial. No per defecte. Cost: augmenta tokens d'entrada per invocació. Skills del nucli a `nucli/skills/`, específics a `serveis/<nom>/skills/`.
- **Cicle de destil·lació d'agents**: per cada agent nou, aplicar el cicle formal (Pas 1-4 + Pas 2.5 condicional per frontmatter extensions).

## Estructura
```
WIZARD.md           ← entry point per a agents externs (via URL)
CLAUDE.md           ← aquest fitxer (manteniment intern)
MANIFEST.md         ← catàleg de components i estat de construcció
NORMES_GLOBALS.md   ← 9 regles fundacionals
README.md           ← portada humana GitHub
plantilles/         ← esquelets parametritzables (CLAUDE.md, AGENTS.md)
nucli/              ← agents base (worker, oracle; orquestrador = Claude principal, sense fitxer)
serveis/            ← paquets modulars
scripts/            ← bootstrap i activate-service
```
