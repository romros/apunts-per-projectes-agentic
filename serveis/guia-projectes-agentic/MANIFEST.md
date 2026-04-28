```yaml
servei: guia-projectes-agentic
categoria: meta
depen_de:
  - memoria
depen_de_recomanat: []
incompatible_amb: []
requisits_projecte: []
aporta_agents:
  - guia-projectes-agentic
aporta_commands: []
aporta_skills: []
escriu_a:
  - .claude/agents/guia-projectes-agentic.md
```

# Servei guia-projectes-agentic

## Descripció

Guardià del sistema agentic del projecte. Connecta el projecte amb el repo de referència (`apunts-per-projectes-agentic`) per guiar el creixement del sistema agentic al llarg del temps: activa serveis nous quan la fricció ho justifica, detecta millores disponibles, manté l'inventari d'agents actualitzat.

**Activa'l quan**: el projecte ja porta camí agentic i vols que algú vetlli per la coherència i l'evolució del sistema sense haver de recordar-te de consultar la guia.

**Categoria**: servei meta — no aporta capacitat de domini, aporta governança del sistema agentic.

---

## Fitxers que aporta

| Fitxer | Destí al projecte |
|--------|-------------------|
| `agents/guia-projectes-agentic.md` | `.claude/agents/guia-projectes-agentic.md` |

---

## Dependències

- **Servei Memòria** — necessita `flash.jsonl` i `short-term.csv` actius al projecte per registrar consultes. Verifica que `.claude/agent-memory/flash.jsonl` existeix abans d'activar.

---

## Prerequisit al `CLAUDE.md` del projecte

Abans d'activar, afegeix al `CLAUDE.md` del projecte la secció:

```markdown
## Origen del sistema agentic

- **Repo de referència**: https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/
- **Commit adoptat**: <COMMIT_SHA_DEL_BOOTSTRAP>
```

Substitueix `<COMMIT_SHA_DEL_BOOTSTRAP>` pel SHA del commit del repo de referència que vas usar en fer el bootstrap (visible al comentari `<!-- generat des de apunts-per-projectes-agentic@SHA -->` del teu `CLAUDE.md`).

---

## Activació ràpida

Enganxa **una sola línia** a Claude Code al teu projecte:

```
Instal·la el servei guia-projectes-agentic seguint aquest ordre: (1) Si no existeix .claude/agent-memory/flash.jsonl, instal·la el Servei Memòria complet des de https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/serveis/memoria/MANIFEST.md. (2) Instal·la l'agent: https://raw.githubusercontent.com/romros/apunts-per-projectes-agentic/main/serveis/guia-projectes-agentic/agents/guia-projectes-agentic.md — copia'l a .claude/agents/, crea .claude/agent-memory/guia-projectes-agentic/MEMORY.md, actualitza AGENTS.md. (3) Fes el diagnosi inicial del sistema agentic.
```

Claude comprova les dependències, instal·la el que falta i comença immediatament.

---

## Quan invocar-lo

- "Necessito [nova capacitat]" → diagnostica si hi ha un servei al catàleg que ho cobreixi
- "Quins serveis tinc disponibles?" → `estat`
- "Hi ha novetats al repo de referència?" → `actualitza`
- Quan el sistema agentic porta temps sense revisió → `estat` per detectar derives

## Quan NO invocar-lo

- Per a tasques de domini (codi, dades, docs de producte) → worker o agents especialitzats
- Per a decisions arquitectòniques → oracle
- Per a gestió de memòria → mem-curator
