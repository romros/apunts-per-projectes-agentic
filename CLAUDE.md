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
- Documentació operativa (aquest fitxer, `MANIFEST.md`, `NORMES_GLOBALS.md`, `WIZARD.md`)

## Regles de manteniment

- **Audiència de cada fitxer**: `README.md` → humans. Tots els altres → Claude Code agents.
- **Cap fitxer entra al repo sense haver provat el seu valor en un projecte real.**
- **`WIZARD.md` és el punt d'entrada per a agents externs.** No barregis el seu rol amb `CLAUDE.md`.
- Quan afegeixes un servei nou a `serveis/`, actualitza `MANIFEST.md` (taula d'estat).

## Estructura
```
WIZARD.md           ← entry point per a agents externs (via URL)
CLAUDE.md           ← aquest fitxer (manteniment intern)
MANIFEST.md         ← catàleg de components i estat de construcció
NORMES_GLOBALS.md   ← 9 regles fundacionals
README.md           ← portada humana GitHub
nucli/              ← agents base (worker, oracle)
serveis/            ← paquets modulars
scripts/            ← bootstrap i activate-service
```
