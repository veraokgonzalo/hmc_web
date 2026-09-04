#!/usr/bin/env python3
"""
sync_categories.py
------------------
Analiza data/tiendanube-productos-utf8.csv y extrae el árbol completo de categorías:
Nivel 1 (Principal) -> Nivel 2 (Subcategoría) -> Nivel 3 (Sub-subcategoría),
calculando el total de productos por nodo y normalizando nombres.
Exporta la estructura a JSON y formato JavaScript para boceto_web/js/app.js.
"""

import csv
from collections import Counter, defaultdict
import json
import os
import re

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_PATH = os.path.join(BASE_DIR, "data", "tiendanube-productos-utf8.csv")

# Mapeo de nombres limpios oficiales y descripciones para Nivel 1 (sin &, sin emojis)
ROOT_METADATA = {
    "AGUA": {
        "displayName": "Agua",
        "description": "Electrobombas centrífugas, presurizadoras, sumergibles y bombas solares."
    },
    "CONSTRUCCION": {
        "displayName": "Construcción",
        "description": "Compactación, cortadoras de concreto, allanadoras, medición láser y demolición."
    },
    "CONSUMIBLES E INSUMOS": {
        "displayName": "Consumibles e Insumos",
        "description": "Cadenas, espadas, tanzas, aceites 2T y 4T, grasas y lubricantes específicos."
    },
    "FERRETERIA": {
        "displayName": "Ferretería",
        "description": "Herramientas manuales, eléctricas, a batería, neumáticas y equipamiento para taller."
    },
    "GENERACION ENERGIA": {
        "displayName": "Generación Energía",
        "description": "Grupos electrógenos monofásicos y trifásicos, paneles solares e inversores."
    },
    "JARDIN": {
        "displayName": "Jardín",
        "description": "Herramientas de corte, poda, sopladores, pulverizadores y mantenimiento de césped."
    },
    "MAQUINA A BATERIA": {
        "displayName": "Máquinas a Batería",
        "description": "Línea inalámbrica profesional: motosierras, podadoras, sopladores y baterías."
    },
    "MAQUINA A EXPLOSION": {
        "displayName": "Máquinas a Explosión",
        "description": "Motosierras, motoguadañas, cortacéspedes, riders y motores nafteros o diesel."
    },
    "MAQUINA ELECTRICA": {
        "displayName": "Máquinas Eléctricas",
        "description": "Hidrolavadoras industriales, aspiradoras profesionales y lavadoras de piso."
    },
    "MAQUINA MANUAL": {
        "displayName": "Máquinas Manuales",
        "description": "Barredoras mecánicas y equipos de limpieza manual para taller y depósito."
    },
    "PRODUCTO DE FUERZA": {
        "displayName": "Productos de Fuerza",
        "description": "Motores estacionarios horizontales y verticales, diesel y motobombas pesadas."
    },
    "REPUESTOS": {
        "displayName": "Repuestos",
        "description": "Componentes originales, carburadores, cilindros, cuchillas y kits de reparación."
    },
    "RIEGO": {
        "displayName": "Riego",
        "description": "Aspersores, toberas, electroválvulas, goteros, caños y accesorios de polietileno."
    }
}

def normalize_name(name):
    name = name.strip()
    name = name.replace(" & ", " y ").replace("&", "y")
    # Correcciones de auditoría
    if name == "ACHA":
        return "HACHA"
    if name == "ALLANADORAS-ALISADORAS":
        return "ALLANADORAS - ALISADORAS"
    if name == "LIMA":
        return "LIMAS"
    if name == "TERMOSfusora Elect":
        return "TERMOFUSORAS ELECTRICAS"
    return name

def extract_category_tree():
    tree = defaultdict(lambda: defaultdict(lambda: Counter()))
    product_ids_by_cat = defaultdict(set)

    with open(CSV_PATH, "r", encoding="utf-8-sig") as f:
        reader = csv.DictReader(f, delimiter=";")
        for row in reader:
            pid = row.get("Identificador de URL", "").strip()
            cats_str = row.get("Categorías", "").strip()
            if not cats_str:
                continue
            for cat_path in cats_str.split(","):
                cat_path = cat_path.strip()
                if not cat_path or cat_path.startswith("MARCAS"):
                    continue
                parts = [normalize_name(p) for p in cat_path.split(">")]
                if len(parts) == 1:
                    tree[parts[0]]["__ROOT__"][parts[0]] += 1
                elif len(parts) == 2:
                    tree[parts[0]][parts[1]]["__TOTAL__"] += 1
                elif len(parts) >= 3:
                    tree[parts[0]][parts[1]][parts[2]] += 1
                
                # Guardar el ID de producto para conteo de productos únicos
                norm_path = " > ".join(parts)
                product_ids_by_cat[norm_path].add(pid)

    # Convertir a estructura jerárquica lista para frontend
    result = []
    
    # Calcular totales por rubro principal
    root_totals = {}
    for root in tree.keys():
        unique_prods = set()
        for path, pids in product_ids_by_cat.items():
            if path == root or path.startswith(root + " >"):
                unique_prods.update(pids)
        root_totals[root] = len(unique_prods)

    # Ordenar Nivel 1 ALFABÉTICAMENTE por displayName
    sorted_roots = sorted(
        root_totals.keys(),
        key=lambda r: ROOT_METADATA.get(r, {}).get("displayName", r.title()).lower()
    )

    for root in sorted_roots:
        meta = ROOT_METADATA.get(root, {
            "displayName": root.title().replace(" & ", " y ").replace("&", "y"),
            "description": f"Equipos y productos de {root.lower()}."
        })
        
        subcats_dict = tree[root]

        # Calcular totales por subcategoría
        sub_totals = {}
        for sub in subcats_dict.keys():
            if sub == "__ROOT__":
                continue
            unique_sub_prods = set()
            for path, pids in product_ids_by_cat.items():
                if path == f"{root} > {sub}" or path.startswith(f"{root} > {sub} >"):
                    unique_sub_prods.update(pids)
            sub_totals[sub] = len(unique_sub_prods)

        # Ordenar subcategorías ALFABÉTICAMENTE
        sorted_subs = sorted(sub_totals.keys(), key=lambda s: s.title().lower())

        subcategories = []
        for sub in sorted_subs:
            subsubs_dict = subcats_dict[sub]
            
            # Ordenar sub-subcategorías ALFABÉTICAMENTE
            subsub_counts = {
                ss: count for ss, count in subsubs_dict.items() if ss != "__TOTAL__"
            }
            sorted_subsubs = sorted(subsub_counts.keys(), key=lambda ss: ss.lower())
            
            subsubcategories = []
            for ss in sorted_subsubs:
                clean_ss_name = ss.title() if not ss.isupper() else ss.title()
                # Mantener siglas comunes en mayúsculas si aplica, pero formato legible
                subsubcategories.append({
                    "name": clean_ss_name,
                    "count": subsub_counts[ss],
                    "slug": re.sub(r'[^a-zA-Z0-9]+', '-', ss.lower()).strip('-')
                })

            clean_sub_display = sub.title().replace(" E ", " e ").replace(" Y ", " y ").replace(" & ", " y ").replace("&", "y")
            subcategories.append({
                "name": sub,
                "displayName": clean_sub_display,
                "count": sub_totals[sub],
                "slug": re.sub(r'[^a-zA-Z0-9]+', '-', sub.lower()).strip('-'),
                "subsubcategories": subsubcategories
            })

        slug_root = re.sub(r'[^a-zA-Z0-9]+', '-', root.lower()).strip('-')
        result.append({
            "id": slug_root,
            "name": root,
            "displayName": meta["displayName"],
            "description": meta["description"],
            "count": root_totals[root],
            "subcategoriesCount": len(subcategories),
            "subcategories": subcategories
        })

    return result

if __name__ == "__main__":
    tree = extract_category_tree()
    print(f"Total Categorías Nivel 1: {len(tree)}")
    total_subs = sum(c['subcategoriesCount'] for c in tree)
    total_subsubs = sum(sum(len(s['subsubcategories']) for s in c['subcategories']) for c in tree)
    print(f"Total Subcategorías Nivel 2: {total_subs}")
    print(f"Total Sub-subcategorías Nivel 3: {total_subsubs}")
    
    print("\nTop 12 Categorías Principales:")
    for i, c in enumerate(tree[:12], 1):
        print(f" {i:2d}. {c['displayName']} ({c['name']}): {c['count']} prods | {c['subcategoriesCount']} subcats")

def export_js():
    tree = extract_category_tree()
    js_path = os.path.join(BASE_DIR, "boceto_web", "js", "categories-data.js")
    with open(js_path, "w", encoding="utf-8") as f:
        f.write("/* --------------------------------------------------------------------------\n")
        f.write("   Master Real Categories Tree Database (Extracted from Tiendanube CSV)\n")
        f.write("   Auto-generated by scripts/sync_categories.py\n")
        f.write("   -------------------------------------------------------------------------- */\n\n")
        f.write("const REAL_CATEGORIES_TREE = ")
        json.dump(tree, f, indent=2, ensure_ascii=False)
        f.write(";\n\n")
        f.write("if (typeof window !== 'undefined') {\n")
        f.write("  window.REAL_CATEGORIES_TREE = REAL_CATEGORIES_TREE;\n")
        f.write("}\n")
    print(f"Exportado exitosamente a: {js_path}")

if __name__ == "__main__":
    export_js()
