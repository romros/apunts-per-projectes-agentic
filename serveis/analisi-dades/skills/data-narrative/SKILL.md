---
name: data-narrative
description: Principis de narrativa de dades per a audiències expertes que prenen decisions. Estructura, format i anti-patrons basats en Knaflic, Tufte, Minto i Dykes. Usat per analyst-senior i redactor del servei analisi-dades.
when_to_use: Quan es produeix analisi.md, informes o documents destinats a decisors experts. No per a documentació tècnica interna ni posts de blog generalistes.
disable-model-invocation: true
---

# Narrativa de dades professional

Principis per a documents destinats a audiències expertes que prenen decisions.
Fonts: Knaflic (*Storytelling with Data*), Tufte (*The Visual Display of Quantitative Information*), Minto (*The Pyramid Principle*), Dykes (*Effective Data Storytelling*).

---

## Estructura: Pyramid Principle + BLUF

La conclusió va **primer**. L'expert vol la resposta, no el viatge.

- **Resum executiu** (no "BLUF" — no és català): el finding més important, no la descripció del que fa l'informe.
- Estructura deductiva: resposta → argumentació → dades de suport.
- Si l'expert vol profunditat, la demanarà. No la serveixis per defecte.

**Test de comprensibilitat**: el resum executiu ha de ser llegible per un no-analista a la primera lectura. Si el lector ha de llegir-ho dues vegades, cal reescriure-ho. Eliminar del resum: argot analític, "aritmètica de creixement", "dilució de taxa agregada". Usar causa-efecte en termes plans.

---

## Narrativa fractal — BLUF a 3 nivells

L'estructura s'aplica simultàniament a tres nivells:

- **Nivell document**: el resum executiu = BLUF de tot l'informe. Si llegeixes NOMÉS el resum, tens la decisió completa.
- **Nivell secció**: la primera frase de cada secció = BLUF d'aquella secció. Si llegeixes NOMÉS les primeres frases en seqüència, tens la història completa.
- **Nivell bloc**: cada bloc narratiu segueix Data → Insight → Acció. Si falta un component, el bloc és incomplet.

**Test fractal (obligatori)**: extreu la primera frase de cada secció. Llegeix-les seguides. Formen una narrativa coherent? Si no → el document falla → tornar al redactor.

---

## Unitat mínima: Data → Insight → Acció

Cada bloc narratiu té tres components obligatoris:

- **Data**: l'observació factual (xifra, tendència, anomalia)
- **Insight**: per què és significatiu per a l'audiència concreta
- **Acció**: què implica per a les decisions que s'han de prendre

Sense els tres, el bloc no és complet:
- Dades sense insight = soroll
- Insight sense acció = acadèmic
- Acció sense dades = opinió

---

## Regles per a audiències expertes

- **No explicar el que ja saben**: sobre-explicar a experts senyala desconfiança en el receptor.
- **Data-ink ratio màxim** (Tufte): eliminar tot text que no aporti dada nova o insight.
- **Separar exploració d'explicació**: no mostrar com s'ha arribat a les dades; mostrar el que les dades diuen i per què importa.
- **To peer-to-peer**: col·legues que informen col·legues, no consultor a client.

---

## Anti-patrons a eliminar

- Frases que comencen amb: "Cal destacar que", "És important notar", "Com podem observar", "En el context de"
- Context pedagògic per a coses que l'audiència ja sap
- Narrativa emocional o identitària que no aporta dada
- Repetir en text el que el gràfic ja mostra
- Mostrar el procés analític quan l'expert vol el resultat
- Argot analític en el resum executiu

---

## Expert vs. audiència general

| Dimensió | Audiència general | Decisors experts |
|----------|-------------------|------------------|
| Context | Necessari i extens | Assumit o breu |
| Metodologia | No mostrar | Transparència sobre limitacions |
| Complexitat | Reduir | No simplificar en excés |
| Estructura | General a específic amb molta mà | Conclusió primer sense excuses |
| Chartjunk | Tolerable si ajuda | Contraproduent: senyala desconfiança |

---

## Objectivitat i transparència

La narrativa de dades és necessàriament subjectiva. La distinció rellevant no és entre objectiu i subjectiu, sinó entre subjectivitat íntegra i subjectivitat deshonesta.

- Articular explícitament el que les dades indiquen, els seus límits i les conclusions defensables.
- Ser transparent sobre la selecció: "hem escollit mostrar X perquè és el factor diferencial; Y i Z existeixen però no canvien la conclusió principal."
- Separar recomanació de conclusió: "les dades mostren X" vs. "recomanem Y basant-nos en X" — no barrejar-los.

---

## Fonts

- Cole Nussbaumer Knaflic — *Storytelling with Data* → format Data→Insight→Acció, principi "so what?"
- Edward Tufte — *The Visual Display of Quantitative Information* → data-ink ratio, eliminació de chartjunk
- Barbara Minto — *The Pyramid Principle* → conclusió primer, estructura deductiva
- Brent Dykes — *Effective Data Storytelling* → triangle Dades-Narrativa-Visuals
- Daniel Kahneman — *Thinking, Fast and Slow* → detectar quan l'audiència activarà heurística i quan cal forçar raonament (útil quan la dada contradiu la intuïció experta)
