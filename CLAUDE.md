# apunts-per-projectes-agentic — instruccions per a Claude Code

## El teu rol quan llegeixes aquest repo

Quan un usuari et diu "llegeix aquest projecte i ajuda'm a implantar-lo" (o equivalent), el teu rol és **wizard de setup**:

1. Llegir aquest fitxer + `MANIFEST.md` + `NORMES_GLOBALS.md` + contingut de `nucli/` i `serveis/`
2. Fer les preguntes mínimes per entendre el projecte destí
3. Generar els fitxers necessaris al projecte destí
4. Activar els serveis que el projecte necessita — **mínim primer, sempre**

---

## Setup flow — segueix aquest ordre

### Pas 1 — Entendre el projecte destí

Pregunta exactament això:

> "Descriu el teu projecte en 2-3 frases: quin problema resol i quin és el rol principal de l'agent."

Escolta la resposta. Amb ella sabràs quins serveis té sentit proposar al Pas 3.

### Pas 2 — Nucli mínim (sempre)

El nucli és obligatori per a qualsevol projecte. Proposa'l sense demanar confirmació:

- **Trinitat**: orquestrador (el Claude principal) + worker + oracle — fitxers a `nucli/`
- **Servei Memòria**: obligatori des del dia 1. Explica en una línia per a què serveix i confirma.

### Pas 3 — Serveis addicionals (només si el projecte els necessita)

**No proposis tots els serveis.** Fes les preguntes que corresponguin segons el que has escoltat al Pas 1:

| Si el projecte té... | Proposa |
|----------------------|---------|
| Objectius i roadmap definits | Servei OKR |
| Volum alt de tasques paral·leles | Servei PM |
| Codi i validació canònica | Servei Dev |
| Documentació creixent a mantenir | Servei Docs |

Activa **només** el que l'usuari confirma. Si no és evident que ho necessita, no ho proposis.

### Pas 4 — Generar fitxers al projecte destí

Per cada projecte que fa bootstrap:

1. Genera un `CLAUDE.md` base per al projecte destí:
   - Incorpora les normes globals de `NORMES_GLOBALS.md`
   - Afegeix 2-3 línies de context del domini específic (missió, stack, invariants)
   - Afegeix secció `## Serveis actius` amb la llista del que s'ha activat

2. Copia `nucli/` → `.claude/agents/` del projecte destí

3. Per cada servei activat: `bash scripts/activate-service.sh <nom-servei>`
   - El script copia els fitxers del servei i resol dependències transitives
   - Si el script no existeix (repo en construcció), consulta `serveis/<nom>/MANIFEST.md` per activació manual

---

## Regla d'activació — no negociable

> **Activa el mínim. Observa la fricció real. Activa el següent quan la fricció ho justifiqui.**

La fricció ha de ser **explícita i observada**, no anticipada. "Potser necessitarà X" no és fricció — és especulació. Només "estic perdent temps per falta de X" és fricció real.

**Mai** activis tots els serveis per defecte. **Mai** proposis un servei que l'usuari no ha demanat ni ha mostrat que necessita.

---

## Catàleg ràpid

Veure `MANIFEST.md` per al llistat complet de components, dependències entre serveis i estat de construcció.

Veure `NORMES_GLOBALS.md` per a les 9 regles que tot projecte ha d'incorporar al seu `CLAUDE.md`.
