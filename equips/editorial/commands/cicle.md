# /cicle — Cicle editorial complet

Executa el cicle editorial complet sobre el tema: $ARGUMENTS

Segueix aquest flux obligatori, en ordre, amb TaskCreate per a cada fase. No saltis cap pas. No escriguis res sense evidències validades.

## PREPARACIÓ

- Crea les tasques del cicle amb TaskCreate (fases 1a, 1b, 2, 3, 4a, 4b, 5, 6).
- Defineix el slug del tema (paraules curtes en minúscules amb guions, p. ex. `gestacio-ia`).
- Crea el directori `peces/<slug>/` i `peces/<slug>/grafics/`.

---

## FASE 1 — SENYALS (en paral·lel)

Llança `radar-web` i `analista-dades` simultàniament.

**radar-web**: busca tendències actuals (últims 3-6 mesos) sobre el tema. Senyals externs, notícies, debats, casos humans, estudis, declaracions. Desa a `pluja de idees/<data>-radar-<slug>.md`.

**analista-dades**: consulta la font de dades interna del projecte per extreure senyals rellevants — patrons atípics, continguts destacats, engagement alt, evolució temporal, etc. Fes les consultes que la teva font de dades permeti. Desa a `pluja de idees/<data>-analisi-<slug>.md`.

⚠ **CONFIGURACIÓ REQUERIDA**: `analista-dades` és un slot que cada projecte ha de definir amb el seu agent de dades propi. Si el projecte no té `analista-dades`, aquesta fase es fa manualment o s'omet. Documenta la font de dades al `CLAUDE.md` del projecte.

---

## FASE 2 — IDEACIÓ I BRIEF (ideator, un sol agent)

Alimenta l'ideator amb els dos outputs de la Fase 1.

**Mode scout**: genera 5-8 idees d'article. Per a cada una: títol, angle, evidència disponible, potencial (1-5). Tria la millor i justifica.

**Mode brief** (mateix agent, continuació): desenvolupa la idea triada en un brief complet:
- Títol definitiu (3 opcions, tria la millor)
- Tesi central (2-3 frases)
- Audiència, to i registre
- Estructura per seccions
- Dades i cites clau
- Fonts externes necessàries per a l'investigador-web
- Riscos editorials

Desa scout a `pluja de idees/<data>-scout-<slug>.md` i brief a `briefs/<data>-brief-<slug>.md`.

🟢 **CHECKPOINT HUMÀ**: l'usuari tria 1 idea (o demana variants). No continuïs fins tenir confirmació.

---

## FASE 3 — VALIDACIÓ (en paral·lel)

Llança `analista-dades` i `investigador-web` simultàniament, alimentats amb el brief.

**analista-dades**: valida les dades crítiques del brief. Confirma o descarta cada hipòtesi amb dades reals de la font interna. Marca quines xifres estan verificades i quines no. Desa a `pluja de idees/<data>-dades-<slug>.md`.

**investigador-web**: construeix el dossier de fonts externes sobre el tema del brief. Per a cada font: URL, data, autor, cita textual clau, utilitat per a l'article. Declara explícitament les llacunes. Desa a `pluja de idees/<data>-dossier-<slug>.md`.

---

## FASE 4 — REDACCIÓ

Llança el redactor amb tots els inputs: brief + dossier web + dades validades.

Escriu tres peces:

- **`editorial.md`** (950-1.100 paraules): to analític i emotiu. Autoritat sense pedanteria.
- **`blog.md`** (750-900 paraules): to proper i honest. De tu a tu.
- **`twitter-thread.md`** (11-13 tweets): revelació progressiva. Cada tweet funciona sol.

**Regles de rigor absolutes** (el redactor no pot saltar-se-les):
- Cap xifra sense font verificada
- Cap cita entre cometes sense font primària escrita
- Si una dada no s'ha pogut confirmar, no s'usa o s'indica explícitament la font i el grau de certesa

Desa a `peces/<slug>/editorial.md`, `peces/<slug>/blog.md`, `peces/<slug>/twitter-thread.md`.

---

## FASE 5 — CORRECCIÓ

Llança el corrector amb les tres peces i el brief.

Avaluació per dimensions (1-5): cor, rigor, emoció, pragmatisme, impacte. Crítica dura — si no emociona, ho diu. Si el titular no para, ho diu.

Reescriu el que suspengui ≥2 dimensions. Retoca el que suspengui 1. No toca el que funciona.

Sobreescriu els tres fitxers. Crea `peces/<slug>/revisio-corrector.md` amb l'avaluació, el changelog i la recomanació final.

---

## FASE 6 — GRÀFICS (opcional)

Genera 2 gràfics PNG professionals amb Python (matplotlib, estil editorial net — fons blanc, colors periodístics). Tria les dues visualitzacions que tinguin més impacte narratiu.

Desa el script a `peces/<slug>/grafics/genera_grafics.py` i executa'l.

Insereix les imatges als tres markdown en els punts de màxim impacte:
- `![títol del gràfic](grafics/nom-grafic.png)` a editorial i blog
- `📎 *[adjuntar: grafics/nom-grafic.png]*` al twitter-thread

---

## ENTREGA FINAL

Estructura de fitxers resultant:

```
pluja de idees/
  <data>-radar-<slug>.md
  <data>-analisi-<slug>.md
  <data>-scout-<slug>.md
  <data>-dades-<slug>.md
  <data>-dossier-<slug>.md
briefs/
  <data>-brief-<slug>.md
peces/<slug>/
  editorial.md
  blog.md
  twitter-thread.md
  revisio-corrector.md
  grafics/
    genera_grafics.py
    01-<nom>.png
    02-<nom>.png
```

Informa l'usuari quan cada fase acabi. Marca cada tasca `completed` en el moment que acabi — no esperis el final.
