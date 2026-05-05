```yaml
name: analisi-dades
version: 1.0.0
status: validat
origen: projecte domini .cat (consultoria de dades puntCAT)
depen_de:
  - corrector-catala
```

# Servei: analisi-dades

Pipeline multi-agent per a consultoria de dades: des de la consulta a una BD fins al document final revisat. Cobreix el cicle sencer dades → visualització → interpretació → narrativa → correcció.

## Quan activar

- El projecte fa anàlisi de dades i produeix informes per a audiències expertes
- Cal un pipeline estructurat amb agents especialitzats per a cada fase
- La BD és accessible via MCP

## Fitxers que aporta

| Fitxer | Rol |
|--------|-----|
| `agents/data-analyst.md` | Executa consultes SQL via MCP. Retorna dades estructurades. |
| `agents/viz-builder.md` | Genera gràfics ECharts (HTML + PNG) a partir de dades. |
| `agents/analyst-senior.md` | Interpretació profunda. Hipòtesis contrastades intern + extern. Usa Opus. |
| `agents/researcher.md` | Cerca externa per contrastar hipòtesis. Retorna fonts citades. |
| `agents/redactor-analisi.md` | Coherència narrativa del document final. Fresh eyes. Verifica, no inventa. |
| `skills/data-narrative/SKILL.md` | Principis de narrativa de dades per a audiències expertes (Knaflic, Tufte, Minto). |
| `skills/pdf-generation/SKILL.md` | Protocol de generació de PDFs via Playwright + HTML. |

El `corrector-catala` és el darrer pas del pipeline però viu al servei independent `serveis/corrector-catala/` — s'activa com a dependència.

## Dependències

**Requereix activat:**
- `corrector-catala` — últim pas del pipeline (correcció lingüística del document final)

**Llegeix de:**
- BD del projecte via MCP (data-analyst)
- Fonts web públiques (researcher)
- Fitxers d'anàlisi intermedis: dades brutes, fonts externes
- `analisi.md` — output de l'analyst-senior, input directe del redactor-analisi (sense pas d'assemblatge intermedi)

**Escriu a:**
- `<directori-analisi>/analisi.md` — interpretació de l'analyst-senior
- `<directori-analisi>/fonts-externes.md` — fonts del researcher
- `<directori-analisi>/figures/` — gràfics del viz-builder
- Document final + `_corregit.md` — output del corrector

## Pipeline

```
data-analyst → viz-builder → analyst-senior ←→ researcher
                                    ↓
                            redactor-analisi
                                    ↓
                           corrector-catala
                                    ↓
                            document final
```

`analyst-senior` i `researcher` treballen en cicle: l'analyst formula hipòtesis, el researcher les contrasta amb fonts externes, l'analyst integra i tanca.

## Activació manual

1. Activar primer la dependència:
   ```
   serveis/corrector-catala/MANIFEST.md → seguir instruccions
   ```

2. Copiar els agents a `.claude/agents/` del projecte destí:
   ```
   data-analyst.md, viz-builder.md, analyst-senior.md,
   researcher.md, redactor-analisi.md
   ```

3. Copiar els skills a `.claude/skills/` del projecte destí:
   ```
   data-narrative/SKILL.md, pdf-generation/SKILL.md
   ```

4. **Adaptar `data-analyst.md`**: afegir les eines MCP específiques de la BD al frontmatter. Crear `.claude/agent-memory/data-analyst/` amb l'estructura de skills que l'agent declara a la secció "Memòria d'esquema": `schema/SKILL.md`, `joins/SKILL.md`, `metrics/SKILL.md`, `temporal/SKILL.md`, `business-rules/SKILL.md`. Inicialitzar-los buits i omplir-los a mesura que el data-analyst descobreix l'esquema.

5. **Adaptar `analyst-senior.md`**: declarar a la secció "Context mínim necessari" els paths reals dels fitxers d'input del projecte:
   - Dades internes — output del data-analyst
   - Fonts externes — output del researcher (`fonts-externes.md`)
   - Perfil de domini — `docs/perfil-<domini>.md` o equivalent
   - Memòria d'edicions — `<directori-analisi>/memoria-edicions.md` (crear buit si el projecte és recurrent)

6. **Copiar scripts auxiliars** de `extras/scripts-python-viz/` del llavor:
   - `screenshot.py` — captura HTML → PNG via Playwright
   - `gen_html_echarts.py` — assembla HTML interactiu amb figures ECharts
   - `gen_pdf_md.py` — converteix Markdown a PDF via ReportLab
   Adaptar els paths interns de cada script al projecte destí.

7. Al `CLAUDE.md` del projecte, afegir a la secció d'agents:
   ```
   Pipeline analisi-dades: data-analyst → viz-builder → analyst-senior ←→ researcher → redactor-analisi → corrector-catala
   ```

## Notes

- **`analyst-senior` usa Opus** — cada invocació és cara. Aplicar el test 3/3 (forma causal + canvia decisió + ≥2 fonts heterogènies).
- **`viz-builder` no té memòria** — les plantilles del projecte (`assets/` o equivalent) són la font de veritat visual.
- **El registre esperat** per al corrector ha de declarar-se al brief de cada informe.
- Els scripts de generació (`screenshot.py`, `gen_html_echarts.py`, `gen_pdf_md.py`) viuen a `extras/scripts-python-viz/` del llavor — copiar i adaptar paths al projecte.
