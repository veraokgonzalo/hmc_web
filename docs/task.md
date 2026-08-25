# Tareas de desarrollo — tentativo

Lista tentativa de tareas que implican programación sobre este repositorio (`web_fork/`), extraída de `docs/checklist_presupuesto.md`. Quedan afuera a propósito todos los ítems administrativos/de configuración de plataforma (plan, dominio, medios de pago, envíos, impuestos, páginas legales, redes sociales, carga de productos) — esos no requieren tocar código del tema.

## Landing / home a medida

Spec definida en `docs/specs.md` § Home / Landing a medida. Plan de implementación paso a paso en `docs/progress.md`.

- [x] Relevar qué secciones ya cubre el tema base vs. qué necesita la landing — ninguna section nueva hizo falta, las 6 secciones de contenido ya existen en el tema (ver "Fuera de esta spec" en `docs/specs.md`).
- [x] Aplicar la identidad de marca (`docs/design.md`) a `config/settings_schema.json` / `config/settings_data.json`: paleta de colores, tipografía de headings (Quedora o alternativa web-safe), color de acento/botones. (spec §0)
- [x] Armar Hero — carrusel de ofertas/contenido informativo (spec §2, `sections/slideshow.tpl`).
- [x] Armar Propuesta de valor — 4 ítems ícono+texto (spec §3, `sections/icon-text.tpl`).
- [x] Armar Categorías destacadas — por categoría real del catálogo, placeholder (spec §4, `sections/featured-categories.tpl`).
- [x] Armar Productos destacados/ofertas con countdown (spec §5, `sections/timer-offers.tpl`) + recordatorio de sincronizar a mano la fecha con la promoción real, y **hoy está oculta en la tienda publicada** porque no tiene fechas cargadas — solo se ve en el preview del editor con un countdown de prueba. Para que aparezca en la tienda real hay que cargar `start_date`/`start_time`/`end_date`/`end_time` en la sección (deben coincidir con una promoción real configurada en el admin de Tiendanube). También hay que crear la colección `timer_offers` en el admin — hoy no existe, así que la sección usa productos placeholder.
- [x] Armar Marcas destacadas — logos placeholder (spec §6, `sections/featured-brands.tpl`).
- [ ] Adaptar `layouts/resources/style-tokens.tpl` si los tokens de color/tipografía por defecto no alcanzan para el diseño de marca.
- [ ] Revisar uso del logo en header/footer (`sections/header.tpl`, `snippets/logo/`, `sections/footer.tpl`) contra las reglas de `docs/design.md` (variante horizontal, área de seguridad, versión sobre fondo oscuro/claro).
- [ ] QA Task 7 (2026-08-24) encontró un gap concreto en el chequeo anterior: el renderizado del logo (`web_fork/blocks/header-logo.tpl:3-9` → `web_fork/snippets/logo/logo-img.tpl:12`, `image_src: store.logo(logo_thumbnail)`) siempre muestra el mismo asset subido en el admin, sin lógica que elija variante de color según el `background_color` de la sección (tabla "Usos correctos" de `docs/design.md` §1: blanco/mono sobre verde, isotipo verde + texto blanco sobre negro/gris oscuro, isotipo verde + texto negro sobre gris claro). Hoy el header (`web_fork/templates/layout/header.json:57`) y el footer (`web_fork/templates/layout/footer.json:8`) tienen `background_color: "#FFFFFF"`, que sí corresponde a la versión a color por defecto — pero si algún fondo cambia a verde/negro/gris (colores de la propia paleta de marca), el mismo logo se renderizaría sin ajuste de color. Nota: el footer (`web_fork/templates/layout/footer.json:39-46`) no tiene ningún logo cargado en el bloque `footer-institutional` (falta la key `logo`), así que hoy no muestra logo ahí.

### Pendiente de contenido del cliente

- [ ] Los 8 links placeholder (`"#"`) del home no apuntan a nada real: 2 botones del hero, 1 botón de la sección de ofertas, y los 6 links de categorías destacadas — reemplazar cuando existan las páginas/colecciones reales.
- [ ] Copy e imágenes del hero son placeholder (sin `image`/`image_mobile` configuradas en los slides) — reemplazar con fotos reales de producto/marca cuando el cliente las provea.
- [ ] Tipografía: `font_headings` usa "Chakra Petch" y `font_rest` usa "Inter" como aproximaciones provisorias — la tipografía real de marca ("Quedora", ver `docs/design.md` §3) no está disponible como web font; si el cliente provee el archivo, hay que evaluar subirla como fuente custom.
- [ ] Logos de marcas (`featured_brands_section`) y nombres de categorías (`featured_categories_real`) son placeholder — ya estaban anotados, referenciados acá para juntar todo lo pendiente en un solo lugar.

## SEO técnico (parte de "Medición y SEO base" que sí es código)

- [ ] Revisar `snippets/structured-data/structured-data-organization.tpl` y `structured-data.tpl`: completar datos de la organización/producto si faltan campos.
- [ ] Verificar que `layouts/layout.tpl` / `component('head-tags')` generen correctamente `<title>` y meta description por tipo de página (home, producto, categoría).
- [ ] Confirmar que las imágenes renderizadas por `snippets/image.tpl` incluyan `alt` (ya soporta `media_alt`, pero verificar que las plantillas lo estén pasando en todos los usos nuevos que se agreguen).

## Medición (solo si se necesita algo más allá de la integración nativa de Tiendanube)

- [ ] Si el cliente pide tracking de e-commerce avanzado (add to cart, checkout steps, compra) más allá de lo que cubre la integración nativa de GA4/Meta Pixel de Tiendanube, instrumentar eventos custom en `static/js/store.js` / `libraries.js.tpl`.
- [ ] (Condicional a lo anterior) Verificar que los eventos disparen correctamente en el carrito ajax (`snippets/cart/cart-modal.tpl`, notificación en `layouts/layout.tpl`).

## QA de flujo de compra

- [ ] Recorrer el flujo completo (`main-product` → carrito ajax → `main-cart` → checkout) sobre el tema ya personalizado y corregir bugs de template/estilos que aparezcan (el checkout en sí no es customizable, pero sí todo lo previo).
- [ ] Testear responsive (mobile/desktop) de las secciones nuevas del home a medida.

---

Esta lista es un punto de partida — conviene revisarla contra `docs/specs.md` (specs de features) a medida que se defina el alcance final con el cliente, y trackear el avance real en `docs/progress.md`.
