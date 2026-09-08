# 📝 Tasklist de Correcciones & Mejoras — Boceto Web HMC HUB

Tasklist priorizada para resolver todas las observaciones, inconsistencias y fallas de responsividad mobile identificadas en la auditoría técnica de `boceto_web/`.

---

## 🔴 Fase 1: Correcciones Críticas Mobile & Usabilidad (Bloqueantes UX)

Tareas de máxima prioridad que impactan directamente la navegación y conversión en dispositivos móviles (< 768px y < 480px).

- [x] **1.1. Resolver Solapamiento Táctil en Ficha de Producto (`product.html` & `styles.css`)**
  - **Problema:** El botón flotante de WhatsApp (`bottom: 74px; right: 16px; z-index: 100`) se superpone exactamente sobre el botón "Comprar" de la barra adhesiva móvil `.mobile-sticky-buy-bar` (`bottom: 60px; z-index: 99`).
  - **Acción:**
    - Ajustar dinámicamente o vía CSS la posición del botón flotante cuando `.mobile-sticky-buy-bar.active` está presente: elevarlo a `bottom: 136px;` en móviles.
    - Elevar el `z-index` de la barra adhesiva o integrar un botón secundario de WhatsApp dentro de la propia barra para unificar acciones.
  - **Archivos:** `boceto_web/css/styles.css`, `boceto_web/js/app.js`.

- [x] **1.2. Refactorización Responsive Completa de "Nosotros" (`about.html` & `styles.css`)**
  - **Problema:** La vista carece de reglas en `styles.css` y usa estilos `style="..."` inline rígidos. En móviles, la sección de identidad queda en 2 columnas de 140px y las métricas en 4 columnas de `font-size: 3rem`, desbordando la pantalla.
  - **Acción:**
    - Eliminar todos los estilos inline y crear clases semánticas: `.about-hero`, `.about-identity-grid`, `.about-metrics-grid`, `.about-metric-card`.
    - En `styles.css`, crear bloque `@media (max-width: 768px)` y `@media (max-width: 480px)`:
      - `.about-identity-grid`: pasar a 1 columna apilada (`grid-template-columns: 1fr; gap: 24px;`).
      - `.about-metrics-grid`: pasar a cuadrícula 2x2 en tablet/mobile y ajustar número a `font-size: 2rem;`.
      - `.about-hero`: reducir padding de `60px 40px` a `28px 18px` y título a `1.6rem`.
    - Actualizar métrica a "Más de 100 Marcas" para coherencia con el directorio.
  - **Archivos:** `boceto_web/about.html`, `boceto_web/css/styles.css`.

- [ ] **1.3. Corrección de Cross-Selling Comprimido en Carrito (`cart.html` & `styles.css`)**
  - **Problema:** `#cartCrossSellGrid` tiene estilo inline `display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px;` sin regla CSS móvil, aplastando 3 tarjetas en columnas de 90px en móviles de 360px.
  - **Acción:**
    - Reemplazar estilo inline por clase `.cart-cross-sell-grid`.
    - Añadir regla en `styles.css`: en desktop 3 columnas, en tablet 2 columnas, en móviles ($< 576\text{px}$) 1 columna o carrusel táctil horizontal.
  - **Archivos:** `boceto_web/cart.html`, `boceto_web/css/styles.css`.

- [ ] **1.4. Inyección de Carrito Lateral y Modales en Categorías (`categories.html`)**
  - **Problema:** Se omitió el markup de `#cartDrawer`, `#quickViewModal` y `.floating-whatsapp`. Al tocar el botón de carrito en el navbar o barra inferior, no ocurre nada (falla silenciosa).
  - **Acción:**
    - Inyectar los contenedores faltantes o implementar la modularización global de modales (ver Fase 2).
    - Corregir el favicon roto: reemplazar `assets/logos/isotipo-verde.png` (404) por un asset válido (`assets/logos/logo-circular-green.png`).
  - **Archivos:** `boceto_web/categories.html`.

---

## 🟡 Fase 2: Consistencia Arquitectónica, Modularización & Enlaces

Tareas de mantenimiento, escalabilidad y eliminación de deuda técnica.

- [ ] **2.1. Modularizar Drawer de Carrito, Modal y WhatsApp en `app.js`**
  - **Problema:** `#cartDrawer`, `#quickViewModal` y `.floating-whatsapp` están duplicados manualmente en 7 archivos HTML y ausentes en 1.
  - **Acción:**
    - Crear función `renderGlobalModalsAndDrawer()` en `app.js` (siguiendo el mismo patrón de `renderGlobalNavigation()` y `renderGlobalFooter()`).
    - Centralizar el markup en una única fuente de verdad y reemplazar las 200+ líneas repetidas en los 8 HTML por un contenedor `<div id="globalModals"></div>`.
  - **Archivos:** `boceto_web/js/app.js`, y los 8 archivos `.html`.

- [ ] **2.2. Unificación Taxonómica de Categorías (Slugs & Filtros)**
  - **Problema:** Desajuste entre los IDs del mega-menú (`agua`, `consumibles-e-insumos`, `maquina-a-bateria`, `maquina-a-explosion`) y los valores en `catalog.html` y `PRODUCT_CATALOG` (`agua-bombeo`, `accesorios-insumos`, `herramientas-bateria`, `maquinas-explosion`). Al entrar desde el menú a una categoría, los filtros no coinciden.
  - **Acción:**
    - Normalizar una única convención de slugs (ej. `agua-bombeo`, `consumibles-insumos`, etc.) o hacer que `initCatalogPage()` soporte alias/sinónimos en la lectura del query param `?category=`.
    - Sincronizar checkboxes de `catalog.html`, enlaces en `index.html` y `REAL_STORE_CATEGORIES` en `app.js`.
  - **Archivos:** `boceto_web/js/app.js`, `boceto_web/catalog.html`, `boceto_web/index.html`.

- [ ] **2.3. Corrección de Error de Sintaxis en Chips Activos de Marca (`catalog.html`)**
  - **Problema:** En `renderActiveFilterChips` (`app.js:2510`), `document.querySelector('.js-filter-brand[value=' + b + ']')` rompe con error fatal si la marca tiene espacios (ej. `DOWEN PAGIO`).
  - **Acción:**
    - Envolver el valor en comillas escapadas: `[value="${b.replace(/"/g, '\\"')}"]` o asignar la remoción mediante un listener limpio sin string de selector.
  - **Archivos:** `boceto_web/js/app.js`.

- [ ] **2.4. Sincronización de Enlaces Rotos o Inconsistentes en Home (`index.html`)**
  - **Problema:**
    - Slide 2: El botón "Conocenos" tiene `href="#nosotros"` (salta a testimonios de la misma página en lugar de `about.html`).
    - Slide 3: El botón "Nuestras Marcas" tiene `href="catalog.html?brand=STIHL"` (muestra 0 productos).
    - Tarjetas Showcase: apunten a `category=generadores` y `category=jardineria` (categorías que no existen en el catálogo mock).
  - **Acción:**
    - Actualizar Slide 2 a `href="about.html"`.
    - Actualizar Slide 3 a `href="brands.html"` o a una marca con stock disponible (ej. `catalog.html?brand=BOSCH`).
    - Ajustar links de Showcase a categorías activas (`ferreteria`, `maquinas-explosion`).
  - **Archivos:** `boceto_web/index.html`.

- [ ] **2.5. Favicon Global Unificado en Todas las Páginas**
  - **Problema:** Solo `categories.html` tenía etiqueta de favicon (y apuntaba a una imagen rota 404). Las otras 7 vistas no tienen favicon.
  - **Acción:**
    - Añadir `<link rel="icon" type="image/png" href="assets/logos/logo-circular-green.png">` en el `<head>` de los 8 archivos HTML.
  - **Archivos:** Los 8 archivos `.html`.

---

## 📱 Fase 3: Optimizaciones de Experiencia Móvil & Accesibilidad

Mejoras en interacción táctil, ergonomía y accesibilidad conforme a `docs/design.md` y `CLAUDE.md`.

- [ ] **3.1. Apilado Vertical en Formulario de Contacto (`contact.html`)**
  - **Problema:** Campos Email y Teléfono están en un `div` con estilo inline `grid-template-columns: 1fr 1fr;`, quedando muy angostos en móviles.
  - **Acción:**
    - Reemplazar estilo inline por clase `.form-row-2col`.
    - En `styles.css`, definir que a `max-width: 600px` pase a `grid-template-columns: 1fr;`.
  - **Archivos:** `boceto_web/contact.html`, `boceto_web/css/styles.css`.

- [ ] **3.2. Cierre de Hoja de Filtros al Tocar Overlay (`catalog.html`)**
  - **Problema:** Al abrir filtros en móvil, tocar el fondo oscuro exterior no cierra la hoja.
  - **Acción:**
    - En `initCatalogPage()` (`app.js`), agregar listener a `#mobileDrawerOverlay` para ejecutar `closeMobileFilters()`.
  - **Archivos:** `boceto_web/js/app.js`.

- [ ] **3.3. Acceso Rápido a Buscador en Cabecera Móvil**
  - **Problema:** La búsqueda está oculta en móvil y solo se encuentra abriendo el menú lateral.
  - **Acción:**
    - Añadir un ícono de lupa en `.header-utilities` en móvil que despliegue un campo de búsqueda deslizable bajo el header, o agregar acceso a búsqueda en `.mobile-bottom-nav`.
  - **Archivos:** `boceto_web/js/app.js`, `boceto_web/css/styles.css`.

- [ ] **3.4. Adecuación de Áreas Táctiles a Estándar $\ge 44 \times 44\text{px}$**
  - **Problema:** Varios botones interactivos tienen áreas de tap muy reducidas.
  - **Acción:**
    - `.cart-close-btn`: aumentar de glyph suelto a botón de $44 \times 44\text{px}$.
    - `.catalog-sidebar-close-btn`: aumentar de $32\text{px}$ a $44\text{px}$.
    - `.mobile-drawer-close`: aumentar de $36\text{px}$ a $44\text{px}$.
    - `.btn-clear-search`: aumentar área táctil con padding invisible a $44\text{px}$.
    - `.qty-btn` (en carrito): aumentar tamaño de $28\text{px}$ a $38-44\text{px}$ para fácil ajuste con pulgar.
  - **Archivos:** `boceto_web/css/styles.css`.

- [ ] **3.5. Compatibilidad con Dispositivos iOS (Safe Area Insets)**
  - **Problema:** En iPhones con barra de inicio, `.mobile-bottom-nav` puede superponerse con el gesto de inicio.
  - **Acción:**
    - Añadir `padding-bottom: max(6px, env(safe-area-inset-bottom));` y ajustar la altura de `.mobile-bottom-nav`.
  - **Archivos:** `boceto_web/css/styles.css`.

---

## 🛠️ Fase 4: Refinamiento Funcional del Flujo de Compra & Catálogo

Pulido de estados interactivos y manejo de casos borde.

- [ ] **4.1. Evitar Apertura del Drawer al Añadir Ítems desde la Página Completa de Carrito**
  - **Problema:** Al pulsar "Sumar al pedido" en el cross-selling de `cart.html`, se abre el drawer lateral por encima de la página de carrito.
  - **Acción:**
    - En `hmcAddToCart()`, si `document.getElementById('cartPageLayout')` está presente, omitir `openCart()` y solo actualizar la vista de la página con toast.
  - **Archivos:** `boceto_web/js/app.js`.

- [ ] **4.2. Limpieza de Cupones al Vaciar Carrito**
  - **Problema:** El botón "Vaciar Carrito" deja `appliedCoupon` en memoria.
  - **Acción:**
    - En la acción de vaciar carrito, resetear `appliedCoupon = null;` para evitar descuentos erráticos al sumar nuevos productos.
  - **Archivos:** `boceto_web/js/app.js`, `boceto_web/cart.html`.

- [ ] **4.3. Manejo de Paginación Dinámica en Catálogo**
  - **Problema:** Los botones de paginación están fijos y no responden al número de productos filtrados.
  - **Acción:**
    - Implementar paginación reactiva en JavaScript o reemplazarla por scroll/conteo dinámico si los productos son menores a 12.
  - **Archivos:** `boceto_web/catalog.html`, `boceto_web/js/app.js`.

- [ ] **4.4. Incorporación de Productos Mock para Marcas Principales**
  - **Problema:** Marcas líderes destacadas en los filtros (STIHL, HUSQVARNA, HONDA, GARDENA, OREGON) no tienen productos cargados en `PRODUCT_CATALOG`.
  - **Acción:**
    - Añadir al menos 1 equipo emblemático para cada una de estas marcas en `PRODUCT_CATALOG` para evitar resultados vacíos al navegar por marca.
  - **Archivos:** `boceto_web/js/app.js`.

- [ ] **4.5. Limpieza de Código Inactivo en Home**
  - **Problema:** La sección `#catalog` con tabs se mantiene en `index.html` con `style="display: none;"`.
  - **Acción:**
    - Eliminar el bloque inactivo o documentar si se reactivará como sección opcional en Tiendanube.
  - **Archivos:** `boceto_web/index.html`.

---

## 🧪 Fase 5: QA, Pruebas Cruzadas & Validación

- [ ] **5.1. Prueba de Viewports en Emulador y Dispositivos Reales**
  - Validar en 360px (móvil pequeño), 390px (iPhone), 480px, 768px (iPad) y 1280px+.
  - Comprobar ausencia total de scroll horizontal (`overflow-x: hidden`).
- [ ] **5.2. Recorrido Completo del Embudo de Compra**
  - Home -> Catálogo con filtros -> Ficha de producto -> Carrito -> Aplicación de cupón (`BIENVENIDO-HMC` / `HMCPRO`) -> Estimador CP -> Simulación de Checkout.
- [ ] **5.3. Navegación Cruzada y Deep Links**
  - Probar URLs con parámetros: `catalog.html?category=agua-bombeo`, `catalog.html?brand=BOSCH`, `catalog.html?offers=true`, `categories.html?cat=ferreteria`.
