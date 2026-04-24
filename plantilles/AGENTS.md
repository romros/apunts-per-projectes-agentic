# AGENTS.md — [NOM DEL PROJECTE]

<!-- generat des de apunts-per-projectes-agentic@COMMIT_SHA:plantilles/AGENTS.md -->

## Agents disponibles

| Agent | Rol | Fitxer | Quan invocar |
|-------|-----|--------|--------------|
| **Orquestrador** | Coordina. Tradueix intenció en acció. | Claude principal (sense fitxer) | Sempre actiu |
| **Worker** | Executa tasques. | `.claude/agents/worker.md` | Per a implementació i feina mecànica |
| **Oracle** | Criteri arquitectònic independent. | `.claude/agents/oracle.md` | Bootstrap, nous agents/serveis, incoherències, consulta explícita |
<!-- Afegeix aquí els agents de servei que hagis activat -->
<!-- Exemple (Servei Docs): | **Doc-curator** | Manté coherència documental | `.claude/agents/doc-curator.md` | Auditoria docs, reorganització, detecció obsolets | -->

---

## Sistema de memòria

<!-- ACTIU NOMÉS SI SERVEI MEMÒRIA INSTAL·LAT — si no, esborra aquesta secció -->

```bash
# Escriure memòria
bash .claude/agent-memory/shared/flash-remember/scripts/remember.sh \
  --agent <nom-agent> --content "<text>" --tags "<tags>"

# Recuperar context
bash .claude/agent-memory/shared/flash-recall/scripts/recall.sh --agent <nom-agent>
```

Arquitectura: `flash.jsonl` → (cron 5min) → `short-term.csv` → (mem-curator) → `skills/SKILL.md`

A l'inici de cada sessió, els agents han de:
1. Llegir `.claude/agent-memory/<agent>/MEMORY.md`
2. Executar `flash-recall` per carregar context recent

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
