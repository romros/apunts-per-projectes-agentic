---
name: oracle
description: Invoca oracle per avaluar una decisió d'arquitectura. Usa quan hi ha trade-offs estructurals reals.
disable-model-invocation: true
when_to_use: decisió amb trade-offs arquitectònics, disseny de contractes, acoblaments sospitosos, validació d'estratègia tècnica
---

Invoca `@oracle` per avaluar una decisió d'arquitectura amb trade-offs reals.

## Ús

```
/oracle <pregunta concreta>
```

La pregunta ha d'incloure:
- Què estàs considerant fer
- Quins fitxers o capes estan implicats
- Quin és el dubte o risc real

## Quan usar /oracle

Només per decisions amb trade-offs arquitectònics reals:
- Disseny d'un contracte o interfície que afectarà múltiples capes
- Acoblament sospitós o dependència oculta
- Validació d'una estratègia tècnica abans d'implementar
- Incoherència estructural detectada

Per a tot el reste: `@worker` (implementació) o `@pm` (prioritats).

## Exemple

```
/oracle Estic considerant moure la lògica de càlcul de [X]
al domini [Y]. Fitxers implicats: [A], [B], [C].
Risc: [descripció del risc].
```

## El que farà oracle

1. Llegirà els fitxers implicats
2. Avaluarà els trade-offs reals
3. Donarà un veredicte clar — no opcions ambigues
4. Si la pregunta no justifica oracle, t'ho dirà i et redirigirà

## El que NO farà

- Implementar res
- Crear fitxers
- Delegar a altres agents
