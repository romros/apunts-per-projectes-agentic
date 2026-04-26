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

## Format oficial d'un skill (Claude Code)

Cada skill és un directori amb `SKILL.md` com a punt d'entrada:

```
<nom-skill>/
  SKILL.md           ← obligatori
  template.md        ← opcional: plantilla per emplenar
  examples/
    sample.md        ← opcional: exemple d'output esperat
  scripts/
    helper.sh        ← opcional: script que Claude pot executar
```

**`SKILL.md` mínim:**

```yaml
---
name: nom-skill
description: Quan usar aquest skill. Front-load el cas d'ús.
# when_to_use: frases addicionals de trigger (opcional)
# disable-model-invocation: true  # si vols invocació manual només
# user-invocable: false           # si Claude ha d'invocar-lo, no l'usuari
# allowed-tools: Read Bash        # eines pre-aprovades per a aquest skill
# effort: medium                  # sobreescriu l'effort de la sessió
---

[Contingut del skill: instruccions, convencions, patrons...]
```

El camp `description` és el que Claude usa per decidir quan activar el skill automàticament. Front-load el cas d'ús principal — el text combinat de `description` + `when_to_use` es talla a 1.536 caràcters.

Ref: https://code.claude.com/docs/en/skills

## Skills del nucli disponibles

| Skill | Command | Quan usar |
|-------|---------|-----------|
| `oracle/SKILL.md` | `/oracle <pregunta>` | Decisions arquitectòniques amb trade-offs reals |
