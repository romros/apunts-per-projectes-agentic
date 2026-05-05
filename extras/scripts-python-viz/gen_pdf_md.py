#!/usr/bin/env python3
"""
gen_pdf_md.py — Genera un PDF a partir d'un fitxer Markdown.

Usa ReportLab per renderitzar el text. Les línies de figures
(El gràfic corresponent és `figures/<nom>.png`) s'inclouen com a imatge PNG.

Ús:
  python gen_pdf_md.py <fitxer.md> [output.pdf]

Requereix: pip install reportlab
"""

import sys
import re
from pathlib import Path
from datetime import date

from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import cm
from reportlab.lib import colors
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Image, HRFlowable
)
from reportlab.lib.enums import TA_CENTER


CHART_PLACEHOLDER_RE = re.compile(
    r"El gr[àa]fic corresponent [eé]s `(figures/[^`]+\.png)`\."
)

BOLD_RE = re.compile(r"\*\*(.+?)\*\*")
ITALIC_RE = re.compile(r"\*(.+?)\*")
CODE_RE = re.compile(r"`(.+?)`")


def md_inline_to_rl(text: str) -> str:
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    text = BOLD_RE.sub(r"<b>\1</b>", text)
    text = ITALIC_RE.sub(r"<i>\1</i>", text)
    text = CODE_RE.sub(r"<font name='Courier' size=9>\1</font>", text)
    return text


def build_styles():
    base = getSampleStyleSheet()
    return {
        "h1": ParagraphStyle("H1", parent=base["Heading1"], fontSize=18, leading=22,
            spaceAfter=4, textColor=colors.HexColor("#0d0d2b"), fontName="Helvetica-Bold"),
        "subtitle": ParagraphStyle("Subtitle", parent=base["Normal"], fontSize=9, leading=12,
            spaceAfter=14, textColor=colors.HexColor("#666666"), fontName="Helvetica-Oblique"),
        "h2": ParagraphStyle("H2", parent=base["Heading2"], fontSize=12, leading=16,
            spaceBefore=16, spaceAfter=4, textColor=colors.HexColor("#0d0d2b"),
            fontName="Helvetica-Bold"),
        "h3": ParagraphStyle("H3", parent=base["Normal"], fontSize=10, leading=14,
            spaceBefore=8, spaceAfter=2, fontName="Helvetica-Bold"),
        "body": ParagraphStyle("Body", parent=base["Normal"], fontSize=10, leading=15,
            spaceAfter=6, fontName="Helvetica"),
        "note": ParagraphStyle("Note", parent=base["Normal"], fontSize=8.5, leading=12,
            spaceAfter=4, textColor=colors.HexColor("#555555"), fontName="Helvetica"),
        "footer": ParagraphStyle("Footer", parent=base["Normal"], fontSize=7.5, leading=10,
            textColor=colors.HexColor("#999999"), fontName="Helvetica", alignment=TA_CENTER),
    }


def parse_md(md_text: str, base_dir: Path, styles: dict):
    lines = md_text.split("\n")
    story = []
    subtitle_done = False
    i = 0

    while i < len(lines):
        line = lines[i]

        m = CHART_PLACEHOLDER_RE.search(line)
        if m:
            png_path = base_dir / m.group(1)
            if png_path.exists():
                max_w = A4[0] - 4 * cm
                story.append(Spacer(1, 0.3 * cm))
                story.append(Image(str(png_path), width=max_w, height=max_w * 0.55))
                story.append(Spacer(1, 0.3 * cm))
            i += 1
            continue

        if line.strip() == "":
            i += 1
            continue

        if line.startswith("# "):
            story.append(Paragraph(md_inline_to_rl(line[2:].strip()), styles["h1"]))
            i += 1
            continue

        if line.startswith("*") and line.endswith("*") and not line.startswith("**") and not subtitle_done:
            story.append(Paragraph(md_inline_to_rl(line.strip("*").strip()), styles["subtitle"]))
            story.append(HRFlowable(width="100%", thickness=1,
                color=colors.HexColor("#ccccdd"), spaceAfter=6))
            subtitle_done = True
            i += 1
            continue

        if line.startswith("## "):
            story.append(HRFlowable(width="100%", thickness=0.5,
                color=colors.HexColor("#e0e0f0"), spaceBefore=4, spaceAfter=4))
            story.append(Paragraph(md_inline_to_rl(line[3:].strip()), styles["h2"]))
            i += 1
            continue

        if line.startswith("### "):
            text = md_inline_to_rl(line[4:].strip())
            story.append(Paragraph(f"<b>{text}</b>", styles["body"]))
            i += 1
            continue

        if line.startswith("---"):
            story.append(HRFlowable(width="100%", thickness=0.5,
                color=colors.HexColor("#e0e0f0"), spaceBefore=4, spaceAfter=4))
            i += 1
            continue

        story.append(Paragraph(md_inline_to_rl(line.strip()), styles["body"]))
        i += 1

    story.append(Spacer(1, 1 * cm))
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.HexColor("#e0e0f0")))
    story.append(Spacer(1, 0.2 * cm))
    story.append(Paragraph(
        f"Generat per gen_pdf_md.py &middot; {date.today().isoformat()}",
        styles["footer"]
    ))
    return story


def main():
    if len(sys.argv) < 2:
        print("Ús: python gen_pdf_md.py <fitxer.md> [output.pdf]", file=sys.stderr)
        sys.exit(1)

    md_path = Path(sys.argv[1])
    if not md_path.exists():
        print(f"Error: no existeix {md_path}", file=sys.stderr)
        sys.exit(1)

    out_path = Path(sys.argv[2]) if len(sys.argv) >= 3 else md_path.with_suffix(".pdf")
    styles = build_styles()

    doc = SimpleDocTemplate(str(out_path), pagesize=A4,
        leftMargin=2*cm, rightMargin=2*cm, topMargin=2*cm, bottomMargin=2*cm)
    doc.build(parse_md(md_path.read_text(encoding="utf-8"), md_path.parent, styles))

    print(f"PDF generat: {out_path} ({out_path.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
