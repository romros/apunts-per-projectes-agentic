---
id: PROC-002
resum: "Es valida que la feina feta és correcta, es registra com a completada i s'actualitzen els objectius del projecte."
disparador: PM ha validat que l'evidència cobreix el DoD
agents: [pm, okr-curator, oracle, easy-worker]
equips-serveis: [equips/pm, equips/okr]
serveis-requerits: [serveis/memoria]
cost-estimat:
  rang-tokens: "15k–35k"
  model-dominant: sonnet
  factors: "6 passos, oracle condicional (+Opus si hi ha correccions o impacte arquitectònic)"
---

# Tancar una tasca

## Quan s'usa

Quan el PM ha validat que la tasca ha complert el seu DoD i l'evidència és executable (tests passants, build OK, o equivalent del projecte).

## Passos

1. Review: Oracle obligatori si la tasca ha tingut correccions post-revisió, toca arquitectura o introdueix decisions amb efecte durador. PM sol per tasques purament mecàniques — (@pm + @oracle)
2. PM declara la tasca com a DONE amb resum d'evidència — (@pm)
3. OKR-curator actualitza el registre de tasques (tasca passa a `fetes/`, estat `done`) — (@okr-curator)
4. OKR-curator actualitza els KRs i OKRs afectats — (@okr-curator)
5. OKR-curator regenera el roadmap dinàmic si cal — (@okr-curator)
6. Commit a git amb missatge descriptiu — (@easy-worker o l'agent que correspongui)

## Condició de sortida

El registre de tasques reflecteix l'estat `done`, els KRs afectats estan actualitzats, i el commit existeix al repositori.
