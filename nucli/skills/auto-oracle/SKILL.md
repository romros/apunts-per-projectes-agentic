---
name: auto-oracle
description: Patrons arquitectònics que requereixen consulta a oracle abans d'actuar.
user-invocable: false
---

Abans de fer qualsevol d'aquestes accions, **para i considera si cal consultar oracle**. Si hi ha dubte, la resposta és sí.

## Senyals que requereixen oracle

**Alta d'un agent o servei** — afegir un fitxer a `.claude/agents/` o activar un nou servei del catàleg.

**Modificació de contractes compartits** — canviar interfícies, schemas, tipus o formes d'API que múltiples components usen. Si un canvi obliga a actualitzar més d'un fitxer per mantenir consistència, és un contracte.

**Inversió de dependències** — qualsevol canvi que fa que un component de capa baixa depengui d'un de capa alta, o que trenqui la direcció declarada al `CLAUDE.md`.

**Canvi a invariants del projecte** — modificar les regles de `CLAUDE.md` (invariants, capes, privadesa).

**Decisió que afecta múltiples sessions futures** — si la decisió serà difícil de desfer i afectarà com es treballa en sessions posteriors.

## Com invocar oracle

Usa `/oracle` o `@oracle` amb:
- Què estàs considerant fer
- Quins fitxers o capes estan implicats
- Quin és el dubte o risc real

## Després de la resposta d'oracle

Registra la decisió a `docs/decisions.md` del projecte (plantilla a `nucli/plantilles/decisions.md`).
Sense registre, la decisió s'evaporarà entre sessions.

## Quan NO cal oracle

- Implementació dins l'abast definit d'una tasca
- Refactorització que no canvia contractes ni dependències
- Tasques mecàniques (git, fitxers, scripts)
- Debugging i correccions de bugs sense impacte arquitectònic
