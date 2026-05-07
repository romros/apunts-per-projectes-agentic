---
Origen: extret de `agents.md` del projecte llista.cat.
Adaptat per al servei `editorial` de `apunts-per-projectes-agentic`.
Data adaptació: 2026-04-28
---

# Flux editorial

Aquesta part del document descriu **com es combinen els agents** per produir un article de blog. Mentre els fitxers de cada agent expliquen *com funciona cadascun*, aquest explica *com orquestrar-los*.

## Plantilla d'agents

| Agent | Paper | Model |
|-------|-------|-------|
| `radar-web` | Escaneig de tendències externes | sonnet |
| `analista-dades` | Consultes a la font de dades interna *(slot — cada projecte defineix el seu)* | sonnet |
| `ideator` | Creatiu — creua senyals i fa briefs | **opus** |
| `investigador-web` | Dossier d'evidències per article | sonnet |
| `redactor` | Draft de l'article | sonnet |
| `corrector` | Revisió final i changelog | sonnet |
| `easy-worker` | Suport mecànic transversal *(del nucli del framework)* | **haiku** |

`easy-worker` no és una fase: és un **recurs compartit**. Qualsevol agent sènior hi pot delegar feina mecànica (reformat, extracció literal, comptatges).

## Visió general del flux

```
FASE 1 — CERCA D'IDEES
radar-web    ┐
             ├──→ ideator (scout) ──→ llista de 8-12 idees
analista-dades ┘                            │
                                            ▼
                            🟢 CHECKPOINT HUMÀ (tries 1 idea)

FASE 2 — BORRADOR
ideator (brief) ──→ brief editorial
             │
             ├──→ analista-dades ──→ dades internes
             └──→ investigador-web ──→ dossier web
                         │
                         ▼
                     redactor ──→ draft + notes

FASE 3 — ARTICLE FINAL
draft ──→ corrector ──→ article final + changelog
              │
              ▼
        🟢 REVISIÓ HUMANA OPCIONAL → PUBLICACIÓ
```

---

## FASE 1 — Cerca d'idees

**Objectiu**: generar idees sustentades alhora per tendència externa viva i senyal intern.

### 1.1 Escaneig en paral·lel

Es llancen **simultàniament** (no serialitzar):
- **`radar-web`** — àmbit + finestra temporal (defecte 7 dies). Torna 10–15 tendències externes.
- **`analista-dades`** — mateix àmbit. Torna senyals interns: patrons atípics, continguts destacats, engagement alt, distribució temporal.

### 1.2 Síntesi creativa

- **`ideator` (mode scout)** — rep ambdós outputs + context editorial (to, audiència, línia del blog). Creua senyals i proposa **8–12 idees** amb titular, angle, per_que_ara, dades_internes, evidencies_extra, dificultat, potencial. Recomana **3 idees prioritàries**.

### 1.3 🟢 Checkpoint humà

L'usuari tria 1 idea (o demana variants). Pas crític: evita que el pipeline produeixi articles amb angles febles.

---

## FASE 2 — Borrador

**Objectiu**: convertir la idea triada en un draft complet.

### 2.1 Brief editorial

- **`ideator` (mode brief)** — desenvolupa la idea en brief operatiu: titular, hook, audiència, to, longitud, estructura secció a secció, dades_clau, evidencies_web, angle_unic, que_evitar. Aquest brief és el **contracte** de redactor i corrector.

### 2.2 Recollida de material en paral·lel

- **`analista-dades`** — consultes concretes segons `dades_clau`. Dades, rànquings, cites.
- **`investigador-web`** — dossier estructurat segons `evidencies_web`. Fonts primàries, cites textuals, comparatives, contradiccions.

Els dos poden delegar feina mecànica a `easy-worker`.

### 2.3 Redacció del draft

- **`redactor`** — rep brief + dades internes + dossier web. Escriu un **article complet** seguint les regles d'estil (obertura concreta, paràgrafs curts, zero clixés d'IA, citació inline). Si falten dades, s'atura i les demana — no inventa.

Sortida: markdown amb front-matter + cos + "Notes per al corrector".

---

## FASE 3 — Article final

**Objectiu**: deixar el text llest per publicar.

### 3.1 Revisió

- **`corrector`** — llegeix el draft amb ulls nous. Comprova compliment del brief, caça clixés d'IA, afina ritme i verifica coherència factual. **Canvis cirúrgics**, no reescriptures.

Sortida: article final + changelog (canvis aplicats, compliment brief ✅/⚠, avisos).

### 3.2 🟢 Revisió humana opcional

Segons preferència, l'usuari valida o torna al corrector/redactor amb notes.

### 3.3 Publicació

Aprovat el text, és publicable. Convé actualitzar `memory/articles_publicats.md` (si existeix) perquè l'`ideator` no reproposi el tema.

---

## Regles d'orquestració

1. **Paral·lelització obligatòria** a 1.1 i 2.2.
2. **Checkpoint humà a 1.3 no es salta** — és el filtre de qualitat editorial.
3. **`easy-worker` és recurs compartit**, no una fase.
4. **Cap agent de fase 2/3 treballa sense el brief complet.**
5. **Cap agent inventa dades.** Si falta info, es torna enrere.
6. **Una tesi per article.** L'`ideator` filtra idees barrejades; el `redactor` no les rescata.

---

## Regles comunes obligatòries per a tots els agents

Aquestes tres regles s'apliquen a **tots els agents de l'editorial**. Estan replicades al perfil de cada agent perquè les llegeixi al seu system prompt.

### R1 — Delegació cap avall obligatòria

Cap agent fa una feina que un agent menys potent i més barat pot fer correctament. Si `easy-worker` (Haiku) pot resoldre-la, se li delega. Opus no fa feina de Sonnet; Sonnet no fa feina de Haiku.

### R2 — Escalat davant problemes abans de continuar

Si un agent topa amb un bloqueig — dada que falta, font contradictòria, brief ambigu, input malformat — **s'atura i avisa el seu superior abans de continuar**. No improvisa, no inventa, no emplena amb prosa buida. Millor una pausa amb pregunta clara que un resultat dubtós que contamini la resta del pipeline.

### R3 — L'humà té l'última paraula

Qualsevol decisió editorial és revisable per l'humà. Els checkpoints marcats al flux (1.3 obligatori, 3.2 opcional) són **inviolables**. Cap fase és totalment autònoma.

---

## Slot `analista-dades` — configuració obligatòria

`analista-dades` **no s'inclou** en aquest servei. Cada projecte ha de definir el seu propi agent d'anàlisi de dades internes.

El projecte ha de crear `.claude/agents/analista-dades.md` (o configurar un agent equivalent) amb accés a la seva font de dades. L'agent ha de retornar senyals (patrons, continguts destacats, mètriques) en un format que `ideator` i `corrector` puguin consumir.

Sense `analista-dades`, les fases que el requereixen es fan manualment o s'ometen.

---

## Cost estimat per article

| Fase | Agent | Model | Crides |
|------|-------|-------|--------|
| 1.1 | radar-web | sonnet | 1× |
| 1.1 | analista-dades | sonnet | 1× |
| 1.2 | ideator (scout) | **opus** | 1× |
| 2.1 | ideator (brief) | **opus** | 1× |
| 2.2 | analista-dades | sonnet | 1–3× |
| 2.2 | investigador-web | sonnet | 1× |
| 2.3 | redactor | sonnet | 1× |
| 3.1 | corrector | sonnet | 1× |
| transversal | easy-worker | **haiku** | N× (barat) |

**Cost dominant**: les dues crides a `ideator` (Opus). És deliberat — és on es decideix la qualitat. Estalviar aquí treu valor a tot el pipeline.
