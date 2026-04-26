---
name: oracle-proposa
description: Oracle proposa una tasca quan detecta una tensió arquitectònica que ningú ha plantejat.
disable-model-invocation: true
when_to_use: quan oracle detecta un problema estructural que requereix acció i no existeix cap tasca que l'adreci
allowed-tools: Write Read
---

Oracle ha detectat una tensió arquitectònica. Crea una tasca perquè el sistema l'adreci.

## Ús

```
/oracle-proposa
```

Oracle invoca aquest skill quan detecta una tensió no reportada. L'usuari no necessita fer res — oracle ja ha identificat el problema.

## El que fa oracle

1. Descriu la tensió detectada (fitxers implicats, risc, urgència)
2. Proposa l'acció mínima per resoldre-la
3. Crea el fitxer de tasca

## On va la tasca

**Si el Servei OKR està actiu** (existeix directori de tasques actives):
- Crea `[directori-okr]/tasques/pendents-oracle/oracle-[timestamp].md`
- PM la prioritzarà al proper cicle

**Si no hi ha OKR**:
- Afegeix entrada a `docs/pendents-oracle.md` (el crearà si no existeix)

## Format de la tasca generada per oracle

```markdown
# TASCA ORACLE — [títol breu de la tensió]

**Origen**: oracle (detecció autònoma)
**Data**: [data]
**Urgència**: alta / mitja / baixa

## Tensió detectada

[Descripció precisa del problema estructural]

**Fitxers implicats**: [paths]
**Risc si no s'adreça**: [conseqüència]

## Acció mínima proposada

[Què cal fer per resoldre la tensió]

## Notes d'oracle

[Raonament per haver generat aquesta tasca sense ser preguntat]
```

## Regla d'ús responsable

Oracle no abusa d'aquest mecanisme. El reserva per a tensions que:
1. Ningú ha identificat explícitament
2. Afectaran el projecte si no s'adrecen aviat
3. No estan ja cobertes per una tasca existent

Si hi ha dubte sobre si cal crear la tasca: no crear-la. Reportar-la verbalment a l'orquestrador.
