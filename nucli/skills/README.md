# Skills del nucli

Skills compartits per a tots els agents del projecte destí.

## Quan crear un skill aquí

Un skill del nucli es justifica quan:
- El contingut és **compartit** per múltiples agents (no per a un sol agent)
- El contingut és **volàtil** — canvia independentment dels agents que l'usen
- El contingut és **referencial** — documentació tècnica, schemas, convencions

Si el contingut és part de la "personalitat" d'un agent específic, va al system prompt de l'agent — no aquí.

## Com usar un skill al frontmatter d'un agent

```yaml
---
name: nom-agent
description: ...
skills:
  - nom-skill
---
```

El contingut complet del skill s'injecta al context de l'agent en startup.

**Atenció al cost**: cada skill injectat augmenta els tokens d'entrada en cada invocació. Mesura l'impacte abans de generalitzar.

## Desplegament al projecte destí

Els fitxers d'aquest directori es copien a `.claude/skills/` del projecte destí durant el bootstrap.

## Skills del nucli previstos

*(Cap creat encara. S'afegiran quan un contingut demostri ser compartit per ≥2 agents.)*
