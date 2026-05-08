# Plantilla canònica de procés

<!-- 
CONVENCIÓ DE NOMS (BPMN ISO/IEC 19510):
  Procés:     [Objecte] + [verb nominalitzat]  → "Gestió de deutes"
  Pas/Tasca:  [Verb infinitiu] + [Objecte]     → "Validar DoD"
  Disparador: [Objecte] + [estat]              → "DoD validat per PM"
  Agent:      [domini-opcional]-[rol]          → "dev-worker", "pm"

COST-ESTIMAT (ordre de magnitud):
  Sonnet: ~2–5k tokens/invocació per agent
  Opus:   ~6–15k tokens/invocació per agent (3× cost)
  Suma els agents × invocacions per estimar el rang
-->

---
id: PROC-<NNN>          # PROC-NNN per processos interns, CMD-NNN per commands d'usuari
resum: "<Una frase en llenguatge pla per a qualsevol persona. Sense @, sense sigles, sense vocabulari del framework.>"
disparador: <[Objecte] + [estat] — ex: "DoD validat per PM", "Tasca proposada per l'usuari">
agents: [<agent1>, <agent2>]        # IDs del GRAPH.md — agents que apareixen als passos
equips-serveis: [<equip/servei1>]   # paths del GRAPH.md — on viuen els agents
serveis-requerits: [<servei1>]      # serveis que han d'estar actius per a que funcioni
cost-estimat:
  rang-tokens: "<Xk–Yk>"
  model-dominant: <sonnet|opus|haiku>
  factors: "<N passos, agents involucrats, paral·lel/seqüencial, notes de cost>"
---

# <Nom del procés — [Objecte] + [verb nominalitzat]>

## Quan s'usa

<Context i precondicions. Màxim 3 frases.>
<Quan NO s'usa si hi ha risc de confusió amb un altre procés.>

## Passos

1. <Verb infinitiu + objecte> — (<@actor>)
2. <Verb infinitiu + objecte> — (<@actor>)
3. <Verb infinitiu + objecte> — (<@actor>)
   - Si <condició (gateway)>: <acció branca A>
   - Si no: <acció branca B — o "tornar al pas N">

## Condició de sortida

<Estat observable del sistema quan el procés ha acabat correctament. Una frase per condició.>

## Notes *(opcional)*

- <Restriccions operatives, toleràncies, excepcions documentades.>
- <Referència a altres processos si aquest en dispara un altre: "Continua amb PROC-002".>
