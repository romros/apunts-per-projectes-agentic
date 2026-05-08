# Idea: renombrar `serveis/` → `equips/`

**Data**: 2026-05-05
**Estat**: hipòtesi — no validada

## Idea

Canviar el concepte "serveis" per "equips" com a nom del directori i la terminologia del catàleg.

## Motivació (pendent de concretar)

*(L'usuari l'anotarà quan tingui més forma)*

## Condició de validació

Abans de promoure: determinar si el canvi és cosmètic (renombrat) o conceptual (implica redefinir com s'agrupen els agents). Si és cosmètic → PATCH. Si és conceptual → MAJOR, amb path de migració per a projectes ja bootstrappejats.

## Impacte estimat si es fa

- `MANIFEST.md`, `WIZARD.md`, `CLAUDE.md`, `NORMES_GLOBALS.md` — totes les referències a "serveis"
- Tots els projectes bootstrappejats amb apunts-per-projectes-agentic actual haurien d'actualitzar les seves referències
- El WIZARD hauria d'incloure nota de migració
