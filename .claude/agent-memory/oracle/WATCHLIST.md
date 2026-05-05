# Watchlist oracle — llavor

> Àrees fràgils. Llegit quan la pregunta és sobre estabilitat o riscos futurs.

---

## WIZARD.md ↔ MANIFESTs — risc de deriva

El WIZARD descriu el flux d'instal·lació de cada servei. Els MANIFESTs descriuen el mateix des del punt de vista del servei. Qualsevol canvi a un MANIFEST que afecti la instal·lació ha d'actualitzar el WIZARD (i viceversa).

**Senyal d'alerta**: si el WIZARD diu "fes X" i el MANIFEST de destil·lació diu "fes Y" per al mateix servei.

---

## nucli/oracle.md ↔ .claude/agents/oracle.md — risc de divergència

La plantilla (`nucli/`) i la còpia operacional (`.claude/agents/`) poden divergir si s'actualitza una i no l'altra. L'Override de projecte al fitxer local documenta el risc i obliga a actualitzar manualment.

**Senyal d'alerta**: si `nucli/oracle.md` canvia (estructura, límits, calibratge) i `.claude/agents/oracle.md` no s'ha actualitzat.

---

## Projectes ja bootstrappejats — risc de divergència silenciosa

Cada projecte destí té fitxers copiats per valor des d'un SHA concret. Si el llavor evoluciona (nous invariants, agents actualitzats), els projectes existents no ho saben. No hi ha `seed sync` implementat.

**Senyal d'alerta**: quan un projecte destí invoca un agent del llavor i el comportament és diferent del que el seu CLAUDE.md descriu.

---

## Catàleg sense validació multi-projecte

Serveis com `okr`, `pm`, `dev`, `editorial` han entrat al catàleg validats en un sol projecte (el laboratori d'origen). La regla és ≥2 contextos per promoure a norma. Cap d'ells compleix la regla pròpia del llavor.

**Senyal d'alerta**: quan un projecte destí activi un d'aquests serveis i trobi que els supòsits no apliquen al seu domini.
