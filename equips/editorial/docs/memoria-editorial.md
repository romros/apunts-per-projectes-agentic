# Memòria editorial — estructura i protocol

> Guia per als agents i per al projecte destí. Explica quins fitxers de memòria existeixen, qui els escriu, quan es creen i com s'actualitzen.
> **No crear fitxers buits.** Els fitxers es creen la primera vegada que hi ha contingut real per posar-hi.

---

## Memòria compartida — fets del projecte

Viu a `memory/shared/`. La llegeixen tots els agents. Té un únic escriptor per fitxer.

### `memory/shared/estil-editorial.md`

**Qui l'escriu**: el projecte (manualment) o el corrector quan tanca el primer article aprovat per l'humà.

**Quan es crea**: quan el primer article ha passat la revisió humana i hi ha estil aprovat.

**Contingut mínim**:
```markdown
# Estil editorial del projecte

## To i veu
- Persona: tu / vosaltres / indefinit
- Registre: col·loquial / formal / periodístic
- Longitud de frase: curta (<20 paraules) / variada / llarga admesa
- Temes vedats: [llistar]

## Tics aprovats (part de la veu, no clixés)
- [construccions que el corrector NO ha de marcar com a error]

## Tics a evitar (específics d'aquest projecte)
- [a part dels clixés d'IA genèrics]

## Referència: primer article aprovat
- Titular: [titular]
- Data: [data]
- Per llegir la veu de referència: [path]
```

### `memory/shared/articles-publicats.md`

**Qui l'escriu**: el corrector (afegeix una entrada quan tanca cada article) o manualment.

**Quan es crea**: quan el primer article es publica.

**Contingut mínim per entrada**:
```markdown
## [data] — [titular]
- Slug: [slug]
- Angle: [angle en una frase]
- Dades internes usades: [sí/no + quines]
- Resultat: aprovat / tornat al redactor N vegades
```

---

## Memòria per agent — aprenentatge operatiu

Viu a `memory/<agent>/`. Cada agent és propietari del seu fitxer.

### `memory/radar-web/memory.md`

**Qui l'escriu**: radar-web, al final de cada execució si ha après alguna cosa nova.

**Contingut**:
- Fonts que han donat resultats fiables per al domini del projecte
- Fonts que han donat resultats poc fiables o amb biaix identificat
- Àmbits on la seva cobertura és estructuralment feble (p.ex. contingut en vídeo)

### `memory/ideator/memory.md`

**Qui l'escriu**: ideator, al final de cada sessió scout si ha identificat patrons.

**Contingut**:
- Patrons de la font de dades interna que no cal redescobrir (relacions, estacionalitats)
- Idees proposades i el seu estat (proposada / aprovada / escrita / descartada-per-motiu)
- Angles que han funcionat bé vs. angles que han caigut

### `memory/investigador-web/memory.md`

**Qui l'escriu**: investigador-web, quan descobreix patrons del domini.

**Contingut**:
- Llacunes estructurals conegudes del domini (no buscar-les cada vegada)
- Fonts primàries recurrents del domini
- Tipus de cerca que no funcionen per a aquest domini

### `memory/redactor/memory.md`

**Qui l'escriu**: redactor, quan el corrector retorna notes recurrents.

**Contingut**:
- Errors recurrents identificats pel corrector
- Estructures d'article que han funcionat (obertura, tancament, transicions)

### `memory/corrector/memory.md`

**Qui l'escriu**: corrector, quan calibra el nivell d'intervenció adequat per al projecte.

**Contingut**:
- Historial de qualitat: articles que han passat amb pocs canvis vs. molts canvis
- Tendències estilístiques del redactor que **no** s'han de corregir (part de la veu)
- Calibratge de la "prova d'autocontrol": quin és el nombre normal de canvis per a aquest projecte

---

## Regla d'escriptura

Cap agent crea un fitxer de memòria buit. El fitxer es crea la primera vegada que hi ha contingut real per posar-hi. La memòria buida no és memòria — és deute.

Quan un agent escriu memòria, usa el sistema `flash.jsonl` del Servei Memòria (si actiu) o escriu directament al fitxer corresponent.
