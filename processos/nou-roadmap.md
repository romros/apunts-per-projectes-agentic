---
id: PROC-003
resum: "Quan un cicle acaba, el sistema planifica el bloc d'objectius següent: defineix OKRs, els valida i prepara la primera tasca."
disparador: roadmap actual tancat o tasques crítiques DONE
agents: [pm, oracle, okr-curator]
equips-serveis: [equips/pm, equips/okr]
serveis-requerits: [serveis/memoria]
cost-estimat:
  rang-tokens: "30k–70k"
  model-dominant: opus
  factors: "7 passos, oracle obligatori per validació arquitectònica OKRs, planificació estratègica"
---

# Nou roadmap

## Quan s'usa

Quan el cicle de treball actual ha conclòs i cal planificar el següent bloc d'objectius.

## Passos

1. PM llegeix l'estat actual: deutes pendents, roadmap vigent i context de producte — (@pm)
2. PM proposa OKRs i KRs del nou roadmap a l'usuari (mode exploratiu, sense crear fitxers) — (@pm)
3. Usuari dona feedback i alineació
4. Oracle valida l'arquitectura dels OKRs si hi ha decisions tècniques estructurals — (@oracle)
5. Usuari confirma → PM genera els registres formals (OKRs, KRs, tasques) via el servei OKR — (@pm → @okr-curator)
6. OKR-curator genera el document de roadmap dinàmic — (@okr-curator)
7. PM defineix la primera tasca (command `commands/tasca-seguent.md`, des del pas 2)

## Condició de sortida

Registres creats, roadmap generat, primera tasca presentada a l'usuari.

## Notes

- L'usuari confirma sempre abans de materialitzar els registres formals
- Una tasca a la vegada: no planificar en cascada
- Els deutes del cicle anterior s'incorporen explícitament com a entrades al nou roadmap, no s'ignoren
