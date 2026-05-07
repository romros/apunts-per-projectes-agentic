# Skills de dev — per projecte

Aquest directori conté skills que el projecte destí crea per al seu domini tecnològic concret. No hi ha skills predefinides al llavor — el contingut és per-projecte.

## Quan crear una skill aquí

Una skill de dev es justifica quan el contingut:
- Múltiples invocacions de dev-worker el necessiten de referència
- Canvia independentment de l'agent (arquitectura evoluciona, testing patterns canvien)
- És massa llarg per posar-lo al system prompt de dev-worker

## Com usar una skill al dev-worker

Al override local de dev-worker (`.claude/agents/dev-worker.md` del projecte):

```yaml
---
name: dev-worker
description: ...
skills:
  - arquitectura-capes
  - testing-patterns
---
```

El contingut complet de cada skill s'injecta al context de l'agent en startup.

## Budget de tokens

El conjunt de skills carregades per defecte **no hauria de superar ~5.000 tokens**. Per sobre d'aquest límit, el cost per invocació creix de forma notable. Si una skill és massa gran, divideix-la o mou part del contingut a referència sota demanda.

## Exemples de skills típiques per projectes de codi

- `arquitectura-capes.md` — capes del projecte i direcció d'imports permesa
- `testing-patterns.md` — quines coses s'han de testar i com
- `validacio-canonica.md` — com es valida DONE en aquest projecte (Docker, pytest, etc.)
- `convencions-codi.md` — estil, imports, naming, patrons repetitius
