# Decisions d'apunts-per-projectes-agentic

Registre de decisions de disseny del framework. Format: data, decisió, raonament, alternativa descartada, condició de revisió.

---

## 2026-05-08 — OKR mogut de `serveis/` a `equips/`

**Decisió**: `serveis/okr/` → `equips/okr/`
**Raonament**: El test de distinció "A qui retorna un resultat?" determina que OKR produeix output concret per encàrrec (roadmap, KRs, tasques) → és un equip, no un servei.
**Alternativa descartada**: Mantenir-lo a `serveis/` per coherència amb la versió anterior. Descartada perquè viola el criteri fundacional de distinció.
**Condició de revisió**: Si el criteri Equip/Servei canvia de definició.

---

## 2026-05-08 — Distinció Equip vs Servei formalitzada

**Decisió**: Test canònic: "A qui retorna un resultat?" → output a usuari/agent = equip; habilita el sistema passivament = servei.
**Raonament**: La confusió entre equips i serveis generava incoherències estructurals (ex: OKR mal classificat). El test és binari i aplicable a qualsevol component nou.
**Alternativa descartada**: Distinció per "nombre d'agents" o "complexitat". Descartada per ambigüitat.
**Condició de revisió**: Si apareix un component que passa el test però genera confusió en dos contextos reals.

---

## 2026-05-08 — `tasca-seguent` i `revisa-opinio` moguts de `processos/` a `commands/`

**Decisió**: Fitxers traslladats a `commands/`. Els originals a `processos/` convertits en stubs de redirecció.
**Raonament**: Ambdós workflows tenen entry point explícit de l'usuari (slash command / feedback extern). Per definició canònica, això els fa commands, no processos.
**Alternativa descartada**: Mantenir-los a `processos/` amb nota explicativa. Descartada perquè viola la distinció Procés/Command.
**Condició de revisió**: Si la distinció Procés/Command canvia de definició.

---

## 2026-05-08 — Mode d'operació consultiu per defecte

**Decisió**: `plantilles/CLAUDE.md` estableix mode consultiu com a default. Mode automàtic activable explícitament per projecte.
**Raonament**: El mode automàtic sense supervisió és massa agressiu per a projectes nous. El mode consultiu preserva el control de l'usuari. El canvi a automàtic és una decisió conscient, no el comportament per defecte.
**Alternativa descartada**: Mode automàtic per defecte. Descartada per risc de decisions no supervisades en fases inicials.
**Condició de revisió**: Si l'experiència amb projectes pilot mostra que el mode consultiu és un fre consistent.

---

## 2026-05-08 — `ux-expert` usa `model: opus` (Criteri B)

**Decisió**: `ux-expert` porta `model: opus` hardcoded al frontmatter.
**Raonament**: El model és part de la identitat arquitectònica de l'agent (Criteri B de `CLAUDE.md`). `ux-expert` fa judici qualitatiu expert sobre UX — el mateix tipus d'avaluació que `analyst-senior` i `ideator`, que també usen Opus. Haiku o Sonnet no tenen el criteri estètic necessari per a validació UX de qualitat.
**Alternativa descartada**: Sonnet sense model hardcoded, igual que `code-curator`. Descartada perquè la qualitat del judici UX depèn directament del model, no és una qüestió d'esforç.
**Condició de revisió**: Si un model Sonnet futur demostra judici UX equiparable a Opus en projectes pilot.

---

## 2026-05-08 — GRAPH.md com a font de veritat

**Decisió**: Si MANIFEST.md i GRAPH.md discrepessin → GRAPH.md mana.
**Raonament**: GRAPH.md és el mapa complet del sistema (agents, processos, dependències). MANIFEST.md és un catàleg de setup. En cas de conflicte, el mapa detallat té més informació que el catàleg.
**Alternativa descartada**: MANIFEST.md com a font de veritat. Descartada perquè MANIFEST no conté la xarxa de dependències.
**Condició de revisió**: Si GRAPH.md es fragmenta o deixa de ser mantenible com a fitxer únic.
