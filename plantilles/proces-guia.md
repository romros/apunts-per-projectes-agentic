# Guia: com crear un procés nou

Segueix aquests 6 passos en ordre. Al final hauràs de tenir un fitxer a `processos/` o `commands/` que qualsevol agent pot llegir i executar sense context extern.

---

## Pas 1 — Determina si és un procés o un command

| Si... | Aleshores és... | Va a... |
|-------|----------------|---------|
| El dispara el sistema automàticament (un agent, un estat intern) | **Procés** | `processos/` |
| El dispara l'usuari explícitament (slash command, ordre directa) | **Command** | `commands/` |

---

## Pas 2 — Assigna ID i nom

**ID:** mira el darrer ID usat al GRAPH.md (secció "Processos i commands registrats") i suma 1.
- Procés → `PROC-NNN`
- Command → `CMD-NNN`

**Nom (BPMN):**
- Procés → `[Objecte] + [verb nominalitzat]` → *"Gestió de deutes"*, *"Validació d'arquitectura"*
- Tasca/Pas → `[Verb infinitiu] + [Objecte]` → *"Validar DoD"*, *"Registrar deute"*
- Disparador → `[Objecte] + [estat]` → *"DoD validat"*, *"Feedback rebut"*

---

## Pas 3 — Identifica actors i dependències

Consulta `GRAPH.md` (secció "Agents per component"):

1. **Quins agents fan feina** en aquest procés? → camp `agents:`
2. **De quin equip o servei vénen?** → camp `equips-serveis:`
3. **Quins serveis han d'estar actius** per a que funcioni? (memòria, OKR, etc.) → camp `serveis-requerits:`

---

## Pas 4 — Escriu el resum per a humans

Una sola frase. Regles:
- Cap `@`
- Cap sigla sense explicar (no "DoD", no "KR", no "OKR")
- Ha de tenir sentit per a algú que no coneix el framework

✓ *"El sistema verifica que el problema és real, el defineix i l'executa fins que el resultat és correcte."*
✗ *"PM executa PROC-001 amb dev-worker fins que DoD es cobreix."*

---

## Pas 5 — Estima el cost en tokens

Formula ràpida:
```
cost ≈ Σ (agents × invocacions × tokens_per_invocació)

Sonnet: ~2–5k tokens/invocació
Opus:   ~6–15k tokens/invocació
Haiku:  ~0.5–2k tokens/invocació
```

Exemple: 3 agents Sonnet × 2 invocacions cadascun × 3k avg = ~18k → rang "15k–25k"

Si hi ha agents Opus, indica'ls als `factors` — costen 3× i canvien la decisió d'arquitectura.

---

## Pas 6 — Escriu el fitxer

Copia `plantilles/proces.md` i omple cada camp. Comprova:

- [ ] `id` registrat al GRAPH.md (secció processos)
- [ ] `resum` llegible per un humà sense context
- [ ] `agents` coincideixen amb IDs del GRAPH.md
- [ ] Cada pas segueix `[Verb infinitiu] + [Objecte] — (@actor)`
- [ ] `Condició de sortida` és un estat observable, no una acció
- [ ] Si dispara un altre procés, citat a `## Notes`

---

## Checklist final (per a l'oracle si cal validació)

```
[ ] Nom segueix convenció BPMN
[ ] ID únic i registrat al GRAPH.md
[ ] Tots els agents existeixen al GRAPH.md
[ ] Dependències declarades i instal·lables
[ ] Resum entenedor per a humans sense context
[ ] Cost estimat amb model dominant declarat
[ ] Condició de sortida observable i verificable
```
