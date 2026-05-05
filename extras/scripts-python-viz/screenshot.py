#!/usr/bin/env python3
"""Converteix HTML a PNG via Playwright. Ús: python screenshot.py input.html output.png [width] [height] [delay_ms]"""
import sys
from pathlib import Path
from playwright.sync_api import sync_playwright

def screenshot(html_path, out_path, width=1000, height=520, delay=900):
    html_abs = Path(html_path).resolve()
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page(viewport={'width': width, 'height': height})
        page.goto(f'file:///{html_abs}')
        page.wait_for_timeout(delay)
        page.screenshot(path=str(out_path), full_page=True)
        browser.close()
    print(f'OK: {out_path} ({Path(out_path).stat().st_size:,} bytes)')

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print('Ús: python screenshot.py input.html output.png [width] [height] [delay_ms]')
        sys.exit(1)
    w = int(sys.argv[3]) if len(sys.argv) > 3 else 1000
    h = int(sys.argv[4]) if len(sys.argv) > 4 else 520
    d = int(sys.argv[5]) if len(sys.argv) > 5 else 900
    screenshot(sys.argv[1], sys.argv[2], w, h, d)
