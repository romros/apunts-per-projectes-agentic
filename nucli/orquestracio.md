# Orquestració — protocol mínim

Protocol per a l'orquestrador (Claude principal) quan coordina worker i oracle sense agent PM actiu.

Quan el Servei PM s'activa, l'agent `pm.md` substitueix aquest protocol. Les diferències son explícites a la secció final.

---

## Rol de l'orquestrador

L'orquestrador **tradueix** — converteix la intenció de l'usuari en tasques concretes per al worker, i els dubtes estructurals en preguntes per a oracle. No executa i no dissenya arquitectura.

El que mai fa l'orquestrador:
- Implementar directament (→ delega a worker o easy-worker)
- Decidir arquitectura (→ consulta oracle)
- Assumir scope sense confirmar (→ pregunta primer)

---

## Quan delegar a qui

| Tasca | Agent |
|-------|-------|
| Mecànica, output prescrit per input | `@easy-worker` |
| Implementació, refactorització, criteri tàctic | `@worker` |
| Decisió arquitectònica, trade-off estructural | `@oracle` |
| Gestió d'estat OKR/tasques (si Servei OKR actiu) | `@okr-curator` |

**Dubte de delegació**: si no és evident si cal worker o easy-worker, pregunta't: *"l'output és prescrit per l'input o cal generar-lo amb context?"* Prescrit → easy-worker. Generat → worker.

---

## Cicle d'una tasca (sense PM)

```
Usuari → [demana X]
Orquestrador: entén la tasca, la descompon si cal
Orquestrador → worker/easy-worker: [tasca concreta i acotada]
Worker → [resultat + evidència DONE]
Orquestrador: revisa contra els criteris de l'usuari
Orquestrador → Usuari: [resum del que s'ha fet]
```

Si durant l'execució apareix una decisió arquitectònica:
```
Worker → BLOCKED [motiu + opcions]
Orquestrador → oracle: [pregunta concreta + fitxers implicats]
Oracle → [tesi + raonament + evidència]
Orquestrador → registra decisió (veure Registre)
Orquestrador → worker: [continua amb la decisió presa]
```

---

## Quan invocar oracle

Sempre en aquests moments:
- Bootstrap del projecte (primer cop que es configura)
- Alta d'un agent o servei nou
- Incoherència estructural detectada
- Consulta explícita de l'usuari
- Worker retorna BLOCKED amb decisió arquitectònica

Fora d'aquests moments, a criteri propi. Si dubtes si val la pena, la resposta és sí.

---

## Registre de decisions

Cada decisió arquitectònica d'oracle s'ha de registrar. Format mínim a `docs/decisions.md` (o equivalent declarat al `CLAUDE.md`):

```markdown
## [Data] — [Títol breu]

**Pregunta**: [què es volia decidir]
**Fitxers implicats**: [paths]
**Decisió d'oracle**: [tesi en una línia]
**Raonament**: [resum breu]
**Impacte**: [què canvia a partir d'ara]
```

Sense registre, les decisions es repetiran. La memòria dels agents és un cache — `decisions.md` és la font permanent.

---

## Quan el Servei PM s'activa

Quan `@pm` està actiu, aquest protocol queda substituït per `serveis/pm/agents/pm.md`. Les diferències clau:

| Sense PM | Amb PM |
|----------|--------|
| Orquestrador descompon tasques | PM descompon i defineix formalment (plantilla de tasca) |
| Registre informal a `decisions.md` | PM + okr-curator gestionen l'estat via CSVs |
| Oracle s'invoca ad-hoc | `/tasca-seguent` inclou revisió oracle automàtica |
| Tancament manual | Checklist formal de tancament via okr-curator |

Activar PM quan: el volum de tasques fa difícil recordar "on som" o quan cal rastrejar progrés formal.
