# Home / Landing a medida — Plan de implementación

> **Para quien ejecute este plan:** usar `superpowers:subagent-driven-development` (recomendado) o `superpowers:executing-plans`, tarea por tarea. Los pasos usan checkboxes (`- [ ]`) — tildalos a medida que avanzás; este archivo es también el tracker de avance del proyecto.

**Goal:** Reconstruir `templates/pages/home.json` como la landing a medida de HMC Hub (identidad de marca + 5 secciones de contenido en el orden aprobado), reemplazando el contenido demo del tema base.

**Architecture:** Todo el trabajo es edición de JSON de configuración del tema Nimbus (`config/settings_data.json` y `templates/pages/home.json`) usando sections y blocks que **ya existen** en `web_fork/` — no hace falta crear ningún `.tpl` nuevo. Cada sección se arma como un objeto dentro de `sections` + una entrada en el array `order`.

**Tech Stack:** Tiendanube/Nuvemshop, motor de plantillas Nimbus (Twig-like), `@tiendanube/cli` (`tiendanube theme ...`). No hay test runner: la verificación de cada paso es (a) el JSON es válido, y (b) `tiendanube theme diff` / `tiendanube theme preview` muestran el cambio esperado — ver `CLAUDE.md`.

**Spec:** `docs/specs.md` § Home / Landing a medida. Reglas de marca: `docs/design.md`.

## Global Constraints

- Paleta de marca (verbatim de `docs/design.md`): verde `#3FAA47`, negro `#000000`, gris oscuro `#494848`, gris claro `#CCCCCC`.
- Todo el copy/imágenes/categorías/marcas arranca **placeholder** — coherente con tono de marca, se reemplaza después sin tocar código.
- No crear ninguna section/block nueva — las 5 secciones de contenido de la spec ya existen en el tema (`sections/slideshow.tpl`, `sections/icon-text.tpl`, `sections/featured-categories.tpl`, `sections/timer-offers.tpl`, `sections/featured-brands.tpl`).
- El countdown de `timer-offers` no lee la promoción real de Tiendanube — sus fechas se cargan a mano (ver spec §5).
- Todos los comandos `tiendanube theme ...` se corren desde `web_fork/`.

---

### Task 1: Identidad de marca en `config/settings_data.json`

**Files:**
- Modify: `web_fork/config/settings_data.json` (objeto `settings`)

**Interfaces:**
- Produces: `settings.accent_color`, `settings.font_headings`, `settings.font_rest` con los valores de marca — todas las secciones del home (tareas 2-6) heredan estos tokens automáticamente vía `layouts/resources/style-tokens.tpl`, no hace falta repetirlos por sección.

- [ ] **Step 1: Confirmar que `background_color` y `text_color` ya están correctos**

Abrí `web_fork/config/settings_data.json` y confirmá que `settings.background_color` es `"#FFFFFF"` y `settings.text_color` es `"#000000"` — ya coinciden con `docs/design.md` §2, no requieren edición.

- [ ] **Step 2: Editar `accent_color`**

Cambiar:
```json
"accent_color": "#49539E",
```
por:
```json
"accent_color": "#3FAA47",
```

- [ ] **Step 3: Editar `font_headings` y `font_rest`**

Cambiar:
```json
"font_headings": "\"Zalando Sans Expanded\", sans-serif",
```
por:
```json
"font_headings": "\"Chakra Petch\", sans-serif",
```
`docs/design.md` §3 nombra "Quedora" como tipografía de marca, pero no está entre las fuentes de `font_picker` del tema (son solo Google Fonts) y el manual no incluye el archivo de la fuente. "Chakra Petch" es la aproximación geométrica/técnica más cercana disponible — dejar anotado que es una decisión provisoria, a confirmar con el cliente si van a proveer el archivo real de Quedora para subirla como fuente custom (fuera de alcance de esta tarea).

Cambiar:
```json
"font_rest": "\"Zalando Sans\", sans-serif",
```
por:
```json
"font_rest": "\"Inter\", sans-serif",
```
`docs/design.md` §3 deja la tipografía de texto de cuerpo pendiente de confirmar con el cliente — "Inter" es un placeholder neutro y legible mientras tanto.

- [ ] **Step 4: Validar el JSON**

Run: `python -m json.tool web_fork/config/settings_data.json > /dev/null`
Expected: sin output (JSON válido). Si tira error de sintaxis, corregir antes de seguir.

- [ ] **Step 5: Preview del cambio**

Run (desde `web_fork/`): `tiendanube theme diff`
Expected: el diff muestra solo los 3 valores de `config/settings_data.json` cambiados en este paso.

- [ ] **Step 6: Commit**

```bash
git add web_fork/config/settings_data.json
git commit -m "theme: apply HMC Hub brand palette and typography to settings"
```

---

### Task 2: Hero — carrusel de ofertas/institucional + limpieza del home demo

**Files:**
- Modify: `web_fork/templates/pages/home.json`

**Interfaces:**
- Consumes: nada de tareas anteriores (el color/fuente se aplican solo vía `settings`, no se referencian acá).
- Produces: la key de sección `"slideshow"` en `sections`, y `"order": ["slideshow"]` — la tarea 3 la extiende agregando la siguiente key al final del array.

- [ ] **Step 1: Eliminar las secciones demo que no son parte de la spec**

En `web_fork/templates/pages/home.json`, borrar del objeto `sections` las keys `"featured_products_1"` y `"banners_grid_3_vertical"` completas (no están en la spec de `docs/specs.md`).

- [ ] **Step 2: Reemplazar el contenido de la sección `slideshow`**

Reemplazar el objeto de la key `"slideshow"` por:

```json
"slideshow": {
  "type": "slideshow",
  "settings": {
    "autoplay": false
  },
  "blocks": {
    "slide_offers": {
      "type": "slide",
      "settings": {
        "alignment": "center",
        "gap": 16,
        "vertical_padding": 32,
        "horizontal_padding": 32,
        "text_color": "#FFFFFF",
        "show_overlay": true,
        "overlay_color": "#000000",
        "overlay_opacity": 30
      },
      "blocks": {
        "heading": {
          "type": "heading",
          "settings": {
            "title": "Ofertas de temporada",
            "size": "h1"
          }
        },
        "text": {
          "type": "text",
          "settings": {
            "text": "Descuentos en herramientas y equipos seleccionados.",
            "size": "paragraph_big"
          }
        },
        "button": {
          "type": "button",
          "settings": {
            "label": "Ver ofertas",
            "link": "#",
            "variant": "primary",
            "size": "big"
          }
        }
      },
      "block_order": ["heading", "text", "button"]
    },
    "slide_institucional": {
      "type": "slide",
      "settings": {
        "alignment": "center",
        "gap": 16,
        "vertical_padding": 32,
        "horizontal_padding": 32,
        "text_color": "#FFFFFF",
        "show_overlay": true,
        "overlay_color": "#000000",
        "overlay_opacity": 30
      },
      "blocks": {
        "heading": {
          "type": "heading",
          "settings": {
            "title": "Todo lo que mueve tu obra, tu campo, tu casa o tu negocio",
            "size": "h1"
          }
        },
        "text": {
          "type": "text",
          "settings": {
            "text": "Respaldo técnico y asesoramiento en cada compra.",
            "size": "paragraph_big"
          }
        },
        "button": {
          "type": "button",
          "settings": {
            "label": "Conocé HMC Hub",
            "link": "#",
            "variant": "secondary",
            "size": "big"
          }
        }
      },
      "block_order": ["heading", "text", "button"]
    }
  },
  "block_order": ["slide_offers", "slide_institucional"]
}
```

Notas de esta sección:
- El heading del segundo slide reutiliza textual la bio de Instagram citada en `docs/design.md`/`docs/checklist_presupuesto.md` ("Un solo lugar. Todo lo que mueve tu obra, tu campo, tu casa o tu negocio") — es copy de marca real, no lorem ipsum.
- No se configura `image`/`image_mobile` en ningún slide a propósito: sin imagen, `blocks/slide.tpl` usa automáticamente el placeholder rotativo del tema (`images/placeholders/carrousel/slide-N.webp`); el overlay negro al 30% garantiza que el texto blanco sea legible sobre cualquier placeholder o foto real que se cargue después.
- Los links de los botones (`"#"`) son placeholder — apuntar a la colección de ofertas real y a una página institucional cuando existan.

- [ ] **Step 3: Actualizar el array `order`**

Reemplazar:
```json
"order": ["slideshow", "featured_products_1", "banners_grid_3_vertical"]
```
por:
```json
"order": ["slideshow"]
```

- [ ] **Step 4: Validar el JSON**

Run: `python -m json.tool web_fork/templates/pages/home.json > /dev/null`
Expected: sin output.

- [ ] **Step 5: Preview del cambio**

Run (desde `web_fork/`): `tiendanube theme diff`, luego `tiendanube theme preview` y abrir la URL — confirmar que el home ahora tiene solo el carrusel hero con los 2 slides, texto blanco legible, sin las secciones demo viejas.

- [ ] **Step 6: Commit**

```bash
git add web_fork/templates/pages/home.json
git commit -m "theme: rebuild home hero and drop demo sections"
```

---

### Task 3: Propuesta de valor

**Files:**
- Modify: `web_fork/templates/pages/home.json`

**Interfaces:**
- Produces: la key de sección `"value_props"` (`type: "icon-text"`), agregada al final de `order`.

- [ ] **Step 1: Agregar la sección al objeto `sections`**

Agregar esta key junto a `"slideshow"` dentro de `sections`:

```json
"value_props": {
  "type": "icon-text",
  "settings": {
    "alignment": "center",
    "section_width": "page",
    "gap": 32,
    "vertical_padding": 64
  },
  "blocks": {
    "heading": {
      "type": "heading",
      "settings": {
        "title": "Por qué elegir HMC Hub",
        "size": "h4"
      }
    },
    "items": {
      "type": "icon-text-group",
      "settings": {
        "icon_position": "horizontal",
        "alignment": "left",
        "mobile_format": "carousel",
        "icon_size": 32,
        "description_size": "paragraph_small",
        "gap": 16
      },
      "blocks": {
        "item_1": {
          "type": "icon-text-item",
          "settings": {
            "icon_source": "design",
            "icon": "phone",
            "title": "Asesoramiento técnico",
            "description": "Te ayudamos a elegir el equipo justo para tu obra, campo, casa o negocio."
          }
        },
        "item_2": {
          "type": "icon-text-item",
          "settings": {
            "icon_source": "design",
            "icon": "shipping",
            "title": "Envíos a todo el país",
            "description": "Coordinamos el envío a donde estés."
          }
        },
        "item_3": {
          "type": "icon-text-item",
          "settings": {
            "icon_source": "design",
            "icon": "card",
            "title": "Medios de pago",
            "description": "Tarjetas, transferencia y cuotas."
          }
        },
        "item_4": {
          "type": "icon-text-item",
          "settings": {
            "icon_source": "design",
            "icon": "security",
            "title": "Garantía y postventa",
            "description": "Respaldo y servicio técnico después de la compra."
          }
        }
      },
      "block_order": ["item_1", "item_2", "item_3", "item_4"]
    }
  },
  "block_order": ["heading", "items"]
}
```

Los 4 ítems son los definidos en la spec (asesoramiento técnico, envíos, medios de pago, garantía/postventa); los íconos (`phone`, `shipping`, `card`, `security`) son de la librería de íconos ya incluida en `blocks/icon-text-item.tpl`, no hace falta ningún asset nuevo.

- [ ] **Step 2: Agregar la key al array `order`**

```json
"order": ["slideshow", "value_props"]
```

- [ ] **Step 3: Validar el JSON**

Run: `python -m json.tool web_fork/templates/pages/home.json > /dev/null`
Expected: sin output.

- [ ] **Step 4: Preview del cambio**

Run: `tiendanube theme diff` / `tiendanube theme preview` — confirmar que debajo del hero aparecen los 4 ítems con ícono, título y descripción, en fila en desktop y como carrusel en mobile.

- [ ] **Step 5: Commit**

```bash
git add web_fork/templates/pages/home.json
git commit -m "theme: add home value-props section"
```

---

### Task 4: Categorías destacadas

**Files:**
- Modify: `web_fork/templates/pages/home.json`

**Interfaces:**
- Produces: la key de sección `"featured_categories_real"` (`type: "featured-categories"`), agregada al final de `order`.

- [ ] **Step 1: Agregar la sección al objeto `sections`**

```json
"featured_categories_real": {
  "type": "featured-categories",
  "settings": {
    "orientation": "horizontal",
    "use_different_mobile_orientation": true,
    "orientation_mobile": "vertical",
    "section_width": "page",
    "gap": 32
  },
  "blocks": {
    "heading": {
      "type": "heading",
      "settings": {
        "title": "Categorías",
        "size": "h4"
      }
    },
    "nav": {
      "type": "category-nav",
      "static": true,
      "settings": {
        "category_type": "image_thumbnail",
        "format_image": "square",
        "gap": 32
      },
      "blocks": {
        "cat_1": { "type": "category-item", "settings": { "text": "Motosierras", "link": "#" } },
        "cat_2": { "type": "category-item", "settings": { "text": "Hidrolavadoras", "link": "#" } },
        "cat_3": { "type": "category-item", "settings": { "text": "Desmalezadoras", "link": "#" } },
        "cat_4": { "type": "category-item", "settings": { "text": "Generadores", "link": "#" } },
        "cat_5": { "type": "category-item", "settings": { "text": "Ferretería", "link": "#" } },
        "cat_6": { "type": "category-item", "settings": { "text": "Pinturas", "link": "#" } }
      },
      "block_order": ["cat_1", "cat_2", "cat_3", "cat_4", "cat_5", "cat_6"]
    }
  },
  "block_order": ["heading", "nav"]
}
```

Las 6 categorías son placeholder basado en los rubros que se ven en las fotos del brandbook (`docs/design.md` §4) — se reemplazan por las categorías reales/más visitadas cuando el catálogo esté cargado (spec §4). Ningún `category-item` tiene `image` configurada a propósito: sin imagen, `blocks/category-item.tpl` usa automáticamente el placeholder rotativo del tema.

- [ ] **Step 2: Agregar la key al array `order`**

```json
"order": ["slideshow", "value_props", "featured_categories_real"]
```

- [ ] **Step 3: Validar el JSON**

Run: `python -m json.tool web_fork/templates/pages/home.json > /dev/null`
Expected: sin output.

- [ ] **Step 4: Preview del cambio**

Run: `tiendanube theme diff` / `tiendanube theme preview` — confirmar que aparecen las 6 categorías como thumbnails cuadrados en carrusel horizontal.

- [ ] **Step 5: Commit**

```bash
git add web_fork/templates/pages/home.json
git commit -m "theme: add home featured-categories section"
```

---

### Task 5: Productos destacados / ofertas (con countdown)

**Files:**
- Modify: `web_fork/templates/pages/home.json`

**Interfaces:**
- Produces: la key de sección `"timer_offers_section"` (`type: "timer-offers"`), agregada al final de `order`.

- [ ] **Step 1: Agregar la sección al objeto `sections`**

```json
"timer_offers_section": {
  "type": "timer-offers",
  "settings": {
    "section_width": "page",
    "gap": 16,
    "vertical_padding": 64,
    "horizontal_padding": 32,
    "background_color": "transparent"
  },
  "blocks": {
    "timer": {
      "type": "timer",
      "settings": {
        "alignment": "center",
        "alignment_vertical": "center",
        "gap": 16,
        "vertical_padding": 60,
        "horizontal_padding": 32,
        "background_color": "#FFFFFF",
        "text_color": "#000000"
      },
      "blocks": {
        "heading": {
          "type": "heading",
          "settings": {
            "title": "Oferta por tiempo limitado",
            "size": "h4"
          }
        },
        "text": {
          "type": "text",
          "settings": {
            "text": "Aprovechá antes de que termine."
          }
        },
        "counter": {
          "type": "timer-counter",
          "settings": {
            "background_color": "#3FAA47",
            "text_color": "#FFFFFF"
          }
        },
        "button": {
          "type": "button",
          "settings": {
            "label": "Ver ofertas",
            "link": "#",
            "variant": "primary"
          }
        }
      },
      "block_order": ["heading", "text", "counter", "button"]
    },
    "products": {
      "type": "timer-products",
      "settings": {
        "title": "Productos en oferta",
        "products_source": { "kind": "collection", "id": "timer_offers" }
      }
    }
  },
  "block_order": ["timer", "products"]
}
```

Notas importantes:
- **A propósito no se configuran `start_date`/`start_time`/`end_date`/`end_time`.** Según `sections/timer-offers.tpl:23-29,42`, sin fechas válidas la sección solo se muestra en el preview del editor (con el reloj en `00 00 00`) y queda **oculta en la tienda publicada**. Es el comportamiento correcto hasta que exista una promoción real: cuando se cargue una promoción con fecha de fin en el admin de Tiendanube, hay que completar esas 4 fechas acá a mano con el mismo rango (ver spec §5) para que el countdown se muestre.
- `timer-counter` usa el verde de marca (`#3FAA47`) de fondo con texto blanco, para que el reloj se sienta parte de la identidad y no un componente genérico.
- `products_source` apunta a una colección con `id: "timer_offers"` — esa colección hay que crearla/nombrarla en el admin de Tiendanube (contenido, fuera de alcance de este repo); mientras no exista, `blocks/timer-products.tpl` muestra 8 productos placeholder automáticamente.

- [ ] **Step 2: Agregar la key al array `order`**

```json
"order": ["slideshow", "value_props", "featured_categories_real", "timer_offers_section"]
```

- [ ] **Step 3: Validar el JSON**

Run: `python -m json.tool web_fork/templates/pages/home.json > /dev/null`
Expected: sin output.

- [ ] **Step 4: Preview del cambio**

Run: `tiendanube theme diff`, luego `tiendanube theme preview` — en el editor/preview la sección debe aparecer (modo preview siempre la muestra) con el reloj en verde de marca y productos placeholder. Confirmar (leyendo el código, no hace falta un sitio publicado) que sin fechas configuradas la sección no se renderiza en la tienda real.

- [ ] **Step 5: Commit**

```bash
git add web_fork/templates/pages/home.json
git commit -m "theme: add home timer-offers section"
```

---

### Task 6: Marcas destacadas

**Files:**
- Modify: `web_fork/templates/pages/home.json`

**Interfaces:**
- Produces: la key de sección `"featured_brands_section"` (`type: "featured-brands"`), agregada al final de `order`. Última sección del home.

- [ ] **Step 1: Agregar la sección al objeto `sections`**

```json
"featured_brands_section": {
  "type": "featured-brands",
  "settings": {
    "section_width": "page",
    "gap": 32,
    "text_alignment": "center"
  },
  "blocks": {
    "heading": {
      "type": "heading",
      "settings": {
        "title": "Marcas que trabajamos",
        "size": "h4"
      }
    },
    "brands": {
      "type": "brand-group",
      "settings": {
        "logo_size": 80,
        "gap": 40
      },
      "blocks": {
        "logo_1": { "type": "brand-logo", "settings": {} },
        "logo_2": { "type": "brand-logo", "settings": {} },
        "logo_3": { "type": "brand-logo", "settings": {} },
        "logo_4": { "type": "brand-logo", "settings": {} },
        "logo_5": { "type": "brand-logo", "settings": {} },
        "logo_6": { "type": "brand-logo", "settings": {} }
      },
      "block_order": ["logo_1", "logo_2", "logo_3", "logo_4", "logo_5", "logo_6"]
    }
  },
  "block_order": ["heading", "brands"]
}
```

Ningún `brand-logo` tiene `image` configurada a propósito: sin imagen, `blocks/brand-logo.tpl` usa automáticamente el placeholder rotativo del tema (`images/placeholders/logos/brand-logo-N.webp`) — se reemplazan por los logos reales de las marcas que distribuye HMC cuando el cliente los provea (spec §6).

- [ ] **Step 2: Agregar la key al array `order` (orden final)**

```json
"order": ["slideshow", "value_props", "featured_categories_real", "timer_offers_section", "featured_brands_section"]
```

- [ ] **Step 3: Validar el JSON**

Run: `python -m json.tool web_fork/templates/pages/home.json > /dev/null`
Expected: sin output.

- [ ] **Step 4: Preview del cambio**

Run: `tiendanube theme diff` / `tiendanube theme preview` — confirmar que el carrusel de logos placeholder aparece al final del home.

- [ ] **Step 5: Commit**

```bash
git add web_fork/templates/pages/home.json
git commit -m "theme: add home featured-brands section"
```

---

### Task 7: QA final del home completo

**Files:** ninguno (solo verificación) — a lo sumo ajustes puntuales sobre `web_fork/templates/pages/home.json` si el preview muestra algo roto.

**Interfaces:** consume el resultado completo de las tareas 1-6.

- [ ] **Step 1: Diff completo**

Run (desde `web_fork/`): `tiendanube theme diff`
Expected: el diff acumulado de las 6 tareas anteriores, sin cambios inesperados fuera de `config/settings_data.json` y `templates/pages/home.json`.

- [ ] **Step 2: Preview y recorrido visual en desktop**

Run: `tiendanube theme preview`, abrir la URL y recorrer el home de arriba a abajo. Confirmar el orden: Hero → Propuesta de valor → Categorías destacadas → Productos/ofertas (oculto si no hay fechas cargadas, ver Task 5) → Marcas destacadas → footer. Confirmar que el verde `#3FAA47` se usa en botones/acentos y que los headings usan la tipografía Chakra Petch aplicada en la Task 1.

- [ ] **Step 3: Recorrido responsive**

Repetir el recorrido del Step 2 en viewport mobile (devtools del navegador). Confirmar que la sección de Categorías destacadas cambia a orientación vertical (`orientation_mobile: vertical` de la Task 4) y que la Propuesta de valor pasa a carrusel (`mobile_format: carousel` de la Task 3).

- [ ] **Step 4: Chequeo del logo en header/footer contra `docs/design.md`**

Con el editor de temas abierto, revisar que el logo en `sections/header.tpl` y `sections/footer.tpl` respete la variante y el color de logo correctos para el fondo que tengan (ver `docs/design.md` §1, tabla de "Usos correctos"). Si no cumple, **no corregirlo acá** — anotarlo como ítem aparte en `docs/task.md` (header/footer ya existían antes de esta spec, están fuera de su alcance).

- [ ] **Step 5: Marcar como resuelto en `docs/task.md`**

Tildar en `docs/task.md` § "Landing / home a medida" los ítems que este plan cubrió (identidad de marca en settings, y las 5 secciones del home).

- [ ] **Step 6: Commit final (si el Step 4 generó cambios)**

```bash
git add web_fork/templates/pages/home.json docs/task.md
git commit -m "theme: finish home landing implementation, QA pass"
```
