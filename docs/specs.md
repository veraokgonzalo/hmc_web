# Specs de features

> **⚠️ Desactualizado:** este documento fue escrito contra la estructura de tema con sections/blocks (`web_fork/`, ya eliminada). Los paths de archivo citados (`sections/*.tpl`, `blocks/*.tpl`, `config/settings_schema.json`, etc.) no existen en `web_ftp/`, el core de desarrollo actual (ver `CLAUDE.md`). Revisar y reescribir contra la estructura real de `web_ftp/` antes de usar como guía de implementación.

Especificaciones de funcionalidad a construir sobre el tema. Cada feature queda como una sección propia. La estética a aplicar (colores, tipografía, logo, fotografía) vive en `docs/design.md`; acá solo se referencia.

---

## Home / Landing a medida

`templates/pages/home.json` es la landing — no hay una página aparte. El objetivo es venta directa, pero sin arrancar con catálogo: primero se construye confianza/contexto (ofertas, propuesta de valor) y después se empuja a navegar/comprar.

Contenido: todo arranca **placeholder** (copy, fotos, categorías, marcas) coherente con `docs/design.md`, y se reemplaza por contenido real del cliente más adelante sin tocar código.

### 0. Identidad de marca en settings del tema

Aplicar la paleta y tipografía de `docs/design.md` a nivel global del tema, antes de armar las secciones del home (todas las secciones heredan estos valores por defecto):

- `config/settings_schema.json` / `config/settings_data.json`:
  - `background_color`: `#FFFFFF`
  - `text_color`: `#000000` (texto secundario/atenuado: `#494848`)
  - `accent_color` / color de botones y CTAs: `#3FAA47`
  - `font_headings`: Quedora (si está disponible como web font vía `font_picker`; si no, buscar geométrica condensada similar y dejarlo anotado)
  - `font_rest`: pendiente de definir con el cliente (ver `docs/design.md` §3) — mientras tanto, usar una sans-serif neutra del listado de `font_picker` del tema.

### 1. Header + navigation bar de categorías

Ya existen en el tema (`sections/header.tpl`, `sections/navigation-bar.tpl`, `snippets/header/`) con logo y buscador incluidos — es configuración vía editor (aplicar logo de marca, colores), no desarrollo nuevo.

### 2. Hero

Carrusel (`sections/slideshow.tpl`) con ofertas de temporada y/o contenido informativo/institucional. Varios slides, cada uno con heading + texto + botón (según necesidad de cada slide). Reemplaza el contenido demo actual del `home.json` (título/descripción genéricos, texto en amarillo `#FFFF00` que no es de la paleta de marca).

### 3. Propuesta de valor

`sections/icon-text.tpl` + `blocks/icon-text-group.tpl`, 4 ítems (ícono + título corto + descripción):

1. Asesoramiento técnico / respaldo — el diferencial central de marca (ver `docs/design.md` §4: HMC compite por trayectoria y asesoramiento, no por precio).
2. Envíos a todo el país / zona.
3. Medios de pago / cuotas.
4. Garantía / postventa.

Copy definitivo de cada ítem: pendiente del cliente, arranca con placeholder.

### 4. Categorías destacadas

`sections/featured-categories.tpl`, organizadas por **categoría real del catálogo** (no por segmento genérico tipo "obra/campo/casa/negocio"). Qué categorías mostrar: placeholder por ahora, se define cuando estén cargados los productos y se pueda ver cuáles tienen más tráfico/ventas.

### 5. Productos destacados / ofertas

`sections/timer-offers.tpl`, con cuenta regresiva visible.

⚠️ Nota operativa: el countdown de esta sección es decorativo y **no lee la promoción real configurada en Tiendanube** (`start_date`/`end_date` son campos propios del editor del tema, sin integración con la fecha de fin de la Promoción del admin). Cada vez que se cargue una oferta con tiempo límite hay que cargar a mano la misma fecha de fin en ambos lados para que no queden desincronizados.

### 6. Marcas destacadas

`sections/featured-brands.tpl` (`brand-group` + `brand-logo` blocks). Logos placeholder por ahora — se reemplazan por las marcas reales que distribuye HMC cuando el cliente las provea.

### Fuera de esta spec

- Crear una section nueva no fue necesario — las 6 secciones de contenido de arriba ya existen en el tema base. Si en algún punto se pide algo que ninguna section/block existente cubre, se evalúa puntualmente ahí.
- El resto del checklist original (`docs/checklist_presupuesto.md`) que no es programación (plan/dominio, medios de pago, envíos, impuestos, páginas legales, redes sociales, carga de contenido) queda fuera del alcance de este repo.

---

## Ajustes de Feedback del Cliente (2026-09-26)

> Escrito contra la estructura real vigente: `web_ftp/` (tema legacy productivo) para todo lo que ya está migrado, y `boceto_web/` (prototipo) para lo que todavía no se portó (la página "Nosotros" no tiene aún equivalente en `web_ftp/`). Fuente: `docs/feedback_cliente.md` §7.

### A. Mobile — Más espaciado ("falta aire")

El cliente percibe la vista mobile apretada. Archivos: `web_ftp/static/css/style-async.scss` (breakpoints `≤768px`/`≤480px`) y, en paralelo, `boceto_web/css/styles.css`.

- No es el padding horizontal del contenedor (`--container-padding`, ya en 16px en mobile — es un piso definido en `CLAUDE.md`, no se debe bajar de ahí).
- Es espaciado **vertical**: separación entre secciones del home (`section-padding` / márgenes entre `<section>`), y espaciado interno/entre cards en grillas (categorías, productos, value props, testimonios) en los breakpoints mobile.
- Acción: aumentar los valores de `margin`/`padding` verticales entre bloques y el `gap` de las grillas de cards específicamente en `≤768px` y `≤480px`, sin tocar el layout desktop.

### B. Carrusel Hero (Home) — imagen no se condice con el título

Archivos: `web_ftp/snipplets/home/home-slider.tpl` (slides por defecto, líneas 6-34) y `boceto_web/index.html` (slides estáticos, líneas ~37-86). Mapeo correcto:

| Slide | Título | Imagen debe ser |
|---|---|---|
| 1 | "Hacé tu compra online" | Foto de un **tractor** |
| 2 | "Potencia y Rendimiento Para Tu Trabajo" | Foto de **insumos y repuestos** |
| 3 | "Servicio Técnico Oficial y Repuestos Originales" | Foto de **llaves inglesas** (ya es la actual — sin cambios) |

⚠️ Nota operativa: `home-slider.tpl` usa `settings.slider` del admin si está cargado (`has_custom_slider`), y en ese caso ignora por completo los slides por defecto del código. Antes de tocar el `.tpl`, verificar en el admin de Tiendanube si hay un slider custom cargado — si lo hay, el fix va ahí, no en el código.

### C. Categorías Destacadas (Home) — fotos no coinciden con la categoría

Archivo: `web_ftp/snipplets/home/home-categories.tpl` (array `default_categories`, líneas 7-50). Mismo mecanismo de override por admin que el hero: si `settings.slider_categories` está cargado, revisar ahí primero.

Pendiente de auditoría visual (el cliente no especificó cuáles fotos están mal, solo que hay que revisarlas) contra las 6 categorías actuales:

| Slug | Nombre | Imagen actual |
|---|---|---|
| `agua` | Agua | `categoria-3-agua-bombeo.webp` |
| `construccion` | Construcción | `categoria-4-construccion.webp` |
| `consumibles-e-insumos` | Consumibles e Insumos | `categoria-6-accesorios-insumos.webp` |
| `ferreteria` | Ferretería | `categoria-1-ferreteria.webp` |
| `maquina-a-bateria` | Herramientas a Batería | `categoria-5-herramientas-bateria.webp` |
| `maquina-a-explosion` | Máquinas a Explosión | `categoria-2-maquinas-explosion.webp` |

### D. Página "Nosotros" — Tarjetas de valor (`boceto_web/about.html`, líneas 103-127)

Solo existe en `boceto_web/` por ahora (no portada a `web_ftp/`).

- Tarjeta actual `<h4 class="value-prop-title">Servicio Técnico y Taller</h4>` (línea 119) + descripción "Taller propio homologado, puesta en marcha sin cargo y mantenimiento preventivo continuo." (línea 120) → **renombrar a "Servicio de Post Venta"** y ajustar la descripción a ese enfoque (texto definitivo pendiente del cliente).
- Tarjeta `<h4 class="value-prop-title">Asesoría Especializada</h4>` (línea 109) → nueva descripción: *"Personal especializado a tu disposición para guiarte en la elección de la máquina exacta para vos."*

### E. Foto de la Casa Central — interior → exterior

Asset: `sucursal-foto-vertical.webp` (foto actual = interior del showroom/mostrador, según `docs/assets-map.md`). Usada en 4 lugares que hay que actualizar todos con la nueva foto exterior:

1. `web_ftp/static/images/sucursal-foto-vertical.webp` (o nuevo nombre de archivo si se reemplaza el asset)
2. `web_ftp/static/css/style-async.scss:3196` (`background-image`, sección parallax del home)
3. `boceto_web/about.html:203` (`<img src="assets/images/sucursal-foto-vertical.webp">`, sección "Casa Central")
4. `boceto_web/css/styles.css:7301` (`background-image`, parallax del home en el boceto)
