# Specs de features

Especificaciones de funcionalidad a construir en `web_fork/`. Cada feature queda como una sección propia. La estética a aplicar (colores, tipografía, logo, fotografía) vive en `docs/design.md`; acá solo se referencia.

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
