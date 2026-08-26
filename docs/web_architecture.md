# Arquitectura del sitio — `web_ftp/`

> Generado a partir de una lectura completa del árbol de `web_ftp/` (agosto 2026). Es una foto del estado actual — si se agregan/renombran archivos, actualizar este documento.

## Resumen de arquitectura

`web_ftp/` es el tema Tiendanube/Nuvemshop que hoy está publicado en la tienda de **HMC HUB**, bajado vía FTP. Es la estructura **legacy** de temas de Tiendanube (pre-Nimbus): no tiene sistema de *sections*/*blocks* con JSON de composición ni `{% schema %}` por archivo. En su lugar:

- **Páginas** = un archivo `.tpl` por tipo de página en `templates/` (uno para home, uno para producto, uno para categoría, etc.), que arman el HTML directamente con lógica Twig-like inline.
- **Partials reutilizables** = `snipplets/` (así, con esa grafía — no es un typo de este documento), organizados por dominio (header, footer, navigation, product, cart, grid, forms, shipping, home, svg…), incluidos con `{% snipplet 'archivo.tpl' %}` o `{% include 'snipplets/archivo.tpl' %}`.
- **Configuración del editor de temas** = archivos de texto plano en `config/` con un DSL propio de indentación (`settings.txt` define los campos, `defaults.txt` sus valores por defecto), en vez de los JSON `settings_schema.json`/`settings_data.json` de Nimbus.
- **Composición del home** = no es drag-and-drop de bloques: `templates/home.tpl` recorre 21 settings numerados (`home_order_position_1` … `_21`), cada uno con el nombre de un módulo fijo de home (`slider`, `main_categories`, `welcome`, `products`, `brands`, `testimonials`, etc.), y `snipplets/home/home-section-switch.tpl` resuelve cada nombre a su snipplet `snipplets/home/home-*.tpl` correspondiente. El orden y la visibilidad de las secciones del home se controlan 100% desde esos settings, no desde una lista editable de bloques.
- **Layout global** = `layouts/layout.tpl`, el único archivo de shell HTML: define `<head>`, carga de CSS crítico/async, incluye header y footer, y el bootstrap de JS al final del `<body>`.
- **Assets estáticos** = `static/`, con las hojas de estilo (`css/`, separadas en crítico/async/colores), JS de terceros y del store (`js/`), e imágenes placeholder (`images/`).
- **Modales y componentes de UI transversales** (buscador, carrito ajax, hamburguesa, quick-shop) se arman con `snipplets/modal.tpl` como base genérica (`{% embed %}` con bloques `modal_head`/`modal_body`/`modal_foot`), no con un sistema de secciones aparte.
- El tema también usa `{{ component('nombre', {...}) }}` en varios puntos — son componentes propios de Tiendanube (no archivos de este repo), resueltos server-side (ej. `logos/logo`, `search/search-form`, `sort-by`, `labels`, `promotions/cross-selling-form`, `claim-info`, `nubesdk-slot`).

No hay build/lint/test local: los `.tpl` se renderizan server-side en Tiendanube; validar cambios implica subir por FTP y revisar la tienda/preview (ver `CLAUDE.md`).

---

## Árbol de archivos

```
web_ftp/
├── config/
│   ├── data.json
│   ├── defaults.txt
│   ├── sections.txt
│   ├── settings.txt
│   ├── translations.txt
│   └── variants.txt
├── layouts/
│   └── layout.tpl
├── snipplets/
│   ├── banner-services/
│   │   ├── banner-services.tpl
│   │   └── banner-services-item.tpl
│   ├── defaults/
│   │   ├── help_banner_services_item.tpl
│   │   ├── help_instagram.tpl
│   │   ├── help_item.tpl
│   │   ├── show_help_category.tpl
│   │   ├── show_help_product.tpl
│   │   └── home/
│   │       ├── banners_help.tpl
│   │       ├── brands_help.tpl
│   │       ├── featured_banners_help.tpl
│   │       ├── featured_products_help.tpl
│   │       ├── image_text_modules_help.tpl
│   │       ├── informative_banners_help.tpl
│   │       ├── instafeed_help.tpl
│   │       ├── institutional_message_help.tpl
│   │       ├── main_categories_help.tpl
│   │       ├── main_category_item_help.tpl
│   │       ├── main_product_help.tpl
│   │       ├── slider_help.tpl
│   │       ├── testimonials_help.tpl
│   │       └── video_help.tpl
│   ├── footer/
│   │   └── footer.tpl
│   ├── forms/
│   │   ├── form.tpl
│   │   ├── form-input.tpl
│   │   └── form-select.tpl
│   ├── grid/
│   │   ├── categories.tpl
│   │   ├── filters.tpl
│   │   ├── filters-modals.tpl
│   │   ├── filters-sidebar.tpl
│   │   ├── item.tpl
│   │   ├── item-colors.tpl
│   │   ├── pagination.tpl
│   │   ├── products-list.tpl
│   │   └── quick-shop.tpl
│   ├── header/
│   │   ├── header.tpl
│   │   ├── header-advertising.tpl
│   │   ├── header-banners.tpl
│   │   ├── header-modals.tpl
│   │   ├── header-search.tpl
│   │   └── header-utilities.tpl
│   ├── home/
│   │   ├── home-banners.tpl
│   │   ├── home-banners-grid.tpl
│   │   ├── home-brands.tpl
│   │   ├── home-categories.tpl
│   │   ├── home-categories-name.tpl
│   │   ├── home-featured-banners.tpl
│   │   ├── home-featured-grid.tpl
│   │   ├── home-featured-products.tpl
│   │   ├── home-instafeed.tpl
│   │   ├── home-institutional-message.tpl
│   │   ├── home-main-product.tpl
│   │   ├── home-newsletter.tpl
│   │   ├── home-popup.tpl
│   │   ├── home-section-switch.tpl
│   │   ├── home-slider.tpl
│   │   ├── home-testimonials.tpl
│   │   ├── home-video.tpl
│   │   └── home-welcome-message.tpl
│   ├── navigation/
│   │   ├── navigation.tpl
│   │   ├── navigation-banners.tpl
│   │   ├── navigation-categories.tpl
│   │   ├── navigation-categories-list.tpl
│   │   ├── navigation-foot.tpl
│   │   ├── navigation-foot-secondary.tpl
│   │   ├── navigation-lang.tpl
│   │   ├── navigation-nav-list.tpl
│   │   ├── navigation-panel.tpl
│   │   └── navigation-secondary.tpl
│   ├── placeholders/
│   │   ├── button-placeholder.tpl
│   │   └── shipping-placeholder.tpl
│   ├── product/
│   │   ├── product-description.tpl
│   │   ├── product-form.tpl
│   │   ├── product-image.tpl
│   │   ├── product-image-thumb.tpl
│   │   ├── product-image-thumbs.tpl
│   │   ├── product-payment-details.tpl
│   │   ├── product-quantity.tpl
│   │   ├── product-related.tpl
│   │   ├── product-variants.tpl
│   │   └── product-video.tpl
│   ├── shipping/
│   │   ├── branches.tpl
│   │   ├── cart-fulfillment.tpl
│   │   ├── shipping-calculator.tpl
│   │   ├── shipping-calculator-item.tpl
│   │   └── shipping-free-rest.tpl
│   ├── shipping_suboptions/
│   │   └── select.tpl
│   ├── social/
│   │   ├── social-links.tpl
│   │   └── social-share.tpl
│   ├── svg/
│   │   ├── (icono).tpl              — ~65 partials, uno por ícono SVG inline
│   │   └── help/
│   │       └── help-*.tpl           — 15 ilustraciones mockup de "onboarding"
│   ├── breadcrumbs.tpl
│   ├── card.tpl
│   ├── cart-item-ajax.tpl
│   ├── cart-panel.tpl
│   ├── cart-related-products.tpl
│   ├── cart-totals.tpl
│   ├── category-banner.tpl
│   ├── contact-links.tpl
│   ├── cross-selling.tpl
│   ├── labels.tpl
│   ├── modal.tpl
│   ├── newsletter.tpl
│   ├── notification.tpl
│   ├── notification-cart.tpl
│   ├── page-header.tpl
│   ├── preload-images.tpl
│   ├── product_grid.tpl
│   ├── shipping_options.tpl
│   ├── video-item.tpl
│   └── whatsapp-chat.tpl
├── static/
│   ├── css/
│   │   ├── style-async.scss
│   │   ├── style-colors.scss
│   │   ├── style-critical.scss
│   │   └── style-tokens.tpl
│   ├── images/
│   │   └── empty-placeholder.png
│   ├── js/
│   │   ├── external.js.tpl
│   │   ├── external-no-dependencies.js.tpl
│   │   ├── google-survey.js.tpl
│   │   ├── instatheme-4705b9ac39b70890a34e138d0638c18530.js
│   │   └── store.js.tpl
│   └── checkout.scss.tpl
└── templates/
    ├── account/
    │   ├── address.tpl
    │   ├── addresses.tpl
    │   ├── info.tpl
    │   ├── login.tpl
    │   ├── newpass.tpl
    │   ├── order.tpl
    │   ├── orders.tpl
    │   ├── register.tpl
    │   └── reset.tpl
    ├── 404.tpl
    ├── blog.tpl
    ├── blog-post.tpl
    ├── cart.tpl
    ├── category.tpl
    ├── contact.tpl
    ├── home.tpl
    ├── page.tpl
    ├── password.tpl
    ├── product.tpl
    └── search.tpl
```

---

## Descripción de archivos

### `config/`

| Archivo | Descripción |
|---|---|
| `data.json` | Config de preview: qué assets compilados usar al previsualizar el tema (hoy solo `css/style-tokens.tpl`). |
| `defaults.txt` | Valores por defecto de todos los settings del tema (colores, banners, tipografía, etc.) — mismo DSL de indentación que `settings.txt` pero solo clave/valor. |
| `sections.txt` | Define las colecciones de producto predefinidas que puede mostrar el home (`primary`/Destacados, `new`/Novedades, `sale`/Ofertas, `promotion`/Promociones, `best_seller`/Más vendidos, `featured`/Principal), con nombre y descripción para el admin. |
| `settings.txt` | Definición de **todos** los campos del editor de temas: agrupados en "Colores de tu marca", "Tipo de letra", "Encabezado", "Página de inicio", "Listado de productos", "Detalle de producto", "Carrito de compras", "Pie de página" y "Edición avanzada de CSS". Es el equivalente legacy a `settings_schema.json` de Nimbus. |
| `translations.txt` | Strings de UI del tema en español (labels, mensajes, textos de ayuda), agrupados por sección (General, Navigation, Home, Catalog, Product, etc.). |
| `variants.txt` | Presets de esquema de color completos (ej. "Sports") que el admin puede aplicar de una — cada uno redefine todos los colores de header/nav/adbar/etc. de una vez. |

### `layouts/`

| Archivo | Descripción |
|---|---|
| `layout.tpl` | Shell HTML único de todas las páginas: `<head>` (meta tags, preload de fuentes/CSS, structured data), incluye `header/header.tpl` y `footer/footer.tpl`, imprime `{% template_content %}` en el medio, y al final del `<body>` carga JS externo, `store.js.tpl` y scripts condicionales (reCAPTCHA, Google Survey, tracking code del admin). |

### `snipplets/` — raíz

| Archivo | Descripción |
|---|---|
| `breadcrumbs.tpl` | Migas de pan; arma el trail según `template` (page, cart, search, blog, orden, categoría, etc.). |
| `card.tpl` | Wrapper visual genérico "card" con bloques `card_head`/`card_body`/`card_footer` y soporte de colapso. |
| `cart-item-ajax.tpl` | Renderiza un ítem de línea dentro del panel de carrito ajax (imagen, nombre, variante, precio, cantidad). |
| `cart-panel.tpl` | Contenido del modal de carrito ajax: lista de ítems (`cart-item-ajax.tpl`) + estado vacío. |
| `cart-related-products.tpl` | Clases/config para el slider de productos relacionados dentro del carrito. |
| `cart-totals.tpl` | Barra de progreso hacia envío gratis en el carrito/producto (usa el componente `free-shipping-bar`). |
| `category-banner.tpl` | Banner de cabecera de categoría: imagen (de la categoría o genérica) + nombre + descripción, vía `page-header.tpl` embebido. |
| `contact-links.tpl` | Lista de contacto (WhatsApp, teléfono, email, dirección, blog) reusada en footer y página de contacto. |
| `cross-selling.tpl` | Formulario de venta cruzada (`promotions/cross-selling-form`) que aparece al agregar un producto con promoción asociada. |
| `labels.tpl` | Configura y renderiza las etiquetas de producto (oferta, promoción, envío gratis, sin stock) vía el componente `labels`. |
| `modal.tpl` | Base genérica de modal (posición, transición, ancho, footer fijo, form embebido) usada por *todos* los modales del tema vía `{% embed %}`. |
| `newsletter.tpl` | Formulario de suscripción al newsletter, usado en el footer. |
| `notification.tpl` | Contenedor de notificaciones globales: banner de cookies, notificación de estado de pedido, y switch a `notification-cart.tpl` al agregar al carrito. |
| `notification-cart.tpl` | Notificación flotante "¡Agregado al carrito!" con datos del ítem y, opcionalmente, resumen de recomendados. |
| `page-header.tpl` | Título de página + breadcrumbs, reusado como `{% embed %}` en casi todos los templates de `templates/`. |
| `preload-images.tpl` | `<link rel="preload">` de la imagen LCP según el template (primer slide del home, primera imagen de producto, banner de categoría) — optimización de performance. |
| `product_grid.tpl` | Loop que imprime `grid/item.tpl` por cada producto de una lista, marcando prioridad de carga en las 2 primeras imágenes. |
| `shipping_options.tpl` | Lista de opciones de envío a domicilio y retiro en sucursal dentro de la calculadora de envío, separando destacadas de "ver más". |
| `video-item.tpl` | Reproductor de video de producto (nativo o embed de YouTube), con miniatura y modal opcional. |
| `whatsapp-chat.tpl` | Botón flotante o de header de contacto directo por WhatsApp. |

### `snipplets/banner-services/`

| Archivo | Descripción |
|---|---|
| `banner-services.tpl` | Macro que arma hasta 4 "banners de servicio" (envío, pago, seguridad, etc.) leyendo settings `banner_services_0N_*`. |
| `banner-services-item.tpl` | Card individual de un banner de servicio (ícono + título + descripción). |

### `snipplets/defaults/` y `snipplets/defaults/home/`

Placeholders de "onboarding" del editor: se muestran cuando una sección todavía no tiene contenido cargado (tienda sin productos, sin banners, etc.), para guiar al comerciante en el admin.

| Archivo | Descripción |
|---|---|
| `help_banner_services_item.tpl` | Placeholder de un ítem de banner de servicios. |
| `help_instagram.tpl` | Placeholder del feed de Instagram del home. |
| `help_item.tpl` | Card de ayuda genérica (usada en categoría/producto vacíos). |
| `show_help_category.tpl` | Página de categoría completa de ejemplo cuando no hay productos. |
| `show_help_product.tpl` | Página de producto completa de ejemplo (usada también en el 404 sin productos). |
| `home/banners_help.tpl` | Placeholder de banners de categoría/promocionales/novedades del home. |
| `home/brands_help.tpl` | Placeholder de la sección de marcas del home. |
| `home/featured_banners_help.tpl` | Placeholder de los 4 banners destacados del home. |
| `home/featured_products_help.tpl` | Placeholder de cualquier grilla de productos del home (destacados/novedades/ofertas/etc., parametrizado por título). |
| `home/image_text_modules_help.tpl` | Placeholder del módulo imagen+texto del home. |
| `home/informative_banners_help.tpl` | Placeholder de los banners informativos (icon+texto) del home. |
| `home/instafeed_help.tpl` | Placeholder del feed de Instagram embebido en home. |
| `home/institutional_message_help.tpl` | Placeholder compartido por el mensaje de bienvenida e institucional. |
| `home/main_categories_help.tpl` | Placeholder del carrusel de categorías principales. |
| `home/main_category_item_help.tpl` | Placeholder de un ítem individual de categoría principal. |
| `home/main_product_help.tpl` | Placeholder del producto principal destacado del home. |
| `home/slider_help.tpl` | Placeholder del slider/hero del home. |
| `home/testimonials_help.tpl` | Placeholder de la sección de testimonios. |
| `home/video_help.tpl` | Placeholder de la sección de video embebido. |

### `snipplets/footer/`

| Archivo | Descripción |
|---|---|
| `footer.tpl` | Footer completo: redes sociales, menús (principal/secundario/contacto), newsletter, logos de pago/envío, selector de idioma, sellos (AFIP/EBIT/sello propio) y barra legal con el link obligatorio a Tiendanube. |

### `snipplets/forms/`

| Archivo | Descripción |
|---|---|
| `form.tpl` | Wrapper genérico de `<form>` con bloque `form_body`. |
| `form-input.tpl` | Input genérico con soporte de label, prepend/append, distintos tipos (número, email, etc.). |
| `form-select.tpl` | `<select>` genérico con label y opciones vía bloque `select_options`. |

### `snipplets/grid/`

| Archivo | Descripción |
|---|---|
| `categories.tpl` | Sidebar de subcategorías dentro de una categoría (con acordeón "ver más"). |
| `filters.tpl` | Filtros de catálogo (precio, atributos) y chips de filtros aplicados. |
| `filters-modals.tpl` | Modales mobile de "Ordenar por" y "Filtrar" en categoría/búsqueda. |
| `filters-sidebar.tpl` | Columna lateral desktop que agrupa `categories.tpl` + `filters.tpl`. |
| `item.tpl` | Card de producto individual en cualquier grilla (imagen, nombre, precio, variantes, quick-shop) — el componente más reusado del tema. |
| `item-colors.tpl` | Bullets de color/variante debajo del nombre del producto en `item.tpl`. |
| `pagination.tpl` | Paginación clásica o "cargar más"/infinite scroll de listados. |
| `products-list.tpl` | Contenedor de la grilla de productos: incluye `product_grid.tpl` + paginación, o el mensaje de "sin resultados". |
| `quick-shop.tpl` | Modal de compra rápida disparado desde `item.tpl`. |

### `snipplets/header/`

| Archivo | Descripción |
|---|---|
| `header.tpl` | Header completo: overlay, ad bar, logo (posición configurable), buscador, íconos de utilidad (cuenta/idioma/WhatsApp/carrito), menú desktop y notificaciones; orquesta al resto de `header/*` y `navigation/*`. |
| `header-advertising.tpl` | Barra superior de anuncios/promos (adbar), con hasta 3 mensajes en swiper y/o imagen de fondo. |
| `header-banners.tpl` | Hasta 2 banners informativos junto al menú (envío, medios de pago, etc., con ícono o imagen). |
| `header-modals.tpl` | Registra los modales de búsqueda, menú hamburguesa, carrito ajax y recomendados post-compra (todos vía `modal.tpl`). |
| `header-search.tpl` | Formulario de búsqueda (componente `search/search-form`), reusado en header desktop, mobile y modal. |
| `header-utilities.tpl` | Switch de íconos de utilidad del header: menú, WhatsApp, cuenta, idiomas, buscador, carrito — según los parámetros con los que se incluye. |

### `snipplets/home/`

| Archivo | Descripción |
|---|---|
| `home-banners.tpl` | Render de banners de categoría/promocionales/novedades/módulos imagen+texto (parametrizado por flag). |
| `home-banners-grid.tpl` | Variante en grilla de banners (usa `has_mobile_banners*` para versión mobile). |
| `home-brands.tpl` | Sección de logos de marcas destacadas (slider o grilla). |
| `home-categories.tpl` | Carrusel de categorías principales del home. |
| `home-categories-name.tpl` | Resuelve recursivamente el nombre de una categoría/subcategoría por `handle` para `home-categories.tpl`. |
| `home-featured-banners.tpl` | Los 4 banners destacados configurables del home (`banner_01`…`_04`). |
| `home-featured-grid.tpl` | Encabezado/config del slider de productos destacados (archivo casi vacío, solo comentario de propiedades). |
| `home-featured-products.tpl` | Grillas de productos por colección (destacados/novedades/ofertas/promociones/más vendidos), según flags `has_*`. |
| `home-instafeed.tpl` | Feed de Instagram embebido (requiere token conectado en el admin). |
| `home-institutional-message.tpl` | Bloque de texto institucional configurable (título + texto + botón opcional). |
| `home-main-product.tpl` | Sección de "producto principal" destacado (aleatorio o fijo, según setting). |
| `home-newsletter.tpl` | Sección de suscripción al newsletter dentro del home (wrapper visual de `newsletter.tpl`). |
| `home-popup.tpl` | Modal promocional que se dispara al entrar al home (imagen/título/texto/CTA configurables). |
| `home-section-switch.tpl` | El "router" del home: recibe `section_select` y hace `{% include %}` del snipplet correspondiente (o su placeholder de ayuda si no hay contenido). Es la pieza clave de la composición del home. |
| `home-slider.tpl` | Slider/hero principal (desktop y, si está activado, una versión mobile separada). |
| `home-testimonials.tpl` | Slider de hasta 3 testimonios de clientes. |
| `home-video.tpl` | Sección de video embebido (YouTube o nativo) con overlay de texto opcional. |
| `home-welcome-message.tpl` | Bloque de bienvenida (misma estructura que `home-institutional-message.tpl`). |

### `snipplets/navigation/`

| Archivo | Descripción |
|---|---|
| `navigation.tpl` | Contenedor del menú principal desktop (flechas de scroll + lista). |
| `navigation-banners.tpl` | Banner de imagen dentro de un dropdown de menú (desktop/mobile). |
| `navigation-categories.tpl` | Ítem "Categorías" del menú desktop con su dropdown. |
| `navigation-categories-list.tpl` | Lista recursiva de categorías/subcategorías para el dropdown de categorías. |
| `navigation-foot.tpl` | Ítems del menú de footer principal (`settings.footer_menu`). |
| `navigation-foot-secondary.tpl` | Ítems del menú de footer secundario. |
| `navigation-lang.tpl` | Selector de idioma/moneda, como lista (footer) o `<select>` (header). |
| `navigation-nav-list.tpl` | Lista recursiva genérica de ítems de menú, reusada por desktop, mobile/hamburguesa y submenús. |
| `navigation-panel.tpl` | Contenido del panel/modal de menú mobile (hamburguesa): links primarios o accesos a cuenta. |
| `navigation-secondary.tpl` | Barra de menú secundario debajo del header (`settings.head_secondary_menu`). |

### `snipplets/placeholders/`

| Archivo | Descripción |
|---|---|
| `button-placeholder.tpl` | Botón "Agregar al carrito"/"Comprar" en estado de carga (skeleton), reemplazado por JS al hidratar. |
| `shipping-placeholder.tpl` | Líneas de skeleton para el cálculo de envío mientras carga. |

### `snipplets/product/`

| Archivo | Descripción |
|---|---|
| `product-description.tpl` | Descripción del producto (+ caja de comentarios de Facebook si está activada). |
| `product-form.tpl` | Nombre, breadcrumbs y arranque del formulario de compra del producto. |
| `product-image.tpl` | Galería principal de imágenes/video del producto con thumbnails. |
| `product-image-thumb.tpl` | Thumbnail individual de imagen — **marcado como deprecated/sin uso** en el propio archivo. |
| `product-image-thumbs.tpl` | Thumbnail individual de imagen o video (la versión vigente, sucesora de `product-image-thumb.tpl`). |
| `product-payment-details.tpl` | Modal con detalle de cuotas/medios de pago del producto. |
| `product-quantity.tpl` | Selector de cantidad en el formulario de compra. |
| `product-related.tpl` | Resuelve la lista de productos relacionados (por metafield de app o por tag). |
| `product-variants.tpl` | Selectores de variantes (talle, color, etc.), con soporte de bullets de color. |
| `product-video.tpl` | Reproductor de video de producto reusado dentro de la galería (ver también `snipplets/video-item.tpl`, versión standalone). |

### `snipplets/shipping/`

| Archivo | Descripción |
|---|---|
| `branches.tpl` | Acordeón de sucursales de retiro (store pickup). |
| `cart-fulfillment.tpl` | Bloque de método de envío guardado en el carrito, con aviso si dejó de estar disponible. |
| `shipping-calculator.tpl` | Calculadora de código postal (con o sin CP ya guardado). |
| `shipping-calculator-item.tpl` | Opción individual de envío/retiro dentro de la calculadora, con selección automática de la primera opción. |
| `shipping-free-rest.tpl` | Mensaje de "te falta $X para envío gratis" en producto o carrito. |

### `snipplets/shipping_suboptions/`

| Archivo | Descripción |
|---|---|
| `select.tpl` | Sub-opciones de una opción de envío/retiro (ej. elegir sucursal específica dentro de "Retirar por..."). |

### `snipplets/social/`

| Archivo | Descripción |
|---|---|
| `social-links.tpl` | Íconos de redes sociales de la tienda (Instagram, Facebook, YouTube, TikTok, Twitter, Pinterest), usado en el footer. |
| `social-share.tpl` | Botones de compartir producto (WhatsApp, Facebook, Twitter) en la página de producto. |

### `snipplets/svg/`

~65 archivos, uno por ícono, cada uno un `<svg>` inline parametrizable por `svg_custom_class` (ej. `arrow-right.tpl`, `bag.tpl`, `cart.tpl`, `chevron-down.tpl`, `search.tpl`, `truck.tpl`, `whatsapp.tpl`, `facebook-f.tpl`, `user.tpl`, `check-circle.tpl`, `trash-alt.tpl`, etc.). El nombre de archivo es descriptivo del ícono que contiene; no se detalla cada uno individualmente en esta tabla porque no aportan lógica más allá del propio marcado SVG.

### `snipplets/svg/help/`

15 archivos (`help-instagram-1/2.tpl`, `help-logo.tpl`, `help-main-category-1/2/3.tpl`, `help-product-1..8.tpl` + variantes `-green`/`-red`, `help-slider.tpl`, `help-video.tpl`) — ilustraciones de relleno usadas exclusivamente por los placeholders de `snipplets/defaults/` cuando la tienda todavía no tiene contenido cargado.

### `static/css/`

| Archivo | Descripción |
|---|---|
| `style-critical.scss` | Estilos críticos, inyectados inline en `<head>` antes del resto del sitio (above-the-fold). |
| `style-async.scss` | Resto de los estilos del tema, cargados de forma asíncrona (no bloquean el render inicial). |
| `style-colors.scss` | Estilos derivados directamente de los settings de `config/settings.txt` (colores, tipografía). |
| `style-tokens.tpl` | Genera los custom properties CSS (`:root { --... }`) a partir de los valores de settings — el puente entre `config/settings.txt`/`defaults.txt` y el CSS. |

### `static/js/`

| Archivo | Descripción |
|---|---|
| `external.js.tpl` | Librerías de terceros que requieren jQuery ya cargado. |
| `external-no-dependencies.js.tpl` | Librerías de terceros sin dependencias (se cargan antes que jQuery). |
| `google-survey.js.tpl` | Badge/script de Google Customer Reviews (solo si la tienda tiene `google_merchant_id`). |
| `instatheme-4705b9ac39b70890a34e138d0638c18530.js` | Librería de terceros de nombre hasheado (integración externa; nombre auto-generado, no es del equipo). |
| `store.js.tpl` | JS propio del tema: variantes de producto, carrito, envío, lazy load, notificaciones, etc. (archivo grande, es el "core" JS del sitio). |

### `static/`

| Archivo | Descripción |
|---|---|
| `checkout.scss.tpl` | Estilos aplicados al checkout (solo si `store.allows_checkout_styling`), basados en los mismos settings de marca. |
| `images/empty-placeholder.png` | Placeholder 1×1 usado como `src` inicial de imágenes con lazy-load (`data-src`/`data-srcset`). |

### `templates/`

| Archivo | Descripción |
|---|---|
| `404.tpl` | Página de error 404 (o producto de ejemplo si la tienda todavía no tiene productos cargados). |
| `blog.tpl` | Listado de posts del blog. |
| `blog-post.tpl` | Detalle de un post del blog. |
| `cart.tpl` | Página de carrito de compras (no-ajax / página completa). |
| `category.tpl` | Listado de productos de una categoría, con banner, filtros y paginación. |
| `contact.tpl` | Formulario de contacto (también usado para pedidos de cancelación de orden). |
| `home.tpl` | Página de inicio: arma el orden de secciones vía `home_order_position_1..21` + popup promocional. |
| `page.tpl` | Página institucional genérica (creada desde el admin, contenido en `page.content`). |
| `password.tpl` | Pantalla de tienda protegida por contraseña. |
| `product.tpl` | Página de detalle de producto: imagen (`product-image.tpl`) + formulario (`product-form.tpl`). |
| `search.tpl` | Resultados de búsqueda (misma estructura de grilla/paginación que categoría). |

### `templates/account/`

| Archivo | Descripción |
|---|---|
| `address.tpl` | Alta/edición de una dirección del cliente. |
| `addresses.tpl` | Listado de direcciones guardadas del cliente. |
| `info.tpl` | Edición de datos personales de la cuenta. |
| `login.tpl` | Formulario de inicio de sesión. |
| `newpass.tpl` | Solicitud de cambio de contraseña (o activación de cuenta). |
| `order.tpl` | Detalle de una orden del cliente (con flujo de cancelación). |
| `orders.tpl` | Listado de órdenes del cliente. |
| `register.tpl` | Formulario de registro de cuenta. |
| `reset.tpl` | Confirmación de envío de email para restablecer contraseña. |
