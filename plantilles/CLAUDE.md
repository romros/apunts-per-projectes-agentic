# CLAUDE.md — [NOM DEL PROJECTE]

<!-- generat des de apunts-per-projectes-agentic@COMMIT_SHA:plantilles/CLAUDE.md -->

## Inici de sessió — OBLIGATORI

Llegeix en paral·lel a l'inici de cada sessió:
- `README.md` — missió i context del projecte
- `AGENTS.md` — agents disponibles i sistema de memòria
<!-- SI SERVEI OKR ACTIU:
- `okr/roadmaps/actual/roadmap.md` — fase actual, KRs oberts
- `okr/roadmaps/actual/decisions.md` — decisions preses
-->

---

## Missió

[DESCRIU EN 2-3 FRASES: quin problema resol aquest projecte, per a qui, i quin és el rol principal de l'agent.]

- **Stack**: [TECNOLOGIES PRINCIPALS]
- **Directori principal**: [PATH PRINCIPAL DEL PROJECTE]
- **Invariants irrompibles**:
  - [INVARIANT 1 — la restricció que no es pot trencar mai]
  - [INVARIANT 2]
<!-- Afegeix o elimina invariants segons el projecte. Si no n'hi ha, esborra la secció. -->

---

## Calibratge operacional

**Model base: Sonnet. Esforç base: mínim.**

| Esforç | Quan |
|--------|------|
| Mínim | Resposta directa, sense ambigüitat, sense risc de ser incorrecte |
| Estàndard | Cal llegir fitxers, contrastar informació o generar output estructurat |
| Intensiu | Decisió amb trade-offs, múltiples fitxers afectats, fork point real |

Comença sempre pel mínim. Escala per necessitat, mai per precaució.

---

## Modes de prompt

L'usuari pot prefixar la seva petició amb un mode explícit:

| Mode | Significat | Eines permeses |
|------|-----------|----------------|
| `[FER]` | Executa. Aplica canvis, edita fitxers, crida codi | Totes |
| `[PENSAR]` | Analitza, raona, proposa. No canvia res | Read, Grep, Glob. No Edit/Write/Bash destructiu |
| `[SENTIR]` | Comprova l'estat (codi, projecte, tu mateix) | Read, Grep, Glob, Bash no destructiu |

Si no hi ha prefix, assumeix mode mixt. Si el prefix entra en tensió amb la petició, demana aclariment.

---

## Normes globals

<!-- EL WIZARD INJECTA AQUÍ el bloc de NORMES_GLOBALS.md des del marcador "INICI INJECCIÓ" fins al final -->
<!-- Normes 2, 5 i 9 marcades amb → han d'estar particularitzades per al domini (no han de quedar amb → sense omplir) -->

---

## Sistema de memòria

<!-- No elimines aquesta secció — el Servei Memòria és obligatori. -->

Per recordar alguna cosa, afegeix una línia JSON a `.claude/agent-memory/flash.jsonl`:

```json
{"ts": "2026-01-01T00:00:00Z", "agent": "NOM_AGENT", "content": "TEXT", "tags": ["tag"]}
```

Per llegir context a l'inici de sessió:
1. Llegeix `.claude/agent-memory/<agent>/MEMORY.md` — skills actuals
2. Llegeix les últimes files de `.claude/agent-memory/short-term.csv` on `agent=<nom>`

Quan `flash.jsonl` supera 20 entrades → invoca `@mem-curator` per consolidar.

Arquitectura: `flash.jsonl` → (mem-curator quan cal) → `short-term.csv` → `skills/SKILL.md`

---

## Serveis actius

<!-- EL WIZARD OMPLE AQUESTA SECCIÓ SEGONS ELS SERVEIS ACTIVATS -->
<!-- Exemple: -->
<!-- - Servei Memòria (`serveis/memoria/`) -->
<!-- - Servei Docs (`serveis/docs/`) -->

---

## Agents actius i latents

Declara explícitament quins agents invoca aquest projecte. Agents no llistats com a actius son **latents** — existeixen però no s'invoquen per defecte.

**Actius** (invocables sense restricció):
<!-- EL WIZARD OMPLE SEGONS ELS SERVEIS ACTIVATS I LA MISSIÓ DEL PROJECTE -->
<!-- Exemple: -->
<!-- - `@worker` — implementació i tasques amb context -->
<!-- - `@easy-worker` — tasques mecàniques (git, fitxers, scripts) -->
<!-- - `@mem-curator` — consolidació de memòria quan flash.jsonl > 20 entrades -->

**Latents** (disponibles però no invocats habitualment):
<!-- - `@oracle` — decisions arquitectòniques i fork points (convocar ritualment) -->
<!-- - Afegir/treure segons el projecte -->

> Un agent latent no és un agent absent. Pot ser convocat quan calgui. Declarar-lo latent evita invocacions per defecte innecessàries.

---

## Origen del sistema agentic

<!-- WIZARD: omple amb la URL base i el commit SHA del moment del bootstrap -->
- **Repo de referència**: https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/
- **Commit adoptat**: COMMIT_SHA
