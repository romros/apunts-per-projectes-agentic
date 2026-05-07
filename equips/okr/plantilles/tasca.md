# TASCA — [TÍTOL CURT I ACCIONABLE]

**ID:** `[fase]-t[NN]`

## Com ho explicaries a algú aliè al projecte?

[Una o dues frases en llenguatge planer. Qui es beneficia i de quin problema. Sense tecnicismes.]

---

## 0) Referències canòniques (llegir abans d'implementar)

- `[FITXER NORMATIU PRINCIPAL]` — invariants, regles d'arquitectura
- `[PATH DEL ROADMAP ACTIU]` — OKR actiu, KR assignat
- `[docs/features/<feature>/README.md]` — si aplica
- Fitxers clau afectats: [paths concrets]

---

## 1) Context / Problema

- Què està passant ara (símptomes o gap respecte l'estat desitjat)
- Per què importa (bloqueig, risc, cost, incoherència)

---

## 2) Rumb triat

**Decisió:** [què farem i què NO farem]
**Per què ara:** [1-3 bullets — ROI, risc reduït, desbloqueja la seguent fase]
**Principi:** [ex: fail-closed, zero duplicació, no trencar contractes existents]

---

## 3) Objectiu

- [ ] Objectiu 1 (mesurable)
- [ ] Objectiu 2 (mesurable)

---

## 4) Punt d'entrada

**Mòdul/subprojecte:** [NOM]
**Fitxer/funció canònica:**
- `[path]:[funció/classe]`

**Components afectats:**
- [llista curta]

---

## 5) Abast

### ENTRA
- [bullets]

### NO ENTRA
- [bullets]

---

## 6) Disseny / Regles

- Regla 1: [determinista / fail-closed / sense efectes secundaris ocults]
- Regla 2: [com es gestionen els errors]

**Contracte (si aplica):**
- Inputs:
- Outputs:
- Errors:
- Side-effects:

---

## 7) Pla de treball

1. [pas 1]
2. [pas 2]
3. [pas 3]

---

## 8) Tests / Validació

**Criteri DONE del projecte:** [comanda canònica declarada al CLAUDE.md]

- [test 1] — què prova
- [test 2] — què prova

---

## 9) Criteris d'acceptació (DoD)

- [ ] Cap contracte extern trencat
- [ ] Tests passats en entorn canònic
- [ ] Documentació actualitzada si la tasca tanca o modifica una feature
- [ ] Commit amb missatge clar

---

## 10) Riscos i guardrails

**Risc principal:** [què pot sortir malament]
**Guardrail:** [com ho prevenim]
**Rollback:** [com es desfà si cal]

---

## 11) Artifacts

- Commits:
- Evidència (output, logs, screenshots):
- Notes finals:

---

## Checklist PM — Tancament

Abans de moure la tasca a `fetes/`:

- [ ] §11 Artifacts omplert amb commits i evidència real
- [ ] `tasques.csv` actualitzat (estat → DONE, data tancament)
- [ ] `krs.csv` actualitzat si aplica
- [ ] Fitxer mogut a la carpeta de tasques fetes
- [ ] Roadmap actualitzat si cal
- [ ] OKR-curator invocada per verificar consistència
