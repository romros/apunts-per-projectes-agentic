#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
gen_html_echarts.py — Genera HTML interactiu a partir d'un fitxer Markdown.

Segueix el patró de dos scripts separats per figura ECharts:
  1. Carrega ECharts UNA SOLA VEGADA des d'un fitxer local (assets/echarts.min.js o equivalent)
  2. Extreu NOMÉS el codi d'inicialització de cada figura (no la biblioteca)
  3. Injecta tots els scripts al final del body amb IDs únics i IIFEs

Protocol de figures al .md:
  El gràfic corresponent és `figures/<nom>.png`.

Ús:
  python gen_html_echarts.py <fitxer.md> [output.html]

Adaptar ASSETS_ECHARTS a la ruta local del projecte.
"""

import sys
import re
import html as html_module
from pathlib import Path
from datetime import date


CHART_PLACEHOLDER_RE = re.compile(
    r"El gr[àa]fic corresponent [eé]s `(figures/[^`]+\.png)`\."
)

# Adaptar al projecte destí
ASSETS_ECHARTS = Path(__file__).resolve().parent.parent / "assets" / "echarts.min.js"

CSS = """
* { box-sizing: border-box; }
body {
    font-family: 'Segoe UI', Arial, Helvetica, sans-serif;
    font-size: 10.5pt; line-height: 1.65; color: #1e1e1e;
    background: #f4f5f7; margin: 0; padding: 0;
}
.wrapper { max-width: 860px; margin: 0 auto; background: white; padding: 36px 48px 56px; box-shadow: 0 2px 20px rgba(0,0,0,0.08); }
h1 { font-size: 18pt; font-weight: 700; color: #0a2540; margin: 0 0 4px 0; }
.subtitle { color: #6090b0; font-style: italic; font-size: 10pt; margin-bottom: 28px; display: block; }
h2 { font-size: 12pt; font-weight: 700; color: #0a2540; border-left: 5px solid #e07b00; padding-left: 10px; margin: 28px 0 10px 0; }
h3 { font-size: 10.5pt; font-weight: 700; color: #1a3a60; margin: 16px 0 6px 0; }
p { margin: 0 0 10px 0; text-align: justify; }
strong { font-weight: 700; }
em { font-style: italic; color: #555; }
code { font-family: 'Consolas','Courier New',monospace; font-size: 8.5pt; background: #eef2f7; padding: 1px 5px; border-radius: 3px; color: #0a4080; }
hr { border: none; border-top: 1px solid #dde3ec; margin: 18px 0; }
ul, ol { margin: 6px 0 12px 20px; }
li { margin-bottom: 4px; }
table { width: 100%; border-collapse: collapse; margin: 14px 0 18px 0; font-size: 9pt; }
thead tr { background: #0a2540; }
th { color: white; padding: 7px 10px; text-align: left; font-weight: 600; font-size: 8.5pt; }
td { padding: 6px 10px; border-bottom: 1px solid #e8ecf2; }
tbody tr:nth-child(even) td { background: #f5f8fd; }
.echarts-div { width: 100%; height: 400px; margin: 16px 0 20px 0; border-radius: 4px; box-shadow: 0 1px 8px rgba(10,37,64,0.07); background: #fff; }
footer { margin-top: 32px; font-size: 7.5pt; color: #aaa; border-top: 1px solid #dde3ec; padding-top: 8px; }
"""


def extract_init_script(figure_html_path: Path, chart_id: str) -> tuple[str, str]:
    """
    Extreu el codi d'inicialització ECharts d'una figura HTML.
    Retorna (div_html, init_script_iife).

    Ignora la biblioteca ECharts embedded — la carguem una vegada a nivell de pàgina.
    Funciona amb figures que segueixen el protocol de dos blocs <script> separats:
      - Script 1: biblioteca ECharts completa
      - Script 2: codi d'inicialització (var chart = echarts.init(...))
    """
    txt = figure_html_path.read_text(encoding="utf-8")

    all_scripts = re.findall(r"<script[^>]*>(.*)</script>", txt, re.DOTALL | re.IGNORECASE)

    init_code = None
    for sc in reversed(all_scripts):
        if "setOption" in sc or "echarts.init" in sc:
            umd_start = sc.find("!function(t,e)")
            if umd_start == -1:
                umd_start = sc.find("!function(e,t)")
            if umd_start == -1:
                umd_start = sc.find('"object"==typeof exports')

            if umd_start > 0:
                init_start = sc.find("var chart =")
                if init_start == -1:
                    init_start = sc.find("var myChart =")
                if init_start > umd_start:
                    init_code = sc[init_start:].strip()
                else:
                    init_code = sc.strip()
            else:
                init_code = sc.strip()
            break

    if not init_code:
        return f'<div id="{chart_id}" class="echarts-div"></div>', ""

    init_code = init_code.replace("getElementById('container')", f"getElementById('{chart_id}')")
    init_code = init_code.replace('getElementById("container")', f'getElementById("{chart_id}")')
    init_code = re.sub(r"\bvar chart\b", f"var {chart_id}", init_code)
    init_code = re.sub(r"(?<!\w)chart(?!\w)(?!\s*=\s*echarts)", chart_id, init_code)

    div = f'<div id="{chart_id}" class="echarts-div"></div>'
    iife = f"// {figure_html_path.name}\n(function() {{\n{init_code}\n}})();"
    return div, iife


def convert_inline(text: str) -> str:
    text = html_module.escape(text, quote=False)
    text = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", text)
    text = re.sub(r"\*(.+?)\*", r"<em>\1</em>", text)
    text = re.sub(r"`(.+?)`", r"<code>\1</code>", text)
    return text


def md_to_html_body(md_text: str, base_dir: Path) -> tuple[str, list[str]]:
    lines = md_text.split("\n")
    html_parts = []
    all_init_scripts = []
    chart_counter = [0]

    i = 0
    while i < len(lines):
        line = lines[i]

        m = CHART_PLACEHOLDER_RE.search(line)
        if m:
            png_rel = m.group(1)
            html_rel = png_rel[:-4] + ".html"
            html_path = base_dir / html_rel
            chart_counter[0] += 1
            chart_id = f"chart_{chart_counter[0]:02d}"

            if html_path.exists():
                div, iife = extract_init_script(html_path, chart_id)
                html_parts.append(div)
                if iife:
                    all_init_scripts.append(iife)
            else:
                html_parts.append(f'<figure><img src="{html_module.escape(png_rel)}" alt="Gràfic" style="max-width:100%"></figure>')
            i += 1
            continue

        if line.strip() == "":
            html_parts.append("")
            i += 1
            continue

        if line.startswith("# "):
            text = convert_inline(line[2:].strip())
            html_parts.append(f"<h1>{text}</h1>")
            i += 1
            if i < len(lines) and lines[i].startswith("*") and lines[i].endswith("*"):
                subtitle_text = html_module.escape(lines[i][1:-1].strip(), quote=False)
                html_parts.append(f'<span class="subtitle">{subtitle_text}</span>')
                i += 1
            continue

        if line.startswith("## "):
            text = convert_inline(line[3:].strip())
            html_parts.append(f"<h2>{text}</h2>")
            i += 1
            continue

        if line.startswith("### "):
            text = convert_inline(line[4:].strip())
            html_parts.append(f"<h3>{text}</h3>")
            i += 1
            continue

        if line.startswith("---"):
            html_parts.append("<hr>")
            i += 1
            continue

        text = convert_inline(line)
        html_parts.append(f"<p>{text}</p>")
        i += 1

    return "\n".join(html_parts), all_init_scripts


HTML_TEMPLATE = """\
<!DOCTYPE html>
<html lang="ca">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{title}</title>
  <style>{css}</style>
</head>
<body>
<div class="wrapper">
{body}
<footer>Generat per gen_html_echarts.py · {date}</footer>
</div>
<script>{echarts_js}</script>
<script>
{init_scripts}
</script>
</body>
</html>
"""


def main():
    if len(sys.argv) < 2:
        print("Ús: python gen_html_echarts.py <fitxer.md> [output.html]", file=sys.stderr)
        sys.exit(1)

    md_path = Path(sys.argv[1])
    if not md_path.exists():
        print(f"Error: no existeix {md_path}", file=sys.stderr)
        sys.exit(1)

    out_path = Path(sys.argv[2]) if len(sys.argv) >= 3 else md_path.with_suffix(".html")

    if not ASSETS_ECHARTS.exists():
        print(f"Error: no trobat {ASSETS_ECHARTS}", file=sys.stderr)
        sys.exit(1)

    md_text = md_path.read_text(encoding="utf-8")
    base_dir = md_path.parent

    title_m = re.search(r"^# (.+)$", md_text, re.MULTILINE)
    title = title_m.group(1).strip() if title_m else md_path.stem

    body_html, init_scripts = md_to_html_body(md_text, base_dir)
    echarts_js = ASSETS_ECHARTS.read_text(encoding="utf-8")

    output = HTML_TEMPLATE.format(
        title=html_module.escape(title),
        css=CSS,
        body=body_html,
        echarts_js=echarts_js,
        init_scripts="\n\n".join(init_scripts) if init_scripts else "// cap figura",
        date=date.today().isoformat(),
    )

    out_path.write_text(output, encoding="utf-8")
    size = out_path.stat().st_size
    print(f"HTML generat: {out_path} ({size:,} bytes)")


if __name__ == "__main__":
    main()
