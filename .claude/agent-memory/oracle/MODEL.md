# Model del sistema — oracle del llavor

> Oracle manté i actualitza aquest fitxer. Conté NOMÉS el que oracle necessita en cada invocació.
> Llegit a l'inici de cada sessió oracle. Actualitzat quan la realitat divergeixi.

---

## Què és aquest projecte

`apunts-per-projectes-agentic` és un repo de referència (no un framework per clonar). Els projectes destí fan bootstrap via `WIZARD.md` i reben fitxers copiats per valor, marcats amb SHA. El `guia-projectes-agentic` detecta novetats al llavor des del projecte destí.

---

## Invariants actius

| Invariant | Descripció | Raó |
|-----------|------------|-----|
| V-01 | Cap servei al catàleg sense ≥1 projecte real que el validi | Evita hipòtesis disfressades de solucions |
| V-02 | Cap infraestructura sense consumidor real observat | Scripts, MCPs, resolvers: primer el cas, després l'eina |
| V-03 | Fitxers del llavor escrits per a agent com a lector primari (excepte README.md) | El lector real és Claude Code, no un humà |
| V-04 | Dependències entre serveis declarades als MANIFESTs (format: Requereix activat / Llegeix de / Escriu a) | Localitat: la dep viu amb el servei que la declara |
| V-05 | El WIZARD activa mínim per defecte, l'usuari afegeix per fricció real | Sobreenginyeria disfressada de modularitat és el pitjor anti-patró |

---

## Tensions actives

| Data | Tensió | Gravetat | Notes |
|------|--------|----------|-------|
| 2026-04-25 | N=1 pilot (Windows, 1 persona, sense codi). Validació insuficient per generalitzar | mitja | Necessita ≥3 pilots en contextos variats |
| 2026-05-05 | `seed sync` no existeix — no hi ha mecanisme de sync entre llavor i projectes ja bootstrappejats | mitja | Condició per construir: ≥2 projectes actius amb necessitat observada |
| 2026-05-05 | MCP proposat però ajornat — reconsiderar quan catàleg ≥10 serveis + ≥3 projectes actius + cerca textual insuficient | baixa | Documentat, no oblidat |

---

## Deutes arquitectònics coneguts

| Data | Deute | Cost previst | Condició per resoldre |
|------|-------|-------------|----------------------|
| 2026-04-26 | `activate-service.sh` no existeix (Fase 4 ajornada) | Activació manual per a cada servei | Quan ≥2 usuaris trobin la manual inacceptable |
| 2026-05-05 | No hi ha política de breaking changes documentada per a projectes ja bootstrappejats (MAJOR version) | Projectes que bootstrappegen ara poden divergir silenciosament | Quan hi hagi ≥2 projectes actius amb versions diferent del llavor |

---

## Estructura de capes (dependències permeses)

```
nucli/          ← base universal. No depèn de res.
serveis/        ← depenen del nucli. Poden dependre d'altres serveis (declarat al MANIFEST).
.claude/agents/ ← còpies operacionals. Derivades del nucli i serveis.
projecte destí  ← rep del llavor per valor. Mai al revés.
```

---

## Últim contrast amb realitat

Data: 2026-05-05
Resultat: MODEL creat en aquesta sessió. Pendent primer contrast post-sessió.
