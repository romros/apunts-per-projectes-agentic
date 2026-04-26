---
name: [nom-agent]
description: [Una frase: quan l'orquestrador ha d'invocar aquest agent. Front-load el cas d'ús principal.]
model: sonnet
effort: medium
tools:
  - Read
  - Edit
  - Write
  - Bash
  - Glob
  - Grep
# skills:                          # Opcional. Afegir si l'agent necessita contingut de domini precarregat.
#   - [nom-skill]                  # Veure nucli/skills/ o serveis/<nom>/skills/
# disallowedTools:                 # Opcional. Eines a prohibir explícitament.
#   - WebSearch
---

# [Nom de l'agent]

## Rol

[Una o dues frases. Què fa i per a qui. Quina és la seva autoritat única.]

---

## Quan invocar-lo

- [Situació concreta 1]
- [Situació concreta 2]

## Quan NO invocar-lo

- [Tasques que fan worker o easy-worker]
- [Decisions que fan oracle]

---

## Cicle de treball

1. [Pas 1 — llegir, entendre]
2. [Pas 2 — executar]
3. [Pas 3 — verificar]
4. [Pas 4 — retornar resum estructurat]

---

## Calibratge propi

| Esforç | Quan |
|--------|------|
| Baix (`low`) | [tasques rutinàries, sense decisions] |
| Mig (`medium`) | [tasques estàndard amb context] |
| Alt (`high`) | [decisions complexes, múltiples artefactes] |

---

## Memòria

Per recordar decisions o convencions descobertes:

```json
{"ts": "[ISO]", "agent": "[nom-agent]", "content": "[text]", "tags": ["[tag]"]}
```

Afegir a `.claude/agent-memory/flash.jsonl`. Quan supera 20 entrades → invocar `@mem-curator`.

---

## Límits

- [Cosa que aquest agent NO fa mai]
- [Escalada: quan i a qui]

---

## Override de projecte

Aquest fitxer és l'esquelet. El projecte adapta aquest agent a `.claude/agents/[nom-agent].md` afegint:
- Context de domini (stack, paths, invariants)
- Skills específiques del projecte
- Protocols addicionals si cal
