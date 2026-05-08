# Plantilla canònica de procés

<!-- Convenció BPMN (ISO/IEC 19510):
  - Nom del procés: [Objecte] + [verb nominalitzat] → "Gestió de deutes", "Tancament de tasca"
  - Nom de cada pas: [Verb infinitiu] + [Objecte] → "Validar DoD", "Actualitzar KRs"
  - Disparador: [Objecte] + [estat] → "DoD validat", "Tasca proposada"
-->

---
id: PROC-<NNN>
equips: [<actor1>, <actor2>]
disparador: <[Objecte] + [estat] — ex: "Tasca proposada per l'usuari">
---

# <Nom del procés — [Objecte] + [verb nominalitzat]>

## Quan s'usa

<Context i precondicions. Màxim 3 frases.>
<Si hi ha risc de confusió amb un altre procés, aclarir quan NO s'usa.>

## Passos

1. <Verb infinitiu + objecte> — (<@actor>)
2. <Verb infinitiu + objecte> — (<@actor>)
3. <Verb infinitiu + objecte> — (<@actor>)
   - Si <condició (gateway BPMN)>: <acció branca A>
   - Si no: <acció branca B — o "tornar al pas N">

## Condició de sortida

<Estat observable del sistema quan el procés ha acabat correctament. Una frase per condició.>

## Notes *(opcional)*

- <Restriccions operatives, toleràncies, excepcions documentades.>
- <Referència a altres processos si aquest en dispara un altre.>
