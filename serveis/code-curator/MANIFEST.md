```yaml
name: code-curator
categoria: meta
depen_de:
  - memoria
aporta_agents:
  - code-curator
```

# Servei: code-curator

Auditoria arquitectònica del codebase. Detecta violacions de capa, acoblaments ocults, mòduls orfes i codi mort. No produeix features — vetlla per la salut estructural del projecte.

## Quan activar

- El projecte té codebase de producció amb arquitectura per capes
- Cal un agent que auditi periòdicament la coherència arquitectònica
- Es detecten símptomes: imports creuats, dependències circulars, fitxers sense ús

## Fitxers que aporta

| Fitxer | Rol |
|--------|-----|
| `agents/code-curator.md` | Agent d'auditoria arquitectònica |

## Dependències

**Requereix activat:** memoria
**Llegeix de:** codebase del projecte
**Escriu a:** `docs/auditoria-arquitectura.md` (o equivalent declarat per l'orquestrador)

*Com usa memòria:* code-curator no escriu flash directament. La dependència de memòria és indirecta — l'orquestrador pot desar les troballes recurrents via `@mem-curator` per evitar re-auditar àrees ja revisades. La dependència és **recomanada**, no obligatòria en sentit estricte.

## Activació manual

1. Copiar `agents/code-curator.md` a `.claude/agents/code-curator.md`
2. Al `CLAUDE.md` del projecte, afegir a agents latents:
   ```
   - `@code-curator` — auditoria arquitectònica (invocar periòdicament o quan es detectin símptomes)
   ```

## Notes

- **Latent per defecte** — no s'invoca a cada tasca. L'orquestrador el convoca quan detecta símptomes o periòdicament (cada N roadmaps).
- **No modifica codi** — descriu el que troba i genera tasques per al worker si cal acció.
