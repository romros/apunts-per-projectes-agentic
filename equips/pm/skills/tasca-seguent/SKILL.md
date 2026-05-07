---
name: tasca-seguent
description: Tanca la tasca actual i prepara la següent. Protocol complet — okr-curator tanca, PM defineix, oracle revisa.
disable-model-invocation: true
when_to_use: quan l'usuari vol passar a la tasca següent del roadmap
---

Protocol complet per tancar la tasca actual i obrir la següent. Executa en ordre estricte — no saltes passos.

## 1. Tancament de la tasca anterior

Invoca `@okr-curator` per:
- Actualitzar els CSVs (tasques, KRs, OKRs)
- Regenerar el board i la secció DYNAMIC del roadmap
- Registrar el tancament a `history.csv`

Fes commit amb missatge descriptiu.

## 2. Identificació de la propera tasca

Llegeix el roadmap actiu per identificar la propera fase/tasca natural.
Llegeix l'historial de tasques per confirmar l'ordre.

## 3. PM defineix la tasca

Invoca `@pm` per generar la nova tasca seguint la plantilla canònica del projecte.
El PM llegeix el codi/documents reals com a evidència — no supòsits.

## 4. Oracle revisa la tasca

Invoca `@oracle` amb la tasca generada i els fitxers implicats.
Oracle retorna: APROVADA / APROVADA AMB CORRECCIONS / REBUTJADA.

## 5. PM aplica correccions (si cal)

Si oracle demana correccions, PM les aplica.
Si cal una segona revisió, es fa.

## 6. Presentació a l'usuari

La tasca queda a `actual/` en estat `review`. Presenta:
- Resum en llenguatge planer (quin problema resol)
- Veredicte d'oracle
- Punts que necessiten decisió de l'usuari (si n'hi ha)

L'usuari diu OK → s'assigna al worker corresponent.

## Regles

- Mai assignar al worker sense l'OK explícit de l'usuari
- PM i oracle treballen amb evidències reals, no supòsits
- Si el roadmap s'ha acabat, reporta-ho i atura
