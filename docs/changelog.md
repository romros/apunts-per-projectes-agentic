# Changelog del llavor

Format de versió: [MAJOR.MINOR.PATCH](https://semver.org)
- **PATCH**: correccions de text, claredat. Projectes existents poden ignorar-ho.
- **MINOR**: nous serveis, noves capes opcionals. No trenca res existent.
- **MAJOR**: canvis a `NORMES_GLOBALS.md`, contractes de nucli (`oracle.md`, `worker.md`), o `plantilles/`. Pot trencar projectes existents — llegir path de migració.

Per saber si el teu projecte té canvis pendents: compara el SHA del teu `CLAUDE.md` (`# Generat des de apunts-per-projectes-agentic@<SHA>`) amb el HEAD d'aquest repo. Llegeix les entrades del rang.

---

## [2.0.0] — 2026-05-07 — `3e182c9`

**MAJOR** — Mode d'operació a plantilles, nous serveis destil·lats de laboratori_profes, processos millorats.

### Trencador (llegir si el teu projecte ja usa el llavor)

**`plantilles/CLAUDE.md`** — nova secció `## Mode d'operació` entre Calibratge operacional i Modes de prompt. Si el teu `CLAUDE.md` ve d'una versió anterior: el sistema continua funcionant en mode consultiu per defecte. Per adoptar la secció (recomanat):
```
## Mode d'operació
Per defecte: mode consultiu — espera confirmació de l'usuari (pas 4 executar-tasca).
Per activar mode automàtic: afegeix bloc "## Mode d'operació: AUTOMÀTIC" al CLAUDE.md del projecte.
```

**`serveis/okr/` → `equips/okr/`** — OKR reclassificat com a equip (produeix output per encàrrec, no és infraestructura passiva). Si el teu projecte referencia `serveis/okr/` en algun fitxer intern → actualitza a `equips/okr/`. La majoria de projectes bootstrappejats tenen el seu propi `okr/` a arrel i no es veuen afectats.

### Afegit

**`serveis/ux-expert/`** — Revisió UX per a projectes amb interfície:
- `ux-expert` (Opus) — avalua pantalles, fluxos i fricció. S'injecta al pas 6 d'`executar-tasca` si activat.
- Activa si el projecte té component UI.

**`serveis/code-curator/`** — Auditoria arquitectònica del codebase:
- `code-curator` (Sonnet) — detecta violacions de capa, acoblaments ocults, mòduls orfes, codi mort. Latent per defecte.
- Activa si el projecte té codebase de producció amb arquitectura per capes.

**`processos/gestio-deutes.md`** — Protocol complet de gestió de deutes tècnics:
- PM com a portador actiu de deutes entre sessions i roadmaps
- Circuit: `deutes.md` → `deutes-globals.md` → revisió a cada roadmap nou
- Tolerància 0 amb deutes resolubles dins la tasca actual

### Millorat

**`processos/executar-tasca.md`** — Pas 2 enriquit amb diagnòstic previ explícit: (a) evidència objectiva que el problema existeix, (b) descarta artefactes d'observació, (c) confirma que cap tasca existent el cobreix. Mode automàtic documentat al pas 4.

**`processos/tancar-tasca.md`** — Criteri Oracle explícit: obligatori si hi ha correccions post-revisió, impacte arquitectònic o efecte durador. PM sol per tasques purament mecàniques.

**YAML frontmatters** — `analisi-dades`, `dev`, `corrector-catala`: camps `name:` i `aporta_agents:` afegits per coherència.

### Què fer si el teu projecte ja usa el llavor

**Obligatori si referencieu `serveis/okr/`:** actualitzar a `equips/okr/`.

**Recomanat:** afegir secció `## Mode d'operació` al `CLAUDE.md` del projecte (veure bloc trencador).

**Opcional:** activar `ux-expert` si el projecte té UI, `code-curator` si té codebase de producció. Llegir els `MANIFEST.md` respectius per a instruccions d'activació.

---

## [1.3.0] — 2026-05-05 — `a24bde7`

**MINOR** — Nous serveis de domini. Cap impacte en projectes existents.

### Afegit

**`serveis/analisi-dades/`** — Pipeline multi-agent per a consultoria de dades:
- `data-analyst` — consultes SQL via MCP, protocol d'exploració d'esquema
- `viz-builder` — gràfics ECharts (HTML+PNG), invariant dos scripts `<script>` separats
- `analyst-senior` — interpretació experta, test 3/3, cicle intern→extern→intern (Opus)
- `researcher` — cerca externa, criteri citació vs descart
- `redactor-analisi` — fresh eyes, prohibit inventar, `[VERIFICAR]` per a xifres sospitoses
- `skills/data-narrative/` — Knaflic, Tufte, Minto, Data→Insight→Acció
- `skills/pdf-generation/` — Playwright+HTML, bug Chromium #14441

**`serveis/corrector-catala/`** — Servei independent de correcció lingüística catalana:
- Normativa IEC (ortografia, gramàtica, DIEC2, TERMCAT)
- Distinció ortografia (binari) vs naturalitat (espectre + suggeriment)
- Compatible amb `serveis/editorial` com a capa lingüística addicional

**`extras/scripts-python-viz/`** — Scripts Python reutilitzables:
- `screenshot.py` — HTML → PNG via Playwright
- `gen_html_echarts.py` — assembla HTML interactiu amb figures ECharts
- `gen_pdf_md.py` — Markdown → PDF via ReportLab

### Què fer si el teu projecte ja usa el llavor

Res obligatori. Addició pura.

Si el teu projecte fa anàlisi de dades i vols adoptar el servei:
→ Llegeix `equips/analisi-dades/MANIFEST.md` — té instruccions d'activació completes.

Si el teu projecte publica en català i vols correcció lingüística normativa:
→ Llegeix `serveis/corrector-catala/MANIFEST.md`.

Si uses `equips/editorial` en català:
→ `corrector-catala` és complementari al `corrector` editorial (capes diferents: lingüística vs. compliment de brief). Pots afegir-lo com a darrer pas del pipeline.

---

## [1.2.0] — 2026-05-05 — `3bb54db`

**MINOR** — Oracle per defecte, FUNDATOR, model/effort a tots els agents.

### Afegit

- **`FUNDATOR.md`** — governança del llavor: criteris de promoció de patrons, versionat semàntic, procés de destil·lació d'agents, gestió de tensions internes
- **`.claude/agents/oracle.md`** — oracle operacional del llavor amb context propi
- **`.claude/agent-memory/oracle/`** — MODEL.md, PREDICTIONS.md, WATCHLIST.md del llavor
- **`.claude/agents/worker.md`** — worker intern del llavor (amb override: consulta FUNDATOR.md per governança)
- **`.claude/agents/easy-worker.md`** — easy-worker intern del llavor

### Canviat

- **`WIZARD.md`**: Oracle Gate (Capes 1+3) ara s'instal·la per defecte; Capa 5 (cron) opcional. Nou Pas 7: registre de friccions i aprenentatges.
- **Tots els agents de serveis**: afegit `model:` i `effort:` al frontmatter (dev-worker, doc-curator, mem-curator, okr-curator, pm, guia-projectes-agentic, ideator, radar-web, investigador-web, redactor, corrector).
- **Tots els MANIFESTs de serveis**: secció Dependències formalitzada amb format rich (Requereix activat / Llegeix de / Escriu a).
- **`nucli/oracle.md`**: afegit `model: opus`
- **`nucli/worker.md`**: afegit `model: sonnet`, `effort: medium`

### Què fer si el teu projecte ja usa el llavor

**Oracle Gate**: si el teu projecte no té Oracle Gate instal·lat i el vols activar:
```bash
cp <llavor>/nucli/hooks/oracle-gate-post.sh .claude/hooks/
cp <llavor>/nucli/hooks/oracle-gate-pre-commit.sh .claude/hooks/
cp <llavor>/nucli/hooks/oracle-session-start.sh .claude/hooks/session-start.sh
chmod +x .claude/hooks/*.sh
# Fusiona el bloc "hooks" de nucli/hooks/settings-example.json al teu .claude/settings.json
```

**model/effort als agents**: si vols adoptar-ho als teus agents de servei, afegeix les línies al frontmatter de cada agent. No és obligatori — el sistema funciona sense.

---

## [1.1.0] — 2026-04-28 — `c05e626`

**MINOR** — Servei editorial.

### Afegit

- **`serveis/editorial/`** — Pipeline multi-agent per a publicació d'articles de blog: radar-web → ideator → investigador-web → redactor → corrector. Validat en producció a llista.cat.

### Què fer si el teu projecte ja usa el llavor

Res obligatori. Si el teu projecte publica contingut editorial: llegeix `equips/editorial/MANIFEST.md`.

---

## [1.0.0] — (commit inicial)

Llavor base: nucli (worker, easy-worker, oracle), servei memòria, servei docs, servei okr, servei pm, servei dev, servei cultura-agents, servei guia-projectes-agentic. WIZARD.md, NORMES_GLOBALS.md, plantilles.
