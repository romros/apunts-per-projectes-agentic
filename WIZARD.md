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
3. `plantilles/CLAUDE.md` — esquelet per generar el CLAUDE.md destí
4. `plantilles/AGENTS.md` — esquelet per generar l'AGENTS.md destí

Exemple d'URL per als fitxers de plantilles (substitueix la URL base):
```
<URL_BASE>plantilles/CLAUDE.md
<URL_BASE>plantilles/AGENTS.md
```

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

**Si al Pas 1 no has detectat configuració agentic prèvia:**

> "He llegit el teu projecte. [Resum breu del que has vist: stack, etc.]
> Confirma o corregeix: [la teva hipòtesi de missió del projecte].
> Vols que procedeixi a fer-lo agentic?"

**Si al Pas 1 has detectat `CLAUDE.md`, `.claude/` o `AGENTS.md` existents:**

Aquesta pregunta muta. No proposes setup nou — proposes fusió:

> "El teu projecte ja té configuració agentic. He vist: [llista el que existeix].
> Vols que: (a) fusioni el manual amb el que tens, (b) substitueixi la configuració existent, o (c) ho deixem com està?"

Espera decisió explícita. **No procedeixis fins que l'usuari confirmi.**

No demanis coses que ja saps per la inspecció. Si alguna cosa no has pogut determinar, pregunta-ho aquí.

---

## Pas 3 — Nucli mínim (sempre)

Informa l'usuari del que activaràs per defecte:

- **Agents base**: orquestrador (Claude principal) + worker + oracle
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

Usa l'esquelet de `plantilles/CLAUDE.md` que ja has llegit al Pas 0. Completa'l:
- Omple `[NOM DEL PROJECTE]` amb el nom real
- Omple la secció `## Missió` amb el que has après de la inspecció i les respostes
- Injecta a la secció `## Normes globals` el bloc de `NORMES_GLOBALS.md` **des del marcador `<!-- INICI INJECCIÓ -->`** fins al final del fitxer. No injectes el preàmbul.
  - Particularitza les normes 2, 5 i 9 amb el domini concret (marcades amb `→` a NORMES_GLOBALS.md). Cap `→` ha de quedar sense omplir al fitxer generat.
- Omple `## Serveis actius` amb la llista del que s'ha activat
- Substitueix `COMMIT_SHA` al marcador de versió per la referència de la URL que has llegit
- Esborra les seccions comentades que no s'usen (serveis no activats, invariants buits, etc.)

**2. `AGENTS.md` base**

Usa l'esquelet de `plantilles/AGENTS.md` que ja has llegit al Pas 0. No el busquis a l'arrel del repo destí — és una plantilla del llavor, no un fitxer del projecte. Usa'l com a esquelet:
- Omple `[NOM DEL PROJECTE]`
- Afegeix a la taula d'agents qualsevol agent de servei activat al Pas 4
- Omple la secció `## Validació canònica` amb la comanda DONE del projecte destí (si n'hi ha)
- Substitueix `COMMIT_SHA` com al fitxer anterior
- Esborra les seccions condicionals no aplicables

**3. Agents del nucli**

Llegeix `nucli/worker.md` i `nucli/oracle.md` des de la URL base.
Copia'ls a `.claude/agents/worker.md` i `.claude/agents/oracle.md` del projecte destí.

*(Si els fitxers de nucli no existeixen encara — el manual està en construcció — informa l'usuari i usa un placeholder mínim: un fitxer amb nom i rol documentats.)*

**4. Serveis activats**

Per cada servei confirmat:
- Si existeix `scripts/activate-service.sh`: executa `bash scripts/activate-service.sh <nom>`.
- Si no existeix (manual en construcció): llegeix `serveis/<nom>/MANIFEST.md` i segueix les instruccions d'activació manual.
- Si `serveis/<nom>/` tampoc existeix: informa l'usuari que el servei és pendent de construcció i proposa ajornar-ne l'activació.

**Nota sobre el Servei Memòria**: és obligatori. Si no s'ha construït `serveis/memoria/` encara, activa'l manualment copiant l'estructura `.claude/agent-memory/` (consulta l'usuari per al path font).

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
