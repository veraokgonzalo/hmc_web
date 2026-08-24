# Tareas de desarrollo — tentativo

Lista tentativa de tareas que implican programación sobre este repositorio (`web_fork/`), extraída de `docs/checklist_presupuesto.md`. Quedan afuera a propósito todos los ítems administrativos/de configuración de plataforma (plan, dominio, medios de pago, envíos, impuestos, páginas legales, redes sociales, carga de productos) — esos no requieren tocar código del tema.

## Landing / home a medida

- [ ] Relevar qué secciones ya cubre el tema base (`sections/hero.tpl`, `sections/banners.tpl`, `sections/featured-categories.tpl`, `sections/featured-brands.tpl`, `sections/icon-text.tpl`, etc.) vs. qué necesita la landing pedida por el cliente.
- [ ] Aplicar la identidad de marca (`docs/design.md`) a `config/settings_schema.json` / `config/settings_data.json`: paleta de colores, tipografía de headings (Quedora o alternativa web-safe), color de acento/botones.
- [ ] Ajustar/crear los blocks y sections necesarios para armar el home a medida (composición en `templates/pages/home.json`), respetando el sistema de blocks existente (`blocks/*.tpl` + `{% schema %}`).
- [ ] Adaptar `layouts/resources/style-tokens.tpl` si los tokens de color/tipografía por defecto no alcanzan para el diseño de marca.
- [ ] Revisar uso del logo en header/footer (`sections/header.tpl`, `snippets/logo/`, `sections/footer.tpl`) contra las reglas de `docs/design.md` (variante horizontal, área de seguridad, versión sobre fondo oscuro/claro).
- [ ] Si la landing requiere secciones que no existen en el tema base, evaluar crear una nueva section siguiendo la convención existente (markup + `{% schema %}` con presets).

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
