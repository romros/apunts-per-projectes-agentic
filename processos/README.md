# Processos

Workflows **interns multi-agent** sense entry point d'usuari. Els dispara el sistema (un agent, un trigger intern), no l'usuari directament.

---

## Distinció fonamental: commands vs processos

Tot projecte agentic té dos tipus de workflows:

**`commands/`** — workflows amb **entry point explícit de l'usuari**. L'usuari els invoca (via slash command, frase literal, instrucció directa). Font de veritat per a qualsevol workflow que comenci des de fora del sistema.

**`processos/`** — workflows **interns entre agents**. Els dispara el sistema (un agent completa una fase, es detecta una condició). L'usuari no els invoca directament, tot i que pot ser-ne el disparador indirecte.

**Regla crítica: mai duplicar.** Si un workflow existeix a `commands/`, no existeix a `processos/`. Un procés intern pot *referenciar* un command, però no copiar-ne el contingut.

---

## Exemple del principi en acció

`tasca-seguent` té disparador de l'usuari ("l'usuari dona el OK") → viu a `commands/tasca-seguent.md`.

`tancar-tasca` té disparador intern ("PM ha validat el DoD") → viu a `processos/tancar-tasca.md`.

`tasca-seguent` (command) referencia `tancar-tasca` (procés) al pas 1. El codi de cada un viu en un sol lloc.

---

## Processos disponibles

| Procés | Disparador | Fitxer |
|--------|-----------|--------|
| **Executar una tasca** | L'usuari proposa una tasca nova | `executar-tasca.md` |
| **Tancar una tasca** | PM ha validat que l'evidència cobreix el DoD | `tancar-tasca.md` |
| **Nou roadmap** | El roadmap actual és tancat i cal definir el següent | `nou-roadmap.md` |
| **Gestió de deutes** | Worker o PM detecta un deute fora del scope de la tasca activa | `gestio-deutes.md` |

Els workflows `tasca-seguent` i `revisa-opinio` han estat moguts a `commands/` perquè tenen entry point d'usuari.
