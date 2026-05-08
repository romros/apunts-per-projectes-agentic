# Catàleg de components

> **Agent nou?** Comença per [`WIZARD.md`](WIZARD.md) — és l'entry point per bootstrapejar un projecte. Aquest fitxer és el catàleg de components.

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

## Equips

Produeixen feina per encàrrec. Cada equip té un workflow intern i genera output. Opcionals, activables per fricció observada.

| Equip | Directori | Depèn de | Descripció |
|-------|-----------|----------|------------|
| **OKR** | `equips/okr/` | — | Rastreig d'objectius i tasques. Custodi de la font de veritat (CSVs). |
| **PM** | `equips/pm/` | OKR | Coordinació del flux de treball agentic. Activa sempre amb OKR. |
| **Dev** | `equips/dev/` | Memòria | Worker especialitzat per a codi. Skills per projecte + dev-worker. |
| **Editorial** | `equips/editorial/` | Memòria (recomanat) | Pipeline multi-agent per a publicació d'articles de blog amb flux scout→brief→redacció→correcció. |
| **Analisi-dades** | `equips/analisi-dades/` | corrector-catala | Pipeline multi-agent per a consultoria de dades: BD→visualització→interpretació→narrativa→correcció. 6 agents (data-analyst, viz-builder, analyst-senior, researcher, redactor-analisi, corrector-catala). |

---

## Serveis

Infraestructura transversal. Sostenen el sistema. Opcionals excepte Memòria (obligatòria).

### Infraestructura — sempre activa

| Component | Directori | Rol |
|-----------|-----------|-----|
| **Memòria** | `serveis/memoria/` | Pipeline de memòria persistent. Obligatori. Sense memòria, els agents comencen de zero cada sessió. |

### Serveis de domini

| Servei | Directori | Depèn de | Descripció |
|--------|-----------|----------|------------|
| **Docs** | `serveis/docs/` | — | Custòdia documental entre sessions. Inventari, coherència, progrés. |
| **Corrector-català** | `serveis/corrector-catala/` | — | Correcció lingüística de documents en català. Útil a qualsevol projecte que produeixi text en català. |
| **UX Expert** | `serveis/ux-expert/` | — | Revisió UX per a projectes amb interfície. Activa si el projecte té component UI. |

### Serveis de cultura

Paquets culturals opcionals. Cap projecte els necessita, però poden donar coherència i veu als agents.

| Servei | Directori | Packs disponibles |
|--------|-----------|-------------------|
| **cultura-agents** | `serveis/cultura-agents/` | `neutral` (default), `laboratori` (validat) |

### Serveis meta

Governança del sistema agentic — no aporten capacitat de domini, vetllen pel sistema en si.

| Servei | Directori | Depèn de | Quan activar |
|--------|-----------|----------|--------------|
| **guia-projectes-agentic** | `serveis/guia-projectes-agentic/` | Memòria | Quan el sistema agentic ja porta camí i cal que algú el mantingui i faci créixer |
| **Code Curator** | `serveis/code-curator/` | Memòria | Auditoria arquitectònica del codebase. Activa si el projecte té codebase de producció. |

---

## Commands

Workflows amb **entry point explícit de l'usuari**. Creables com a slash commands a `.claude/commands/` del projecte destí.

| Command | Fitxer | Quan usar-lo |
|---------|--------|-------------|
| **Tasca següent** | `commands/tasca-seguent.md` | L'usuari dona el go per tancar la tasca activa i obrir la següent |
| **Revisar opinió externa** | `commands/revisa-opinio.md` | Arriba feedback extern sobre la tasca en curs i cal avaluar-lo |

---

## Processos

Workflows **interns entre agents**, sense entry point d'usuari. Els dispara el sistema, no l'usuari directament. Veure `processos/README.md` per a la distinció commands vs processos.

| Procés | Fitxer | Disparador |
|--------|--------|-----------|
| **Executar una tasca** | `processos/executar-tasca.md` | L'usuari proposa una tasca nova |
| **Tancar una tasca** | `processos/tancar-tasca.md` | PM ha validat que l'evidència cobreix el DoD |
| **Nou roadmap** | `processos/nou-roadmap.md` | El roadmap actual és tancat |
| **Gestió de deutes** | `processos/gestio-deutes.md` | Worker o PM detecta un deute fora del scope de la tasca |

---

Cada equip o servei té el seu `MANIFEST.md` amb: descripció, fitxers que aporta, dependències, i instruccions d'activació manual.

Activar un equip o servei = activar-lo amb les seves dependències transitives.
- Si `scripts/activate-service.sh` existeix: resol dependències automàticament.
- Si no: activa manualment seguint el `MANIFEST.md` de cada peça i les seves dependències.

---

## Mapes i convencions

| Recurs | Fitxer | Propòsit |
|--------|--------|---------|
| Mapa de dependències | `GRAPH.md` | Font de veritat: agents, processos, dependències entre components |
| Convencions de nomenclatura | `docs/convencions.md` | BPMN com a estàndard, glossari canònic, regles de noms |
| Plantilla de procés | `plantilles/proces.md` | Estructura canònica per a nous processos |

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
| `nucli/orquestracio.md` | ✓ |
| `nucli/plantilles/agent.md` | ✓ |
| `nucli/plantilles/decisions.md` | ✓ |
| `nucli/skills/oracle/SKILL.md` | ✓ |
| `nucli/skills/auto-oracle/SKILL.md` | ✓ |
| `nucli/skills/oracle-proposa/SKILL.md` | ✓ |
| `nucli/scripts/oracle-audit.sh` | ✓ |
| `nucli/hooks/oracle-gate-post.sh` | ✓ |
| `nucli/hooks/oracle-gate-pre-commit.sh` | ✓ |
| `nucli/hooks/oracle-session-start.sh` | ✓ |
| `nucli/hooks/settings-example.json` | ✓ |
| `nucli/plantilles/oracle-memory/MODEL.md` | ✓ |
| `nucli/plantilles/oracle-memory/PREDICTIONS.md` | ✓ |
| `nucli/plantilles/oracle-memory/WATCHLIST.md` | ✓ |
| `serveis/memoria/` | ✓ |
| `serveis/docs/` | ✓ |
| `serveis/guia-projectes-agentic/` | ✓ |
| `equips/okr/` | ✓ |
| `serveis/cultura-agents/` | ✓ |
| `serveis/corrector-catala/` | ✓ |
| `equips/pm/` | ✓ |
| `equips/dev/` | ✓ |
| `equips/editorial/` | ✓ |
| `equips/analisi-dades/` | ✓ |
| `commands/README.md` | ✓ |
| `commands/tasca-seguent.md` | ✓ |
| `commands/revisa-opinio.md` | ✓ |
| `processos/README.md` | ✓ |
| `processos/executar-tasca.md` | ✓ |
| `processos/tancar-tasca.md` | ✓ |
| `processos/nou-roadmap.md` | ✓ |
| `extras/scripts-python-viz/` | ✓ |
| `serveis/ux-expert/` | ✓ |
| `serveis/code-curator/` | ✓ |
| `processos/gestio-deutes.md` | ✓ |
| `scripts/bootstrap.sh` | Pendent (Fase 4) |
| `scripts/activate-service.sh` | Pendent (Fase 4) |
