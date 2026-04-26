# Catàleg de components

## Nucli — Agents base

Obligatori per a qualsevol projecte. Tres rols que no es poden fusionar:

| Agent | Rol | Fitxer |
|-------|-----|--------|
| **Orquestrador** | Coordina. Tradueix intenció en acció. No decideix arquitectura. | El Claude principal — no té fitxer separat |
| **Worker** | Executa tasques que requereixen context i judici tàctic. | `nucli/worker.md` |
| **Easy-worker** | Executa tasques mecàniques (output prescrit per input). Model Haiku, cost baix. | `nucli/easy-worker.md` |
| **Oracle** | Criteri arquitectònic independent. Latent entre convocatòries. | `nucli/oracle.md` |

**Quan convocar l'oracle** — en aquests moments, sempre; fora d'ells, a criteri:
- Bootstrap del projecte
- Alta d'agent o servei nou
- Incoherència estructural detectada
- Consulta explícita de l'usuari

---

## Infraestructura — sempre activa

| Component | Directori | Rol |
|-----------|-----------|-----|
| **Memòria** | `serveis/memoria/` | Pipeline de memòria persistent. Obligatori. Sense memòria, els agents comencen de zero cada sessió. |

---

## Serveis de domini

Aporten capacitats al projecte. Opcionals, activables per fricció observada.

| Servei | Directori | Depèn de |
|--------|-----------|----------|
| **Docs** | `serveis/docs/` | — |
| **OKR** | `serveis/okr/` | Docs |
| **PM** | `serveis/pm/` | OKR |
| **Dev** | `serveis/dev/` | Memòria |

---

## Serveis meta

Governança del sistema agentic — no aporten capacitat de domini, vetllen pel sistema en si.

| Servei | Directori | Depèn de | Quan activar |
|--------|-----------|----------|--------------|
| **guia-projectes-agentic** | `serveis/guia-projectes-agentic/` | Memòria | Quan el sistema agentic ja porta camí i cal que algú el mantingui i faci créixer |

---

Cada servei té `serveis/<nom>/MANIFEST.md` amb: descripció, fitxers que aporta, dependències, i instruccions d'activació manual.

Activar un servei = activar-lo amb les seves dependències transitives.
- Si `scripts/activate-service.sh` existeix: resol dependències automàticament.
- Si no: activa manualment seguint `serveis/<nom>/MANIFEST.md` de cada servei i dependències.

---

## Normes globals

`NORMES_GLOBALS.md` — 9 regles fundacionals. S'incorporen al `CLAUDE.md` del projecte destí.

Les normes 2, 5 i 9 requereixen 1-2 línies de particularització per domini (evidència DONE, dades sensibles, dependències estructurals). La resta s'apliquen tal com estan.

---

## Scripts

*(Pendent — Fase 4. No existeixen encara. El camí principal és el WIZARD.md.)*

| Script | Funció | Estat |
|--------|--------|-------|
| `scripts/bootstrap.sh` | Versió no-agentic del flow de `WIZARD.md` | Pendent Fase 4 |
| `scripts/activate-service.sh <nom>` | Activa un servei amb resolució de dependències | Pendent Fase 4 |

---

## Extras

Scripts bash opcionals per a projectes Unix/Linux/Mac que volen automatització via cron.

| Contingut | Notes |
|-----------|-------|
| `extras/scripts-bash-unix/` | Scripts del pipeline de memòria (flash-remember, flash-recall, process-flash, check-threshold). No necessaris per al funcionament normal — els agents escriuen directament a `flash.jsonl`. |

---

## Plantilles

Esquelets parametritzables per al wizard. **No còpies del projecte origen** — fitxers dissenyats per ser omplerts.

| Plantilla | Conté | Notes |
|-----------|-------|-------|
| `plantilles/CLAUDE.md` | Inici sessió, missió, calibratge, modes de prompt, normes (injectades), memòria, serveis actius | Wizard omple placeholders + injecta NORMES_GLOBALS.md des del marcador |
| `plantilles/AGENTS.md` | Taula d'agents (orquestrador/worker/oracle + serveis), sistema de memòria, validació canònica | Wizard omple taula amb agents activats |

---

## Estat de construcció

| Component | Estat |
|-----------|-------|
| `WIZARD.md` (entry point agents externs) | ✓ |
| `CLAUDE.md` (manteniment intern repo) | ✓ |
| `MANIFEST.md` (aquest fitxer) | ✓ |
| `NORMES_GLOBALS.md` | ✓ |
| `plantilles/CLAUDE.md` | ✓ |
| `plantilles/AGENTS.md` | ✓ |
| `nucli/worker.md` | ✓ |
| `nucli/easy-worker.md` | ✓ |
| `nucli/oracle.md` | ✓ |
| `serveis/memoria/` | ✓ |
| `serveis/docs/` | ✓ |
| `serveis/guia-projectes-agentic/` | ✓ |
| `serveis/okr/` `serveis/pm/` `serveis/dev/` | Pendent (Fase 6) |
| `scripts/bootstrap.sh` | Pendent (Fase 4) |
| `scripts/activate-service.sh` | Pendent (Fase 4) |
