# Prediccions oracle — llavor

> Decisions aprovades per oracle amb predicció de conseqüències. Llegit quan la pregunta és sobre evolució o decisions passades.

---

## 2026-05-05 — Procés de destil·lació com a text, no agent

**Decisió**: el procés de destil·lació d'agents viu a `FUNDATOR.md` com a procés textual. No es crea un agent destil·lador.

**Raó**: no hi ha comportament diferenciat ni estat recurrent entre destil·lacions. Un wrapper sobre instruccions textuals no aporta valor.

**Predicció**: si en ≥3 destil·lacions l'orquestrador produeix resultats inconsistents (agents que entren al catàleg sense qualitat suficient), la pressió serà crear un agent. Condició de revisió: inconsistència observada, no anticipada.

---

## 2026-05-05 — MCP ajornat

**Decisió**: no construir MCP ara. Reconsiderar quan catàleg ≥10 serveis + ≥3 projectes + cerca textual insuficient.

**Raó**: llavor és repo estàtic. MCP requereix servidor en execució. Local-first es trenca si és extern. 3 de 4 eines proposades repliquen WebFetch.

**Predicció**: la cerca semàntica serà el primer dolor real (no les altres eines). El senyal serà "no trobo el servei adequat" repetit per ≥2 usuaris independents.

---

## 2026-05-05 — Dependències als MANIFESTs, no deps.json

**Decisió**: dependències entre serveis viuen a cada `MANIFEST.md` (secció `## Dependències` amb format rich). No hi ha `deps.json` central.

**Raó**: localitat. La dep viu amb el servei que la declara. Un JSON central divergiria silenciosament dels MANIFESTs.

**Predicció**: si el catàleg supera ~12 serveis, la navegació manual dels MANIFESTs costarà. Aleshores un script que generi el graf des dels MANIFESTs (derivat, no font de veritat) tindrà sentit.
