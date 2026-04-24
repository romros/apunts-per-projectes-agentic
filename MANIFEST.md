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

Activar un servei = activar-lo amb les seves dependències transitives. L'script `scripts/activate-service.sh` ho resol automàticament.

---

## Normes globals

`NORMES_GLOBALS.md` — 9 regles fundacionals. S'incorporen al `CLAUDE.md` del projecte destí.

Les normes 2, 5 i 9 requereixen 1-2 línies de particularització per domini (evidència DONE, dades sensibles, dependències estructurals). La resta s'apliquen tal com estan.

---

## Scripts

| Script | Funció |
|--------|--------|
| `scripts/bootstrap.sh` | Primer setup interactiu. Pregunta serveis, genera `CLAUDE.md` destí, copia fitxers. |
| `scripts/activate-service.sh <nom>` | Afegeix un servei a un projecte ja bootstrapejat. Resol dependències. |

---

## Estat de construcció

| Component | Estat |
|-----------|-------|
| `WIZARD.md` (entry point agents externs) | ✓ |
| `CLAUDE.md` (manteniment intern repo) | ✓ |
| `MANIFEST.md` (aquest fitxer) | ✓ |
| `NORMES_GLOBALS.md` | ✓ |
| `nucli/worker.md` | Pendent (Fase 2) |
| `nucli/oracle.md` | Pendent (Fase 2) |
| `serveis/memoria/` | Pendent (Fase 3) |
| `serveis/docs/` | Pendent (Fase 3) |
| `serveis/okr/` `serveis/pm/` `serveis/dev/` | Pendent (Fase 6) |
| `scripts/bootstrap.sh` | Pendent (Fase 4) |
| `scripts/activate-service.sh` | Pendent (Fase 4) |
