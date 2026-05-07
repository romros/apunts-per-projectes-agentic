---
equips: [pm, dev, okr]
disparador: l'usuari proposa una tasca nova o el sistema detecta la propera tasca del backlog
---

# Executar una tasca

## Quan s'usa

Quan l'usuari vol que el sistema executi una unitat de treball concreta (feature, fix, millora).

## Passos

1. Usuari proposa la tasca — (usuari)
2. PM i Worker verifiquen que el problema és real (diagnòstic previ): (a) evidència objectiva que existeix al codi o sistema, (b) descarta artefactes d'observació, (c) confirma que cap tasca existent el cobreix — (@pm + @dev-worker o @easy-worker)
3. PM exposa el rumb basat en el diagnòstic i espera confirmació — (@pm)
4. Usuari confirma (mode consultiu) o PM continua directament (mode automàtic, si el `CLAUDE.md` del projecte l'activa) — (usuari / automàtic)
5. PM genera la definició formal de la tasca (DoD, criteris, fitxer de tasca) — (@pm)
6. Worker executa i retorna resum amb evidència — (@dev-worker o @easy-worker) *(projectes amb component UX: @ux-expert revisa en paral·lel si el projecte l'activa)*
7. PM valida que l'evidència cobreix el DoD — (@pm)
8. Si passa: go a tancament (veure `tancar-tasca.md`). Si no: worker corregeix i torna al pas 6 — (@pm)

## Condició de sortida

El PM ha validat que l'evidència cobreix el DoD i dóna el go per tancar.
