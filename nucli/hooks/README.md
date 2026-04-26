# Oracle Gate — Hooks (Capa 1)

Converteix oracle de consultor opcional a guardià obligatori.

**Efecte**: qualsevol canvi a fitxers arquitectònics (agents, domain, CLAUDE.md, contracts) queda marcat. El `git commit` és bloquejat fins que oracle hagi revisat i la marca s'hagi esborrat.

---

## Instal·lació

```bash
# 1. Copiar hooks al projecte
mkdir -p .claude/hooks
cp <path-llavor>/nucli/hooks/oracle-gate-post.sh .claude/hooks/
cp <path-llavor>/nucli/hooks/oracle-gate-pre-commit.sh .claude/hooks/
chmod +x .claude/hooks/oracle-gate-post.sh .claude/hooks/oracle-gate-pre-commit.sh

# 2. Registrar a settings.json
# Copia settings-example.json com a .claude/settings.json
# o fusiona el bloc "hooks" amb el teu settings.json existent
cp <path-llavor>/nucli/hooks/settings-example.json .claude/settings.json
```

---

## Customització dels patrons arquitectònics

A `oracle-gate-post.sh`, la variable `ARCH_PATTERNS` defineix quins fitxers disparen la revisió. Adapta-la al teu projecte:

```bash
ARCH_PATTERNS=(
  ".claude/agents/"    # Agents del sistema
  "domain/"            # Contractes de domini
  "CLAUDE.md"          # Invariants i regles
  "src/api/"           # Endpoints (afegir si aplica)
  "schemas/"           # Schemas compartits (afegir si aplica)
)
```

---

## Flux normal

```
Claude edita .claude/agents/worker.md
  → oracle-gate-post.sh detecta el patró
  → Crea .claude/oracle-review-pending
  → Injecta avís: "Consulta oracle abans del commit"

Usuari invoca /oracle amb el context del canvi
  → Oracle dóna veredicte
  → Usuari registra decisió a docs/decisions.md

Usuari esborra la marca:
  rm .claude/oracle-review-pending

Claude fa git commit
  → oracle-gate-pre-commit.sh no troba marca
  → Commit passa
```

---

## Flux si s'intenta saltar l'oracle

```
Claude edita .claude/agents/worker.md
  → oracle-gate-post.sh crea marca

Claude intenta git commit directament
  → oracle-gate-pre-commit.sh troba marca
  → BLOQUEJA el commit (permissionDecision: deny)
  → Missatge: "Hi ha canvis arquitectònics pendents de revisió"
```

---

## Notes

- Els hooks requereixen `python3` o `python` al PATH (mateix que el Servei Memòria)
- Windows: funcionen via Git Bash amb `CLAUDE_PROJECT_ROOT` en format `C:/...`
- El fitxer `.claude/oracle-review-pending` és temporal — afegir a `.gitignore`

```bash
echo ".claude/oracle-review-pending" >> .gitignore
```
