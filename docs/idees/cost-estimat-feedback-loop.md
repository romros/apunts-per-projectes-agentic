# Idea: feedback loop per a `cost-estimat` als processos

**Data**: 2026-05-08
**Estat**: hipòtesi — no validada
**Origen**: veredicte oracle sessió 2026-05-08

---

## Problema

El camp `cost-estimat` (rang-tokens, model-dominant, factors) existeix als frontmatters de tots els processos i commands. Ara mateix és decoració: cap agent el llegeix, cap mecanisme el consulta, i els rangs declarats no han estat verificats empíricament. Norma 7: si no s'actua, eliminar.

## Idea

Implementar un feedback loop que tanqui el cicle:

1. **Registrar `proces-id`** al format de `cost.jsonl` en cada crida d'agent que forma part d'un procés. Format proposat:
   ```json
   {"ts": "...", "agent": "pm", "proces-id": "PROC-001", "tokens": 12400, "cost_usd": 0.04, "model": "claude-sonnet-4-6"}
   ```

2. **Script de comparació** (`RECURSOS/cost-proces.sh` o similar): llegeix `cost.jsonl`, agrupa per `proces-id`, calcula mitjana de tokens per execució, i compara amb el rang declarat al frontmatter del procés.

3. **Corregir els rangs** amb dades reals un cop acumulades ≥3 execucions per procés.

## Rangs actuals vs estimació oracle

| ID | Rang declarat | Estimació oracle (més realista) |
|----|-------------|-------------------------------|
| PROC-001 | 20k–50k | 40k–100k (oracle al flux) |
| PROC-002 | 15k–30k | 20k–50k |
| PROC-003 | 30k–70k | OK |
| PROC-004 | 8k–15k | OK |
| CMD-001 | 15k–35k | 30k–60k |
| CMD-002 | 20k–40k | OK |

## Condició d'implementació

Implementar quan un projecte que usa el framework acumuli `cost.jsonl` amb ≥10 entrades amb `proces-id`. Sense dades reals, els rangs corregits serien igualment especulatius.

## Alternativa

Si en 3 sessions cap projecte ha implementat el registre de `proces-id` → eliminar `cost-estimat` dels frontmatters per Norma 7 i documentar-ho a `docs/tensions-llavor.md`.
