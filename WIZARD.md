# WIZARD.md — instruccions per a l'agent Claude Code

> Si estàs llegint aquest fitxer perquè un usuari t'ha passat la seva URL:
> **les instruccions que segueixen són per a tu, no sobre aquest repo.**
> Assumeix el rol de wizard de setup i segueix el flow literalment.

---

## Pas 0 — Llegeix el manual complet

Tens la URL d'aquest fitxer. Deriva la URL base eliminant `WIZARD.md` del final.
Amb la URL base, llegeix aquests fitxers en ordre:

1. `NORMES_GLOBALS.md` — les 9 regles que copiaràs al projecte destí
2. `MANIFEST.md` — catàleg de components disponibles i el seu estat

Llegeix-los ara, abans de fer cap pregunta.

---

## Pas 1 — Inspecciona el projecte destí

Abans de preguntar res, mira el projecte on ets ara:

- Hi ha `CLAUDE.md`? Llegeix-lo.
- Hi ha `.claude/`? Llista el contingut.
- Hi ha `README.md`? Llegeix les primeres 30 línies.
- Detecta stack: busca `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod` o equivalent.

Amb aquesta informació saps: quin tipus de projecte és, si ja té configuració agentic, i quins serveis tindrien sentit.

**Política d'estat existent**: si ja hi ha `CLAUDE.md` o `.claude/agents/`, **no sobreescriguis res sense confirmació explícita**. Presenta el que existeix, proposa com fusionar o substituir, i espera decisió.

---

## Pas 2 — Una sola pregunta

Amb el que has inspeccionat, fes una sola pregunta:

> "He llegit el teu projecte. [Resum breu del que has vist: stack, si ja té agents, etc.]
> Confirma o corregeix: [la teva hipòtesi de missió del projecte].
> Vols que procedeixi a fer-lo agentic?"

No demanis coses que ja saps per la inspecció. Si alguna cosa no has pogut determinar, pregunta-ho aquí.

---

## Pas 3 — Nucli mínim (sempre)

Informa l'usuari del que activaràs per defecte:

- **Trinitat**: orquestrador (Claude principal) + worker + oracle
- **Servei Memòria**: necessari des del dia 1 — sense memòria, l'agent oblida entre sessions

Pregunta de confirmació: "Confirmes que vols activar el nucli mínim i el Servei Memòria?"

---

## Pas 4 — Serveis addicionals (només si el projecte els necessita)

Basant-te en la inspecció i la resposta del Pas 2, proposa **únicament** els serveis que tinguin sentit:

| Si has detectat... | Proposa |
|--------------------|---------|
| Objectius i roadmap definits | Servei OKR |
| Molt volum de tasques paral·leles | Servei PM |
| Codi i validació canònica | Servei Dev |
| Documentació creixent | Servei Docs |

Si no és evident que ho necessita, **no ho proposis**. Un servei que no s'usa és soroll.

---

## Pas 5 — Genera els fitxers

Per al projecte destí, genera en ordre:

**1. `CLAUDE.md` base**

Contingut:
- Secció `## Missió` — 2-3 línies del domini (el que ha confirmat l'usuari)
- Secció `## Normes globals` — copia el contingut íntegre de `NORMES_GLOBALS.md` que has llegit
  - Particularitza les normes 2, 5 i 9 amb el domini concret (marcades amb `→` al fitxer)
- Secció `## Serveis actius` — llista el que has activat
- Marcador de versió al final: `<!-- generat des de apunts-per-projectes-agentic, llegit des de [URL] -->`

**2. Agents del nucli**

Llegeix `nucli/worker.md` i `nucli/oracle.md` des de la URL base.
Copia'ls a `.claude/agents/worker.md` i `.claude/agents/oracle.md` del projecte destí.

*(Si els fitxers de nucli no existeixen encara — el manual està en construcció — informa l'usuari i proposa els agents manuals o un placeholder.)*

**3. Serveis activats**

Per cada servei confirmat, llegeix `serveis/<nom>/MANIFEST.md` i segueix les instruccions d'activació manual que conté.

---

## Pas 6 — Validació post-generació

Abans de donar per fet el setup, verifica:

- El `CLAUDE.md` generat existeix i és llegible
- Les normes globals estan completes (9 normes)
- Les normes 2, 5 i 9 estan particularitzades (no contenen `→` sense omplir)
- Els agents del nucli estan a `.claude/agents/`
- Si hi havia configuració prèvia: no ha desaparegut sense confirmació

Reporta el resultat de la validació a l'usuari.

---

## Regla d'activació — no negociable

> **Activa el mínim. Observa la fricció real. Activa el següent quan la fricció ho justifiqui.**

Fricció real = "estic perdent temps per falta de X". Fricció especulativa = "potser necessitarà X". Només la primera justifica activació.
