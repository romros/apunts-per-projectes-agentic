# Glossari canònic

Vocabulari definitiu del framework. Termes mútuament excloents — cap element pertany a dues categories.

Per a nomenclatura de processos i convencions de noms, veure [`docs/convencions.md`](convencions.md).

---

| Terme | Definició | Criteri de distinció |
|-------|-----------|---------------------|
| **Agent** | Entitat autònoma amb rol fix, fitxer de definició propi i capacitat d'acció delegada per l'orquestrador. | L'actor individual. Un agent pot pertànyer a un equip o a un servei. |
| **Equip** | Conjunt d'agents que executa un workflow per produir un output concret per encàrrec. | Retorna un resultat a l'usuari o a un altre agent com a feina feta. |
| **Servei** | Component d'infraestructura transversal que habilita capacitats al sistema sense produir outputs per encàrrec. | Habilita el sistema; no produeix artefactes propis per encàrrec. |
| **Procés** | Workflow intern entre agents sense entry point d'usuari. El dispara el sistema, no l'usuari. | Fitxer a `processos/`. ID format `PROC-NNN`. |
| **Command** | Workflow amb entry point explícit de l'usuari. L'usuari el crida directament (slash command). | Fitxer a `commands/`. ID format `CMD-NNN`. |
| **DoD** | Definition of Done. Llista de criteris verificables que han de ser certs perquè una tasca es pugui declarar completada. | Normalment: tests passants, build OK, revisió PM aprovada. Específic per projecte. |
| **OKR** | Objectives and Key Results. Marc de gestió d'objectius: un Objectiu qualitatiu + Key Results mesurables que indiquen si s'ha assolit. | Gestionat per `okr-curator`. |
| **KR** | Key Result. Mètrica concreta i mesurable que indica el progrés cap a un Objectiu. | Forma part d'un OKR. |
| **Roadmap** | Seqüència planificada de tasques agrupades per un objectiu de cicle. | Gestionat per `equips/okr`. Té estat: actual, tancat, futur. |
| **Backlog** | Llista ordenada de tasques pendents d'executar. | El PM el llegeix per identificar la tasca següent. |
| **Fork point** | Decisió arquitectònica que no es pot desfer fàcilment i que pot tenir impacte durador. | Activa `@oracle` obligatòriament. |

---

## Test ràpid: Equip vs Servei

**Pregunta:** "A qui retorna un resultat?"
- → A l'usuari o a un altre agent com a output de treball = **Equip**
- → Retorna capacitat al sistema sense encàrrec exprés = **Servei**

**Exemples:**
- `equips/pm` → produeix definicions de tasques per encàrrec = equip ✓
- `serveis/memoria` → habilita la memòria persistent sense producir artefactes = servei ✓
- `equips/okr` → produeix registres i roadmaps per encàrrec del PM = equip ✓
- `serveis/corrector-catala` → habilita correcció lingüística quan se li demana = servei ✓

---

*Versió 1.0 · 2026-05-08 — sincronitzat amb `docs/convencions.md`*
