# Servei cultura-agents

## Descripció

Paquets culturals que donen veu i caràcter als agents d'un projecte. Cada pack defineix un to de comunicació, valors i metàfores compartides. Opcional — cap projecte l'ha de tenir.

**Activar quan**: el projecte vol que els seus agents tinguin una identitat coherent i reconeixible. Si la comunicació purament funcional és suficient, usa el pack `neutral` o no actives el servei.

---

## Com funciona

Un pack és una **skill** que s'injecta al context de cada agent en startup. No canvia les eines ni el protocol dels agents — canvia com s'expressen.

```
packs/<nom>.md          ← contingut del pack (to, valors, metàfores)
       ↓ (copiar)
.claude/skills/cultura.md   ← skill activa al projecte destí
       ↓ (carregada per)
agents amb `skills: [cultura]` en el frontmatter
```

---

## Packs disponibles

| Pack | Descripció | Estat |
|------|------------|-------|
| `neutral` | Tècnic pur. Cap personalitat. Default. | ✓ |
| `laboratori` | Evidència, urgència artesanal, pragmatisme militant. Instruments especialitzats d'una sola ment. | ✓ (validat laboratori_profes) |

Altres packs son **hipòtesis**. Entren al catàleg quan un projecte real els validi — mai abans.

---

## Dependències

Cap.

---

## Activació manual

```bash
# 1. Triar el pack
# (consultar packs/ per veure els disponibles)

# 2. Copiar el pack com a skill del projecte
mkdir -p .claude/skills
cp <path>/packs/<nom>.md .claude/skills/cultura.md

# 3. Declarar la skill als agents que han d'adoptar la cultura
# Al frontmatter de cada agent (.claude/agents/<nom>.md):
# skills:
#   - cultura

# 4. Declarar al CLAUDE.md del projecte
# ## Servei cultura-agents
# Pack actiu: <nom>
# Agents que el carreguen: [llista]
```

---

## Crear un pack nou

Un pack nou es justifica quan:
- Un projecte real ha operat amb una cultura específica durant ≥2 mesos
- Els agents han adoptat un to coherent i reconeixible
- La cultura ha demostrat valor en les interaccions

Format canònic (veure `packs/monastic.md` com a referència):
- To de comunicació
- Metàfores i imatges
- Valors que guien les respostes
- Quan usar-lo
- Nota sobre l'origen (d'on ve, quin projecte el va validar)

---

## Nota important

La cultura ha de ser **subtextual, no declarativa**. L'agent no ha de dir "com a escriba, jo..." — ha de comunicar-se amb el to del pack sense anunciar-ho. Un pack mal aplicat produeix agents que semblen disfressats, no caracteritzats.
