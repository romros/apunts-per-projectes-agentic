# Checkpoint sessió 2026-05-08

> **Propòsit:** Contextualitzar tot el que s'ha construït en les darreres sessions per poder revisar-ho en fred, detectar incoherències i decidir com aplicar el llavor a si mateix.

---

## 1. Què s'ha construït (v2.0.0)

### Reestructuració equips / serveis
- **Decisió clau**: OKR mogut de `serveis/okr/` → `equips/okr/` per incoherència estructural detectada per l'oracle. Criteri: "A qui retorna un resultat?" → encàrrec directe = equip; habilita sistema passivament = servei.
- Dois nous serveis destil·lats de `laboratori_profes`: `serveis/ux-expert/` i `serveis/code-curator/`.

### Documentació de sistema (nova)
| Fitxer | Funció |
|--------|--------|
| `GRAPH.md` | Mapa complet: 23 agents (A01–A23), 4 processos (PROC-001 a PROC-004), 2 commands (CMD-001, CMD-002), dependències entre components, diagrama Mermaid |
| `docs/GLOSSARI.md` | 11 termes canònics amb test Equip vs Servei |
| `docs/convencions.md` | Convenció de nomenclatura BPMN (ISO/IEC 19510) + APQC PCF v7.4, amb fonts i justificació |
| `plantilles/proces-guia.md` | Guia de 6 passos per crear un procés + checklist oracle |
| `plantilles/proces.md` | Plantilla canònica amb 7 camps obligatoris al frontmatter |

### Processos enriquits
Tots els processos i commands han rebut frontmatter complet: `id`, `resum`, `agents`, `equips-serveis`, `serveis-requerits`, `cost-estimat` (rang, model dominant, factors).

| ID | Fitxer | Cost estimat |
|----|--------|-------------|
| PROC-001 | `processos/executar-tasca.md` | 20k–50k tokens, sonnet |
| PROC-002 | `processos/tancar-tasca.md` | 15k–30k tokens, sonnet/opus |
| PROC-003 | `processos/nou-roadmap.md` | 30k–70k tokens, opus |
| PROC-004 | `processos/gestio-deutes.md` | 8k–15k tokens, sonnet |
| CMD-001 | `commands/tasca-seguent.md` | 15k–35k tokens, sonnet |
| CMD-002 | `commands/revisa-opinio.md` | 20k–40k tokens, opus |

### Mode d'operació a plantilles
`plantilles/CLAUDE.md` té nova secció `## Mode d'operació`: consultiu per defecte, automàtic activable via bloc al CLAUDE.md del projecte.

### Changelog
`docs/changelog.md` — entrada v2.0.0 amb SHA `3e182c9`, breaking changes documentats (migració `serveis/okr/` → `equips/okr/`).

---

## 2. Gaps detectats per l'oracle (pendents)

### Prioritat alta — WIZARD.md desactualitzat
`WIZARD.md` no menciona `ux-expert` ni `code-curator`. Un nou usuari que segueixi el wizard pas a pas no sabria que existeixen. Cal afegir-los als passos de decisió de serveis opcionals.

### Prioritat mitjana — `cultura-agents` inconsistent al GRAPH.md
Apareix a la taula "Serveis per activar" (GRAPH.md:82) amb nota *(sense agent dedicat — activa via fitxers de configuració)* però no apareix a la taula de dependències ni al diagrama Mermaid. O s'integra correctament o s'elimina de la taula.

### Prioritat baixa — Stubs a `processos/`
`processos/revisa-opinio.md` i `processos/tasca-seguent.md` són stubs de redirecció cap a `commands/`. El GRAPH.md no ho documenta. Un agent que llegeixi el GRAPH.md no sabria per què existeixen aquests fitxers a `processos/`.

---

## 3. Autoapplicació del llavor a si mateix

### Pregunta central
El llavor és un framework per a projectes agèntics. Hauria d'usar-se a si mateix? Pot un projecte ser alhora el producte i el consumidor del marc?

### Veredicte de l'oracle (sessió 2026-05-08)
**Sí per a infraestructura operativa. No per a governança constitucional.**

Concretament:
- `serveis/memoria/` → el llavor podria tenir el seu propi pipeline flash → short-term → skills (ara no en té)
- `equips/pm/` → el llavor podria tenir OKRs i roadmap propis (ara gestiona el seu roadmap manualment via changelog)
- **No**: la governança del llavor (FUNDATOR.md, criteris de promoció, versionat) és diferent de la governança d'un projecte fill — no s'hauria d'aplicar el `equips/pm/` literalment

### Agents identificats com a gap a l'organisme (context)
- `@researcher` — cap agent al llavor ni a l'organisme té mandat explícit de llegir el món extern de forma sistemàtica. `equips/analisi-dades/agents/researcher.md` existeix al llavor però no s'aplica a si mateix.

### Preguntes obertes per a la revisió
1. El llavor hauria de tenir un roadmap formal (OKR + KRs) o n'hi ha prou amb el changelog?
2. Quin projecte "fill" hauria de servir de cas de prova per al WIZARD.md actualitzat?
3. `FUNDATOR.md` i `WIZARD.md` estan sincronitzats? (No verificat en aquesta sessió)
4. Hi ha agents referenciats a GRAPH.md que no existeixen al filesystem? (Oracle va verificar que tots existien — però cal re-verificar si hi ha hagut canvis)

---

## 4. Coherència pendent de verificar

Abans de continuar construint, revisar:

- [ ] `WIZARD.md` vs `GRAPH.md` — estan sincronitzats? WIZARD guia la instal·lació; GRAPH és la font de veritat. Si divergeixen, GRAPH mana.
- [ ] `FUNDATOR.md` — conté els criteris de promoció de patrons. S'han promocionat patrons nous en v2.0.0? Cal actualitzar?
- [ ] `plantilles/CLAUDE.md` — la secció `## Mode d'operació` nova és coherent amb `NORMES_GLOBALS.md`?
- [ ] Tots els agents de GRAPH.md (A01–A23) tenen els camps `model:` i `effort:` al frontmatter? (v1.2.0 ho va introduir; v2.0.0 va afegir agents nous — cal verificar)

---

## 5. Estat del commit

Darrer commit pujat: `827a983` (main). Tot el de dalt és a producció.

Aquest checkpoint no és codi ni procés — és context per a la propera sessió de revisió.
