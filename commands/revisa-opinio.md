---
equips: [pm, oracle, dev-worker]
disparador: arriba feedback extern sobre una tasca en curs i cal avaluar-lo contrastant amb el codi real
---

# Revisar opinió externa

## Quan s'usa

Quan un consultor, revisor o agent extern emet un judici sobre la tasca en curs i cal decidir si s'incorpora, es descarta, o es debat.

## Passos

1. Identificar la tasca activa i el codi rellevant — (orquestrador)
2. PM i Oracle reben el feedback i llegeixen el codi real en paral·lel — (@pm + @oracle)
3. Cada agent jutja cada punt del feedback: VÀLID / PARCIALMENT VÀLID / INCORRECTE (amb cita fitxer:línia)
4. Consolidar en taula resum:
   - Si coincideixen → veredicte clar
   - Si divergeixen → debat presentat a l'usuari
5. Worker aplica patches mínims als punts VÀLIDS consensuats — (@dev-worker)
6. Presentar resultat a l'usuari: punts incorporats, punts descartats amb justificació

## Condició de sortida

Tots els punts del feedback tenen veredicte. Patches aplicats o descartats amb justificació documentada.

## Notes

- El consultor extern no té accés al codi — pot estar equivocat per falta de context, no per incompetència
- El codi i la definició de la tasca manen sobre l'opinió externa
- Aplicar patches mínims: no reescriure res que no estigui directament qüestionat
