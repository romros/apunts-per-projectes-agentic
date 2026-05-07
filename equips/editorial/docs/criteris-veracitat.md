# Criteris de veracitat editorial

> Framework transversal per a tots els agents del servei editorial.
> Cada agent aplica els nivells que corresponen al seu rol — veure secció "Com aplica cada agent".

---

## Meta-criteri — La regla de les dates

**Tota afirmació factual ha de ser datable. Si no té data verificable, és declaració, no dada.**

Exemples:
- "El 67% dels creadors catalans usen Instagram" sense data → declaració (no usable com a dada)
- "El 67% dels creadors catalans usaven Instagram el 2023 (CAC, informe anual 2023)" → dada verificable
- "Els experts creuen que..." sense atribució i data → descartable

---

## Nivell 1 — Origen de la font

**Pregunta**: qui ha produït aquesta informació i amb quins interessos?

| Categoria | Fiabilitat | Exemples |
|-----------|-----------|---------|
| Institució pública amb metodologia pública | Alta | CAC, Idescat, INE, Eurostat |
| Institució acadèmica peer-reviewed | Alta | Universitats, Google Scholar, Reuters Institute |
| Institució amb conflicte d'interès evident | Baixa — cal citar i marcar | Meta, TikTok, YouTube (dades pròpies) |
| Consultora comercial sense metodologia pública | Baixa | Informes de màrqueting digital sense fonts |
| Blog / opinionista | No és dada — és opinió | Marcar explícitament com a "opinió" |

**Regla específica de domini per a mètriques de xarxes socials**: xifres autopublicades per creadors (seguidors, visualitzacions, ingressos) → sempre declaració, mai dada. L'excepció: si la plataforma publica dades agregades amb metodologia.

---

## Nivell 2 — Traçabilitat

**Pregunta**: puc arribar a la font original sense passar per intermediaris?

- ✅ URL directa a l'informe/estudi original + data de publicació
- ✅ Cita textual amb: qui + quan + en quin context
- ⚠ Premsa que cita un informe sense URL → buscar l'original; si no es troba, marcar com a "no verificat"
- ❌ "Estudis mostren que..." sense citar cap estudi → no usable
- ❌ URL d'un agregador que no cita la font original → no usable

**Distinció data de publicació vs. data de les dades**: un informe publicat el 2024 pot contenir dades de 2021. Citar sempre la data de les dades, no la de publicació del document.

---

## Nivell 3 — Coherència estadística

**Pregunta**: els números se sostenen per si mateixos?

Senyals d'alerta:
- Percentatge sense base mostral ("el 80%..." sense saber de quina mostra)
- Comparativa sense denominador comú (creixement del 200% sobre una base mínima)
- Tendència d'una sola plataforma presentada com a tendència general
- Dada sense comparativa temporal ("el 67%..." sense referència a any anterior o sector)
- Xifres arrodonides que no coincideixen amb el dossier original

---

## Nivell 4 — Corroboració creuada

**Pregunta**: ho diu més d'una font independent?

- Una sola font → afirmació possible, no confirmada. Indicar-ho.
- Dues fonts independents → mínima verificació
- Tres fonts independents + almenys una primària → afirmació sòlida

**Independència**: dos articles de premsa que citen el mateix informe no són dues fonts independents — són una sola font citada dues vegades.

---

## Com aplica cada agent

### radar-web
Aplica nivells 1 i 4 per a cada senyal que retorna.
- Marca l'estat de cada senyal: `emergent | consolidat | en_declivi`
- Afegeix: `data_verificable: sí/no` — si no té data, el senyal no entra com a emergent
- Limitació estructural: no accedeix a bases de dades primàries. Tot el que valida és via cerca web. Si una dada requereix verificació profunda, la marca per a investigador-web.

### ideator
Aplica nivell 1 al valorar si una idea té sustentació.
- Idees basades en dades internes → verificar que vénen de la BD, no d'interpretació de l'analista
- Idees basades en tendències externes → exigir que radar-web hagi marcat `data_verificable: sí`
- Patró a evitar: inputs "ja interpretats" — vol veure l'evidència bruta, no la conclusió

### investigador-web
Aplica els 4 nivells per a cada evidència del dossier.
- Distingeix explícitament: "no localitzat per absència real" vs. "no localitzat per limitació tècnica" (paywall, PDF no parsejable, JS no renderitzat)
- Mai inclou un URL sense haver fet WebFetch primer
- Llacuna estructural coneguda del domini: estudis acadèmics sobre creadors digitals en català pràcticament no existeixen com a cos consolidat — quan el brief els demana, avisar aviat

### redactor
Aplica el meta-criteri de dates i el nivell 2 per a cada afirmació del draft.
- Cada xifra cita: font + data de les dades (no de publicació)
- Cada cita: qui + quan + en quin context + URL si existeix
- Signals de baixa qualitat als inputs a detectar i marcar: dossiers sense dates, URLs amb resums generats automàticament, cites sense rugositat de parla real, dades sense comparativa

### corrector
Aplica el nivell 3 i el meta-criteri de dates en la cinquena passada (verificació factual).
- Comprova concordança entre xifres del draft i xifres del dossier
- Detecta: anys desplaçats per inèrcia, xifres arrodonides que no coincideixen, noms propis lleugerament incorrectes, cites ambigües entre literal i parafraseig
- No pot verificar cerques noves — detecta inconsistències internes. Si detecta error factual: marca i torna al redactor, no corregeix inventant

---

## Sol·licituds pendents — mecanisme de delegació

Els agents no poden invocar sub-agents directament des del seu fil. Quan un agent identifica feina mecànica que hauria de fer easy-worker (reformatejar, extreure URLs, normalitzar), l'inclou al final del seu output en una secció estructurada:

```markdown
## Sol·licituds pendents

- [ ] Reformatejar la llista de fonts a JSON → easy-worker
- [ ] Verificar que les 8 URLs de la bibliografia retornen 200 → easy-worker
- [ ] Normalitzar dates al format YYYY-MM-DD → easy-worker
```

L'orquestrador llegeix aquesta secció i decideix si delegar o no. Sense aquesta secció, la feina mecànica queda a càrrec de l'agent que l'ha identificat.
