# Servei Docs

## Descripció

Custòdia documental per a projectes agentic. Manté la coherència entre el que diuen els docs i el que fa el sistema, sessió a sessió.

**Activar quan**: el projecte comença a tenir documentació que creix i que cal que algú mantingui coherent entre sessions.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/doc-curator.md` | `.claude/agents/doc-curator.md` |

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

## Llegat de cicatrius (format per al projecte destí)

El Servei Docs inclou la pràctica opcional de mantenir un fitxer de cicatrius: errors reals viscuts pel custodi, destil·lats en regles per als futurs custodis del mateix projecte.

Format canònic a `docs/meta/llegat-doc-curator.md`:

```markdown
# Llegat del doc-curator

## Cicatriu N — [títol breu]

[Sessió/moment concret. Descripció honesta del que va passar.]

**La regla que me'n va néixer**: [regla destil·lada, en imperatiu]

**Si t'hi trobes**: [senyal de reconeixement i acció concreta]
```

**Important**: les cicatrius s'escriuen per al custodi del **mateix projecte**, no com a regles universals. El que funciona aquí pot no aplicar en un altre domini.
