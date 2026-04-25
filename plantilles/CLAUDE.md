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

<!-- El wizard omple els paths concrets. No elimines aquesta secció — el Servei Memòria és obligatori. -->

```bash
# Escriure memòria
bash .claude/agent-memory/shared/flash-remember/scripts/remember.sh \
  --agent <nom-agent> --content "<text>" --tags "<tags>"

# Recuperar context
bash .claude/agent-memory/shared/flash-recall/scripts/recall.sh --agent <nom-agent>
```

Arquitectura: `flash.jsonl` → (cron 5min) → `short-term.csv` → (mem-curator) → `skills/SKILL.md`

---

## Serveis actius

<!-- EL WIZARD OMPLE AQUESTA SECCIÓ SEGONS ELS SERVEIS ACTIVATS -->
<!-- Exemple: -->
<!-- - Servei Memòria (`serveis/memoria/`) -->
<!-- - Servei Docs (`serveis/docs/`) -->

---

## Origen del sistema agentic

<!-- WIZARD: omple amb la URL base i el commit SHA del moment del bootstrap -->
- **Repo de referència**: https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/
- **Commit adoptat**: COMMIT_SHA
