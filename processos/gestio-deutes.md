---
equips: [pm, okr]
disparador: qualsevol tasca detecta un deute que no pot resoldre en el seu propi scope
---

# Gestió de deutes tècnics

## Quan s'usa

Quan una tasca troba un deute (codi, arquitectura, documentació) que no és resolubles dins el seu scope. El PM és el portador conscient dels deutes — no es perden entre sessions ni roadmaps.

## Passos

### Quan apareix un deute (dins qualsevol tasca)

1. Worker o PM detecta el deute i el descriu breument — (@dev-worker o @pm)
2. PM valora: resolubles dins la tasca actual? Si sí: resolver ara (tolerància 0 amb deutes fàcils). Si no: registrar — (@pm)
3. PM afegeix entrada a `okr/roadmaps/actual/deutes.md` — (@pm via @okr-curator)

### Quan es tanca un roadmap

4. PM revisa `okr/roadmaps/actual/deutes.md` i classifica cada deute: absorbir al roadmap nou, diferir conscientment, o descartar — (@pm)
5. Deutes que es difereixen passen a `okr/deutes-globals.md` amb data i justificació — (@pm via @okr-curator)

### Quan s'obre un roadmap nou

6. PM llegeix `okr/deutes-globals.md` i decideix quins entren al nou roadmap com a tasques — (@pm)
7. Els que no entren resten a globals amb nota de revisió — (@pm)

## Condició de sortida

Cap deute detectable queda sense registre. El PM sap en tot moment quins deutes existeixen i per què s'han diferit.

## Notes

- **Tolerància 0 amb deutes fàcils**: si es pot resoldre dins la tasca actual sense risc de regressió, es fa ara.
- **Activa si**: el projecte té component de codi, infraestructura o documentació estructurada.
