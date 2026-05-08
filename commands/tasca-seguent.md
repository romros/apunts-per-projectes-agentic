---
id: CMD-001
equips: [pm, dev, okr]
disparador: l'usuari dona el OK per tancar la tasca activa i obrir la següent
---

# Tasca següent

## Quan s'usa

Quan l'usuari dona el go per tancar la tasca actual i definir la propera. Agrupa tancament + definició en un sol moviment per evitar fricció entre iteracions.

## Passos

1. Tancament de la tasca anterior (seguir `processos/tancar-tasca.md`) — (@pm + @okr-curator)
2. PM identifica la propera tasca del backlog (llegint estat real del projecte) — (@pm)
3. PM genera la definició formal de la nova tasca — (@pm)
4. Oracle revisa la tasca generada i retorna veredicte (APROVADA / AMB CORRECCIONS / REBUTJADA) — (@oracle o @gran-oracle segons el projecte)
5. PM incorpora correccions si cal; si cal una segona revisió, es fa — (@pm)
6. PM presenta la tasca a l'usuari amb resum breu i punts de decisió si n'hi ha — (@pm)
7. Usuari dona OK → la tasca s'assigna al worker — (usuari)

## Condició de sortida

La nova tasca té el veredicte de l'oracle, ha estat presentada a l'usuari i té el seu OK explícit per assignar-la al worker.
