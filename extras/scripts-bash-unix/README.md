# Scripts bash opcionals — Unix/Linux/Mac

Scripts per a projectes que volen el pipeline de memòria automatitzat via cron.

**No son el camí principal del llavor.** El Servei Memòria funciona sense scripts — els agents escriuen directament a `flash.jsonl` i el mem-curator consolida quan s'invoca.

Aquests scripts son útils si:
- El projecte corre en Linux/Mac
- Vols consolidació automàtica sense invocar mem-curator manualment
- Tens capacitat de configurar cron o un launcher del sistema

**Prerequisits**: bash, python3 o python, git (per `git rev-parse --show-toplevel`)

**Windows**: els scripts funcionen amb Git Bash, però `CLAUDE_PROJECT_ROOT` ha d'estar en format Windows (`C:/Users/...`), no MSYS (`/c/Users/...`), perquè Python és un procés natiu de Windows. Quan Claude Code invoca els scripts, el path ja és Windows per defecte.

Descarrega els scripts amb `curl` (no PowerShell) per evitar BOM UTF-8.

## Configuració cron (Linux/Mac)

```bash
# Consolida flash → short-term cada 5 minuts (0 tokens LLM)
*/5 * * * * cd /path/al/projecte && bash .claude/agent-memory/mem-curator/process-flash/scripts/process-flash.sh >> .claude/agent-memory/logs/cron.log 2>&1
```
