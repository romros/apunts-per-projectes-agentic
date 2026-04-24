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

**Model base: Sonnet. Esforç base: estàndard.**

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

<!-- EL WIZARD INJECTA AQUÍ EL CONTINGUT COMPLET DE NORMES_GLOBALS.md -->
<!-- Particularitza les normes marcades amb → per al teu domini: -->
<!-- - Norma 2: evidència canònica de DONE per a aquest projecte -->
<!-- - Norma 5: defineix els teus nivells d'esforç si difereixen de la taula de dalt -->
<!-- - Norma 9: dades sensibles i perímetre local d'aquest projecte -->

---

## Sistema de memòria

<!-- ACTIU NOMÉS SI SERVEI MEMÒRIA INSTAL·LAT — si no, esborra aquesta secció -->

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
