```yaml
servei: editorial
categoria: domini
depen_de:
  - memoria
depen_de_recomanat:
  - docs
incompatible_amb: []
requisits_projecte:
  - analista-dades  # agent que el projecte ha de definir — accés a la font de dades interna. Sense ell, Fases 1 i 3 de /cicle es fan manualment.
aporta_agents:
  - radar-web
  - ideator
  - investigador-web
  - redactor
  - corrector
aporta_commands:
  - /cicle
aporta_skills: []
escriu_a:
  - .claude/agents/
  - .claude/commands/cicle.md
  - docs/flux-editorial.md
  - "pluja de idees/"
  - briefs/
  - peces/
```

# Servei Editorial

Pipeline multi-agent per produir articles de blog de qualitat periodística. Combina escaneig de tendències externes, anàlisi de dades internes i un flux de redacció + correcció en 5 fases.

**Validat en producció**: llista.cat (projecte periodístic). Abstracció realitzada 2026-04-28. Invariants conservats: flux de 5 fases, checkpoint humà obligatori, delegació per cost de model.

---

## Activar quan

El projecte publica contingut editorial regularment i vol un pipeline estructurat d'article amb checkpoint humà i rastreig d'evidències.

---

## Fitxers que aporta

| Fitxer del servei | Destí al projecte |
|-------------------|-------------------|
| `agents/radar-web.md` | `.claude/agents/radar-web.md` |
| `agents/ideator.md` | `.claude/agents/ideator.md` |
| `agents/investigador-web.md` | `.claude/agents/investigador-web.md` |
| `agents/redactor.md` | `.claude/agents/redactor.md` |
| `agents/corrector.md` | `.claude/agents/corrector.md` |
| `commands/cicle.md` | `.claude/commands/cicle.md` |
| `docs/flux-editorial.md` | `docs/flux-editorial.md` |

---

## Estructura de directoris que crea al projecte destí

```
pluja de idees/    ← senyals i scouts
briefs/            ← briefs editorials
peces/<slug>/      ← articles finals per tema
  grafics/
```

---

## Dependències

- **Nucli base obligatori**: orquestrador + worker + easy-worker. `easy-worker` és el recurs de delegació mecànica del pipeline.
- **Servei Memòria obligatori**: per recordar articles publicats entre sessions i evitar reproposta de temes.
- **`analista-dades`**: **NO inclòs** — cada projecte ha de definir el seu propi agent d'anàlisi de dades internes. Veure secció "Configuració post-activació".

---

## Configuració post-activació (obligatòria)

El projecte ha de crear `.claude/agents/analista-dades.md` o configurar un agent equivalent amb accés a la seva font de dades interna (base de dades, API, fitxers estructurats).

L'agent ha de retornar senyals (patrons atípics, continguts destacats, mètriques) en format compatible amb els inputs de `ideator`. Documenta la font al `CLAUDE.md` del projecte.

Sense `analista-dades`, les Fases 1 i 3 del `/cicle` es fan manualment o s'ometen.

---

## Activació manual

```bash
# 1. Copiar agents i commands
mkdir -p .claude/agents .claude/commands docs

cp <path-servei>/agents/radar-web.md .claude/agents/
cp <path-servei>/agents/ideator.md .claude/agents/
cp <path-servei>/agents/investigador-web.md .claude/agents/
cp <path-servei>/agents/redactor.md .claude/agents/
cp <path-servei>/agents/corrector.md .claude/agents/

cp <path-servei>/commands/cicle.md .claude/commands/
cp <path-servei>/docs/flux-editorial.md docs/

# 2. Crear estructura de directoris
mkdir -p "pluja de idees" briefs peces

# 3. Crear analista-dades (obligatori — cada projecte el defineix)
# Crea .claude/agents/analista-dades.md amb accés a la teva font de dades

# 4. Declarar al CLAUDE.md del projecte:
# ## Servei Editorial
# Pipeline actiu. Ús: /cicle <tema>
# analista-dades: [CONFIGURAR — veure docs/flux-editorial.md]
# Directoris: pluja de idees/, briefs/, peces/
```

---

## Nota sobre easy-worker

Si el projecte ja té `easy-worker` instal·lat (nucli del framework), no cal instal·lar cap agent addicional de suport mecànic. `easy-worker` és el destí de les delegacions mecàniques de tots els agents editorials.
