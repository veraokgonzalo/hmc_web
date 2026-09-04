#!/usr/bin/env python3
"""
sync_brands.py
--------------
Analiza el archivo data/tiendanube-productos-utf8.csv, extrae las marcas reales,
aplica normalizaciones y genera la estructura de datos JS para el boceto web.
"""

import csv
from collections import Counter
import json
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_PATH = os.path.join(BASE_DIR, "data", "tiendanube-productos-utf8.csv")

def extract_brands():
    brand_counts = Counter()

    with open(CSV_PATH, "r", encoding="utf-8-sig") as f:
        reader = csv.DictReader(f, delimiter=";")
        for row in reader:
            b = row.get("Marca", "").strip()
            # Fallback a categoría "MARCAS > ..." si la columna Marca está vacía
            if not b:
                for c in row.get("Categorías", "").split(","):
                    c = c.strip()
                    if c.startswith("MARCAS >"):
                        b = c.replace("MARCAS >", "").strip()
                        break
            # Caso huérfano identificado en la auditoría
            if not b and "ALIAFOR" in row.get("Nombre", ""):
                b = "ALIAFOR"
            # Normalización de error tipográfico
            if b == "SIZH":
                b = "SHIZEN"
            if b:
                brand_counts[b] += 1

    sorted_brands = [
        {"name": b, "count": c}
        for b, c in sorted(brand_counts.items(), key=lambda x: x[0].upper())
    ]
    return sorted_brands, brand_counts

if __name__ == "__main__":
    brands, counts = extract_brands()
    print(f"Total marcas únicas: {len(brands)}")
    print(f"Total productos mapeados: {sum(counts.values())}")
    print("\nTop 10 marcas por catálogo:")
    for b, c in counts.most_common(10):
        print(f" - {b}: {c} productos")
