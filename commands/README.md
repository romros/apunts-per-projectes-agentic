# Commands

Workflows amb **entry point explícit de l'usuari**. L'usuari els invoca directament — via slash command (`/tasca-seguent`), via frase literal, o via instrucció directa.

**Regla**: si un workflow té un punt d'entrada que l'usuari activa, viu aquí. Si és un workflow intern entre agents (sense que l'usuari l'invoqui), viu a `processos/`.

Cada fitxer d'aquest directori pot ser un slash command de Claude Code: crea-los a `.claude/commands/<nom>.md` al projecte destí.

---

## Commands disponibles

| Command | Quan usar-lo |
|---------|-------------|
| `tasca-seguent.md` | L'usuari dona el go per tancar la tasca activa i obrir la següent |
| `revisa-opinio.md` | Arriba feedback extern sobre la tasca en curs i cal avaluar-lo |

---

## Com distingir command de procés intern

Un workflow és un **command** si:
- L'usuari l'invoca directament (slash command, frase literal)
- Té un disparador que prové de fora del sistema (l'usuari, feedback extern)

Un workflow és un **procés intern** si:
- El dispara un agent, no l'usuari
- Forma part d'un command més gran (el command el referencia)
- No té sentit invocar-lo directament sense context previ d'un altre workflow

**Mai duplicar**: si un workflow ja existeix com a command, no duplicar-lo a `processos/`. Els processos interns poden referenciar-lo, però el codi viu en un sol lloc.
