# Servei Dev

## Descripció

Especialització de `worker` per a projectes amb codi. Aporta protocols de qualitat de codi (quality review, resum enriquit amb tests) i un directori de skills per al domini tecnològic del projecte.

**Activar quan**: el projecte té codi que cal implementar i validar de forma repetida. Per a projectes que comencen o que fan tasques de codi puntuals, l'orquestrador pot usar `worker` directament.

---

## Composició amb el nucli

**Skills aportades** (contingut de referència per projecte):
- `skills/` — buit al llavor. El projecte destí hi crea les seves skills: arquitectura de capes, patrons de testing, validació canònica, convencions de codi.

**Agent propi — dev-worker.md** (per qué no és només skills):
- Justificació (Criteri C): el protocol de comunicació canvia respecte a `worker`. Quality review obligatòria abans de reportar, format de resum enriquit amb tests, criteris d'escalada específics (contractes compartits, regressions).
- Dev-worker **referencia** el rol base de `nucli/worker.md` i **afegeix** els protocols de codi.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/dev-worker.md` | `.claude/agents/dev-worker.md` |
| Skills (creades pel projecte) | `.claude/skills/<nom>.md` |

---

## Dependències

- **Servei Memòria** — dev-worker usa flash-remember per registrar decisions tècniques rellevants

---

## Activació manual

```bash
# 1. Copiar agent
cp <path>/agents/dev-worker.md .claude/agents/dev-worker.md

# 2. Crear directori de skills (el projecte les omple)
mkdir -p .claude/skills

# 3. Adaptar dev-worker.md local al stack del projecte:
#    - Afegir skills: [arquitectura-capes, testing-patterns, ...]
#    - Declarar validació canònica concreta
#    - Afegir invariants de domini si cal

# 4. Declarar al CLAUDE.md del projecte
# ## Servei Dev
# Agent: .claude/agents/dev-worker.md (referencia worker base)
# Skills: .claude/skills/ (arquitectura, testing, validació)
# DONE = [comanda canònica del projecte]
```

---

## Nota sobre solapament worker/dev-worker

`worker` és l'agent base per a qualsevol tasca d'execució. `dev-worker` és worker + protocols de codi. Si la tasca no involucra codi (reorganitzar docs, actualitzar CSVs, webfetch), usa `worker` o `easy-worker` directament.
