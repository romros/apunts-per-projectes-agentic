# FUNDATOR.md — manteniment intern del llavor

> Aquest fitxer és per a qui **manté** el repo `apunts-per-projectes-agentic`, no per a qui l'usa.
> Si has arribat aquí buscant com fer el teu projecte agentic, ves a `WIZARD.md`.

---

## Rol de fundator

El fundator és qui manté aquest llavor concret. Les seves responsabilitats:

- Actualitzar el catàleg de serveis quan un patró nou s'ha validat en ≥2 projectes reals
- Gestionar versions del llavor (canvis que afecten projectes ja bootstrappejats)
- Detectar tensions internes del llavor (incoherències entre WIZARD.md, MANIFEST.md i els serveis)
- Decidir quan un patró d'un pilot promou a norma global

El fundator **no és un agent del catàleg** — és un rol de manteniment. No s'instal·la a projectes destí.

---

## Quan promoure un patró a norma del llavor

Criteris (tots han de complir-se):

1. **Validat en ≥2 contextos reals i diferents** — no el mateix tipus de projecte dues vegades
2. **La fricció sense el patró s'ha observat directament** — no és especulació
3. **El patró és transversal** — aplica a projectes de naturalesa diferent (dev, editorial, recerca, etc.)
4. **Oracle l'ha revisat** — cap norma global entra sense filtre arquitectònic

Si un patró compleix 1-3 però no 4: es queda a `docs/pilots/` com a candidat fins que oracle el validi.

---

## Quan afegir un servei al catàleg

Un servei és un paquet d'agents, normes i scripts que s'activa com a unitat. Per entrar al catàleg:

1. Ha existit de forma orgànica en almenys un projecte real (no inventat per al llavor)
2. S'ha destil·lat seguint el cicle de 4 passos (preguntar a l'agent original → oracle → llegat → escriure fitxers)
3. Té `MANIFEST.md` amb dependències declarades
4. L'agent principal (si n'hi ha) té el filtre contingut/comportament aplicat

Si un servei no compleix tots quatre: es documenta com a hipòtesi a `docs/serveis-candidats.md`, no entra al catàleg.

---

## Política de versionat

### Per qué cal

Un projecte bootstrappejat fa 3 mesos i un altre d'avui es basen en versions del llavor potencialment diferentes. Canvis a `plantilles/CLAUDE.md`, `nucli/oracle.md` o `NORMES_GLOBALS.md` afecten projectes futurs però no actualitzen els existents. Sense política, els projectes divergeixen silenciosament.

### Com funciona

El llavor usa **versionat semàntic** al `MANIFEST.md`:

- **PATCH** (ex. 1.0.1): correccions de text, millores de claredat, scripts que no canvien comportament. Els projectes existents poden ignorar-ho.
- **MINOR** (ex. 1.1.0): nous serveis al catàleg, noves capes opcionals. Els projectes existents no es trenquen però poden adoptar-ho.
- **MAJOR** (ex. 2.0.0): canvis a `NORMES_GLOBALS.md`, a contractes de nucli (`oracle.md`, `worker.md`, `easy-worker.md`), o a l'estructura de `plantilles/`. **Poden trencar projectes existents.**

### Procediment per a canvis MAJOR

1. Documentar el canvi i l'impacte a `docs/changelog.md` (crear si no existeix)
2. Especificar el path de migració: "si el teu projecte té X, fes Y"
3. Actualitzar la versió al `MANIFEST.md`
4. Marcar el commit amb tag `v<versió>`

### El marcador de versió als fitxers generats

Cada `CLAUDE.md` i `AGENTS.md` generat pel WIZARD conté:
```
# Generat des de apunts-per-projectes-agentic@<COMMIT_SHA>
```

Quan un projecte existeix vol saber si té canvis pendents d'adoptar, compara el seu SHA amb el HEAD del llavor i mira `docs/changelog.md` per al rang.

---

## Recollida de friccions de pilots

### On viuen

`docs/pilots/` — un fitxer per pilot, nomenat `<data>-<nom-projecte-anonimitzat>.md`.

El format és el que genera el WIZARD al Pas 7 (`docs/llavor-friccions.md` del projecte destí).

### Com s'usen

Quan hi ha ≥3 fitxers de pilots, llegir-los en paral·lel i buscar patrons:
- Fricció que apareix en ≥2 pilots → candidat a millora del WIZARD o del nucli
- Fricció específica de plataforma → documentar a `docs/notes-plataforma.md`
- Fricció de fusió amb configuració prèvia → revisar el flux del Pas 2 del WIZARD

No actuar sobre una sola fricció. L'evidència és el patró, no l'anècdota.

---

## Detecció de tensions internes

Signes que el llavor té una tensió interna (el fundator les detecta):

- El WIZARD descriu un flux que un fitxer de nucli contradiu
- Un MANIFEST declara una dependència que el WIZARD no instal·la
- Una norma de `NORMES_GLOBALS.md` no té reflex a `plantilles/CLAUDE.md`
- Un artefacte existeix al repo però no té ruta d'instal·lació documentada

Quan detectis una tensió:
1. Obre una nota a `docs/tensions-llavor.md` (crear si no existeix) amb data i descripció
2. Consulta oracle si té implicació arquitectònica
3. Resol o marca com a deute amb condició de resolució

---

## Procés de destil·lació d'agents

Quan un projecte proposa un agent candidat (via `docs/aprenentatges-per-llavor.md` o directament), segueix aquests passos.

### Pas 1 — Descriu el candidat

Recull la informació de l'agent amb aquest format:

```markdown
## Agent candidat: [nom]

**Propòsit** (1-2 frases): ...
**Eines que usa**: Read / Write / Bash / WebSearch / WebFetch / ...
**Model recomanat**: haiku (tasques mecàniques) / sonnet (decisió estàndard) / opus (criteri arquitectònic)
**Quan invocar-lo**: ...
**Quan NO invocar-lo**: ...
**Ha funcionat en**: [descripció breu del projecte i quant de temps]
**Errors típics que comet**: ...
**Per qué és un agent i no un skill**: [ha de tenir comportament diferent, no només contingut diferent]
```

Si no pots respondre "per qué és un agent i no un skill", para aquí. Probablement és un skill.

### Pas 2 — Interroga l'agent original

Obre una sessió amb l'agent tal com existeix al projecte d'origen. Pregunta-li:

1. Com descriuries el teu rol en 3 línies, sense que jo t'ho digui?
2. Quins errors comets habitualment? Quan falles?
3. Quan hauries de refusar una petició i no ho fas?
4. Quin és el contingut mínim que necessites al context per operar bé?
5. Si haguessis d'existir en un projecte diferent al teu (un altre domini, un altre stack), qué canviaries de tu mateix i qué conservaries?

Les respostes revelen el que el document no diu. Usa-les per completar o corregir el Pas 1.

### Pas 3 — Consulta oracle

Passa-li el resultat del Pas 1 + Pas 2 i pregunta:

1. El perfil mínim universal és sòlid o conté coses massa específiques del projecte d'origen?
2. Ha d'entrar com a servei propi o com a extensió d'un servei existent del catàleg?
3. Alguna restricció o invariant que hauria de tenir i no té?

Sense oracle, l'agent no entra al catàleg.

### Pas 4 — Escriu els fitxers

Amb el veredicte d'oracle, crea:

**`serveis/<nom>/agents/<nom>.md`** — estructura:
```markdown
---
name: <nom>
description: <una línia, per a l'usuari que tria agents>
effort: low | medium | high
tools: [llista d'eines]
---

# <Nom>

## Rol
[Descripció clara. Primera persona. Sense adulació.]

## Quan se m'invoca
[Disparadors concrets]

## Quan no se m'invoca
[Límits explícits]

## Com reporto
[Format de resposta]

## Invariants
[El que no faig mai]

## Override de projecte
[El projecte destí pot sobreescriure aquest fitxer localment]
```

**`serveis/<nom>/MANIFEST.md`** — amb frontmatter YAML i seccions:
- Descripció
- Quan activar
- Fitxers que aporta
- Dependències (format: Requereix activat / Llegeix de / Escriu a)
- Activació manual

### Criteri d'acceptació

L'agent entra al catàleg si:
- [ ] Ha funcionat en ≥1 projecte real (no prototip)
- [ ] Oracle ha validat el perfil (Pas 3)
- [ ] El test "agent vs skill" passa (comportament diferent, no només contingut)
- [ ] El MANIFEST té dependències declarades

Si no compleix tots quatre, es queda a `docs/candidats/` com a hipòtesi.

---

## Arxiu de decisions del llavor

Decisions de disseny importants del llavor (per qué el WIZARD fa X, per qué el nucli té Y) viuen a `docs/decisions-llavor.md`.

Format:
```
## [data] — [títol breu]
**Decisió**: [què s'ha decidit]
**Raonament**: [per qué]
**Alternativa descartada**: [si n'hi ha]
**Condició de revisió**: [quan caldria reconsiderar-ho]
```

Sense registre, les decisions evaporen entre sessions i es repeteixen esforços.
