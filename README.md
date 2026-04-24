# apunts-per-projectes-agentic

Manual de bones pràctiques per a sistemes agentic Claude Code.

**Per consultar, no per clonar.**

---

La majoria de projectes agentic fracassen per un patró concret: l'agent que decideix i l'agent que executa són el mateix. Sense una veu que aporti criteri independent, el sistema és ràpid però fràgil — cada decisió important acaba necessitant la persona humana com a àrbitre extern.

Aquest manual dóna l'estructura mínima per evitar-ho des del primer commit.

---

## Contingut

- [`MANIFEST.md`](MANIFEST.md) — Què és, com funciona, com s'usa
- [`NORMES_GLOBALS.md`](NORMES_GLOBALS.md) — Les 9 regles fundacionals
- [`nucli/`](nucli/) — Els tres agents base (Trinitat)
- [`serveis/`](serveis/) — Paquets modulars activables segons necessitat
- [`scripts/`](scripts/) — Bootstrap i activació de serveis

---

## Punt d'entrada recomanat

Llegeix [`MANIFEST.md`](MANIFEST.md) primer.

---

## Origen

Destil·lat de laboratori_profes, un projecte real d'eina de correcció d'exàmens. Les peces d'aquest manual no s'han inventat — han sorgit de l'ús i s'han formalitzat quan han provat el seu valor.
