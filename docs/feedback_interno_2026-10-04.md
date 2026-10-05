# Feedback Interno — 2026-10-04

Revisión sobre la última versión del tema en `web_ftp/`. Estado: **implementado (2026-10-04)** — ver detalle en `docs/progress.md`.

## Categorías

- [x] Los nombres de las categorías van en **minúsculas**.
- [x] Eliminar la cantidad de productos que aparece como subtítulo de cada categoría.
- [x] Eliminar el subtítulo "Busca repuestos y filtra rubros".
- [x] **Mobile:** al escribir una letra en el buscador de categorías se busca automáticamente; debería esperar a que el usuario toque "Buscar".
- [x] **Mobile — directorio de categorías:** el campo de texto de búsqueda debe ocupar todo el ancho de la sección.

## Marcas

- [x] **Mobile:** el buscador del directorio alfabético de marcas no funciona.

## Listados de productos

- [x] Las fotos de las tarjetas de producto se desplazan hacia la derecha al pasar el mouse sobre el nombre del producto. No debería haber animación.

## Topbar (`snipplets/header/header-advertising.tpl`)

- [x] Cambiar el texto del link de WhatsApp de "Ventas y Factura A" a **"Canal de Ventas"**.
- [x] Reemplazar los items del marquee por los mismos de la value prop strip (`snipplets/banner-services/banner-services.tpl`), con sus íconos, en ambas copias del track (la visible y la `aria-hidden`):
  - `fa-shield-halved` Garantía y Service Oficial
  - `fa-truck-ramp-box` Envíos a Todo el País
  - `fa-credit-card` Todos los Medios de Pago
  - `fa-headset` Asesoramiento Técnico

## Hero — Imágenes del carrusel (`snipplets/home/home-slider.tpl`, array `default_slides`)

Las tres imágenes ya existen en `web_ftp/static/images/hero/` y en `boceto_web/assets/images/hero/`; solo hay que reasignar el campo `image` (y actualizar el `alt` de cada slide acorde a la nueva foto). Replicar en `boceto_web/index.html`.

- [x] Slide 1 — "Hacé tu compra online": `images/hero/hero-slide-2-respaldo-generadores.jpg` → **`images/hero/hero-slide-1-ofertas-motosierras.jpg`**
- [x] Slide 2 — "Potencia y Rendimiento Para Tu Trabajo": `images/hero/hero-slide-1-ofertas-motosierras.jpg` → **`images/hero/banner-showcase-1-linea-pesada.jpg`**
- [x] Slide 3 — "Servicio Técnico Oficial y Repuestos Originales": `images/hero/hero-slide-3-servicio-tecnico-taller.jpg` → **`images/hero/hero-slide-2-respaldo-generadores.jpg`**

> Nota: esto reemplaza el ítem §2 "Carrusel Hero" del plan de feedback del cliente 2026-09-26 en `docs/progress.md` (tractor / insumos y repuestos).

## Header y Hero (Home mobile)

- [x] El logo de HMC en el header debe tener espaciado respecto del margen izquierdo.
- [x] El título del hero debe tener espaciado respecto del borde izquierdo.
- [x] El botón del hero debe achicar su ancho al de los otros botones de abajo (como "Consultar al taller").

## Botones (mobile, global)

- [x] Todos los botones en mobile deben tener el mismo ancho que el botón "Consultar al taller".

## Menú lateral (drawer mobile)

- [x] Eliminar el texto con fondo rojo que dice "OFF".
- [x] Quitar el fondo gris innecesario del campo de texto (buscador); dejar todo en blanco.

## Banner de Ofertas (catálogo y búsqueda)

- [x] Reemplazar el texto del banner promocional (`templates/category.tpl:61` y `templates/search.tpl:56`):
  - **Actual:** "Equipos de primeras marcas con hasta 16% OFF, 6 cuotas fijas sin interés y garantía oficial de fábrica."
  - **Nuevo:** "Equipos de primeras marcas con importantes descuentos, financiación y garantía oficial de fábrica."

## Footer

- [x] Reemplazar el acordeón de categorías del footer por las secciones del navbar (Inicio, Categorías, Marcas, Ofertas, Nosotros, Contacto, Asesoría Técnica).
- [x] Eliminar los medios de pago del footer.

## Contacto

- [x] El título "Contacto y Sucursales" debe tener más espaciado superior respecto del navbar.
- [x] El título "Contacto y Sucursales" no está centrado; debe centrarse.
- [x] En la columna `.contact-branches-col`, ajustar la distribución del contenido para que `.branch-card` y `.contact-trust-callout` ocupen todo el alto disponible. Hoy queda un espacio vacío entre ambas cards.
- [x] La sección "Preguntas Frecuentes": tanto el tag/eyebrow "PREGUNTAS FRECUENTES" como su título de sección no están centrados; deben centrarse.

## Correcciones adicionales (2026-10-05)

- [x] **Newsletter:** el botón de enviar es más alto que el campo de texto a su izquierda; deben tener la misma altura (`snipplets/newsletter.tpl` / `snipplets/home/home-newsletter.tpl`).
- [x] **Buscador del header:** al escribir, la búsqueda carga sugerencias automáticamente sin presionar Enter. La lista está bien, pero hay que quitar las imágenes de los productos (desplegables `#searchDropdown` y `#mobileSearchDropdown` en `snipplets/header/header.tpl`).
- [x] **Home — sección "Nuestras Marcas":** el botón dice "Explorar el directorio de marcas"; quitar "Explorar el" y dejar solo **"Directorio de marcas"** (`snipplets/home/home-brands.tpl:115`).

## Breadcrumbs

- [x] En la página de producto el breadcrumb no tiene el mismo formato que en el resto del sitio. El formato correcto es el de la página "Nosotros". Todas las páginas cuyo breadcrumb dice `Inicio > Producto` presentan el mismo problema y deben unificarse a ese formato.
