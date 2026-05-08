# Convencions del framework

## Nomenclatura de processos: BPMN (ISO/IEC 19510)

**Per què BPMN:** és l'estàndard industrial de facto per a processos organitzacionals (ISO/IEC 19510), adoptat per Camunda, SAP i Salesforce. El paper "Towards Modeling Human-Agentic Collaborative Workflows" (arXiv 2412.05958) confirma BPMN com a llengua franca entre empreses i sistemes agèntics LLM. El framework ja seguia BPMN implícitament — aquesta secció ho formalitza.

**Per què no McKinsey:** no publica estàndard de nomenclatura. Framework propietari per client.
**Per què no MetaGPT SOP:** útil per als camps obligatoris (integrats a la plantilla), no com a convenció semàntica.

### Regles de noms

| Element | Patró | Exemple |
|---------|-------|---------|
| **Procés** (el conjunt) | `[Objecte] + [verb nominalitzat]` | *Gestió de deutes*, *Tancament de tasca* |
| **Pas / Tasca** | `[Verb infinitiu] + [Objecte]` | *Validar DoD*, *Actualitzar KRs* |
| **Disparador** | `[Objecte] + [estat]` | *DoD validat*, *Tasca proposada* |
| **Agent** | `[domini-opcional]-[rol-funcional]` | *dev-worker*, *okr-curator*, *pm* |

### Regla per a agents

Noms per **rol funcional** (`pm`, `worker`, `oracle`), no per analogia humana (`director`, `analista`).
Quan l'agent és especialitzat per domini, prefix obligatori: `[domini]-[rol]` → `dev-worker`, `data-analyst`.

**Per què:** els rols humans hereten connotacions de jerarquia i domain knowledge que no corresponen a l'agent. `pm` és inequívoc. `director` no ho és.

---

## Glossari canònic

| Terme | Definició | Criteri de distinció |
|-------|-----------|---------------------|
| **Agent** | Entitat autònoma amb rol fix i fitxer de definició propi | L'actor individual |
| **Equip** | Conjunt d'agents que produeix output concret per encàrrec | Retorna resultat a l'usuari o a un altre agent com a feina feta |
| **Servei** | Infraestructura transversal que habilita capacitats sense produir output per encàrrec | Habilita el sistema; no produeix artefactes propis |
| **Procés** | Workflow intern entre agents sense entry point d'usuari | El dispara el sistema |
| **Command** | Workflow amb entry point explícit de l'usuari | L'usuari el crida directament |

**Test de distinció Equip vs Servei:** "A qui retorna un resultat?" → a l'usuari o com a output de treball = equip. Retorna capacitat al sistema = servei.

---

## Fonts

- BPMN: [Camunda — Naming BPMN Elements](https://docs.camunda.io/docs/components/best-practices/modeling/naming-bpmn-elements/)
- APQC PCF: [Process Classification Framework v7.4](https://www.apqc.org/process-frameworks)
- Agents LLM: [Towards Modeling Human-Agentic Collaborative Workflows](https://arxiv.org/html/2412.05958v1)
- MetaGPT SOP: [MetaGPT: Meta Programming for Multi-Agent Collaborative Framework](https://arxiv.org/abs/2308.00352)
