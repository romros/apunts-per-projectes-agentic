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
- **Els agents no porten `model:` al frontmatter.** El projecte destí decideix el model via sessió o override local. Cap agent del llavor imposa versió de model.
- **Cada agent porta el seu propi calibratge d'esforç** (taula específica del rol, no la genèrica del projecte). El wizard no toca el contingut dels agents — només els copia.

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
