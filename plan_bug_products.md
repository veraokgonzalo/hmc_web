# Análisis y Plan de Corrección: Error en la Página de Productos de Tiendanube

**Fecha:** 28 de Septiembre de 2026  
**Proyecto:** HMC HUB — Tema Tiendanube Legacy  
**Repositorio:** `web_ftp/`  

---

## 1. Resumen Ejecutivo del Problema

Al ingresar a la página de productos en Tiendanube (tanto en el catálogo general `/productos`, en categorías específicas `/categorias/...` como en la ficha de producto `/productos/...`), la página se encuentra bugueada y **los productos no se visualizan** (permanecen invisibles / en blanco y las interacciones están completamente congeladas).

Tras la auditoría estática y de ejecución del código fuente del tema (`web_ftp/`), se identificaron **dos causas directas principales** y **tres puntos de fragilidad estructural en Twig/JS**:

1. **Causa Raíz Crítica (Fatal SyntaxError en JavaScript):**  
   En `web_ftp/static/js/store.js.tpl` (líneas 3845 a 3873), introducido durante la migración de la Fase 4, existen **declaraciones de variables y llamadas a métodos sin nombre de variable** (`var  = jQueryNuvem(this);`, `.data("tab")`, `.addClass("active")`, etc.).  
   Al ser incluido directamente en `<script>` en `layouts/layout.tpl`, el navegador lanza un `Uncaught SyntaxError: Unexpected token '.'` durante el análisis inicial del script. Esto **aborta la ejecución de la totalidad de `store.js`**.

2. **Causa del Ocultamiento Visual (Efecto Cascada en CSS `opacity: 0`):**  
   En `snipplets/grid/item.tpl`, cada tarjeta de producto se renderiza con el atributo `data-transition="fade-in-up"`.  
   En `static/css/style-critical.scss` (líneas 380-388), todo elemento con `[data-transition="fade-in-up"]` tiene definido:
   ```css
   [data-transition="fade-in-up"] { 
     transition: all .5s ease;
     opacity: 0;
     transform: translateY(10px);
   }
   ```
   Dichos elementos **solo pasan a `opacity: 1` cuando un `IntersectionObserver` de JavaScript les añade la clase `.is-inViewport`**.  
   Al haberse roto el script `store.js` por el error de sintaxis, la función de observación jamás se inicializa. Por lo tanto, **todos los productos están presentes en el HTML del DOM pero tienen `opacity: 0` (100% invisibles para el usuario)**. Adicionalmente, las imágenes de producto con clase `.fade-in` tampoco reciben la clase `.lazyloaded`, manteniéndose en `opacity: 0`.

3. **Causa Twig en `/productos` (Acceso inseguro a `category.name`):**  
   En Tiendanube, al visitar la raíz del catálogo `/productos`, la variable `category` es `null` (no se está dentro de una categoría específica).  
   En `templates/category.tpl` (línea 52), se evalúa:
   ```twig
   {% set is_offers_category = params.offers == 'true' or (category.name | lower in ['ofertas', 'liquidación', 'liquidacion', 'promociones']) %}
   ```
   Al intentar acceder a la propiedad `.name` de un objeto nulo, en entornos Twig con verificación estricta se genera una excepción en el renderizado del servidor. Además, en la línea 35, el encabezado `<h1>` queda completamente vacío al no tener fallback cuando `category` es nula.

---

## 2. Diagnóstico Detallado

### 2.1. El Error Fatal de Sintaxis en `web_ftp/static/js/store.js.tpl`

En el commit `af65660` ("feat(theme): migrar Fase 4 completa"), al portar los controladores de pestañas técnicas y barra adhesiva desde el prototipo, ocurrió un fallo de expansión de variables (muy común al usar comandos bash con `$` no escapados).

**Código defectuoso actual en `web_ftp/static/js/store.js.tpl` (Líneas 3844-3873):**

```javascript
    // 1. Technical Product Tabs Switcher
    jQueryNuvem(document).on("click", ".js-product-tab-btn", function(e) {
        e.preventDefault();
        var  = jQueryNuvem(this);                     // <-- ERROR: falta nombre de variable ($btn)
        var targetId = .data("tab");                 // <-- ERROR: SyntaxError "Unexpected token '.'"
        
        jQueryNuvem(".js-product-tab-btn").removeClass("active");
        jQueryNuvem(".js-product-tab-panel").removeClass("active");
        
        .addClass("active");                          // <-- ERROR: SyntaxError "Unexpected token '.'"
        jQueryNuvem("#" + targetId).addClass("active");
    });

    // 2. Mobile Sticky Bottom Buy Bar
    var  = jQueryNuvem("#mobileStickyBuyBar");       // <-- ERROR: falta nombre de variable ($stickyBar)
    if (.length) {                                    // <-- ERROR: SyntaxError "Unexpected token '.'"
        var checkStickyBuyBar = function() {
            if (window.scrollY > 380 && window.innerWidth <= 768) {
                .addClass("active");                  // <-- ERROR: SyntaxError "Unexpected token '.'"
                jQueryNuvem("body").addClass("sticky-buy-active");
            } else {
                .removeClass("active");               // <-- ERROR: SyntaxError "Unexpected token '.'"
                jQueryNuvem("body").removeClass("sticky-buy-active");
            }
        };

        window.addEventListener("scroll", checkStickyBuyBar, { passive: true });
        window.addEventListener("resize", checkStickyBuyBar, { passive: true });
        checkStickyBuyBar();
    }
```

#### Consecuencias en la tienda:
* El navegador detiene de inmediato el parseo del bloque `<script>` en `layout.tpl`.
* Ningún evento de `DOMContentLoaded`, `LS.ready`, ni controladores de Tiendanube se registran.
* Se rompe la vista en grilla / lista, el carrito lateral, la conmutación de fotos, las pestañas de producto y la asignación de clases reactivas.

---

### 2.2. Por qué los productos quedan invisibles (`opacity: 0`)

En `web_ftp/snipplets/grid/item.tpl` (línea 62):
```twig
<div class="js-item-product ... col-grid" ... {% if appear_transition %}data-transition="fade-in-up"{% endif %}>
```
Dado que `appear_transition` es `true` por defecto, cada tarjeta recibe `data-transition="fade-in-up"`.

En `web_ftp/static/css/style-critical.scss` (líneas 380-388):
```scss
[data-transition="fade-in-up"] { 
  transition: all .5s ease;
  opacity: 0;
  transform: translateY(10px);
}
[data-transition="fade-in-up"].is-inViewport,
.swiper-slide-duplicate [data-transition="fade-in-up"] { 
  transition: all .6s ease;
  opacity: 1;
  transform: translateY(0px);
}
```

En `web_ftp/static/js/store.js.tpl` (líneas 540-555):
```javascript
const inViewport = (entries, observer) => {
  entries.forEach(entry => {
    if (entry.isIntersecting && !entry.target.observed) {
      entry.target.classList.add("is-inViewport");
      entry.target.observed = true;
    }
  });
};

const ELs_inViewport = document.querySelectorAll('[data-transition]');
ELs_inViewport.forEach(EL => {
  EL.observed = false;
  const Obs = new IntersectionObserver(inViewport);
  Obs.observe(EL);
});
```

Al romperse `store.js.tpl` por el SyntaxError en la línea 3847, este script falla o no se ejecuta completamente tras el ciclo de vida del DOM, dejando **todas las tarjetas de producto con `opacity: 0`**.

---

### 2.3. Fragilidades en las Plantillas Twig de Catálogo (`category.tpl`)

1. **`category` es nula en `/productos`:**  
   Cuando un usuario entra al catálogo general desde la barra de navegación ("Productos"), Tiendanube ejecuta `category.tpl`, pero el objeto `category` es nulo porque no hay categoría seleccionada.
   * **Línea 35:**
     ```twig
     {% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
     ```
     Renderiza un `<h1>` vacío en blanco.
   * **Línea 52:**
     ```twig
     {% set is_offers_category = params.offers == 'true' or (category.name | lower in ['ofertas', 'liquidación', 'liquidacion', 'promociones']) %}
     ```
     Intenta evaluar `.name` en un valor nulo, lo cual es propenso a excepciones Twig.
   * **Línea 49 de `category.tpl` y Línea 2 de `products-list.tpl`:**
     Generan `category-grid-` (con ID vacío).

2. **Error potencial en observador sticky mobile (`store.js.tpl` línea 1879):**
   ```javascript
   observer.observe(document.querySelector(".js-category-controls-prev"));
   ```
   Si `.js-category-controls-prev` no está presente en el DOM (como ocurre en búsquedas vacías o plantillas sin controles), `document.querySelector` devuelve `null`, provocando:
   `TypeError: Failed to execute 'observe' on 'IntersectionObserver': parameter 1 is not of type 'Element'`.

---

## 3. Plan de Solución Paso a Paso

### Fase 1: Corrección Inmediata de Sintaxis en `store.js.tpl`
Corregir las líneas 3844-3873 en `web_ftp/static/js/store.js.tpl`, asignando nombres explícitos y válidos a las variables:

```javascript
    /* ==========================================================================
       HMC HUB Phase 4: Product Detail Tabs & Mobile Sticky Buy Bar
       ========================================================================== */

    // 1. Technical Product Tabs Switcher
    jQueryNuvem(document).on("click", ".js-product-tab-btn", function(e) {
        e.preventDefault();
        var $btn = jQueryNuvem(this);
        var targetId = $btn.data("tab");
        
        jQueryNuvem(".js-product-tab-btn").removeClass("active");
        jQueryNuvem(".js-product-tab-panel").removeClass("active");
        
        $btn.addClass("active");
        jQueryNuvem("#" + targetId).addClass("active");
    });

    // 2. Mobile Sticky Bottom Buy Bar
    var $stickyBar = jQueryNuvem("#mobileStickyBuyBar");
    if ($stickyBar.length) {
        var checkStickyBuyBar = function() {
            if (window.scrollY > 380 && window.innerWidth <= 768) {
                $stickyBar.addClass("active");
                jQueryNuvem("body").addClass("sticky-buy-active");
            } else {
                $stickyBar.removeClass("active");
                jQueryNuvem("body").removeClass("sticky-buy-active");
            }
        };

        window.addEventListener("scroll", checkStickyBuyBar, { passive: true });
        window.addEventListener("resize", checkStickyBuyBar, { passive: true });
        checkStickyBuyBar();
    }
```

### Fase 2: Salvaguarda Antifallos de Visibilidad de Productos
Para garantizar que **bajo ninguna circunstancia** los productos queden ocultos en `opacity: 0` si un script o red se demora:
1. En `web_ftp/static/css/style-async.scss`, agregar una regla que garantice opacidad 1 en los productos del catálogo una vez cargada la hoja de estilos:
   ```scss
   .js-item-product {
     opacity: 1 !important;
     transform: none !important;
   }
   ```
2. En `web_ftp/static/js/store.js.tpl`, en el bloque de inicialización del grid de productos, forzar la clase `.is-inViewport`:
   ```javascript
   jQueryNuvem('.js-item-product').addClass('is-inViewport');
   ```

### Fase 3: Protección y Resiliencia en Plantillas Twig
1. En `web_ftp/templates/category.tpl`:
   * **Línea 35:** Proporcionar fallback al título cuando `category` es nulo:
     ```twig
     {% block page_header_text %}{{ category ? category.name : ('Productos' | translate) }}{% endblock page_header_text %}
     ```
   * **Línea 49:**
     ```twig
     <section class="category-body" data-store="category-grid{% if category.id %}-{{ category.id }}{% endif %}">
     ```
   * **Línea 52:** Validar existencia de `category` antes de acceder a `.name`:
     ```twig
     {% set is_offers_category = params.offers == 'true' or (category and category.name | lower in ['ofertas', 'liquidación', 'liquidacion', 'promociones']) %}
     ```
2. En `web_ftp/snipplets/grid/products-list.tpl`:
   * **Línea 2:**
     ```twig
     {% set list_data_store = template == 'category' ? (category ? 'category-grid-' ~ category.id : 'category-grid') : 'search-grid' %}
     ```
3. En `web_ftp/snipplets/grid/categories.tpl`:
   * **Línea 8:**
     ```twig
     {% set current_page_category_id = category ? category.id : null %}
     ```

### Fase 4: Blindaje del Observador Sticky en Móviles
En `web_ftp/static/js/store.js.tpl` (línea 1879), añadir comprobación de nulidad para evitar excepciones de `IntersectionObserver`:
```javascript
var stickyTarget = document.querySelector(".js-category-controls-prev");
if (stickyTarget) {
    observer.observe(stickyTarget);
}
```

### Fase 5: Despliegue y Verificación en Vivo
1. Realizar push incremental al servidor FTP de Tiendanube:
   ```bash
   cd web_ftp
   tiendanube theme ftp push
   ```
2. Verificar en el storefront de Tiendanube (`/productos`, `/productos/un-producto`, `/marcas` y buscador):
   * Comprobar en la consola de herramientas de desarrollo (F12) la ausencia de errores de sintaxis (`Uncaught SyntaxError`).
   * Verificar la visibilidad inmediata de la grilla de productos, imágenes y precios.
   * Probar el alternador de vista Grilla / Lista.
   * Probar la reactividad de los filtros laterales y chips activos.
   * Probar en la ficha de producto el intercambio de pestañas técnicas ("Descripción", "Garantía", "Opiniones") y la barra adhesiva en vista mobile.

---

## 4. Matriz de Archivos Afectados

| Archivo | Problema | Solución |
| :--- | :--- | :--- |
| `web_ftp/static/js/store.js.tpl` | `var  =` y métodos sin identificador en líneas 3847-3865; `observer.observe` sin null check en línea 1879 | Restaurar `$btn` y `$stickyBar`; agregar comprobación `if (stickyTarget)` |
| `web_ftp/templates/category.tpl` | `category.name` sin fallback en título (L35) y sin null-check en banner de ofertas (L52) | Agregar `category ? category.name : ('Productos' \| translate)` y null check |
| `web_ftp/snipplets/grid/products-list.tpl` | `category-grid-` con ID vacío en `/productos` (L2) | Condicionar sufijo a existencia de `category` |
| `web_ftp/snipplets/grid/categories.tpl` | Asignación directa `category.id` cuando es nulo (L8) | Usar operador ternario `category ? category.id : null` |
| `web_ftp/static/css/style-async.scss` | Dependencia 100% estricta de JS para opacidad de productos | Añadir regla de seguridad para asegurar visibilidad de cards |
