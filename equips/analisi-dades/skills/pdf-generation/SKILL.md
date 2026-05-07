---
name: pdf-generation
description: Generació de PDFs professionals a partir de Markdown via Playwright + HTML. Protocol operatiu, paràmetres correctes i errors coneguts. Usat pel redactor del servei analisi-dades.
when_to_use: Quan cal generar el PDF final d'un informe a partir del document Markdown assembat.
disable-model-invocation: true
---

# Generació de PDFs professionals

Eina canònica: **Playwright + HTML**. Script de referència: `extras/scripts-python-viz/gen_pdf_md.py` (adaptar paths al projecte).

---

## Flux

1. Llegir el Markdown (font de veritat única — no generar des d'altres fonts)
2. Convertir a HTML amb extensions `tables` i `fenced_code`
3. Embedir figures com a base64 inline
4. Generar PDF via Playwright

---

## Paràmetres Playwright correctes

```python
page.emulate_media(media="screen")  # evita CSS print que treu backgrounds
page.pdf(
    format='A4',
    margin={'top': '15mm', 'bottom': '20mm', 'left': '18mm', 'right': '18mm'},
    print_background=True,
    display_header_footer=False,  # bug Chromium #14441
)
```

**`display_header_footer=False` és obligatori.** El bug Chromium #14441 fa que `True` + backgrounds produeixi l'error `pattern_p1_14`. Si cal footer, usar HTML fix al cos del document.

---

## CSS essencial per a taules professionals

```css
th {
    background-color: #003366;
    color: white;
    print-color-adjust: exact;
    -webkit-print-color-adjust: exact;
}
tbody tr:nth-child(even) td {
    background-color: #f0f5fb;
    print-color-adjust: exact;
    -webkit-print-color-adjust: exact;
}
```

Sense `print-color-adjust: exact`, els backgrounds desapareixen al PDF.

---

## Processament de figures

El Markdown pot referenciar figures de dues formes:

```markdown
![caption](figures/nom.png)          ← markdown estàndard
`figures/nom.png`                     ← backtick inline → cal preprocess
```

La funció `process_figures()` ha d'embedir base64 i embolcallar en `<div class="figure-block">` abans de convertir a PDF.

---

## Errors coneguts

| Error | Causa | Fix |
|-------|-------|-----|
| `pattern_p1_14` | `display_header_footer=True` + backgrounds | Posar `display_header_footer=False` |
| Backgrounds blancs al PDF | Falta `print-color-adjust: exact` | Afegir al CSS de taules i elements de color |
| Figura no trobada | Path relatiu al Markdown, no al script | Resoldre paths relatius des del directori del Markdown |

---

## Alternatives si Playwright falla

- **WeasyPrint** — Python pur, bo per CSS Paged Media
- **pwhtmltopdf** — wrapper Playwright + Jinja2
- **Paged.js** — JavaScript, per a layouts complexos
