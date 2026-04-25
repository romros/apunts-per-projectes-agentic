# AGENTS.md — [NOM DEL PROJECTE]

<!-- generat des de apunts-per-projectes-agentic@COMMIT_SHA:plantilles/AGENTS.md -->

## Agents disponibles

| Agent | Rol | Fitxer | Quan invocar |
|-------|-----|--------|--------------|
| **Orquestrador** | Coordina. Tradueix intenció en acció. | Claude principal (sense fitxer) | Sempre actiu |
| **Worker** | Executa tasques. | `.claude/agents/worker.md` | Per a implementació i feina mecànica |
| **Oracle** | Criteri arquitectònic independent. | `.claude/agents/oracle.md` | Bootstrap, nous agents/serveis, incoherències, consulta explícita |
| **Mem-curator** | Curador de memòria persistent. | `.claude/agents/mem-curator.md` | Quan flash.jsonl supera 20 entrades o cal consolidar skills |
<!-- Afegeix aquí els agents de servei addicionals que hagis activat -->
<!-- Exemple (Servei Docs): | **Doc-curator** | Manté coherència documental | `.claude/agents/doc-curator.md` | Auditoria docs, reorganització, detecció obsolets | -->

---

## Sistema de memòria

<!-- No elimines aquesta secció — el Servei Memòria és obligatori. -->

Per recordar, afegeix una línia JSON a `.claude/agent-memory/flash.jsonl`:

```json
{"ts": "2026-01-01T00:00:00Z", "agent": "NOM_AGENT", "content": "TEXT", "tags": ["tag"]}
```

Arquitectura: `flash.jsonl` → (mem-curator quan cal) → `short-term.csv` → `skills/SKILL.md`

A l'inici de cada sessió, els agents han de:
1. Llegir `.claude/agent-memory/<agent>/MEMORY.md`
2. Llegir les últimes files de `short-term.csv` on `agent=<nom>`

---

## Validació canònica

<!-- DEFINEIX AQUÍ COM ES VALIDA QUE UNA TASCA ESTÀ DONE EN AQUEST PROJECTE -->
<!-- Exemple per a projecte amb codi: -->
<!-- ```bash -->
<!-- # Executar des de l'entorn del projecte -->
<!-- [COMANDA DE TEST]   # tests passants -->
<!-- [COMANDA TYPECHECK] # tipatge correcte -->
<!-- [COMANDA BUILD]     # build net -->
<!-- ``` -->
