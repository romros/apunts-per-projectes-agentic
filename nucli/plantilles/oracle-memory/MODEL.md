# Model del sistema — oracle

> Oracle manté i actualitza aquest fitxer. No és memòria flash — és el seu model viu del projecte.
> Llegir-lo a l'inici de cada sessió oracle. Actualitzar-lo quan la realitat divergeixi.

---

## Capes i dependències

<!-- Defineix les capes del projecte i la direcció permesa entre elles -->
<!-- Exemple: app → features → domain → infrastructure. Mai a l'inrevés. -->

[DECLARAR CAPES I DIRECCIÓ D'IMPORTS]

---

## Invariants actius

<!-- Les restriccions que no es poden trencar mai. Derivades de CLAUDE.md. -->

| Invariant | Descripció | Raó |
|-----------|------------|-----|
| [id] | [descripció] | [per qué existeix] |

---

## Tensions actives

<!-- Problemes estructurals que oracle ha identificat però que no s'han resolt. -->
<!-- Cada tensió té una data des de quan existeix. -->

| Data | Tensió | Gravetat | Notes |
|------|--------|---------|-------|
| [data] | [descripció de la tensió] | alta/mitja/baixa | [context] |

---

## Deutes arquitectònics coneguts

<!-- Decisions que es van prendre acceptant un cost futur. -->

| Data | Deute | Cost previst | Condició per resoldre |
|------|-------|-------------|----------------------|
| [data] | [descripció] | [quan costarà] | [quan s'ha de resoldre] |

---

## Últim contrast amb realitat

<!-- Quan oracle ha contrastat aquest MODEL amb el codi/estat real del projecte -->

Data: [data de l'últim contrast]
Resultat: [divergències trobades, o "cap"]
