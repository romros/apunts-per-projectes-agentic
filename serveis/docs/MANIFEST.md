```yaml
servei: docs
categoria: domini
depen_de: []
depen_de_recomanat:
  - memoria
incompatible_amb: []
requisits_projecte: []
aporta_agents:
  - doc-curator
aporta_commands: []
aporta_skills: []
escriu_a:
  - .claude/agents/doc-curator.md
  - docs/meta/
nota_territorial: "doc-curator gestiona docs/ però NO toca okr/ — aquest directori pertany exclusivament a okr-curator si el servei OKR és actiu."
```

# Servei Docs

## Descripció

Custòdia documental per a projectes agentic. Manté la coherència entre el que diuen els docs i el que fa el sistema, sessió a sessió.

**Activar quan**: el projecte comença a tenir documentació que creix i que cal que algú mantingui coherent entre sessions.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/doc-curator.md` | `.claude/agents/doc-curator.md` |
| (creat pel projecte) `docs/meta/incidents-doc-curator.md` | `docs/meta/incidents-doc-curator.md` — el projecte el crea quan acumula incidents propis |

---

## Estructura mínima recomanada al projecte destí

```
docs/
  meta/
    inventory.md   ← índex de tots els docs del projecte
    progress.md    ← estat documental entre sessions (memòria del custodi)
  archive/         ← docs obsolets (mai eliminar, sempre arxivar)
```

El `CLAUDE.md` del projecte ha de declarar explícitament quins fitxers i directoris pertanyen al doc-curator. Sense declaració, el custodi no actua.

---

## Dependències

Cap. El Servei Docs no depèn d'altres serveis.

*(Nota: si el projecte usa Servei Memòria, el doc-curator pot usar `flash-remember` per registrar decisions documental. Recomanat però no obligatori.)*

---

## Activació manual

```bash
# 1. Copiar agent
mkdir -p .claude/agents
cp <path-servei>/agents/doc-curator.md .claude/agents/doc-curator.md

# 2. Crear estructura docs mínima
mkdir -p docs/meta docs/archive

# 3. Inicialitzar fitxers canònics
echo "# Inventory\n\n(Buit. Afegir docs a mesura que es creïn.)" > docs/meta/inventory.md
echo "# Progress\n\n(Buit. Doc-curator actualitza al final de sessions rellevants.)" > docs/meta/progress.md

# 4. Declarar al CLAUDE.md del projecte:
# ## Servei Docs
# El doc-curator gestiona: docs/meta/inventory.md, docs/meta/progress.md, docs/archive/
# No toca: [la resta del projecte]
```

---

## Incidents operatius (format per al projecte destí)

El Servei Docs inclou la pràctica opcional de mantenir un registre d'incidents: errors reals viscuts pel custodi, destil·lats en regles per als futurs custodis del mateix projecte.

Format canònic a `docs/meta/incidents-doc-curator.md`:

```markdown
# Incidents operatius — doc-curator

**Incident**: [situació concreta on alguna cosa va fallar]
**Rule**: [regla derivada, en imperatiu]
**Signal**: [com detectar que estàs a punt de repetir-ho]

---

**Incident**: ...
```

**Important**: els incidents s'escriuen per al custodi del **mateix projecte**, no com a regles universals. El coneixement guanyat per error en un projecte és intransferible; el format sí.

