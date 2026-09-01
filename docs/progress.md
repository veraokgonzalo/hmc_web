# Progress & Architectural Log

Tracker de avance del trabajo de desarrollo sobre `web_ftp/` y prototipo interactivo modular `boceto_web/`.

---

## 🚀 Prototipo Interactivo Modular (`boceto_web/`) - COMPLETADO

Se rediseñó y modularizó el boceto web en páginas independientes interconectadas, siguiendo estrictamente la identidad de marca (`docs/design.md`), requerimientos funcionales (`docs/specs.md`) y mapeo directo 1-a-1 con las plantillas Tiendanube Legacy (`web_ftp/`):

### 1. Estructura de Páginas Creadas y Mapeo a Tiendanube
1. **Home Page (`index.html`)** $\leftrightarrow$ `templates/home.tpl` & `snipplets/home/*.tpl`:
   - Hero Slider interactivo con 3 propuestas de valor.
   - 4 Pilares de valor ("Asesoramiento Técnico", "Envíos a Todo el País", "Medios de Pago", "Garantía y Postventa").
   - Categorías Principales con fotos de alta resolución (`DSC00883.jpg` a `DSC00918.jpg`).
   - Ofertas Especiales con countdown timer sincronizado en vivo.
   - Módulos B2B, Video Showcase en loop con control play/pause, Catálogo con tabs interactivas, Marcas oficiales y Testimonios.

2. **Catálogo & Búsqueda (`catalog.html`)** $\leftrightarrow$ `templates/category.tpl`, `templates/search.tpl` & `snipplets/grid/*.tpl`:
   - Filtros avanzados en sidebar (Categorías, Marcas Oficiales, Slider de Precios min/max, Envío Gratis, En Stock, Solo Ofertas).
   - Chips activos de filtros con eliminación individual y botón "Limpiar todo".
   - Toolbar con contador dinámico de resultados, selector de ordenamiento (precio, descuento, alfabético) y selector de vista (Grilla / Lista).
   - Manejo de query parameters en URL (`?category=`, `?brand=`, `?q=`, `?offers=true`).

3. **Ficha de Producto (`product.html`)** $\leftrightarrow$ `templates/product.tpl` & `snipplets/product/*.tpl`:
   - Carga dinámica según ID (`?id=X`) contra el catálogo maestro.
   - Galería de imágenes en alta resolución con selector de miniaturas activo.
   - Panel de precios, cálculo de 6 cuotas fijas sin interés y stock con indicador en vivo.
   - Calculadora de costo y tiempo de envío por código postal con retiro gratuito en sucursales Zárate y Munro.
   - Selector de cantidad, botón "Agregar al Carrito" y botón "Comprar Ahora".
   - CTA directo a WhatsApp pre-cargado con el nombre y SKU del equipo para asesoría técnica.
   - Pestañas técnicas: Especificaciones (tabla estructurada), Descripción y Aplicaciones, Garantía y Servicio Técnico Oficial, Opiniones verificadas (5.0 ★).
   - Grilla de productos relacionados y accesorios compatibles.

4. **Carrito de Compras Completo (`cart.html`)** $\leftrightarrow$ `templates/cart.tpl` & `snipplets/cart-panel.tpl`:
   - Tabla editable de productos con controles reactivos de cantidad (+ / -), precio unitario, subtotal y eliminación.
   - Barra de progreso hacia la meta de Envío Gratis ($300.000 ARS).
   - Validador interactivo de cupones de descuento (`BIENVENIDO-HMC` 10% OFF, `HMCPRO` 15% OFF).
   - Resumen de compra sticky con subtotal, descuento aplicado y total final.
   - Cross-selling de productos frecuentemente comprados juntos.
   - Estado vacío cuando no hay ítems con botón hacia el catálogo.

5. **Contacto & Soporte Técnico (`contact.html`)** $\leftrightarrow$ `templates/contact.tpl`:
   - Cards directas de contacto rápido (WhatsApp Asesoría, Ventas Corporativas / Factura A, Taller y Puesta en Marcha).
   - Formulario de contacto y solicitud de presupuesto B2B con validación.
   - Fichas de sucursales físicas (Sucursal Central Zárate y Centro de Distribución Munro) con horarios y direcciones.
   - Acordeón interactivo de Preguntas Frecuentes (FAQ) sobre envíos, factura A, puesta en marcha y repuestos.

### 2. Motor CSS y JavaScript Compartido
- **`boceto_web/css/styles.css`**: Sistema de diseño unificado, tokens de color de marca (`#3FAA47`, `#000000`, `#494848`, `#CCCCCC`), tipografías `Chakra Petch` + `Inter`, layout responsive para desktop, tablet y mobile.
- **`boceto_web/js/app.js`**:
  - Catálogo maestro de 12 productos reales de alta fidelidad con fotos de `assets/FOTOS/`.
  - Persistencia de carrito en `localStorage['hmc_cart']` sincronizada en tiempo real entre el Drawer lateral y la página completa de Carrito.
  - Live Search con sugerencias visuales y redirección a `catalog.html?q=...`.
  - Quick View Modal reutilizable en cualquier grilla de productos.
  - Notificaciones tipo Toast.

### 3. Experiencia Móvil de Primera Clase (Mobile UI/UX) - IMPLEMENTADO & PULIDO
- **Barra de Navegación Inferior Estilo App (`.mobile-bottom-nav`)**: Fija en la parte inferior de la pantalla en móviles (< 768px) con accesos a *Inicio*, *Catálogo*, *Asesoría WhatsApp*, *Carrito con contador reactivo* y *Menú*.
- **Menú Off-Canvas Desplegable (`#mobileDrawerMenu`)**: Menú lateral deslizable con buscador integrado, acordeón de categorías, accesos rápidos a ofertas, marcas oficiales, contacto y tarjeta de WhatsApp.
- **Filtros en Hoja Deslizable en Catálogo**: Botón flotante *"Filtrar y Ordenar"* que abre los filtros en formato modal/drawer optimizado para pantallas táctiles.
- **Sticky Buy Bar en Ficha de Producto (`.mobile-sticky-buy-bar`)**: Barra flotante inferior que aparece al hacer scroll en producto mostrando miniatura, precio y botón de compra inmediata.
- **Grillas de Producto Táctiles en 2 Columnas**: Tarjetas compactas con tipografía adaptada, etiquetas de descuento legibles y botones táctiles optimizados (mínimo 44px).
- **Transformación de Tabla de Carrito a Tarjetas Móviles**: El carrito convierte la tabla tradicional en tarjetas individuales con controles de cantidad y eliminación sin scroll horizontal.
- **Soporte de Gestos Táctiles (Touch Swipe)**: Deslizamiento horizontal táctil en el Hero Slider principal.
### 4. Nomenclatura Semántica de Imágenes & Assets - IMPLEMENTADO
- Se reemplazaron todos los nombres genéricos de cámara (`DSC00...`) por nombres semánticos estructurados que identifican inmediatamente el producto, la categoría y la sección de la web.
- Se creó el mapa completo de referencia en [`docs/assets-map.md`](file:///mnt/0076ECF676ECED7A/1_FABRICCKK/1_Trabajo/WEB/HMC_WEB/hmc_web/docs/assets-map.md).
- Se actualizaron todos los archivos HTML y el catálogo maestro en `boceto_web/js/app.js`.




### 5. Actualización de Catálogo Real, Imágenes WebP y Taxonomía de Categorías - IMPLEMENTADO
- **Nuevos Productos y Taxonomía Jerárquica**: Se integraron los 12 productos reales provistos en `categories.txt` (Bombas Niwa, Discos y Lijas Bosch Expert, Demoledores Bosch y DeWalt, Taladros Einhell PXC y Bosch Professional, Sierras circulares e ingletadoras, Mechas SDS Plus, Motoguadañas Shindaiwa y Sensei).
- **Normalización Semántica WebP**: Se renombraron y organizaron todas las imágenes de productos a formato estándar en minúsculas y kebab-case (`prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp`, galerías adicionales y specs).
- **Portadas y Categorías de Portada Actualizadas**: Se crearon y mapearon las 6 portadas de categorías en `boceto_web/assets/images/categories/` (`categoria-1-ferreteria.webp`, `categoria-2-maquinas-explosion.webp`, `categoria-3-agua-bombeo.webp`, `categoria-4-construccion.webp`, `categoria-5-herramientas-bateria.webp`, `categoria-6-accesorios-insumos.webp`).
- **Sincronización Total de Plantillas HTML & JS**: Se actualizaron `boceto_web/js/app.js`, `boceto_web/index.html`, `boceto_web/catalog.html`, `boceto_web/product.html`, `boceto_web/cart.html` y `boceto_web/contact.html` para sincronizar mega-dropdowns, filtros de barra lateral, badges, contadores y catálogo maestro.
- **Documentación Centralizada**: Se actualizaron [`docs/assets-map.md`](assets-map.md) y [`categories.txt`](../boceto_web/assets/images/products/categories.txt).
### 6. Nueva Página Institucional "Nosotros", Limpieza de Contacto y Reorganización de Navegación - IMPLEMENTADO
- **Página de Contacto Optimizada (`contact.html`)**: Se removieron la sección redundante de manifiesto y las 3 tarjetas de contacto rápido previas, dejando el formulario de cotización/contacto directo, las fichas de sucursales físicas (Zárate y Munro) y el acordeón de Preguntas Frecuentes (FAQ).
- **Nueva Página Dedicada "Nosotros" (`about.html`)**: Se creó la página institucional completa con la historia, manifiesto de marca ("HMC no compite por precio, compite por respaldo técnico"), 4 pilares diferenciales, métricas de trayectoria (+15 años, +25.000 clientes), marcas oficiales y centros de distribución.
- **Limpieza de Menú de Navegación**: Se eliminó la opción "Equipos en Acción" y se renombró el acceso a "Nosotros" con enlace directo a `about.html` en todas las plantillas.
- **Reubicación de "Asesoría Técnica"**: Se integró el botón destacado de Asesoría Técnica por WhatsApp en la barra de navegación principal (reemplazando el botón anterior de servicio técnico) y se despejó la barra de utilidades superior.

### 7. Sincronización Reactiva de Navegación & Banner de Ofertas (Opción 1C) - IMPLEMENTADO
- **Motor Centralizado de Estado Activo (`syncNavigationActiveState()`)**: Se añadió un despachador global en `boceto_web/js/app.js` que evalúa la URL y parámetros de consulta (`?offers=true`, `?brand=...`, `?category=...`), asignando la clase `.active` de forma precisa al botón correspondiente (*Ofertas*, *Marcas*, *Categorías*, *Nosotros*, *Contacto* o *Inicio*) en desktop y mobile.
- **Banner Promocional Dinámico en Catálogo (`#catalogOffersPromoBanner`)**: Se integró un banner premium de liquidación en `catalog.html` con diseño oscuro, acento en rojo, tag de *"Oportunidades por Tiempo Limitado"* y pill de *"Precios Promocionales"*, el cual se despliega y oculta de forma reactiva al filtrar por ofertas.
- **Actualización Dinámica de Breadcrumbs & SEO Titles**: Al acceder a ofertas, el título cambia a *"Ofertas Especiales & Oportunidades | HMC HUB"* y la miga de pan se actualiza a *"Inicio > Ofertas Especiales"*.

### 8. Mega Dropdown Híbrido de Marcas para 103 Fabricantes (Opción 2C) - IMPLEMENTADO
- **Arquitectura de 2 Zonas (`.mega-dropdown-brands`)**:
  - **Zona 1 (Marcas Oficiales Destacadas)**: 8 tarjetas interactivas de fabricantes oficiales líderes (*BOSCH, DEWALT, NIWA, EINHELL, SHINDAIWA, SENSEI, STIHL, HONDA*) con descripción de línea y sello de garantía.
  - **Zona 2 (Directorio Completo de 103 Marcas)**: Buscador instantáneo en tiempo real + barra de navegación alfabética rápida (A-Z) + grilla en 4 columnas con scroll suave personalizado.
- **Motor Interactivo en JavaScript (`initMegaBrandsDropdown()`)**:
  - Base de datos completa de 103 marcas del sector industrial y de maquinaria.
  - Filtrado en vivo por texto o por letra inicial sin recargar página.
  - Contador dinámico de marcas disponibles y badges de *"Oficial"*.
- **Integración Responsive & Mobile Drawer**: Acordeón táctil integrado en el menú móvil para explorar las marcas con un toque.
- **Sincronización Total**: Desplegado en las 6 plantillas HTML (`index.html`, `catalog.html`, `product.html`, `cart.html`, `contact.html`, `about.html`).

### 8. Mega Dropdown Alfabético Completo A-Z con Buscador Integrado (Opción 2A) - IMPLEMENTADO
- **Directorio Alfabético Completo para 103 Marcas (`.mega-dropdown-brands-2a`)**:
  - **Cabecera Unificada**: Título del directorio oficial, buscador interactivo centrado en tiempo real y contador de marcas disponibles.
  - **Barra de Navegación Rápida A-Z**: Selector alfabético horizontal completo (`TODAS`, `A` a `Z`) para filtrar o saltar entre letras al instante.
  - **Grilla Amplia en 6 Columnas**: Distribución alfabética integral con scroll suave personalizado, mostrando las 103 marcas con sus respectivos badges de distribución oficial.
  - **Pie de Confianza**: Sello de garantía de fábrica, provisión de repuestos legítimos y enlace al catálogo general.
- **Sincronización Total**: Actualizado en `app.js`, `styles.css` y las 6 plantillas HTML (`index.html`, `catalog.html`, `product.html`, `cart.html`, `contact.html`, `about.html`).

### 9. Arquitectura Modular de Navegación (Única Fuente de Verdad) - IMPLEMENTADO
- **Componente Global Centralizado (`renderGlobalNavigation()`)**: Se unificó toda la estructura de navegación (Top Announcement Bar, Cabecera principal con buscador en tiempo real, Mega-menús de Categorías y Marcas de 103 fabricantes, Menú móvil Drawer y Bottom App Bar) dentro de `boceto_web/js/app.js`.
- **Eliminación de Código Duplicado**: Se reemplazaron más de 1.200 líneas de HTML repetido en [`index.html`](../boceto_web/index.html), [`catalog.html`](../boceto_web/catalog.html), [`product.html`](../boceto_web/product.html), [`cart.html`](../boceto_web/cart.html), [`contact.html`](../boceto_web/contact.html) y [`about.html`](../boceto_web/about.html) por contenedores modulares `<div id="globalNavigation"></div>` y `<div id="globalMobileNavigation"></div>`.
- **Mantenimiento Simplificado**: Cualquier cambio futuro en el menú, enlaces o categorías se realiza en un solo lugar y se propaga automáticamente a todas las vistas.

### 10. Regla Permanente de Responsividad Mobile-First en el Memory Bank - ACTUALIZADO
- **Documentación de Memoria Actualizada**: Se incorporó formalmente en [`CLAUDE.md`](../CLAUDE.md) y [`docs/design.md`](design.md) la regla mandatoria para que **cualquier nuevo componente, refactorización o cambio visual incluya estrictamente su implementación y validación móvil (< 768px y < 480px)** en simultáneo.
- **Pautas Clave**: Áreas táctiles $\ge 44\text{px}$, acordeones móviles para mega-menús, soporte para la barra inferior fija de la app (`.mobile-bottom-nav`), ausencia total de desborde horizontal y transformación de tablas/filtros a hojas deslizables táctiles.

### 11. Nueva Página Dedicada de Marcas & Dropdown Simplificado en Navbar - ACTUALIZADO
- **Página de Directorio de Marcas (`brands.html`)**:
  - **Estructura Depurada y Focalizada**: Se eliminaron secciones accesorias (hero redundante, grilla previa de destacadas y banner B2B) para centrar la página directamente en la herramienta de filtrado y exploración.
  - **Directorio Alfabético Completo Interactivo (103 Marcas)**: Buscador reactivo en tiempo real con botón de borrado rápido + barra horizontal de salto alfabético (A-Z, `# / 0-9`, `TODAS`) + grilla organizada en tarjetas por letra inicial + contador dinámico de marcas disponibles + badges de distribución oficial + estado vacío con botón de reinicio.
- **Navbar Dropdown Simplificado & Enfocado (`.mega-dropdown-brands-featured`)**:
  - Se removió el directorio masivo del dropdown para brindar una experiencia ágil y elegante.
  - Muestra las 8 marcas oficiales destacadas en una cuadrícula compacta y limpia.
  - Incorpora pie destacado con el botón CTA **"Explorar todas nuestras marcas →"** que redirige a `brands.html`.
- **Integración Mobile Drawer & Sincronización Global**:
  - Acordeón móvil táctil actualizado con acceso a las marcas destacadas y enlace resaltado para explorar las 103 marcas en `brands.html`.
  - Motor de estado activo `syncNavigationActiveState()` sincronizado para marcar la navegación activa en `brands.html`.
  - Enlaces de pie de página actualizados en las 7 vistas (`index.html`, `catalog.html`, `product.html`, `cart.html`, `contact.html`, `about.html`, `brands.html`).


