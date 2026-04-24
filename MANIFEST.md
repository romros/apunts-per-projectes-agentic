# Catàleg de components

## Nucli — Trinitat

Obligatori per a qualsevol projecte. Tres rols que no es poden fusionar:

| Agent | Rol | Fitxer |
|-------|-----|--------|
| **Orquestrador** | Coordina. Tradueix intenció en acció. No decideix arquitectura. | El Claude principal — no té fitxer separat |
| **Worker** | Executa tasques. No jutja decisions d'arquitectura. | `nucli/worker.md` |
| **Oracle** | Criteri arquitectònic independent. Latent entre convocatòries. | `nucli/oracle.md` |

**Quan convocar l'oracle** — en aquests moments, sempre; fora d'ells, a criteri:
- Bootstrap del projecte
- Alta d'agent o servei nou
- Incoherència estructural detectada
- Consulta explícita de l'usuari

---

## Serveis modulars

| Servei | Directori | Depèn de |
|--------|-----------|----------|
| **Memòria** | `serveis/memoria/` | — |
| **Docs** | `serveis/docs/` | — |
| **OKR** | `serveis/okr/` | Docs |
| **PM** | `serveis/pm/` | OKR |
| **Dev** | `serveis/dev/` | Memòria |

Cada servei té `serveis/<nom>/MANIFEST.md` amb: descripció, fitxers que aporta, dependències, i instruccions d'activació manual.

Activar un servei = activar-lo amb les seves dependències transitives.
- Si `scripts/activate-service.sh` existeix: resol dependències automàticament.
- Si no: activa manualment seguint `serveis/<nom>/MANIFEST.md` de cada servei i dependències.

**Nota**: el Servei Memòria és obligatori per a qualsevol projecte. No és opcional.

---

## Normes globals

`NORMES_GLOBALS.md` — 9 regles fundacionals. S'incorporen al `CLAUDE.md` del projecte destí.

Les normes 2, 5 i 9 requereixen 1-2 línies de particularització per domini (evidència DONE, dades sensibles, dependències estructurals). La resta s'apliquen tal com estan.

---

## Scripts

| Script | Funció |
|--------|--------|
| `scripts/bootstrap.sh` | Versió scriptificada del flow de `WIZARD.md`. Per a usuaris que **no** usen Claude Code. |
| `scripts/activate-service.sh <nom>` | Afegeix un servei a un projecte ja bootstrapejat. Resol dependències. |

**Relació `bootstrap.sh` vs `WIZARD.md`**: el wizard és el camí agentic (Claude Code llegeix el repo via URL i guia l'usuari). `bootstrap.sh` és el camí no-agentic (script que fa el mateix flow sense Claude). Ambdós produeixen el mateix resultat. Usa el wizard si tens Claude Code; usa l'script si prefereixes automatització directa.

---

## Plantilles

Esquelets parametritzables per al wizard. **No còpies del projecte origen** — fitxers dissenyats per ser omplerts.

| Plantilla | Conté | Notes |
|-----------|-------|-------|
| `plantilles/CLAUDE.md` | Inici sessió, missió, calibratge, modes de prompt, normes (injectades), memòria, serveis actius | Wizard omple placeholders + injecta NORMES_GLOBALS.md des del marcador |
| `plantilles/AGENTS.md` | Taula d'agents (orquestrador/worker/oracle + serveis), sistema de memòria, validació canònica | Wizard omple taula amb agents activats |

---

## Estat de construcció

| Component | Estat |
|-----------|-------|
| `WIZARD.md` (entry point agents externs) | ✓ |
| `CLAUDE.md` (manteniment intern repo) | ✓ |
| `MANIFEST.md` (aquest fitxer) | ✓ |
| `NORMES_GLOBALS.md` | ✓ |
| `plantilles/CLAUDE.md` | ✓ |
| `plantilles/AGENTS.md` | ✓ |
| `nucli/worker.md` | Pendent (Fase 2) |
| `nucli/oracle.md` | Pendent (Fase 2) |
| `serveis/memoria/` | Pendent (Fase 3) |
| `serveis/docs/` | Pendent (Fase 3) |
| `serveis/okr/` `serveis/pm/` `serveis/dev/` | Pendent (Fase 6) |
| `scripts/bootstrap.sh` | Pendent (Fase 4) |
| `scripts/activate-service.sh` | Pendent (Fase 4) |
