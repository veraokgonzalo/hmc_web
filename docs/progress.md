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
