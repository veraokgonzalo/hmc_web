/**
 * HMC HUB - Master Application Logic (Senior Architecture Prototype)
 * Modular Multi-Page Storefront for Tiendanube Legacy & Nimbus Conversion
 */

document.addEventListener('DOMContentLoaded', () => {
  // Global Components
  renderGlobalNavigation();
  renderGlobalFooter();
  syncNavigationActiveState();
  initCartSystem();
  initLiveSearch();
  initQuickViewModal();
  initNewsletter();
  initMobileMenu();

  // Page-Specific Dispatcher
  if (document.querySelector('.hero-slider-section')) {
    initHeroSlider();
    initCountdown();
    initCatalogTabs();
    initVideoPlayer();
    initPromoPopup();
  }

  if (document.querySelector('.js-brands-marquee, .brands-marquee-container')) {
    initBrandsMarquee();
  }

  if (document.getElementById('brandsPageLayout') || document.querySelector('.brands-page-section')) {
    initBrandsPage();
  }

  if (document.getElementById('directorioCategorias') || document.querySelector('.categories-page-section') || document.getElementById('categoriesTreeContainer')) {
    initCategoriesPage();
  }

  if (document.getElementById('catalogPageLayout')) {
    initCatalogPage();
  }

  if (document.getElementById('productDetailLayout')) {
    initProductPage();
  }

  if (document.getElementById('cartPageLayout')) {
    initCartPage();
  }

  if (document.getElementById('contactPageLayout')) {
    initContactPage();
  }
});

/* --------------------------------------------------------------------------
   -1.5. Master Store Categories (Single Source of Truth, Alphabetical, No &, No Emojis)
   -------------------------------------------------------------------------- */
const REAL_STORE_CATEGORIES = [
  { id: "agua", name: "AGUA", displayName: "Agua", count: 19 },
  { id: "construccion", name: "CONSTRUCCION", displayName: "Construcción", count: 151 },
  { id: "consumibles-e-insumos", name: "CONSUMIBLES E INSUMOS", displayName: "Consumibles e Insumos", count: 82 },
  { id: "ferreteria", name: "FERRETERIA", displayName: "Ferretería", count: 1192 },
  { id: "generacion-energia", name: "GENERACION ENERGIA", displayName: "Generación Energía", count: 112 },
  { id: "jardin", name: "JARDIN", displayName: "Jardín", count: 287 },
  { id: "maquina-a-bateria", name: "MAQUINA A BATERIA", displayName: "Máquinas a Batería", count: 159 },
  { id: "maquina-a-explosion", name: "MAQUINA A EXPLOSION", displayName: "Máquinas a Explosión", count: 265 },
  { id: "maquina-electrica", name: "MAQUINA ELECTRICA", displayName: "Máquinas Eléctricas", count: 108 },
  { id: "maquina-manual", name: "MAQUINA MANUAL", displayName: "Máquinas Manuales", count: 8 },
  { id: "producto-de-fuerza", name: "PRODUCTO DE FUERZA", displayName: "Productos de Fuerza", count: 96 },
  { id: "repuestos", name: "REPUESTOS", displayName: "Repuestos", count: 563 },
  { id: "riego", name: "RIEGO", displayName: "Riego", count: 200 }
];

const OFFICIAL_CORE_BRANDS = ["OREGON", "NIWA", "BOSCH", "EINHELL", "HUSQVARNA", "GARDENA", "SENSEI", "HONDA"];

function getCategoriesDropdownHtml() {
  const source = (typeof window !== 'undefined' && window.REAL_CATEGORIES_TREE && window.REAL_CATEGORIES_TREE.length > 0)
    ? window.REAL_CATEGORIES_TREE
    : REAL_STORE_CATEGORIES;

  // 12 Categorías principales por volumen, ordenadas alfabéticamente por displayName
  const top12 = [...source]
    .sort((a, b) => b.count - a.count)
    .slice(0, 12)
    .sort((a, b) => a.displayName.localeCompare(b.displayName, 'es'));

  return top12.map(cat => `
    <a href="catalog.html?category=${cat.id}" class="dropdown-category-card" title="Ver ${cat.count.toLocaleString('es-AR')} productos en ${cat.displayName}">
      <div class="dropdown-category-info">
        <span class="dropdown-category-name">${cat.displayName}</span>
        <span class="dropdown-category-count">${cat.count.toLocaleString('es-AR')} productos</span>
      </div>
    </a>
  `).join('');
}

function getBrandsDropdownHtml() {
  return OFFICIAL_CORE_BRANDS.map(brand => `
    <a href="catalog.html?brand=${encodeURIComponent(brand)}" class="dropdown-brand-card" title="Ver catálogo oficial ${brand}">
      <div class="dropdown-brand-name">
        <span>${brand}</span>
      </div>
    </a>
  `).join('');
}

function getMobileDrawerCategoriesHtml() {
  const source = (typeof window !== 'undefined' && window.REAL_CATEGORIES_TREE && window.REAL_CATEGORIES_TREE.length > 0)
    ? window.REAL_CATEGORIES_TREE
    : REAL_STORE_CATEGORIES;

  const top12 = [...source]
    .sort((a, b) => b.count - a.count)
    .slice(0, 12)
    .sort((a, b) => a.displayName.localeCompare(b.displayName, 'es'));

  let html = top12.map(cat => `
    <a href="catalog.html?category=${cat.id}" class="mobile-subnav-link">${cat.displayName}</a>
  `).join('');

  html += `
    <a href="categories.html" class="mobile-subnav-link mobile-subnav-link-cta">Todas las categorías →</a>
  `;
  return html;
}

function getMobileDrawerBrandsHtml() {
  let html = OFFICIAL_CORE_BRANDS.map(brand => `
    <a href="catalog.html?brand=${encodeURIComponent(brand)}" class="mobile-subnav-link">${brand}</a>
  `).join('');

  html += `
    <a href="brands.html" class="mobile-subnav-link mobile-subnav-link-cta">Todas las marcas →</a>
  `;
  return html;
}

function getCategoriesFastJumpBarHtml(activeCat = "ALL") {
  const source = (typeof window !== 'undefined' && window.REAL_CATEGORIES_TREE && window.REAL_CATEGORIES_TREE.length > 0)
    ? window.REAL_CATEGORIES_TREE
    : REAL_STORE_CATEGORIES;

  const sortedCategories = [...source].sort((a, b) => 
    (a.displayName || a.name).localeCompare(b.displayName || b.name, 'es')
  );

  let html = `<button type="button" class="alpha-btn${activeCat === 'ALL' ? ' active' : ''}" data-cat="ALL">TODAS</button>`;
  sortedCategories.forEach(cat => {
    const isActive = activeCat === cat.id ? ' active' : '';
    html += `\n            <button type="button" class="alpha-btn${isActive}" data-cat="${cat.id}">${cat.displayName || cat.name}</button>`;
  });
  return html;
}

/* --------------------------------------------------------------------------
   -1. Single Source of Truth: Global Header & Navigation Component
   -------------------------------------------------------------------------- */
function renderGlobalNavigation() {
  const navContainer = document.getElementById("globalNavigation") || document.getElementById("siteHeaderNav");
  if (navContainer) {
    navContainer.innerHTML = `
  <!-- 1. Top Announcement Bar (Marquee) -->
  <div class="top-bar">
    <div class="container top-bar-inner">
      <div class="top-bar-slider">
        <div class="top-bar-marquee-track">
          <div class="top-bar-marquee-content">
            <span><i class="fa-solid fa-truck-fast"></i> Envíos a todo el país</span>
            <span class="top-bar-marquee-sep">•</span>
            <span><i class="fa-solid fa-credit-card"></i> <strong>6 cuotas fijas</strong> sin interés</span>
            <span class="top-bar-marquee-sep">•</span>
            <span><i class="fa-solid fa-screwdriver-wrench"></i> Puesta en marcha oficial</span>
            <span class="top-bar-marquee-sep">•</span>
          </div>
          <div class="top-bar-marquee-content" aria-hidden="true">
            <span><i class="fa-solid fa-truck-fast"></i> Envíos a todo el país</span>
            <span class="top-bar-marquee-sep">•</span>
            <span><i class="fa-solid fa-credit-card"></i> <strong>6 cuotas fijas</strong> sin interés</span>
            <span class="top-bar-marquee-sep">•</span>
            <span><i class="fa-solid fa-screwdriver-wrench"></i> Puesta en marcha oficial</span>
            <span class="top-bar-marquee-sep">•</span>
          </div>
        </div>
      </div>
      <div class="top-bar-links">
        <a href="contact.html"><i class="fa-solid fa-location-dot"></i> Sucursal: Santa Rosa, La Pampa</a>
        <a href="https://wa.me/5492954696231" target="_blank"><i class="fa-brands fa-whatsapp"></i> Ventas & Factura A</a>
      </div>
    </div>
  </div>

  <!-- 2. Header & Live Search -->
  <header class="header-main">
    <div class="container header-inner">
      
      <!-- Brand Logo -->
      <div class="logo-container">
        <a href="index.html" class="logo-link">
          <img src="assets/logos/logo-horizontal-color.png" alt="HMC HUB" class="logo-img">
        </a>
      </div>

      <!-- Live Search Form -->
      <div class="header-search">
        <form class="search-form" onsubmit="event.preventDefault();">
          <input type="text" id="mainSearchInput" class="search-input" placeholder="Buscar demoledores, taladros, motoguadañas, bombas, sierras..." autocomplete="off">
          <button type="submit" class="search-btn" title="Buscar">
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
        </form>
        <div id="searchDropdown" class="search-dropdown">
          <div class="search-dropdown-header">Sugerencias destacadas</div>
          <div id="searchResultsList"></div>
        </div>
      </div>

      <!-- Header Utility Actions -->
      <div class="header-utilities">
        <a href="contact.html" class="utility-btn" title="Mi Cuenta & Sucursales">
          <i class="fa-regular fa-user"></i>
          <span class="d-none-mobile">Mi Cuenta</span>
        </a>
        <button class="utility-btn js-open-cart" title="Carrito de Compras">
          <i class="fa-solid fa-cart-shopping"></i>
          <span class="d-none-mobile">Carrito</span>
          <span class="cart-count-badge js-cart-count">1</span>
        </button>
        <button class="mobile-menu-toggle" id="mobileMenuToggle" title="Abrir Menú">
          <i class="fa-solid fa-bars"></i>
        </button>
      </div>

    </div>
  </header>

  <!-- 3. Main Navigation Bar with Mega-Dropdowns -->
  <nav class="nav-bar">
    <div class="container nav-inner">
      <ul class="nav-list">
        <li class="nav-item">
          <a href="index.html" class="nav-link"><i class="fa-solid fa-house"></i> Inicio</a>
        </li>
        <li class="nav-item has-mega-dropdown">
          <a href="categories.html" class="nav-link">
            Categorías <i class="fa-solid fa-chevron-down" style="font-size: 0.75em; margin-left: 2px;"></i>
          </a>
          <!-- Compact Categories Mega Dropdown (12 Top Categories) -->
          <div class="mega-dropdown mega-dropdown-categories-featured">
            <div class="dropdown-categories-wrapper">
              
              <!-- Header -->
              <div class="dropdown-categories-header">
                <div class="dropdown-categories-title">
                  <div>
                    <h4>Categorías Principales</h4>
                  </div>
                </div>
                <span class="badge-official-pill"><i class="fa-solid fa-boxes-stacked"></i> Catálogo HMC</span>
              </div>

              <!-- 12 Top Categories Grid (4 cols x 3 rows, Dynamic & Alphabetical) -->
              <div class="dropdown-categories-grid">
                ${getCategoriesDropdownHtml()}
              </div>

              <!-- Footer CTA Button -->
              <div class="dropdown-categories-footer">
                <div class="dropdown-categories-footer-text">
                  <i class="fa-solid fa-layer-group text-primary"></i>
                  <span>Más de <strong>13 rubros industriales</strong> y 460 subrubros con stock y repuestos.</span>
                </div>
                <a href="categories.html" class="btn btn-primary btn-sm btn-explore-categories">
                  Todas las categorías →
                </a>
              </div>

            </div>
          </div>
        </li>
        <li class="nav-item has-mega-dropdown">
          <a href="brands.html" class="nav-link">
            Marcas <i class="fa-solid fa-chevron-down" style="font-size: 0.75em; margin-left: 2px;"></i>
          </a>
          
          <!-- Simple & Focused Featured Brands Dropdown with Direct Link to Brands Directory -->
          <div class="mega-dropdown mega-dropdown-brands-featured">
            <div class="dropdown-brands-wrapper">
              
              <!-- Header -->
              <div class="dropdown-brands-header">
                <div class="dropdown-brands-title">
                  <div>
                    <h4>Marcas Destacadas</h4>
                  </div>
                </div>
                <span class="badge-official-pill"><i class="fa-solid fa-shield-check"></i> Garantía Oficial</span>
              </div>

              <!-- 8 Featured Brands Grid -->
              <div class="dropdown-brands-grid">
                ${getBrandsDropdownHtml()}
              </div>

              <!-- Footer CTA Button: Explora todas nuestras marcas -->
              <div class="dropdown-brands-footer">
                <div class="dropdown-brands-footer-text">
                  <i class="fa-solid fa-layer-group text-primary"></i>
                  <span>Representamos a más de <strong>100 fabricantes líderes</strong> con stock y repuestos.</span>
                </div>
                <a href="brands.html" class="btn btn-primary btn-sm btn-explore-brands">
                  Todas las marcas →
                </a>
              </div>

            </div>
          </div>
        </li>
        <li class="nav-item">
          <a href="catalog.html?offers=true" class="nav-link has-badge">Ofertas</a>
        </li>
        <li class="nav-item">
          <a href="about.html" class="nav-link">Nosotros</a>
        </li>
        <li class="nav-item">
          <a href="contact.html" class="nav-link">Contacto</a>
        </li>
      </ul>

      <!-- Direct Technical Advice Link in Navbar -->
      <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="nav-support-link">
        <i class="fa-brands fa-whatsapp"></i> Asesoría Técnica
      </a>
    </div>
  </nav>
    `;
  }

  const mobileNavContainer = document.getElementById("globalMobileNavigation") || document.getElementById("siteMobileNav");
  if (mobileNavContainer) {
    mobileNavContainer.innerHTML = `
  <!-- Mobile Off-Canvas Drawer Menu -->
  <div class="mobile-drawer-overlay" id="mobileDrawerOverlay"></div>
  <aside class="mobile-drawer-menu" id="mobileDrawerMenu">
    <div class="mobile-drawer-header">
      <img src="assets/logos/logo-horizontal-white.png" alt="HMC HUB" class="mobile-drawer-logo">
      <button class="mobile-drawer-close" id="mobileDrawerClose" title="Cerrar"><i class="fa-solid fa-xmark"></i></button>
    </div>
    <div class="mobile-drawer-search">
      <form id="mobileDrawerSearchForm">
        <input type="text" id="mobileDrawerSearchInput" placeholder="Buscar demoledores, taladros, motoguadañas, bombas...">
        <button type="submit" title="Buscar"><i class="fa-solid fa-magnifying-glass"></i></button>
      </form>
    </div>
    <div class="mobile-drawer-nav">
      <!-- 1. Inicio -->
      <a href="index.html" class="mobile-nav-link-item">
        <span><i class="fa-solid fa-house"></i> Inicio</span>
      </a>
      
      <!-- 2. Categorías -->
      <div class="mobile-drawer-accordion-header js-drawer-accordion" data-nav="categories">
        <span>Categorías</span>
        <i class="fa-solid fa-chevron-down"></i>
      </div>
      <div class="mobile-drawer-accordion-content">
        ${getMobileDrawerCategoriesHtml()}
      </div>

      <!-- 3. Marcas -->
      <div class="mobile-drawer-accordion-header js-drawer-accordion" data-nav="brands">
        <span>Marcas</span>
        <i class="fa-solid fa-chevron-down"></i>
      </div>
      <div class="mobile-drawer-accordion-content">
        ${getMobileDrawerBrandsHtml()}
      </div>

      <!-- 4. Ofertas -->
      <a href="catalog.html?offers=true" class="mobile-nav-link-item">
        <span>Ofertas</span>
        <span class="badge badge-discount">OFF</span>
      </a>

      <!-- 5. Nosotros -->
      <a href="about.html" class="mobile-nav-link-item">
        <span>Nosotros</span>
      </a>

      <!-- 6. Contacto -->
      <a href="contact.html" class="mobile-nav-link-item">
        <span>Contacto</span>
      </a>

      <!-- 7. Asesoría Técnica -->
      <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="mobile-nav-link-item mobile-nav-support-link" style="color: var(--color-primary-dark); font-weight: 700;">
        <span><i class="fa-brands fa-whatsapp" style="color: #25D366; margin-right: 6px;"></i> Asesoría Técnica</span>
      </a>
    </div>
    <div class="mobile-drawer-footer">
      <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="mobile-drawer-wa-card">
        <i class="fa-brands fa-whatsapp"></i>
        <div>
          <div>Asesoría Técnica Directa</div>
          <small>Respuesta en menos de 15 min</small>
        </div>
      </a>
    </div>
  </aside>

  <!-- Mobile Bottom App Bar -->
  <div class="mobile-bottom-nav">
    <a href="index.html" class="mobile-nav-btn" data-page="index">
      <i class="fa-solid fa-house"></i>
      <span>Inicio</span>
    </a>
    <a href="categories.html" class="mobile-nav-btn" data-page="categories">
      <i class="fa-solid fa-layer-group"></i>
      <span>Categorías</span>
    </a>
    <a href="brands.html" class="mobile-nav-btn" data-page="brands">
      <i class="fa-solid fa-certificate"></i>
      <span>Marcas</span>
    </a>
    <button class="mobile-nav-btn js-open-cart" data-page="cart">
      <div style="position: relative; display: inline-block;">
        <i class="fa-solid fa-cart-shopping"></i>
        <span class="cart-count-badge js-cart-count">1</span>
      </div>
      <span>Carrito</span>
    </button>
    <button class="mobile-nav-btn js-open-mobile-menu" data-page="menu">
      <i class="fa-solid fa-bars"></i>
      <span>Menú</span>
    </button>
  </div>
    `;
  }
}

/* --------------------------------------------------------------------------
   -0.5. Single Source of Truth: Global Footer Component
   -------------------------------------------------------------------------- */
function renderGlobalFooter() {
  const footerContainer = document.getElementById("globalFooter") || document.getElementById("siteFooter");
  if (footerContainer) {
    footerContainer.innerHTML = `
  <footer class="footer-main" id="contacto">
    <div class="container">
      
      <div class="footer-grid">
        
        <!-- Col 1: Brand Info -->
        <div class="footer-col">
          <img src="assets/logos/logo-horizontal-white.png" alt="HMC HUB" class="footer-logo">
          <p class="footer-brand-desc">
            Un solo lugar. Todo lo que mueve tu obra, tu campo, tu casa o tu negocio. Respaldo técnico profesional, trayectoria y servicio oficial.
          </p>
          <div class="footer-social-links">
            <a href="https://instagram.com/hmchub" target="_blank" class="social-btn" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
            <a href="https://wa.me/5492954696231" target="_blank" class="social-btn" title="WhatsApp"><i class="fa-brands fa-whatsapp"></i></a>
          </div>
        </div>

        <!-- Col 2: Navigation Links -->
        <div class="footer-col">
          <h4>Navegación</h4>
          <ul class="footer-links">
            <li><a href="index.html"><i class="fa-solid fa-chevron-right"></i> Inicio</a></li>
            <li><a href="catalog.html"><i class="fa-solid fa-chevron-right"></i> Catálogo Completo</a></li>
            <li><a href="categories.html"><i class="fa-solid fa-chevron-right"></i> Directorio de Categorías</a></li>
            <li><a href="catalog.html?offers=true"><i class="fa-solid fa-chevron-right"></i> Ofertas Especiales</a></li>
            <li><a href="brands.html"><i class="fa-solid fa-chevron-right"></i> Marcas Oficiales</a></li>
            <li><a href="about.html"><i class="fa-solid fa-chevron-right"></i> Nosotros & Respaldo</a></li>
            <li><a href="contact.html"><i class="fa-solid fa-chevron-right"></i> Contacto y Sucursales</a></li>
          </ul>
        </div>

        <!-- Col 3: Customer Care & Policies -->
        <div class="footer-col">
          <h4>Atención al Cliente</h4>
          <ul class="footer-links">
            <li><a href="contact.html"><i class="fa-solid fa-chevron-right"></i> Formas de Envío</a></li>
            <li><a href="contact.html"><i class="fa-solid fa-chevron-right"></i> Medios de Pago</a></li>
            <li><a href="contact.html"><i class="fa-solid fa-chevron-right"></i> Garantía y Devoluciones</a></li>
            <li><a href="contact.html"><i class="fa-solid fa-chevron-right"></i> Servicio Técnico Oficial</a></li>
          </ul>
        </div>

        <!-- Col 4: Direct Contact -->
        <div class="footer-col">
          <h4>Contacto Directo</h4>
          <ul class="footer-contact-list">
            <li>
              <i class="fa-solid fa-location-dot"></i>
              <span>Av. Santiago Marzo (Norte) 171, Santa Rosa, La Pampa, Argentina</span>
            </li>
            <li>
              <i class="fa-brands fa-whatsapp"></i>
              <span>+54 9 2954 69-6231 (Ventas & Asesoría)</span>
            </li>
            <li>
              <i class="fa-solid fa-envelope"></i>
              <span>contacto@hmchub.com.ar</span>
            </li>
            <li>
              <i class="fa-solid fa-clock"></i>
              <span>Lunes a Viernes: 8:00 a 18:00 hs | Sábados: 8:30 a 13:00 hs</span>
            </li>
          </ul>
        </div>

      </div>

      <!-- Footer Bottom -->
      <div class="footer-bottom">
        <div class="footer-bottom-inner">
          <div>
            © 2026 <strong>HMC HUB</strong> — Todos los derechos reservados.
          </div>
          <div class="payment-methods-icons">
            <i class="fa-brands fa-cc-visa" title="Visa"></i>
            <i class="fa-brands fa-cc-mastercard" title="Mastercard"></i>
            <i class="fa-brands fa-cc-amex" title="American Express"></i>
            <i class="fa-solid fa-money-bill-transfer" title="Transferencia Bancaria"></i>
            <i class="fa-solid fa-shield-check text-primary" title="Compra 100% Protegida"></i>
          </div>
        </div>
      </div>

    </div>
  </footer>
    `;
  }
}

/* --------------------------------------------------------------------------
   0. Global Navigation State Synchronization (Active State Engine)
   -------------------------------------------------------------------------- */
function syncNavigationActiveState() {
  const urlParams = new URLSearchParams(window.location.search);
  const pathname = window.location.pathname;
  const isOffers = urlParams.get('offers') === 'true';
  const brandParam = urlParams.get('brand');
  const categoryParam = urlParams.get('category') || urlParams.get('cat');

  // Clear all desktop active nav items
  document.querySelectorAll('.nav-list .nav-item').forEach(item => item.classList.remove('active'));
  // Clear all mobile drawer active links and headers
  document.querySelectorAll('.mobile-drawer-nav .mobile-nav-link-item').forEach(item => item.classList.remove('active'));
  document.querySelectorAll('.mobile-drawer-accordion-header').forEach(item => item.classList.remove('active'));
  // Clear all mobile bottom nav buttons
  document.querySelectorAll('.mobile-bottom-nav .mobile-nav-btn').forEach(item => item.classList.remove('active'));

  if (pathname.includes('about.html')) {
    document.querySelectorAll('.nav-item a[href*="about.html"]').forEach(a => a.parentElement.classList.add('active'));
    document.querySelectorAll('.mobile-nav-link-item[href*="about.html"]').forEach(a => a.classList.add('active'));
  } else if (pathname.includes('brands.html')) {
    document.querySelectorAll('.nav-item a[href*="brands.html"]').forEach(a => a.parentElement.classList.add('active'));
    document.querySelectorAll('.mobile-nav-link-item[href*="brands.html"]').forEach(a => a.classList.add('active'));
    document.querySelectorAll('.mobile-drawer-accordion-header[data-nav="brands"]').forEach(h => h.classList.add('active'));
    document.querySelectorAll('.mobile-bottom-nav a[href*="brands.html"], .mobile-bottom-nav [data-page="brands"]').forEach(a => a.classList.add('active'));
  } else if (pathname.includes('categories.html')) {
    document.querySelectorAll('.nav-item a[href*="categories.html"]').forEach(a => a.parentElement.classList.add('active'));
    document.querySelectorAll('.mobile-nav-link-item[href*="categories.html"]').forEach(a => a.classList.add('active'));
    document.querySelectorAll('.mobile-drawer-accordion-header[data-nav="categories"]').forEach(h => h.classList.add('active'));
    document.querySelectorAll('.mobile-bottom-nav a[href*="categories.html"], .mobile-bottom-nav [data-page="categories"]').forEach(a => a.classList.add('active'));
    const categoriesNavItem = document.querySelector('.mega-dropdown-categories-featured, .mega-dropdown:not(.mega-dropdown-brands-featured)')?.closest('.nav-item');
    if (categoriesNavItem) categoriesNavItem.classList.add('active');
  } else if (pathname.includes('contact.html')) {
    document.querySelectorAll('.nav-item a[href*="contact.html"]').forEach(a => a.parentElement.classList.add('active'));
    document.querySelectorAll('.mobile-nav-link-item[href*="contact.html"]').forEach(a => a.classList.add('active'));
  } else if (pathname.includes('cart.html')) {
    document.querySelectorAll('.mobile-bottom-nav [data-page="cart"], .mobile-bottom-nav .js-open-cart').forEach(btn => btn.classList.add('active'));
  } else if (pathname.includes('catalog.html')) {
    if (isOffers) {
      // 1. Activate "Ofertas" in desktop navbar
      document.querySelectorAll('.nav-item a[href*="offers=true"]').forEach(a => a.parentElement.classList.add('active'));
      // 2. Activate "Ofertas" in mobile drawer
      document.querySelectorAll('.mobile-nav-link-item[href*="offers=true"]').forEach(a => a.classList.add('active'));
      
      // 3. Update Title & Breadcrumbs
      document.title = 'Ofertas Especiales & Oportunidades | HMC HUB';
      const breadcrumbEl = document.getElementById('catalogBreadcrumbCurrent');
      if (breadcrumbEl) breadcrumbEl.textContent = 'Ofertas Especiales';

      // 4. Show Promo Banner
      const promoBanner = document.getElementById('catalogOffersPromoBanner');
      if (promoBanner) promoBanner.style.display = 'block';
    } else if (brandParam) {
      // 1. Activate "Marcas" in navbar
      const brandsNavItem = document.querySelector('.mega-dropdown-brands-featured, .mega-dropdown-brands-2a, .mega-dropdown-brands')?.closest('.nav-item');
      if (brandsNavItem) brandsNavItem.classList.add('active');
      document.querySelectorAll('.mobile-drawer-accordion-header[data-nav="brands"]').forEach(h => h.classList.add('active'));
      document.querySelectorAll('.mobile-bottom-nav a[href*="brands.html"], .mobile-bottom-nav [data-page="brands"]').forEach(a => a.classList.add('active'));
      
      // 2. Update Title & Breadcrumbs
      document.title = `Equipos ${brandParam} Oficial | HMC HUB`;
      const breadcrumbEl = document.getElementById('catalogBreadcrumbCurrent');
      if (breadcrumbEl) breadcrumbEl.textContent = `Marcas: ${brandParam}`;
    } else {
      // Standard catalog / category view
      const categoriesNavItem = document.querySelector('.mega-dropdown-categories-featured, .mega-dropdown:not(.mega-dropdown-brands):not(.mega-dropdown-brands-2a):not(.mega-dropdown-brands-featured)')?.closest('.nav-item');
      if (categoriesNavItem) categoriesNavItem.classList.add('active');
      document.querySelectorAll('.mobile-drawer-accordion-header[data-nav="categories"]').forEach(h => h.classList.add('active'));
      document.querySelectorAll('.mobile-bottom-nav a[href*="categories.html"], .mobile-bottom-nav [data-page="categories"]').forEach(a => a.classList.add('active'));
      if (categoryParam) {
        const catProd = PRODUCT_CATALOG.find(p => p.category === categoryParam);
        const catName = catProd ? catProd.categoryName : categoryParam;
        document.title = `${catName} | HMC HUB`;
        const breadcrumbEl = document.getElementById('catalogBreadcrumbCurrent');
        if (breadcrumbEl) breadcrumbEl.textContent = catName;
      }
    }
  } else if (pathname.includes('index.html') || pathname.endsWith('/') || pathname === '') {
    document.querySelectorAll('.nav-item a[href*="index.html"]').forEach(a => a.parentElement.classList.add('active'));
    document.querySelectorAll('.mobile-nav-link-item[href*="index.html"]').forEach(a => a.classList.add('active'));
    document.querySelectorAll('.mobile-bottom-nav a[href*="index.html"], .mobile-bottom-nav [data-page="index"]').forEach(a => a.classList.add('active'));
  }
}


/* --------------------------------------------------------------------------
   0.1. Master 113 Real Catalog Brands Database (Extracted from Tiendanube CSV)
   -------------------------------------------------------------------------- */
const REAL_CATALOG_BRANDS = [
  { name: "3M", count: 12 },
  { name: "ACA", count: 1 },
  { name: "ADIABATIC", count: 2 },
  { name: "ALIAFOR", count: 13 },
  { name: "BAHCO", count: 11 },
  { name: "BEAR CAT", count: 4 },
  { name: "BELLOTA", count: 7 },
  { name: "BIASSONI", count: 84 },
  { name: "BLACK & DECKER", count: 1 },
  { name: "BLU", count: 3 },
  { name: "BORDER", count: 2 },
  { name: "BOSCH", count: 214 },
  { name: "BTA", count: 57 },
  { name: "CARBORUNDUM", count: 2 },
  { name: "CATANESE", count: 10 },
  { name: "CHERTA", count: 11 },
  { name: "CRAFTSMAN", count: 10 },
  { name: "CROSSMASTER", count: 79 },
  { name: "CUB CADET", count: 1 },
  { name: "DEWALT", count: 22 },
  { name: "DIBRA", count: 4 },
  { name: "DOBLE A", count: 4 },
  { name: "DOLPHIN", count: 4 },
  { name: "DORMER", count: 1 },
  { name: "DOWEN PAGIO", count: 103 },
  { name: "DREMEL", count: 44 },
  { name: "DUCA", count: 17 },
  { name: "DUKE", count: 6 },
  { name: "DUROLL", count: 8 },
  { name: "ECHO", count: 52 },
  { name: "EINHELL", count: 193 },
  { name: "EL CENCERRO", count: 7 },
  { name: "ENERTIK", count: 3 },
  { name: "ESAB", count: 10 },
  { name: "ESLINGAR", count: 4 },
  { name: "EUREKA", count: 1 },
  { name: "EURODRIP", count: 5 },
  { name: "EXPLORER", count: 11 },
  { name: "FASSI", count: 13 },
  { name: "FEMA", count: 34 },
  { name: "FGP", count: 40 },
  { name: "FIASA", count: 37 },
  { name: "FRAMER", count: 3 },
  { name: "FRAVIDA", count: 1 },
  { name: "FREPLAST", count: 14 },
  { name: "GAMMA", count: 9 },
  { name: "GARDENA", count: 159 },
  { name: "GARDEX", count: 47 },
  { name: "GIBER", count: 28 },
  { name: "GREENWORKS", count: 9 },
  { name: "GROWATT", count: 7 },
  { name: "GTM", count: 8 },
  { name: "HI-FLEX", count: 1 },
  { name: "HONDA", count: 74 },
  { name: "HUNTER", count: 75 },
  { name: "HUSQVARNA", count: 193 },
  { name: "INDELPLAS", count: 1 },
  { name: "INVT", count: 2 },
  { name: "IRIMO", count: 18 },
  { name: "ITALIMPIA", count: 6 },
  { name: "KARCHER", count: 7 },
  { name: "KEX", count: 4 },
  { name: "KOHLER", count: 10 },
  { name: "KWB", count: 63 },
  { name: "LAHUEN", count: 4 },
  { name: "LATYN", count: 19 },
  { name: "LIBUS", count: 23 },
  { name: "LOCTITE", count: 1 },
  { name: "LUSQTOFF", count: 43 },
  { name: "MAZAFERRO", count: 8 },
  { name: "METABO", count: 49 },
  { name: "MILWAUKEE", count: 27 },
  { name: "MOURA", count: 12 },
  { name: "NIWA", count: 240 },
  { name: "NUVIS", count: 5 },
  { name: "OLEO MAC", count: 3 },
  { name: "OMBU", count: 9 },
  { name: "OREGON", count: 433 },
  { name: "PAMPA PRO", count: 10 },
  { name: "PATROLL", count: 3 },
  { name: "PEGASO", count: 2 },
  { name: "PERFECTO", count: 1 },
  { name: "PICASSO", count: 34 },
  { name: "PLASTICA ALFA", count: 72 },
  { name: "POLIMEX", count: 126 },
  { name: "POWERCLEAN", count: 3 },
  { name: "RERAR", count: 2 },
  { name: "RIVULIS", count: 5 },
  { name: "SANMARQ", count: 7 },
  { name: "SANOGASS", count: 1 },
  { name: "SEERY", count: 6 },
  { name: "SEGOD", count: 3 },
  { name: "SENNINGER", count: 8 },
  { name: "SENSEI", count: 96 },
  { name: "SENSEI PARTS", count: 109 },
  { name: "SHINDAIWA", count: 3 },
  { name: "SHIZEN", count: 4 },
  { name: "SINCROLAMP", count: 1 },
  { name: "SOCH", count: 4 },
  { name: "STANLEY", count: 53 },
  { name: "SUPER SCRUBBER", count: 2 },
  { name: "SUPER SPEED", count: 22 },
  { name: "TACSA", count: 2 },
  { name: "TECOMEC", count: 2 },
  { name: "TORLETTI", count: 11 },
  { name: "TORO", count: 5 },
  { name: "TORQUE TOOLS", count: 4 },
  { name: "TREBO", count: 19 },
  { name: "TRICOLOR", count: 5 },
  { name: "TROY-BILT", count: 5 },
  { name: "UNIVERSAL", count: 3 },
  { name: "VENTURO", count: 1 },
  { name: "VULCANO", count: 1 }
];

const ALL_BRANDS_103 = REAL_CATALOG_BRANDS.map(b => b.name);

/* --------------------------------------------------------------------------
   0.2. Dynamic Brands Marquee Component (Configurable & Tiendanube-Ready)
   -------------------------------------------------------------------------- */
const MARQUEE_BRANDS_DATA = [
  { name: "BOSCH", logo: "assets/images/brands/bosch.svg", alt: "Bosch Professional" },
  { name: "DEWALT", logo: "assets/images/brands/dewalt.svg", alt: "DeWalt Industrial Tools" },
  { name: "HUSQVARNA", logo: "assets/images/brands/husqvarna.svg", alt: "Husqvarna Maquinaria" },
  { name: "STIHL", logo: "assets/images/brands/stihl.svg", alt: "Stihl Equipos Forestales" },
  { name: "EINHELL", logo: "assets/images/brands/einhell.svg", alt: "Einhell Power X-Change" },
  { name: "HONDA", logo: "assets/images/brands/honda.svg", alt: "Honda Motores & Generadores" },
  { name: "GARDENA", logo: "assets/images/brands/gardena.svg", alt: "Gardena Jardinería & Riego" },
  { name: "NIWA", logo: "assets/images/brands/niwa.svg", alt: "Niwa Maquinarias" },
  { name: "SENSEI", logo: "assets/images/brands/sensei.png", alt: "Sensei Motores & Fuerza" },
  { name: "OREGON", logo: "assets/images/brands/oregon.png", alt: "Oregon Cadenas & Espadas" },
  { name: "DOWEN PAGIO", logo: "assets/images/brands/dowen-pagio.svg", alt: "Dowen Pagio Herramientas" },
  { name: "MAKITA", logo: "assets/images/brands/makita.svg", alt: "Makita Herramientas Eléctricas" },
  { name: "SHINDAIWA", logo: "assets/images/brands/shindaiwa.svg", alt: "Shindaiwa Japón" },
  { name: "BAHCO", logo: "assets/images/brands/bahco.svg", alt: "Bahco Herramientas Manuales" },
  { name: "STANLEY", logo: "assets/images/brands/stanley.svg", alt: "Stanley Tools" },
  { name: "ECHO", logo: "assets/images/brands/echo.svg", alt: "Echo Maquinaria de Poda" },
  { name: "LUSQTOFF", logo: "assets/images/brands/lusqtoff.svg", alt: "Lüsqtoff Soldadura & Fuerza" },
  { name: "HUNTER", logo: "assets/images/brands/hunter.png", alt: "Hunter Irrigation" },
  { name: "METABO", logo: "assets/images/brands/metabo.svg", alt: "Metabo Work. Don't play." },
  { name: "DREMEL", logo: "assets/images/brands/dremel.svg", alt: "Dremel Herramientas Rotativas" },
  { name: "KÄRCHER", logo: "assets/images/brands/karcher.svg", alt: "Kärcher Limpieza Industrial" }
];

function initBrandsMarquee() {
  const marqueeContainers = document.querySelectorAll(".js-brands-marquee, .brands-marquee-container");
  if (!marqueeContainers.length) return;

  marqueeContainers.forEach(container => {
    // 1. Configuración dinámica (velocidad en segundos, dirección)
    const speed = parseInt(container.dataset.speed, 10) || 42;
    const direction = container.dataset.direction || "left";

    // 2. Generación dinámica de tarjetas individuales
    const renderCard = (brand, isAriaHidden = false) => `
      <a href="catalog.html?brand=${encodeURIComponent(brand.name)}" 
         class="brand-marquee-card" 
         title="Explorar productos ${brand.name}" 
         ${isAriaHidden ? 'tabindex="-1" aria-hidden="true"' : ""}>
        <img src="${brand.logo}" alt="${isAriaHidden ? "" : (brand.alt || brand.name)}" loading="lazy">
      </a>
    `;

    const primaryHtml = MARQUEE_BRANDS_DATA.map(b => renderCard(b, false)).join("");
    const duplicateHtml = MARQUEE_BRANDS_DATA.map(b => renderCard(b, true)).join("");

    container.innerHTML = `
      <div class="brands-marquee-track ${direction === "right" ? "marquee-reverse" : ""}" style="--marquee-speed: ${speed}s;">
        <div class="brands-marquee-group">
          ${primaryHtml}
        </div>
        <div class="brands-marquee-group" aria-hidden="true">
          ${duplicateHtml}
        </div>
      </div>
    `;
  });
}

function initBrandsPage() {
  const container = document.getElementById("brandsAlphabetGrid") || document.querySelector(".js-brands-page-grid");
  if (!container) return;

  const searchInput = document.getElementById("brandsPageSearchInput") || document.querySelector(".js-brands-page-search");
  const clearBtn = document.getElementById("brandsPageClearSearch");
  const alphaBtns = document.querySelectorAll(".js-brands-page-alpha-bar .alpha-btn");
  const countPills = document.querySelectorAll(".js-brands-page-count");

  let currentLetter = "ALL";
  let currentSearch = "";

  function renderBrandsDirectory(filterText = "", filterLetter = "ALL") {
    const query = filterText.trim().toLowerCase();
    
    const filtered = REAL_CATALOG_BRANDS.filter(item => {
      const brand = item.name;
      const matchesText = !query || brand.toLowerCase().includes(query);
      const initial = brand.charAt(0).toUpperCase();
      const matchesLetter = 
        (filterLetter === "ALL") || 
        (initial === filterLetter) || 
        (filterLetter === "#" && /\d/.test(initial)) ||
        (filterLetter === "0-9" && /\d/.test(initial));
      return matchesText && matchesLetter;
    });

    // Grouping by letter
    const groups = {};
    filtered.forEach(item => {
      let init = item.name.charAt(0).toUpperCase();
      if (/\d/.test(init)) init = "#";
      if (!groups[init]) groups[init] = [];
      groups[init].push(item);
    });

    const sortedLetters = Object.keys(groups).sort((a, b) => {
      if (a === "#") return -1;
      if (b === "#") return 1;
      return a.localeCompare(b);
    });

    // Update Counter
    countPills.forEach(pill => {
      pill.innerHTML = `<strong>${filtered.length}</strong> marcas disponibles`;
    });

    // Handle Empty State
    if (filtered.length === 0) {
      container.innerHTML = `
        <div class="brands-empty-state">
          <i class="fa-solid fa-circle-exclamation"></i>
          <h4>No encontramos marcas con "${filterText}"</h4>
          <p>Verificá la ortografía o consultá con nuestros especialistas técnicos para cotizar repuestos o equipos a pedido.</p>
          <button type="button" class="btn btn-primary" id="btnResetBrandsFilter">
            <i class="fa-solid fa-rotate-left"></i> Restablecer Directorio Completo
          </button>
        </div>
      `;
      const resetBtn = document.getElementById("btnResetBrandsFilter");
      if (resetBtn) {
        resetBtn.addEventListener("click", () => {
          if (searchInput) searchInput.value = "";
          if (clearBtn) clearBtn.style.display = "none";
          currentSearch = "";
          currentLetter = "ALL";
          alphaBtns.forEach(b => b.classList.remove("active"));
          const allBtn = document.querySelector(".js-brands-page-alpha-bar .alpha-btn[data-letter='ALL']");
          if (allBtn) allBtn.classList.add("active");
          renderBrandsDirectory("", "ALL");
        });
      }
      return;
    }

    // Build Alphabetical Cards HTML
    let html = "";
    sortedLetters.forEach(letter => {
      const brandList = groups[letter];
      html += `
        <div class="brand-group-card" id="brand-group-${letter}">
          <div class="brand-group-card-header">
            <span class="brand-group-letter">${letter}</span>
            <span class="brand-group-count">${brandList.length}</span>
          </div>
          <div class="brand-group-card-body">
      `;

      brandList.forEach(item => {
        html += `
          <a href="catalog.html?brand=${encodeURIComponent(item.name)}" class="brand-directory-item" title="Ver ${item.count} productos de ${item.name} en el catálogo">
            <span class="brand-item-name">${item.name}</span>
            <span class="brand-count-badge">${item.count}</span>
          </a>
        `;
      });

      html += `
          </div>
        </div>
      `;
    });

    container.innerHTML = html;
  }

  // Initial Render
  renderBrandsDirectory("", "ALL");

  // Search Input Handler
  if (searchInput) {
    searchInput.addEventListener("input", (e) => {
      currentSearch = e.target.value;
      if (clearBtn) {
        clearBtn.style.display = currentSearch.length > 0 ? "flex" : "none";
      }
      // Reset active letter to ALL when typing
      alphaBtns.forEach(b => b.classList.remove("active"));
      const allBtn = document.querySelector(".js-brands-page-alpha-bar .alpha-btn[data-letter='ALL']");
      if (allBtn) allBtn.classList.add("active");
      currentLetter = "ALL";

      renderBrandsDirectory(currentSearch, "ALL");
    });
  }

  // Clear Search Button
  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      if (searchInput) {
        searchInput.value = "";
        searchInput.focus();
      }
      clearBtn.style.display = "none";
      currentSearch = "";
      renderBrandsDirectory("", currentLetter);
    });
  }

  // Alphabet Filter Bar Handler
  alphaBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      alphaBtns.forEach(b => b.classList.remove("active"));
      btn.classList.add("active");
      currentLetter = btn.dataset.letter;
      renderBrandsDirectory(currentSearch, currentLetter);
    });
  });
}

/* --------------------------------------------------------------------------
   0.2. Dedicated Hierarchical Categories Page Engine: Master-Detail Architecture
   -------------------------------------------------------------------------- */
function initCategoriesPage() {
  const sectionContainer = document.getElementById("directorioCategorias") || document.querySelector(".categories-directory-section");
  const sidebarNav = document.getElementById("categoriesMasterNavList");
  const detailHero = document.getElementById("categoryDetailHero");
  const detailSubgrid = document.getElementById("categoryDetailSubgrid");

  // Fallback check: if elements don't exist, exit
  if (!sidebarNav && !detailSubgrid) return;

  const categoriesTree = (typeof window !== 'undefined' && window.REAL_CATEGORIES_TREE && window.REAL_CATEGORIES_TREE.length > 0)
    ? window.REAL_CATEGORIES_TREE
    : (typeof REAL_CATEGORIES_TREE !== 'undefined' && REAL_CATEGORIES_TREE.length > 0 ? REAL_CATEGORIES_TREE : REAL_STORE_CATEGORIES);
  if (!categoriesTree || categoriesTree.length === 0) return;

  const searchInput = document.getElementById("categoriesPageSearchInput") || document.querySelector(".js-categories-page-search");
  const clearBtn = document.getElementById("categoriesPageClearSearch");
  const sidebarCountBadge = document.getElementById("categoriesSidebarCount");
  const countPills = document.querySelectorAll(".js-categories-page-count");
  const mobileBackBtn = document.getElementById("btnMobileBackToRubros");

  // Sort master categories tree alphabetically (A-Z)
  const sortedCategories = [...categoriesTree].sort((a, b) => 
    (a.displayName || a.name).localeCompare(b.displayName || b.name, 'es')
  );

  // Expanded subcategories tracker for progressive disclosure (Level 3)
  const expandedSubcategories = new Set();

  // State
  let activeCatId = sortedCategories[0]?.id || "agua";
  let searchQuery = "";

  // Check URL query parameters and hash
  const urlParams = new URLSearchParams(window.location.search);
  const initialCat = urlParams.get('cat') || urlParams.get('category') || (window.location.hash ? window.location.hash.replace('#', '').replace('cat-', '') : null);
  const initialQuery = urlParams.get('search') || urlParams.get('q');

  if (initialCat) {
    const exists = sortedCategories.find(c => c.id.toLowerCase() === initialCat.toLowerCase());
    if (exists) {
      activeCatId = exists.id;
      // On mobile, if a specific category was linked, switch directly to detail step
      if (sectionContainer) {
        sectionContainer.classList.remove("mobile-step-categories");
        sectionContainer.classList.add("mobile-step-detail");
      }
    }
  }

  if (initialQuery && searchInput) {
    searchInput.value = initialQuery;
    searchQuery = initialQuery.trim();
    if (clearBtn) clearBtn.style.display = "flex";
  }

  // Text highlighter helper
  function highlightMatches(text, query) {
    if (!query || !text) return text || "";
    const escaped = query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const regex = new RegExp(`(${escaped})`, 'gi');
    return text.replace(regex, '<mark class="search-highlight">$1</mark>');
  }

  // Render Master Sidebar
  function renderMasterSidebar() {
    if (!sidebarNav) return;
    const query = searchQuery.toLowerCase();

    let matchingCategories = sortedCategories;
    if (query) {
      matchingCategories = sortedCategories.filter(cat => {
        const catNameMatches = cat.name.toLowerCase().includes(query) || 
          (cat.displayName && cat.displayName.toLowerCase().includes(query)) || 
          (cat.description && cat.description.toLowerCase().includes(query));
        if (catNameMatches) return true;

        // Check if any subcategory or sub-subcategory matches
        return (cat.subcategories || []).some(sub => {
          if (sub.name.toLowerCase().includes(query) || (sub.displayName && sub.displayName.toLowerCase().includes(query))) return true;
          return (sub.subsubcategories || []).some(sss => sss.name.toLowerCase().includes(query));
        });
      });
    }

    if (sidebarCountBadge) {
      sidebarCountBadge.textContent = matchingCategories.length;
    }

    let navHtml = "";
    if (matchingCategories.length === 0) {
      navHtml = `
        <div style="padding: 16px 12px; font-size: 0.82rem; color: #888; text-align: center;">
          Sin coincidencias en rubros
        </div>
      `;
    } else {
      matchingCategories.forEach(cat => {
        const isActive = (!query && cat.id === activeCatId) ? " active" : "";
        navHtml += `
          <button type="button" class="master-nav-item${isActive}" data-cat-id="${cat.id}">
            <span class="master-nav-name">${highlightMatches(cat.displayName || cat.name, searchQuery)}</span>
            <span class="master-nav-badge">${cat.count.toLocaleString('es-AR')}</span>
            <i class="fa-solid fa-chevron-right master-nav-arrow"></i>
          </button>
        `;
      });
    }

    sidebarNav.innerHTML = navHtml;

    // Attach click listeners to sidebar items
    const navItems = sidebarNav.querySelectorAll(".master-nav-item");
    navItems.forEach(item => {
      item.addEventListener("click", () => {
        const catId = item.dataset.catId;
        if (!catId) return;

        activeCatId = catId;

        // If user was searching, clear search to view selected category
        if (searchQuery) {
          searchQuery = "";
          if (searchInput) searchInput.value = "";
          if (clearBtn) clearBtn.style.display = "none";
        }

        // Update URL state silently without full page reload
        try {
          const newUrl = new URL(window.location);
          newUrl.searchParams.set('cat', activeCatId);
          newUrl.searchParams.delete('q');
          newUrl.searchParams.delete('search');
          window.history.replaceState(null, '', newUrl.toString());
        } catch (e) {}

        // Re-render
        renderMasterSidebar();
        renderDetailPanel();

        // Switch to detail view on mobile
        if (sectionContainer) {
          sectionContainer.classList.remove("mobile-step-categories");
          sectionContainer.classList.add("mobile-step-detail");
        }

        // Smooth scroll to top of detail panel on mobile
        if (window.innerWidth <= 992 && detailHero) {
          detailHero.scrollIntoView({ behavior: "smooth", block: "start" });
        }
      });
    });
  }

  // Render Detail Panel
  function renderDetailPanel() {
    if (!detailHero || !detailSubgrid) return;
    const query = searchQuery.toLowerCase();

    // MODE 1: Search active across directory
    if (query) {
      renderSearchResults(query);
      return;
    }

    // MODE 2: Master-Detail view for activeCatId
    const currentCat = sortedCategories.find(c => c.id === activeCatId) || sortedCategories[0];
    if (!currentCat) return;

    // 1. Hero / Header
    const subcats = (currentCat.subcategories || []).slice().sort((a, b) => 
      (a.displayName || a.name).localeCompare(b.displayName || b.name, 'es')
    );

    detailHero.innerHTML = `
      <div class="category-detail-hero-header">
        <div style="flex-grow: 1;">
          <h2 class="category-detail-hero-title">${currentCat.displayName || currentCat.name}</h2>
          <p class="category-detail-hero-desc">${currentCat.description || 'Catálogo industrial de repuestos y equipos especializados.'}</p>
        </div>
      </div>
      <div class="category-detail-hero-meta">
        <div class="category-detail-hero-pills">
          <span class="hero-pill">${subcats.length} subcategorías</span>
          <span class="hero-pill hero-pill-highlight">${currentCat.count.toLocaleString('es-AR')} productos disponibles</span>
        </div>
        <a href="catalog.html?category=${currentCat.id}" class="btn btn-outline btn-sm btn-detail-full-catalog" title="Explorar todos los productos de ${currentCat.displayName || currentCat.name}">
          Ver catálogo completo <i class="fa-solid fa-arrow-right"></i>
        </a>
      </div>
    `;

    // 2. Subcategories Grid with Progressive Disclosure
    let subgridHtml = "";
    subcats.forEach(sub => {
      const subKey = `${currentCat.id}__${sub.slug || sub.name}`;
      const isExpanded = expandedSubcategories.has(subKey);

      const subsubsList = (sub.subsubcategories || []).slice().sort((a, b) => 
        a.name.localeCompare(b.name, 'es')
      );

      const totalItems = subsubsList.length;
      const visibleItems = (totalItems <= 5 || isExpanded) ? subsubsList : subsubsList.slice(0, 5);

      let itemsHtml = "";
      if (visibleItems.length > 0) {
        itemsHtml = `
          <div class="detail-subsub-list">
            ${visibleItems.map(item => `
              <a href="catalog.html?q=${encodeURIComponent(item.name)}" class="detail-subsub-item" title="Ver ${item.count} productos de ${item.name}">
                <span class="detail-subsub-name">${item.name}</span>
                <span class="detail-subsub-count">${item.count}</span>
              </a>
            `).join('')}
          </div>
        `;
      } else {
        itemsHtml = `
          <div style="padding: 10px 8px; font-size: 0.80rem; color: #888;">
            Productos de catálogo general
          </div>
        `;
      }

      let expandBtnHtml = "";
      if (totalItems > 5) {
        if (!isExpanded) {
          const remaining = totalItems - 5;
          expandBtnHtml = `
            <button type="button" class="btn-expand-subsubs js-expand-subsubs" data-sub-key="${subKey}">
              <span>+ Ver ${remaining} familias más</span>
              <i class="fa-solid fa-chevron-down"></i>
            </button>
          `;
        } else {
          expandBtnHtml = `
            <button type="button" class="btn-expand-subsubs js-expand-subsubs" data-sub-key="${subKey}">
              <span>- Ver menos</span>
              <i class="fa-solid fa-chevron-up"></i>
            </button>
          `;
        }
      }

      subgridHtml += `
        <div class="detail-sub-card">
          <div class="detail-sub-card-header">
            <div class="detail-sub-card-title-group">
              <a href="catalog.html?q=${encodeURIComponent(sub.name)}" class="detail-sub-card-title" title="Ver productos de ${sub.displayName || sub.name}">
                ${sub.displayName || sub.name}
              </a>
            </div>
            <span class="detail-sub-card-count">${sub.count} prod.</span>
          </div>
          <div class="detail-sub-card-body">
            ${itemsHtml}
            ${expandBtnHtml}
          </div>
        </div>
      `;
    });

    detailSubgrid.innerHTML = subgridHtml;

    // Update global counters
    const totalInitialProducts = sortedCategories.reduce((sum, c) => sum + (c.count || 0), 0);
    countPills.forEach(pill => {
      pill.innerHTML = `<strong>${sortedCategories.length}</strong> rubros • <strong>${totalInitialProducts.toLocaleString('es-AR')}</strong> productos`;
    });
  }

  // Render Global Search Results
  function renderSearchResults(query) {
    const matchedCards = [];
    let totalMatches = 0;

    sortedCategories.forEach(cat => {
      const catMatches = cat.name.toLowerCase().includes(query) || 
        (cat.displayName && cat.displayName.toLowerCase().includes(query)) || 
        (cat.description && cat.description.toLowerCase().includes(query));

      const subcats = cat.subcategories || [];
      subcats.forEach(sub => {
        const subMatches = sub.name.toLowerCase().includes(query) || 
          (sub.displayName && sub.displayName.toLowerCase().includes(query));

        const matchedSubsubs = [];
        const allSubsubs = sub.subsubcategories || [];
        allSubsubs.forEach(sss => {
          if (sss.name.toLowerCase().includes(query) || catMatches || subMatches) {
            matchedSubsubs.push(sss);
          }
        });

        if (catMatches || subMatches || matchedSubsubs.length > 0) {
          matchedCards.push({
            catId: cat.id,
            catName: cat.displayName || cat.name,
            subName: sub.displayName || sub.name,
            subCount: sub.count,
            items: matchedSubsubs.length > 0 ? matchedSubsubs : allSubsubs
          });
          totalMatches += sub.count;
        }
      });
    });

    // Empty state
    if (matchedCards.length === 0) {
      detailHero.innerHTML = `
        <div class="search-results-hero">
          <div>
            <h3 class="search-results-hero-title">Búsqueda: "${searchQuery}"</h3>
            <p style="margin: 4px 0 0 0; font-size: 0.85rem; color: #666;">Sin coincidencias en categorías ni familias de repuestos.</p>
          </div>
          <button type="button" class="btn btn-outline btn-sm" id="btnResetSearchHero">
            <i class="fa-solid fa-rotate-left"></i> Restablecer Búsqueda
          </button>
        </div>
      `;
      detailSubgrid.innerHTML = `
        <div class="brands-empty-state" style="grid-column: 1 / -1; background: #fff; border: 1px solid var(--color-gray-border); border-radius: var(--radius-md); padding: 40px 20px; text-align: center;">
          <i class="fa-solid fa-circle-exclamation" style="font-size: 2.2rem; color: #aaa; margin-bottom: 12px;"></i>
          <h4 style="margin-bottom: 8px;">No encontramos coincidencias para "${searchQuery}"</h4>
          <p style="font-size: 0.88rem; color: #666; max-width: 480px; margin: 0 auto 20px auto;">
            Revisá la ortografía o consultá directamente con nuestros asesores comerciales para cotizar repuestos o equipos a pedido.
          </p>
          <button type="button" class="btn btn-primary btn-sm" id="btnResetSearchAction">
            <i class="fa-solid fa-layer-group"></i> Ver todos los rubros
          </button>
        </div>
      `;

      const resetBtns = [document.getElementById("btnResetSearchHero"), document.getElementById("btnResetSearchAction")];
      resetBtns.forEach(btn => {
        if (btn) {
          btn.addEventListener("click", () => {
            searchQuery = "";
            if (searchInput) searchInput.value = "";
            if (clearBtn) clearBtn.style.display = "none";
            renderMasterSidebar();
            renderDetailPanel();
          });
        }
      });
      return;
    }

    // Hero with search results
    detailHero.innerHTML = `
      <div class="search-results-hero">
        <div>
          <h3 class="search-results-hero-title">Resultados para "${highlightMatches(searchQuery, searchQuery)}"</h3>
          <p style="margin: 4px 0 0 0; font-size: 0.88rem; color: #666;">Mostrando ${matchedCards.length} subcategorías que coinciden con tu búsqueda técnica.</p>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
          <span class="search-results-badge">${matchedCards.length} grupos</span>
          <button type="button" class="btn btn-outline btn-sm" id="btnResetSearchHero">
            <i class="fa-solid fa-xmark"></i> Limpiar
          </button>
        </div>
      </div>
    `;

    const heroReset = document.getElementById("btnResetSearchHero");
    if (heroReset) {
      heroReset.addEventListener("click", () => {
        searchQuery = "";
        if (searchInput) searchInput.value = "";
        if (clearBtn) clearBtn.style.display = "none";
        renderMasterSidebar();
        renderDetailPanel();
      });
    }

    // Subgrid with matched cards
    let subgridHtml = "";
    matchedCards.forEach(card => {
      const items = card.items.slice(0, 8);
      subgridHtml += `
        <div class="detail-sub-card">
          <div class="detail-sub-card-header">
            <div class="detail-sub-card-title-group">
              <span class="detail-sub-card-category-tag">${card.catName}</span>
              <a href="catalog.html?q=${encodeURIComponent(card.subName)}" class="detail-sub-card-title" title="Ver ${card.subName}">
                ${highlightMatches(card.subName, searchQuery)}
              </a>
            </div>
            <span class="detail-sub-card-count">${card.subCount} prod.</span>
          </div>
          <div class="detail-sub-card-body">
            <div class="detail-subsub-list">
              ${items.map(item => `
                <a href="catalog.html?q=${encodeURIComponent(item.name)}" class="detail-subsub-item" title="Ver ${item.name}">
                  <span class="detail-subsub-name">${highlightMatches(item.name, searchQuery)}</span>
                  <span class="detail-subsub-count">${item.count}</span>
                </a>
              `).join('')}
            </div>
            ${card.items.length > 8 ? `
              <a href="catalog.html?q=${encodeURIComponent(card.subName)}" class="btn-expand-subsubs" style="text-decoration: none;">
                <span>Ver ${card.items.length - 8} repuestos más en catálogo →</span>
              </a>
            ` : ''}
          </div>
        </div>
      `;
    });

    detailSubgrid.innerHTML = subgridHtml;

    // Update counters
    countPills.forEach(pill => {
      pill.innerHTML = `<strong>${matchedCards.length}</strong> subcategorías • <strong>${totalMatches.toLocaleString('es-AR')}</strong> productos`;
    });
  }

  // Delegation: Progressive disclosure toggle
  if (detailSubgrid) {
    detailSubgrid.addEventListener("click", (e) => {
      const btn = e.target.closest(".js-expand-subsubs");
      if (!btn) return;

      const subKey = btn.dataset.subKey;
      if (!subKey) return;

      if (expandedSubcategories.has(subKey)) {
        expandedSubcategories.delete(subKey);
      } else {
        expandedSubcategories.add(subKey);
      }

      renderDetailPanel();
    });
  }

  // Mobile Back to Categories (Step 2 -> Step 1)
  if (mobileBackBtn) {
    mobileBackBtn.addEventListener("click", () => {
      if (sectionContainer) {
        sectionContainer.classList.remove("mobile-step-detail");
        sectionContainer.classList.add("mobile-step-categories");
        sectionContainer.scrollIntoView({ behavior: "smooth", block: "start" });
      }
    });
  }

  // Search Input Handler
  if (searchInput) {
    searchInput.addEventListener("input", (e) => {
      searchQuery = e.target.value.trim();
      if (clearBtn) {
        clearBtn.style.display = searchQuery.length > 0 ? "flex" : "none";
      }

      renderMasterSidebar();
      renderDetailPanel();

      // On mobile: if searching and user enters text, show the detail panel with results
      if (searchQuery.length >= 2 && window.innerWidth <= 992 && sectionContainer) {
        sectionContainer.classList.remove("mobile-step-categories");
        sectionContainer.classList.add("mobile-step-detail");
      }
    });
  }

  // Clear Search Button
  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      if (searchInput) {
        searchInput.value = "";
        searchInput.focus();
      }
      clearBtn.style.display = "none";
      searchQuery = "";
      renderMasterSidebar();
      renderDetailPanel();
    });
  }

  // Initial Execution
  renderMasterSidebar();
  renderDetailPanel();
}

/* --------------------------------------------------------------------------
   1. Master Product Database
   -------------------------------------------------------------------------- */
const PRODUCT_CATALOG = [
  {
    id: 1,
    sku: "HMC-BOM-050",
    name: "Bomba Centrífuga Niwa WENW-50C 0.5 HP 16m - 4.2 m³/h 1\"",
    category: "agua-bombeo",
    categoryName: "Agua",
    subCategory: "Bombas Centrífugas",
    brand: "NIWA",
    price: 145000,
    oldPrice: 169000,
    discount: 14,
    image: "assets/images/products/prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp",
    gallery: [
      "assets/images/products/prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp",
      "assets/images/products/prod-01-bomba-centrifuga-niwa-wenw50c-specs.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 14,
    tab: "bestsellers",
    rating: 4.9,
    reviewsCount: 18,
    desc: "Bomba centrífuga monobloc de alta eficiencia diseñada para elevación y trasvase de agua limpia en instalaciones domiciliarias, edificios, quintas y sistemas de riego. Cuerpo de hierro fundido con tratamiento anticorrosivo, impulsor de latón/noryl balanceado dinámicamente y protector térmico con autoreseteo.",
    specs: [
      { label: "Potencia del Motor", val: "0.5 HP (370 Watts)" },
      { label: "Caudal Máximo", val: "4.200 Litros/hora (70 L/min)" },
      { label: "Altura Máxima de Elevación", val: "16 metros" },
      { label: "Bocas de Entrada / Salida", val: "1 pulgada (1\" BSP)" },
      { label: "Voltaje / Frecuencia", val: "220V - 50 Hz Monofásica" },
      { label: "Bobinado del Motor", val: "100% Cobre con aislación Clase F" },
      { label: "Garantía Oficial", val: "12 meses con servicio técnico oficial HMC" }
    ],
    applications: "Elevación de agua desde cisternas a tanques elevados, presurización domiciliaria, alimentación de calderas y riego por aspersión."
  },
  {
    id: 2,
    sku: "HMC-DIS-115",
    name: "Disco de Corte Bosch Expert Carbide Multi Wheel 4 1/2\" (115 mm)",
    category: "accesorios-insumos",
    categoryName: "Consumibles e Insumos",
    subCategory: "Discos Corte y Abrasivos",
    brand: "BOSCH",
    price: 18500,
    oldPrice: 22000,
    discount: 16,
    image: "assets/images/products/prod-02-disco-corte-bosch-carbide-multiwheel-principal.webp",
    gallery: [
      "assets/images/products/prod-02-disco-corte-bosch-carbide-multiwheel-principal.webp"
    ],
    inStock: true,
    freeShipping: false,
    discount: 16,
    tab: "bestsellers",
    rating: 5.0,
    reviewsCount: 47,
    desc: "Disco de corte con tecnología Carbide Multi Wheel que transforma cualquier amoladora angular convencional en una herramienta de corte universal multi-material. Borde de corte con grano de carburo de tungsteno fusionado por láser para cortes limpios, rápidos y seguros sin atascos ni roturas.",
    specs: [
      { label: "Diámetro Exterior", val: "115 mm (4 1/2 pulgadas)" },
      { label: "Diámetro de Buje", val: "22.23 mm (estándar amoladoras)" },
      { label: "Espesor de Corte", val: "1.0 mm ultra delgado" },
      { label: "Tecnología", val: "Carbide Grain Laser Melting Bosch" },
      { label: "Velocidad Máxima", val: "13.300 RPM (80 m/s)" },
      { label: "Línea", val: "Bosch Expert Professional" }
    ],
    applications: "Corte rápido en madera blanda/dura, madera con clavos y tornillos incrustados, plásticos, caños de PVC, placas de yeso (Durlock) y fibra de vidrio."
  },
  {
    id: 3,
    sku: "HMC-DEM-150",
    name: "Martillo Demoledor Bosch GSH 11 E Professional 1500W SDS Max (16.8J)",
    category: "ferreteria",
    categoryName: "Ferretería",
    subCategory: "Martillo Demoledor",
    brand: "BOSCH",
    price: 980000,
    oldPrice: 1150000,
    discount: 15,
    image: "assets/images/products/prod-03-martillo-demoledor-bosch-gsh11e-principal.webp",
    gallery: [
      "assets/images/products/prod-03-martillo-demoledor-bosch-gsh11e-principal.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "heavy",
    rating: 5.0,
    reviewsCount: 31,
    desc: "El referente indiscutido para demoliciones exigentes en pared y suelo. Potencia de impacto extrema de 16.8 Joules con encastre SDS Max y sistema Constant Electronic para mantener el rendimiento invariable incluso bajo carga extrema. Empuñadura auxiliar orientable 360°.",
    specs: [
      { label: "Potencia Absorbida", val: "1500 Watts (220V - 50Hz)" },
      { label: "Energía de Impacto", val: "16.8 Joules (Norma EPTA)" },
      { label: "Número de Impactos", val: "900 - 1.890 IPM regulables" },
      { label: "Portaherramientas", val: "SDS Max con ajuste de cincel en 12 posiciones (Vario-Lock)" },
      { label: "Peso en Seco", val: "10.1 kg" },
      { label: "Incluye", val: "Maletín de transporte reforzado, empuñadura recta y cincel de punta" },
      { label: "Garantía Oficial", val: "24 meses Bosch Heavy Duty Oficial" }
    ],
    applications: "Demolición estructural pesada, apertura de vanos en hormigón armado, rotura de mampostería gruesa y cincelado de zanjas en obra civil."
  },
  {
    id: 4,
    sku: "HMC-LIJ-120",
    name: "Discos de Lija Bosch Expert C470 125mm Grano 120 (Pack 50 piezas)",
    category: "accesorios-insumos",
    categoryName: "Consumibles e Insumos",
    subCategory: "Discos Corte y Abrasivos",
    brand: "BOSCH",
    price: 32500,
    oldPrice: 38000,
    discount: 14,
    image: "assets/images/products/prod-04-disco-lija-bosch-expert-c470-principal.webp",
    gallery: [
      "assets/images/products/prod-04-disco-lija-bosch-expert-c470-principal.webp"
    ],
    inStock: true,
    freeShipping: false,
    discount: 14,
    tab: "new",
    rating: 4.8,
    reviewsCount: 19,
    desc: "Hojas de lija autoadherentes de velocidad superior con recubrimiento anti-empaste de estearato de calcio que previene la acumulación de polvo. Patrón de 8 perforaciones universales para aspiración directa en lijadoras excéntricas y rotorbitales de 125 mm.",
    specs: [
      { label: "Diámetro", val: "125 mm (5 pulgadas)" },
      { label: "Granulometría", val: "Grano 120 (Óxido de aluminio electrostático)" },
      { label: "Perforación", val: "8 orificios para extracción de polvo" },
      { label: "Sistema de Fijación", val: "Velcro / Hook & Loop de alta adherencia" },
      { label: "Presentación", val: "Caja sellada por 50 unidades" },
      { label: "Rendimiento", val: "Hasta 2x más remoción que lijas estándar" }
    ],
    applications: "Lijado fino y preparación de superficies en madera dura/blanda, masillas de pintor, primers automotrices, pinturas, lacas y resinas."
  },
  {
    id: 5,
    sku: "HMC-SIE-235",
    name: "Sierra Circular Bosch GKS 235 9 1/4\" 2200W 5000 RPM Heavy Duty",
    category: "ferreteria",
    categoryName: "Ferretería",
    subCategory: "Sierras",
    brand: "BOSCH",
    price: 389000,
    oldPrice: 445000,
    discount: 13,
    image: "assets/images/products/prod-05-sierra-circular-bosch-gks235-principal.webp",
    gallery: [
      "assets/images/products/prod-05-sierra-circular-bosch-gks235-principal.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 13,
    tab: "heavy",
    rating: 4.9,
    reviewsCount: 24,
    desc: "La sierra circular de mano más potente del mercado profesional con motor de 2200W para cortes profundos y exigentes en maderas duras y húmedas. Placa base de acero estampado con doble fijación angular para cortes a bisel precisos y salida de viruta dirigida.",
    specs: [
      { label: "Potencia del Motor", val: "2200 Watts (220V)" },
      { label: "Diámetro del Disco", val: "235 mm (9 1/4 pulgadas)" },
      { label: "Velocidad en Vacío", val: "5.000 RPM" },
      { label: "Profundidad de Corte a 90°", val: "85 mm" },
      { label: "Profundidad de Corte a 45°", val: "65 mm" },
      { label: "Peso", val: "7.6 kg" },
      { label: "Garantía Oficial", val: "24 meses Bosch Professional" }
    ],
    applications: "Corte longitudinal y transversal de tirantes, vigas estructurales de madera dura, encofrados, tableros fenólicos y carpintería de obra pesada."
  },
  {
    id: 6,
    sku: "HMC-DEM-035",
    name: "Martillo Demoledor DeWalt D25960-AR 35 Joules 1600W Encastre 28mm",
    category: "construccion",
    categoryName: "Construcción",
    subCategory: "Martillo Demoledor",
    brand: "DEWALT",
    price: 1420000,
    oldPrice: 1650000,
    discount: 14,
    image: "assets/images/products/prod-06-martillo-demoledor-dewalt-d25960-principal.webp",
    gallery: [
      "assets/images/products/prod-06-martillo-demoledor-dewalt-d25960-principal.webp",
      "assets/images/products/prod-06-martillo-demoledor-dewalt-d25960-secundaria.webp",
      "assets/images/products/prod-06-martillo-demoledor-dewalt-d25960-tercera.webp",
      "assets/images/products/prod-06-martillo-demoledor-dewalt-d25960-cuarta.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 14,
    tab: "heavy",
    rating: 5.0,
    reviewsCount: 38,
    desc: "Demoledor de pavimentos de alto rendimiento con impacto demoledor de 35 Joules. Incorpora el sistema patentado SHOCKS Active Vibration Control que reduce las vibraciones en los manillares a menos de 6.8 m/s², maximizando el confort y la productividad diaria del operario.",
    specs: [
      { label: "Potencia del Motor", val: "1600 Watts (220V - 50Hz)" },
      { label: "Energía de Impacto", val: "35 Joules (Norma EPTA 05/2009)" },
      { label: "Frecuencia de Impacto", val: "1.450 IPM" },
      { label: "Encastre de Cincel", val: "Hexagonal de 28 mm (1-1/8\" con traba de resorte)" },
      { label: "Control de Vibración", val: "SHOCKS Active Vibration Control" },
      { label: "Peso Operativo", val: "18.4 kg" },
      { label: "Garantía Oficial", val: "36 meses DeWalt Oficial + 1 año de mantenimiento sin cargo" }
    ],
    applications: "Rotura de losas de hormigón armado, rotura de pavimentos asfálticos y pistas, zanjeo de cimientos, pilotajes y demoliciones viales."
  },
  {
    id: 7,
    sku: "HMC-TAL-018",
    name: "Taladro Percutor Inalámbrico Einhell TE-CD 18/44 Li-i (1x2.5Ah PXC)",
    category: "herramientas-bateria",
    categoryName: "Herramientas a Batería",
    subCategory: "Taladros",
    brand: "EINHELL",
    price: 168000,
    oldPrice: 198000,
    discount: 15,
    image: "assets/images/products/prod-07-taladro-impacto-einhell-te-cd18-principal.webp",
    gallery: [
      "assets/images/products/prod-07-taladro-impacto-einhell-te-cd18-principal.webp",
      "assets/images/products/prod-07-taladro-impacto-einhell-te-cd18-secundaria.webp",
      "assets/images/products/prod-07-taladro-impacto-einhell-te-cd18-specs.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "new",
    rating: 4.9,
    reviewsCount: 29,
    desc: "Taladro atornillador percutor a batería del ecosistema Power X-Change. Caja de engranajes metálica robusta de 2 velocidades, mandril metálico autoajustable de 13 mm monomando con bloqueo automático del husillo, luz de trabajo LED y embrague con 20 niveles de torque.",
    specs: [
      { label: "Batería Incluida", val: "18V Li-Ion Power X-Change de 2.5 Ah + Cargador Rápido" },
      { label: "Torque Máximo", val: "44 Nm (Ajuste de 20+1+1 niveles)" },
      { label: "Velocidad 1 / 2", val: "0-350 / 0-1.250 RPM" },
      { label: "Tasa de Percusión", val: "0-18.750 IPM" },
      { label: "Mandril", val: "13 mm metálico de cierre rápido (Quick-Lock)" },
      { label: "Tecnología", val: "Motor optimizado con control electrónico de velocidad" },
      { label: "Garantía Oficial", val: "24 meses garantía oficial Einhell Germany" }
    ],
    applications: "Perforación con percusión en mampostería y ladrillo; atornillado de precisión en perfiles de acero, carpintería en madera y montajes en seco."
  },
  {
    id: 8,
    sku: "HMC-TAL-850",
    name: "Taladro de Percusión Bosch GSB 16 RE Professional 850W Mandril 13mm",
    category: "construccion",
    categoryName: "Construcción",
    subCategory: "Taladros y Rotopercutores",
    brand: "BOSCH",
    price: 178000,
    oldPrice: 210000,
    discount: 15,
    image: "assets/images/products/prod-08-taladro-percusion-bosch-gsb16re-principal.webp",
    gallery: [
      "assets/images/products/prod-08-taladro-percusion-bosch-gsb16re-principal.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "bestsellers",
    rating: 4.9,
    reviewsCount: 52,
    desc: "El taladro percutor profesional más resistente y confiable de la línea Bosch. Carcasa de engranajes metálica tipo olla para máxima durabilidad, rueda selectora de velocidad electrónica preajustable, placa de escobillas giratoria para idéntica potencia en giro reversible y empuñadura ergonómica Softgrip.",
    specs: [
      { label: "Potencia del Motor", val: "850 Watts (220V)" },
      { label: "Velocidad de Giro", val: "0 a 2.800 RPM (Variable y reversible)" },
      { label: "Impactos por Minuto", val: "0 a 47.600 IPM" },
      { label: "Mandril", val: "13 mm (1/2\") de corona dentada con llave" },
      { label: "Capacidad Perforación", val: "Hormigón 16 mm | Mampostería 18 mm | Acero 13 mm | Madera 30 mm" },
      { label: "Peso", val: "2.0 kg ultra compacto" },
      { label: "Garantía Oficial", val: "24 meses Bosch Heavy Duty" }
    ],
    applications: "Instalaciones eléctricas y sanitarias en obra, fijaciones de anclajes en hormigón/ladrillo, herrería de obra y trabajos de mantenimiento general."
  },
  {
    id: 9,
    sku: "HMC-ING-170",
    name: "Sierra Ingletadora Bosch GCM 10 X Professional 1700W 4800 RPM Disco 10\"",
    category: "ferreteria",
    categoryName: "Ferretería",
    subCategory: "Sierras",
    brand: "BOSCH",
    price: 745000,
    oldPrice: 860000,
    discount: 13,
    image: "assets/images/products/prod-09-sierra-ingletadora-bosch-gcm10x-principal.webp",
    gallery: [
      "assets/images/products/prod-09-sierra-ingletadora-bosch-gcm10x-principal.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 13,
    tab: "heavy",
    rating: 5.0,
    reviewsCount: 22,
    desc: "Sierra ingletadora de precisión profesional con motor de 1700W y disco de corte de 10 pulgadas. Mesa de fundición de aluminio rectificada con topes angulares predefinidos en los ángulos más utilizados (0°, 15°, 22.5°, 31.6°, 45°), prensa de fijación vertical y freno de motor de seguridad.",
    specs: [
      { label: "Potencia del Motor", val: "1700 Watts (220V - 50Hz)" },
      { label: "Velocidad de Giro", val: "4.800 RPM" },
      { label: "Diámetro de Hoja de Sierra", val: "254 mm (10 pulgadas) x Buje 25.4/30 mm" },
      { label: "Capacidad de Corte a 0°/0°", val: "89 x 89 mm / 60 x 130 mm" },
      { label: "Capacidad a Inglete 45°", val: "89 x 67 mm / 60 x 95 mm" },
      { label: "Peso", val: "14.1 kg" },
      { label: "Garantía Oficial", val: "24 meses Bosch Professional" }
    ],
    applications: "Corte ingleteado y biselado de alta precisión en molduras, zócalos, machimbre, tirantes de madera, perfiles de aluminio y carpintería de diseño."
  },
  {
    id: 10,
    sku: "HMC-MEC-081",
    name: "Broca Mecha SDS Plus-1 Bosch 8 x 160 mm para Hormigón y Mampostería",
    category: "accesorios-insumos",
    categoryName: "Consumibles e Insumos",
    subCategory: "Mechas",
    brand: "BOSCH",
    price: 7800,
    oldPrice: 9200,
    discount: 15,
    image: "assets/images/products/prod-10-mecha-sds-plus-bosch-8x160-principal.webp",
    gallery: [
      "assets/images/products/prod-10-mecha-sds-plus-bosch-8x160-principal.webp"
    ],
    inStock: true,
    freeShipping: false,
    discount: 15,
    tab: "new",
    rating: 4.9,
    reviewsCount: 64,
    desc: "Broca helicoidal con espiral de 2 aristas en forma de U que garantiza una rápida evacuación del polvo de perforación evitando recalentamientos. Punta centradora de carburo de tungsteno con 2 filos soldada con tecnología AWB para máxima resistencia en hormigón armado.",
    specs: [
      { label: "Diámetro de Perforación", val: "8 mm" },
      { label: "Longitud Útil de Trabajo", val: "100 mm" },
      { label: "Longitud Total", val: "160 mm" },
      { label: "Tipo de Encastre", val: "SDS Plus normalizado" },
      { label: "Material de la Punta", val: "Carburo de tungsteno grado construcción" },
      { label: "Diseño Helicoidal", val: "Doble espiral en U de baja fricción" }
    ],
    applications: "Perforación rápida y limpia para colocación de tarugos y fijaciones en hormigón armado, ladrillo macizo, bloque cerámico, piedra y revoques."
  },
  {
    id: 11,
    sku: "HMC-MOT-530",
    name: "Motoguadaña Profesional Shindaiwa B530 INTL 53.2cc 2T Eje Recto",
    category: "maquinas-explosion",
    categoryName: "Máquinas a Explosión",
    subCategory: "Desmalezadoras",
    brand: "SHINDAIWA",
    price: 840000,
    oldPrice: 960000,
    discount: 12,
    image: "assets/images/products/prod-11-motoguadana-shindaiwa-b530-principal.webp",
    gallery: [
      "assets/images/products/prod-11-motoguadana-shindaiwa-b530-principal.webp",
      "assets/images/products/prod-11-motoguadana-shindaiwa-b530-specs.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 12,
    tab: "heavy",
    rating: 5.0,
    reviewsCount: 27,
    desc: "La legendaria desmalezadora japonesa de alta gama reconocida mundialmente por su durabilidad indestructible y potencia en condiciones extremas. Motor de 53.2cc 2T de alto torque, eje de transmisión cardánico macizo de 8mm montado sobre rulemanes dobles y arnés profesional ergonómico acolchado de 4 puntos.",
    specs: [
      { label: "Cilindrada del Motor", val: "53.2 cc (Motor 2 Tiempos Japones)" },
      { label: "Potencia Máxima", val: "3.2 HP / 2.4 kW a 8.500 RPM" },
      { label: "Transmisión", val: "Eje cardánico macizo de acero templado de 8 mm" },
      { label: "Capacidad de Tanque", val: "1.2 Litros (Mezcla nafta/aceite 2T 50:1)" },
      { label: "Elementos de Corte", val: "Cuchilla 3 puntas 305mm + Cabezal de nylon profesional" },
      { label: "Peso en Seco", val: "9.4 kg" },
      { label: "Garantía Oficial", val: "12 meses Shindaiwa Japón con provisión permanente de repuestos" }
    ],
    applications: "Desmonte pesado de campos y malezales leñosos, mantenimiento intensivo de banquinas viales, cortafuegos forestales y estancias agrícolas."
  },
  {
    id: 12,
    sku: "HMC-MOT-026",
    name: "Motoguadaña Sensei BD-26 25.4cc 2T Liviana y Ergonómica",
    category: "maquinas-explosion",
    categoryName: "Máquinas a Explosión",
    subCategory: "Desmalezadoras",
    brand: "SENSEI",
    price: 245000,
    oldPrice: 289000,
    discount: 15,
    image: "assets/images/products/prod-12-motoguadana-sensei-bd26-principal.webp",
    gallery: [
      "assets/images/products/prod-12-motoguadana-sensei-bd26-principal.webp",
      "assets/images/products/prod-12-motoguadana-sensei-bd26-secundaria.webp",
      "assets/images/products/prod-12-motoguadana-sensei-bd26-specs.webp"
    ],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "bestsellers",
    rating: 4.8,
    reviewsCount: 16,
    desc: "Motoguadaña liviana, ágil y de bajísimo consumo de combustible, perfecta para el mantenimiento de parques residenciales, quintas, borduras y jardines de countries. Sistema de arranque fácil con bomba de cebado manual, manillar abierto tipo bicicleta y cabezal de tanza automático Tap & Go.",
    specs: [
      { label: "Cilindrada del Motor", val: "25.4 cc (Motor 2 Tiempos refrigerado por aire)" },
      { label: "Potencia del Motor", val: "1.0 HP / 0.75 kW" },
      { label: "Capacidad de Tanque", val: "650 ml" },
      { label: "Sistema de Corte", val: "Cabezal de tanza automático Tap & Go + Cuchilla 3 puntas metálica" },
      { label: "Peso en Seco", val: "5.6 kg ultra liviana y maniobrable" },
      { label: "Accesorios Incluidos", val: "Arnés de soporte simple, dosificador de mezcla y kit de llaves" },
      { label: "Garantía Oficial", val: "12 meses respaldo oficial Sensei" }
    ],
    applications: "Corte de césped y maleza liviana en jardines, terminación alrededor de canteros y árboles, limpieza de alambrados y veredas."
  }
];

/* --------------------------------------------------------------------------
   2. Cart & Storage Engine
   -------------------------------------------------------------------------- */
let cart = JSON.parse(localStorage.getItem('hmc_cart')) || [
  { id: 1, qty: 1 }
];

const FREE_SHIPPING_THRESHOLD = 300000; // $300.000 ARS

function initCartSystem() {
  const drawer = document.getElementById('cartDrawer');
  const overlay = document.getElementById('cartOverlay');
  const openButtons = document.querySelectorAll('.js-open-cart');
  const closeBtn = document.getElementById('cartCloseBtn');
  
  function openCart() {
    if (!drawer || !overlay) return;
    drawer.classList.add('active');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
    renderCart();
  }
  
  function closeCart() {
    if (!drawer || !overlay) return;
    drawer.classList.remove('active');
    overlay.classList.remove('active');
    document.body.style.overflow = '';
  }
  
  openButtons.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openCart();
  }));
  
  if (closeBtn) closeBtn.addEventListener('click', closeCart);
  if (overlay) overlay.addEventListener('click', closeCart);
  
  // Global cart methods
  window.hmcAddToCart = function(productId, quantity = 1) {
    const existing = cart.find(item => item.id === productId);
    if (existing) {
      existing.qty += quantity;
    } else {
      cart.push({ id: productId, qty: quantity });
    }
    saveCart();
    renderCart();
    
    // Refresh full cart page if present
    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }

    const product = PRODUCT_CATALOG.find(p => p.id === productId);
    showToast(`¡"${product ? product.name.substring(0, 32) + '...' : 'Producto'}" agregado al carrito!`);
    openCart();
  };
  
  window.hmcUpdateQty = function(productId, delta) {
    const item = cart.find(i => i.id === productId);
    if (!item) return;
    item.qty += delta;
    if (item.qty <= 0) {
      cart = cart.filter(i => i.id !== productId);
    }
    saveCart();
    renderCart();

    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }
  };
  
  window.hmcRemoveItem = function(productId) {
    cart = cart.filter(i => i.id !== productId);
    saveCart();
    renderCart();

    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }
    showToast('Producto eliminado del carrito');
  };
  
  renderCart();
}

function saveCart() {
  localStorage.setItem('hmc_cart', JSON.stringify(cart));
  updateCartBadges();
}

function updateCartBadges() {
  const totalCount = cart.reduce((acc, item) => acc + item.qty, 0);
  document.querySelectorAll('.js-cart-count').forEach(el => {
    el.textContent = totalCount;
  });
}

function formatCurrency(amount) {
  return '$' + Number(amount).toLocaleString('es-AR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
}

function renderCart() {
  const container = document.getElementById('cartItemsContainer');
  const subtotalEl = document.getElementById('cartSubtotal');
  const totalEl = document.getElementById('cartTotalFinal');
  const fillBar = document.getElementById('shippingBarFill');
  const shipText = document.getElementById('shippingBarText');
  
  updateCartBadges();
  
  if (!container) return;
  
  if (cart.length === 0) {
    container.innerHTML = `
      <div class="cart-empty-state">
        <i class="fa-solid fa-cart-shopping"></i>
        <h4>Tu carrito está vacío</h4>
        <p>Explorá nuestro catálogo de maquinaria y herramientas con respaldo técnico.</p>
        <a href="catalog.html" class="btn btn-primary btn-sm" style="margin-top: 16px; display: inline-block;">Ver Catálogo</a>
      </div>
    `;
    if (subtotalEl) subtotalEl.textContent = '$0';
    if (totalEl) totalEl.textContent = '$0';
    if (fillBar) fillBar.style.width = '0%';
    if (shipText) shipText.innerHTML = `<span>Agregá <strong>${formatCurrency(FREE_SHIPPING_THRESHOLD)}</strong> para <strong>Envío Gratis</strong></span>`;
    return;
  }
  
  let subtotal = 0;
  let html = '';
  
  cart.forEach(item => {
    const prod = PRODUCT_CATALOG.find(p => p.id === item.id);
    if (!prod) return;
    const itemTotal = prod.price * item.qty;
    subtotal += itemTotal;
    
    html += `
      <div class="cart-item">
        <img src="${prod.image}" alt="${prod.name}" class="cart-item-img">
        <div class="cart-item-info">
          <a href="product.html?id=${prod.id}" class="cart-item-title">${prod.name}</a>
          <div class="cart-item-price">${formatCurrency(prod.price)}</div>
          <div class="cart-item-controls">
            <div class="qty-selector">
              <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, -1)">-</button>
              <span class="qty-val">${item.qty}</span>
              <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, 1)">+</button>
            </div>
            <button class="cart-item-remove" onclick="hmcRemoveItem(${prod.id})" title="Eliminar">
              <i class="fa-solid fa-trash-can"></i>
            </button>
          </div>
        </div>
      </div>
    `;
  });
  
  container.innerHTML = html;
  if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);
  if (totalEl) totalEl.textContent = formatCurrency(subtotal);
  
  if (fillBar && shipText) {
    const progress = Math.min(100, Math.round((subtotal / FREE_SHIPPING_THRESHOLD) * 100));
    fillBar.style.width = `${progress}%`;
    
    if (subtotal >= FREE_SHIPPING_THRESHOLD) {
      shipText.innerHTML = `<span>🎉 <strong>¡Felicitaciones! Tenés Envío Gratis</strong> en tu pedido</span>`;
    } else {
      const remaining = FREE_SHIPPING_THRESHOLD - subtotal;
      shipText.innerHTML = `<span>Te faltan <strong>${formatCurrency(remaining)}</strong> para <strong>Envío Gratis</strong></span>`;
    }
  }
}

/* --------------------------------------------------------------------------
   3. Live Search Bar & Suggestions
   -------------------------------------------------------------------------- */
function initLiveSearch() {
  const searchInput = document.getElementById('mainSearchInput');
  const dropdown = document.getElementById('searchDropdown');
  const resultsContainer = document.getElementById('searchResultsList');
  const searchForm = document.querySelector('.search-form');
  
  if (!searchInput) return;

  if (searchForm) {
    searchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const q = searchInput.value.trim();
      if (q.length > 0) {
        window.location.href = `catalog.html?q=${encodeURIComponent(q)}`;
      }
    });
  }
  
  if (!dropdown || !resultsContainer) return;
  
  searchInput.addEventListener('input', (e) => {
    const query = e.target.value.trim().toLowerCase();
    if (query.length < 2) {
      dropdown.classList.remove('active');
      return;
    }
    
    const matches = PRODUCT_CATALOG.filter(p => 
      p.name.toLowerCase().includes(query) || 
      p.brand.toLowerCase().includes(query) ||
      p.categoryName.toLowerCase().includes(query) ||
      p.sku.toLowerCase().includes(query)
    ).slice(0, 5);
    
    if (matches.length > 0) {
      resultsContainer.innerHTML = matches.map(p => `
        <div class="search-result-item" onclick="window.location.href='product.html?id=${p.id}'">
          <img src="${p.image}" alt="${p.name}">
          <div class="search-result-info">
            <h5>${p.name}</h5>
            <span>${formatCurrency(p.price)} • <strong style="color: var(--color-primary);">${p.brand}</strong></span>
          </div>
        </div>
      `).join('') + `
        <div style="padding: 10px 16px; background: #fafafa; border-top: 1px solid #eee; text-align: center;">
          <a href="catalog.html?q=${encodeURIComponent(query)}" style="font-size: 0.85rem; font-weight: 700; color: var(--color-primary-dark);">
            Ver todos los resultados para "${query}" →
          </a>
        </div>
      `;
      dropdown.classList.add('active');
    } else {
      resultsContainer.innerHTML = `<div style="padding: 16px; font-size: 0.88rem; color: #777;">No se encontraron productos para "${query}"</div>`;
      dropdown.classList.add('active');
    }
  });
  
  document.addEventListener('click', (e) => {
    if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
      dropdown.classList.remove('active');
    }
  });
}

/* --------------------------------------------------------------------------
   4. Quick View Modal Component
   -------------------------------------------------------------------------- */
function initQuickViewModal() {
  const modal = document.getElementById('quickViewModal');
  const closeBtn = document.getElementById('quickViewClose');
  
  if (!modal) return;
  
  window.hmcOpenQuickView = function(productId) {
    const prod = PRODUCT_CATALOG.find(p => p.id === productId);
    if (!prod) return;
    
    document.getElementById('qvBrand').textContent = prod.brand;
    document.getElementById('qvTitle').textContent = prod.name;
    document.getElementById('qvPrice').textContent = formatCurrency(prod.price);
    document.getElementById('qvOldPrice').textContent = formatCurrency(prod.oldPrice);
    document.getElementById('qvDiscount').textContent = `-${prod.discount}%`;
    document.getElementById('qvDesc').textContent = prod.desc;
    document.getElementById('qvImage').src = prod.image;
    
    const specsList = document.getElementById('qvSpecs');
    if (specsList) {
      specsList.innerHTML = prod.specs.slice(0, 4).map(s => `<li><i class="fa-solid fa-check text-primary"></i> <strong>${s.label}:</strong> ${s.val}</li>`).join('');
    }
    
    const addBtn = document.getElementById('qvAddToCartBtn');
    if (addBtn) {
      addBtn.onclick = function() {
        const qty = parseInt(document.getElementById('qvQtyInput').value) || 1;
        hmcAddToCart(prod.id, qty);
        modal.classList.remove('active');
      };
    }
    
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
  };
  
  function closeModal() {
    modal.classList.remove('active');
    document.body.style.overflow = '';
  }
  
  if (closeBtn) closeBtn.addEventListener('click', closeModal);
  modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
  });
}

/* --------------------------------------------------------------------------
   5. Home Page Components
   -------------------------------------------------------------------------- */
function initHeroSlider() {
  const slides = document.querySelectorAll('.hero-slide');
  const dots = document.querySelectorAll('.hero-dot');
  const prevBtn = document.querySelector('.hero-prev-btn');
  const nextBtn = document.querySelector('.hero-next-btn');
  
  if (!slides.length) return;
  
  let currentSlide = 0;
  let slideInterval = null;
  
  function showSlide(index) {
    slides.forEach((s, i) => s.classList.toggle('active', i === index));
    dots.forEach((d, i) => d.classList.toggle('active', i === index));
    currentSlide = index;
  }
  
  function nextSlide() {
    let next = (currentSlide + 1) % slides.length;
    showSlide(next);
  }
  
  function prevSlide() {
    let prev = (currentSlide - 1 + slides.length) % slides.length;
    showSlide(prev);
  }
  
  function startAutoplay() {
    stopAutoplay();
    slideInterval = setInterval(nextSlide, 8500);
  }
  
  function stopAutoplay() {
    if (slideInterval) clearInterval(slideInterval);
  }
  
  if (nextBtn) nextBtn.addEventListener('click', () => { nextSlide(); startAutoplay(); });
  if (prevBtn) prevBtn.addEventListener('click', () => { prevSlide(); startAutoplay(); });
  
  dots.forEach((dot, idx) => {
    dot.addEventListener('click', () => {
      showSlide(idx);
      startAutoplay();
    });
  });
  
  // Touch Swipe for Mobile
  let touchStartX = 0;
  let touchEndX = 0;
  const sliderEl = document.querySelector('.hero-slider-wrapper');
  if (sliderEl) {
    sliderEl.addEventListener('touchstart', e => {
      touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });
    sliderEl.addEventListener('touchend', e => {
      touchEndX = e.changedTouches[0].screenX;
      if (touchStartX - touchEndX > 45) {
        nextSlide();
        startAutoplay();
      } else if (touchEndX - touchStartX > 45) {
        prevSlide();
        startAutoplay();
      }
    }, { passive: true });
  }
  
  startAutoplay();
}

function initCountdown() {
  const daysEl = document.getElementById('cd-days');
  const hoursEl = document.getElementById('cd-hours');
  const minsEl = document.getElementById('cd-mins');
  const secsEl = document.getElementById('cd-secs');
  
  if (!daysEl) return;
  
  const targetDate = new Date();
  targetDate.setDate(targetDate.getDate() + 4);
  targetDate.setHours(targetDate.getHours() + 18);
  targetDate.setMinutes(targetDate.getMinutes() + 32);
  
  function updateTimer() {
    const now = new Date().getTime();
    const diff = targetDate - now;
    
    if (diff <= 0) {
      daysEl.textContent = '00';
      hoursEl.textContent = '00';
      minsEl.textContent = '00';
      secsEl.textContent = '00';
      return;
    }
    
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const secs = Math.floor((diff % (1000 * 60)) / 1000);
    
    daysEl.textContent = String(days).padStart(2, '0');
    hoursEl.textContent = String(hours).padStart(2, '0');
    minsEl.textContent = String(mins).padStart(2, '0');
    secsEl.textContent = String(secs).padStart(2, '0');
  }
  
  updateTimer();
  setInterval(updateTimer, 1000);
}

function initCatalogTabs() {
  const tabs = document.querySelectorAll('.catalog-tab');
  const container = document.getElementById('featuredProductsGrid');
  
  if (!tabs.length || !container) return;
  
  function renderProducts(filter = 'all') {
    let filtered = PRODUCT_CATALOG;
    if (filter !== 'all') {
      filtered = PRODUCT_CATALOG.filter(p => p.tab === filter);
    }
    
    container.innerHTML = filtered.map(prod => `
      <div class="product-card" data-category="${prod.category}">
        <div class="product-badge-group">
          ${prod.discount ? `<span class="badge badge-discount">-${prod.discount}% OFF</span>` : ''}
          ${prod.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <button class="product-wishlist-btn" onclick="showToast('Guardado en favoritos')" title="Favorito">
          <i class="fa-regular fa-heart"></i>
        </button>
        <div class="product-image-box">
          <a href="product.html?id=${prod.id}">
            <img src="${prod.image}" alt="${prod.name}" class="product-img" loading="lazy">
          </a>
          <div class="product-quick-actions">
            <button class="btn-quick-view" onclick="hmcOpenQuickView(${prod.id})">
              <i class="fa-solid fa-eye"></i> Vista Rápida
            </button>
          </div>
        </div>
        <div class="product-details">
          <div class="product-brand">${prod.brand}</div>
          <h4 class="product-name" title="${prod.name}">
            <a href="product.html?id=${prod.id}">${prod.name}</a>
          </h4>
          <div class="product-price-box">
            <div>
              <span class="price-old">${formatCurrency(prod.oldPrice)}</span>
              <span class="price-current">${formatCurrency(prod.price)}</span>
            </div>
            <div class="installments-info">
              <i class="fa-solid fa-credit-card"></i> <strong>6 cuotas</strong> sin interés
            </div>
          </div>
          <button class="btn btn-primary btn-add-to-cart" onclick="hmcAddToCart(${prod.id})">
            <i class="fa-solid fa-cart-plus"></i> Comprar
          </button>
        </div>
      </div>
    `).join('');
  }
  
  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      renderProducts(tab.dataset.tab);
    });
  });
  
  renderProducts('all');
}

function initVideoPlayer() {
  const video = document.getElementById('showcaseVideo');
  const playBtn = document.getElementById('videoPlayBtn');
  
  if (!video || !playBtn) return;
  
  playBtn.addEventListener('click', () => {
    if (video.paused) {
      video.play();
      playBtn.classList.add('playing');
    } else {
      video.pause();
      playBtn.classList.remove('playing');
    }
  });
  
  video.addEventListener('play', () => playBtn.classList.add('playing'));
  video.addEventListener('pause', () => playBtn.classList.remove('playing'));
}

function initPromoPopup() {
  const popup = document.getElementById('promoPopup');
  const closeBtn = document.getElementById('promoPopupClose');
  
  if (!popup) return;
  
  if (!sessionStorage.getItem('hmc_promo_seen')) {
    setTimeout(() => {
      popup.classList.add('active');
    }, 2800);
  }
  
  function closePromo() {
    popup.classList.remove('active');
    sessionStorage.setItem('hmc_promo_seen', 'true');
  }
  
  if (closeBtn) closeBtn.addEventListener('click', closePromo);
  popup.addEventListener('click', (e) => {
    if (e.target === popup) closePromo();
  });
}

/* --------------------------------------------------------------------------
   6. Dedicated Catalog / Search Page Engine (catalog.html)
   -------------------------------------------------------------------------- */
function initCatalogPage() {
  const gridContainer = document.getElementById('catalogProductsGrid');
  const countEl = document.getElementById('catalogResultsCount');
  const sortSelect = document.getElementById('catalogSortSelect');
  const activeChipsContainer = document.getElementById('activeFilterChips');
  const viewGridBtn = document.getElementById('viewGridBtn');
  const viewListBtn = document.getElementById('viewListBtn');
  const categoryCheckboxes = document.querySelectorAll('.js-filter-category');
  const brandCheckboxes = document.querySelectorAll('.js-filter-brand');
  const freeShipCheckbox = document.getElementById('filterFreeShipping');
  const inStockCheckbox = document.getElementById('filterInStock');
  const offersCheckbox = document.getElementById('filterOffers');
  const minPriceInput = document.getElementById('priceMinInput');
  const maxPriceInput = document.getElementById('priceMaxInput');
  const applyPriceBtn = document.getElementById('applyPriceBtn');
  
  // Read URL query params
  const urlParams = new URLSearchParams(window.location.search);
  const paramCategory = urlParams.get('category') || urlParams.get('cat');
  const paramBrand = urlParams.get('brand');
  const paramSearch = urlParams.get('q');
  const paramOffers = urlParams.get('offers');

  if (paramCategory) {
    categoryCheckboxes.forEach(cb => {
      if (cb.value === paramCategory) cb.checked = true;
    });
  }

  if (paramBrand) {
    brandCheckboxes.forEach(cb => {
      if (cb.value.toUpperCase() === paramBrand.toUpperCase()) cb.checked = true;
    });
  }

  if (paramOffers === 'true') {
    if (offersCheckbox) offersCheckbox.checked = true;
  }

  function applyFilters() {
    const selectedCategories = Array.from(categoryCheckboxes).filter(cb => cb.checked).map(cb => cb.value);
    const selectedBrands = Array.from(brandCheckboxes).filter(cb => cb.checked).map(cb => cb.value.toUpperCase());
    const onlyFreeShipping = freeShipCheckbox ? freeShipCheckbox.checked : false;
    const onlyInStock = inStockCheckbox ? inStockCheckbox.checked : false;
    const onlyOffers = offersCheckbox ? offersCheckbox.checked : false;
    const minP = minPriceInput && minPriceInput.value ? Number(minPriceInput.value) : 0;
    const maxP = maxPriceInput && maxPriceInput.value ? Number(maxPriceInput.value) : Infinity;
    const searchQuery = (paramSearch || '').toLowerCase();

    let results = PRODUCT_CATALOG.filter(item => {
      if (selectedCategories.length > 0 && !selectedCategories.includes(item.category)) return false;
      if (selectedBrands.length > 0 && !selectedBrands.includes(item.brand.toUpperCase())) return false;
      if (onlyFreeShipping && !item.freeShipping) return false;
      if (onlyInStock && !item.inStock) return false;
      if (onlyOffers && (!item.discount || item.discount <= 0)) return false;
      if (item.price < minP || item.price > maxP) return false;
      if (searchQuery) {
        const matches = item.name.toLowerCase().includes(searchQuery) ||
                        item.brand.toLowerCase().includes(searchQuery) ||
                        item.categoryName.toLowerCase().includes(searchQuery) ||
                        item.sku.toLowerCase().includes(searchQuery);
        if (!matches) return false;
      }
      return true;
    });

    // Sorting
    const sortVal = sortSelect ? sortSelect.value : 'featured';
    if (sortVal === 'price-asc') {
      results.sort((a, b) => a.price - b.price);
    } else if (sortVal === 'price-desc') {
      results.sort((a, b) => b.price - a.price);
    } else if (sortVal === 'discount') {
      results.sort((a, b) => (b.discount || 0) - (a.discount || 0));
    } else if (sortVal === 'name-asc') {
      results.sort((a, b) => a.name.localeCompare(b.name));
    }

    const promoBanner = document.getElementById('catalogOffersPromoBanner');
    if (promoBanner) {
      promoBanner.style.display = onlyOffers ? 'block' : 'none';
    }

    renderCatalogResults(results);
    renderActiveFilterChips(selectedCategories, selectedBrands, onlyFreeShipping, onlyOffers, searchQuery);
  }

  function renderCatalogResults(results) {
    if (countEl) {
      countEl.innerHTML = `Mostrando <strong>${results.length}</strong> de <strong>${PRODUCT_CATALOG.length}</strong> equipos`;
    }

    if (!gridContainer) return;

    if (results.length === 0) {
      gridContainer.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; background: #fff; border: 1px dashed var(--color-gray-border); border-radius: var(--radius-lg);">
          <i class="fa-solid fa-magnifying-glass" style="font-size: 3rem; color: #bbb; margin-bottom: 16px;"></i>
          <h3>No encontramos equipos con los filtros seleccionados</h3>
          <p style="color: #666; margin-bottom: 20px;">Probá modificando el rango de precios o quitando filtros de marca o categoría.</p>
          <button class="btn btn-primary" onclick="window.location.href='catalog.html'">Ver Todo el Catálogo</button>
        </div>
      `;
      return;
    }

    gridContainer.innerHTML = results.map(prod => `
      <div class="product-card">
        <div class="product-badge-group">
          ${prod.discount ? `<span class="badge badge-discount">-${prod.discount}% OFF</span>` : ''}
          ${prod.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <button class="product-wishlist-btn" onclick="showToast('Guardado en favoritos')" title="Favorito">
          <i class="fa-regular fa-heart"></i>
        </button>
        <div class="product-image-box">
          <a href="product.html?id=${prod.id}">
            <img src="${prod.image}" alt="${prod.name}" class="product-img" loading="lazy">
          </a>
          <div class="product-quick-actions">
            <button class="btn-quick-view" onclick="hmcOpenQuickView(${prod.id})">
              <i class="fa-solid fa-eye"></i> Vista Rápida
            </button>
          </div>
        </div>
        <div class="product-details">
          <div class="product-brand">${prod.brand}</div>
          <h4 class="product-name" title="${prod.name}">
            <a href="product.html?id=${prod.id}">${prod.name}</a>
          </h4>
          <div class="product-price-box">
            <div>
              <span class="price-old">${formatCurrency(prod.oldPrice)}</span>
              <span class="price-current">${formatCurrency(prod.price)}</span>
            </div>
            <div class="installments-info">
              <i class="fa-solid fa-credit-card"></i> <strong>6 cuotas</strong> sin interés
            </div>
          </div>
          <button class="btn btn-primary btn-add-to-cart" onclick="hmcAddToCart(${prod.id})">
            <i class="fa-solid fa-cart-plus"></i> Comprar Ahora
          </button>
        </div>
      </div>
    `).join('');
  }

  function renderActiveFilterChips(categories, brands, freeShip, offers, search) {
    if (!activeChipsContainer) return;
    let chipsHtml = '';

    if (search) {
      chipsHtml += `<span class="filter-chip">Búsqueda: "${search}" <button onclick="window.location.href='catalog.html'">✕</button></span>`;
    }
    categories.forEach(c => {
      chipsHtml += `<span class="filter-chip">Categoría: ${c} <button onclick="document.querySelector('.js-filter-category[value=${c}]').click()">✕</button></span>`;
    });
    brands.forEach(b => {
      chipsHtml += `<span class="filter-chip">Marca: ${b} <button onclick="document.querySelector('.js-filter-brand[value=${b}]').click()">✕</button></span>`;
    });
    if (freeShip) {
      chipsHtml += `<span class="filter-chip">Envío Gratis <button onclick="document.getElementById('filterFreeShipping').click()">✕</button></span>`;
    }
    if (offers) {
      chipsHtml += `<span class="filter-chip">En Oferta <button onclick="document.getElementById('filterOffers').click()">✕</button></span>`;
    }

    if (chipsHtml) {
      chipsHtml += `<button class="clear-filters-btn" onclick="window.location.href='catalog.html'">Limpiar todo</button>`;
      activeChipsContainer.innerHTML = chipsHtml;
    } else {
      activeChipsContainer.innerHTML = '';
    }
  }

  // Listeners
  categoryCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));
  brandCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));
  if (freeShipCheckbox) freeShipCheckbox.addEventListener('change', applyFilters);
  if (inStockCheckbox) inStockCheckbox.addEventListener('change', applyFilters);
  if (offersCheckbox) offersCheckbox.addEventListener('change', applyFilters);
  if (sortSelect) sortSelect.addEventListener('change', applyFilters);
  if (applyPriceBtn) applyPriceBtn.addEventListener('click', applyFilters);

  // View modes
  if (viewGridBtn && viewListBtn && gridContainer) {
    viewGridBtn.addEventListener('click', () => {
      viewGridBtn.classList.add('active');
      viewListBtn.classList.remove('active');
      gridContainer.classList.remove('list-view');
    });
    viewListBtn.addEventListener('click', () => {
      viewListBtn.classList.add('active');
      viewGridBtn.classList.remove('active');
      gridContainer.classList.add('list-view');
    });
  }

  // Mobile Filter Bottom Sheet Drawer controls
  const btnOpenMobileFilter = document.getElementById('btnOpenMobileFilter');
  const btnCloseMobileFilter = document.getElementById('btnCloseMobileFilter');
  const catalogSidebar = document.querySelector('.catalog-sidebar');
  const mobileDrawerOverlay = document.getElementById('mobileDrawerOverlay');

  function openMobileFilters() {
    if (catalogSidebar) catalogSidebar.classList.add('mobile-sheet-active');
    if (mobileDrawerOverlay) mobileDrawerOverlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeMobileFilters() {
    if (catalogSidebar) catalogSidebar.classList.remove('mobile-sheet-active');
    if (mobileDrawerOverlay) mobileDrawerOverlay.classList.remove('active');
    document.body.style.overflow = '';
  }

  if (btnOpenMobileFilter) btnOpenMobileFilter.addEventListener('click', openMobileFilters);
  if (btnCloseMobileFilter) btnCloseMobileFilter.addEventListener('click', closeMobileFilters);

  applyFilters();
}

/* --------------------------------------------------------------------------
   7. Dedicated Product Detail Page Engine (product.html)
   -------------------------------------------------------------------------- */
function initProductPage() {
  const urlParams = new URLSearchParams(window.location.search);
  const prodId = parseInt(urlParams.get('id')) || 1;
  const prod = PRODUCT_CATALOG.find(p => p.id === prodId) || PRODUCT_CATALOG[0];

  // Populate Meta & Breadcrumb
  document.title = `${prod.name} | HMC HUB`;
  const breadcrumbCat = document.getElementById('breadcrumbCategory');
  const breadcrumbProd = document.getElementById('breadcrumbProduct');
  if (breadcrumbCat) {
    breadcrumbCat.textContent = prod.categoryName;
    breadcrumbCat.href = `catalog.html?category=${prod.category}`;
  }
  if (breadcrumbProd) breadcrumbProd.textContent = prod.name;

  // Populate Details
  const titleEl = document.getElementById('productTitle');
  const brandEl = document.getElementById('productBrand');
  const skuEl = document.getElementById('productSku');
  const priceEl = document.getElementById('productPrice');
  const oldPriceEl = document.getElementById('productOldPrice');
  const discountEl = document.getElementById('productDiscountBadge');
  const installmentsEl = document.getElementById('productInstallmentsText');
  const descEl = document.getElementById('productFullDesc');
  const appDescEl = document.getElementById('productApplications');
  const mainImgEl = document.getElementById('productMainImg');
  const thumbsContainer = document.getElementById('productThumbsContainer');
  const specsTableBody = document.getElementById('productSpecsTableBody');
  const whatsappAdviceBtn = document.getElementById('productWhatsappBtn');
  
  if (titleEl) titleEl.textContent = prod.name;
  if (brandEl) brandEl.textContent = prod.brand;
  if (skuEl) skuEl.textContent = `SKU: ${prod.sku}`;
  if (priceEl) priceEl.textContent = formatCurrency(prod.price);
  if (oldPriceEl) oldPriceEl.textContent = formatCurrency(prod.oldPrice);
  if (discountEl) discountEl.textContent = `-${prod.discount}% OFF`;
  if (descEl) descEl.textContent = prod.desc;
  if (appDescEl) appDescEl.textContent = prod.applications || '';

  // Installments calculation
  if (installmentsEl) {
    const installmentVal = Math.round(prod.price / 6);
    installmentsEl.innerHTML = `<strong>6 cuotas fijas</strong> sin interés de <strong>${formatCurrency(installmentVal)}</strong> con todas las tarjetas`;
  }

  // Gallery
  if (mainImgEl) mainImgEl.src = prod.image;
  if (thumbsContainer && prod.gallery) {
    thumbsContainer.innerHTML = prod.gallery.map((imgSrc, idx) => `
      <div class="gallery-thumb ${idx === 0 ? 'active' : ''}" onclick="hmcSwitchProductImage('${imgSrc}', this)">
        <img src="${imgSrc}" alt="${prod.name}">
      </div>
    `).join('');
  }

  window.hmcSwitchProductImage = function(src, thumbEl) {
    if (mainImgEl) mainImgEl.src = src;
    document.querySelectorAll('.gallery-thumb').forEach(t => t.classList.remove('active'));
    if (thumbEl) thumbEl.classList.add('active');
  };

  // Specs Table
  if (specsTableBody && prod.specs) {
    specsTableBody.innerHTML = prod.specs.map(s => `
      <tr>
        <th>${s.label}</th>
        <td>${s.val}</td>
      </tr>
    `).join('');
  }

  // WhatsApp Technical Inquiry prefill
  if (whatsappAdviceBtn) {
    const msg = encodeURIComponent(`Hola HMC Hub, estoy viendo el equipo "${prod.name}" (SKU: ${prod.sku}) en la web y me gustaría recibir asesoramiento técnico para mi trabajo.`);
    whatsappAdviceBtn.href = `https://wa.me/5492954696231?text=${msg}`;
  }

  // Quantity and Actions
  const qtyInput = document.getElementById('productDetailQty');
  const qtyMinusBtn = document.getElementById('qtyMinusBtn');
  const qtyPlusBtn = document.getElementById('qtyPlusBtn');
  const addToCartBtn = document.getElementById('productAddToCartBtn');
  const buyNowBtn = document.getElementById('productBuyNowBtn');

  if (qtyMinusBtn && qtyInput) {
    qtyMinusBtn.onclick = () => {
      let val = parseInt(qtyInput.value) || 1;
      if (val > 1) qtyInput.value = val - 1;
    };
  }

  if (qtyPlusBtn && qtyInput) {
    qtyPlusBtn.onclick = () => {
      let val = parseInt(qtyInput.value) || 1;
      if (val < 99) qtyInput.value = val + 1;
    };
  }

  if (addToCartBtn) {
    addToCartBtn.onclick = () => {
      const q = parseInt(qtyInput ? qtyInput.value : 1) || 1;
      hmcAddToCart(prod.id, q);
    };
  }

  if (buyNowBtn) {
    buyNowBtn.onclick = () => {
      const q = parseInt(qtyInput ? qtyInput.value : 1) || 1;
      hmcAddToCart(prod.id, q);
      window.location.href = 'cart.html';
    };
  }

  // Product Tabs Switcher
  const tabButtons = document.querySelectorAll('.product-tab-btn');
  const tabPanels = document.querySelectorAll('.product-tab-panel');
  tabButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      tabButtons.forEach(b => b.classList.remove('active'));
      tabPanels.forEach(p => p.classList.remove('active'));
      btn.classList.add('active');
      const targetId = btn.dataset.tab;
      const targetPanel = document.getElementById(targetId);
      if (targetPanel) targetPanel.classList.add('active');
    });
  });

  // Related Products
  const relatedGrid = document.getElementById('relatedProductsGrid');
  if (relatedGrid) {
    const related = PRODUCT_CATALOG.filter(p => p.category === prod.category && p.id !== prod.id).slice(0, 4);
    const fallback = related.length ? related : PRODUCT_CATALOG.filter(p => p.id !== prod.id).slice(0, 4);
    
    relatedGrid.innerHTML = fallback.map(item => `
      <div class="product-card">
        <div class="product-badge-group">
          ${item.discount ? `<span class="badge badge-discount">-${item.discount}% OFF</span>` : ''}
          ${item.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <div class="product-image-box">
          <a href="product.html?id=${item.id}">
            <img src="${item.image}" alt="${item.name}" class="product-img">
          </a>
        </div>
        <div class="product-details">
          <div class="product-brand">${item.brand}</div>
          <h4 class="product-name"><a href="product.html?id=${item.id}">${item.name}</a></h4>
          <div class="product-price-box">
            <div>
              <span class="price-current">${formatCurrency(item.price)}</span>
            </div>
          </div>
          <button class="btn btn-primary btn-add-to-cart" onclick="hmcAddToCart(${item.id})">
            <i class="fa-solid fa-cart-plus"></i> Comprar
          </button>
        </div>
      </div>
    `).join('');
  }

  // Mobile Sticky Bottom Buy Bar
  const stickyBuyBar = document.getElementById('mobileStickyBuyBar');
  const stickyImg = document.getElementById('stickyBuyBarImg');
  const stickyTitle = document.getElementById('stickyBuyBarTitle');
  const stickyPrice = document.getElementById('stickyBuyBarPrice');
  const stickyBtn = document.getElementById('stickyBuyBarBtn');

  if (stickyBuyBar && prod) {
    if (stickyImg) stickyImg.src = prod.image;
    if (stickyTitle) stickyTitle.textContent = prod.name;
    if (stickyPrice) stickyPrice.textContent = formatCurrency(prod.price);
    if (stickyBtn) {
      stickyBtn.onclick = () => {
        hmcAddToCart(prod.id, 1);
      };
    }

    window.addEventListener('scroll', () => {
      if (window.scrollY > 380 && window.innerWidth <= 768) {
        stickyBuyBar.classList.add('active');
      } else {
        stickyBuyBar.classList.remove('active');
      }
    }, { passive: true });
  }
}

/* --------------------------------------------------------------------------
   8. Dedicated Full Cart Page Engine (cart.html)
   -------------------------------------------------------------------------- */
let appliedCoupon = null;

function initCartPage() {
  renderFullCartPage();

  const couponInput = document.getElementById('cartCouponInput');
  const couponBtn = document.getElementById('cartApplyCouponBtn');

  if (couponBtn && couponInput) {
    couponBtn.addEventListener('click', () => {
      const code = couponInput.value.trim().toUpperCase();
      if (code === 'BIENVENIDO-HMC' || code === 'HMC10') {
        appliedCoupon = { code: code, discountPct: 10 };
        showToast('🎉 ¡Cupón aplicado! 10% de descuento en tu compra.');
        renderFullCartPage();
      } else if (code === 'HMCPRO') {
        appliedCoupon = { code: code, discountPct: 15 };
        showToast('🎉 ¡Cupón PRO aplicado! 15% de descuento especial.');
        renderFullCartPage();
      } else {
        showToast('El cupón ingresado no es válido o está vencido.');
      }
    });
  }
}

function renderFullCartPage() {
  const tableBody = document.getElementById('cartPageTableBody');
  const emptyBox = document.getElementById('cartPageEmptyState');
  const contentLayout = document.getElementById('cartPageContentGrid');
  const subtotalEl = document.getElementById('cartPageSubtotal');
  const discountRow = document.getElementById('cartPageDiscountRow');
  const discountValEl = document.getElementById('cartPageDiscountVal');
  const totalEl = document.getElementById('cartPageTotalFinal');
  const freeShipBar = document.getElementById('cartPageShippingProgress');
  const freeShipMsg = document.getElementById('cartPageShippingMsg');
  const crossSellContainer = document.getElementById('cartCrossSellGrid');

  updateCartBadges();

  if (cart.length === 0) {
    if (emptyBox) emptyBox.style.display = 'block';
    if (contentLayout) contentLayout.style.display = 'none';
    return;
  }

  if (emptyBox) emptyBox.style.display = 'none';
  if (contentLayout) contentLayout.style.display = 'grid';

  let subtotal = 0;
  let rowsHtml = '';

  cart.forEach(item => {
    const prod = PRODUCT_CATALOG.find(p => p.id === item.id);
    if (!prod) return;
    const itemTotal = prod.price * item.qty;
    subtotal += itemTotal;

    rowsHtml += `
      <tr>
        <td>
          <div class="cart-product-cell">
            <img src="${prod.image}" alt="${prod.name}" class="cart-product-img">
            <div class="cart-product-meta">
              <h4><a href="product.html?id=${prod.id}">${prod.name}</a></h4>
              <span>Marca: <strong>${prod.brand}</strong> | SKU: ${prod.sku}</span>
            </div>
          </div>
        </td>
        <td style="font-weight: 600;">${formatCurrency(prod.price)}</td>
        <td>
          <div class="qty-selector">
            <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, -1)">-</button>
            <span class="qty-val">${item.qty}</span>
            <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, 1)">+</button>
          </div>
        </td>
        <td style="font-weight: 700; color: var(--color-primary); font-size: 1.05rem;">
          ${formatCurrency(itemTotal)}
        </td>
        <td>
          <button class="cart-item-remove" onclick="hmcRemoveItem(${prod.id})" title="Eliminar ítem">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      </tr>
    `;
  });

  if (tableBody) tableBody.innerHTML = rowsHtml;
  if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);

  // Apply discount if coupon present
  let discountAmount = 0;
  if (appliedCoupon) {
    discountAmount = Math.round(subtotal * (appliedCoupon.discountPct / 100));
    if (discountRow) discountRow.style.display = 'flex';
    if (discountValEl) discountValEl.textContent = `-${formatCurrency(discountAmount)} (${appliedCoupon.discountPct}%)`;
  } else {
    if (discountRow) discountRow.style.display = 'none';
  }

  const grandTotal = subtotal - discountAmount;
  if (totalEl) totalEl.textContent = formatCurrency(grandTotal);

  // Free shipping progress
  if (freeShipBar && freeShipMsg) {
    const progress = Math.min(100, Math.round((subtotal / FREE_SHIPPING_THRESHOLD) * 100));
    freeShipBar.style.width = `${progress}%`;
    if (subtotal >= FREE_SHIPPING_THRESHOLD) {
      freeShipMsg.innerHTML = `🎉 <strong>¡Tenés Envío Gratis garantizado en todo el país!</strong>`;
    } else {
      const remaining = FREE_SHIPPING_THRESHOLD - subtotal;
      freeShipMsg.innerHTML = `Sumá <strong>${formatCurrency(remaining)}</strong> más a tu compra para obtener <strong>Envío Gratis</strong>`;
    }
  }

  // Cross Sell Strip
  if (crossSellContainer) {
    const crossSellCandidates = PRODUCT_CATALOG.filter(p => !cart.some(c => c.id === p.id)).slice(0, 3);
    crossSellContainer.innerHTML = crossSellCandidates.map(p => `
      <div class="product-card" style="box-shadow: none; border: 1px solid var(--color-gray-border);">
        <div class="product-image-box" style="height: 160px;">
          <img src="${p.image}" alt="${p.name}" class="product-img">
        </div>
        <div class="product-details" style="padding: 14px;">
          <h4 style="font-size: 0.88rem; margin-bottom: 6px;"><a href="product.html?id=${p.id}">${p.name.substring(0, 38)}...</a></h4>
          <span style="color: var(--color-primary); font-weight: 700;">${formatCurrency(p.price)}</span>
          <button class="btn btn-dark btn-sm" style="margin-top: 10px; width: 100%; font-size: 0.82rem;" onclick="hmcAddToCart(${p.id})">
            <i class="fa-solid fa-plus"></i> Sumar al pedido
          </button>
        </div>
      </div>
    `).join('');
  }
}

/* --------------------------------------------------------------------------
   9. Contact Page Engine (contact.html)
   -------------------------------------------------------------------------- */
function initContactPage() {
  const faqQuestions = document.querySelectorAll('.faq-question');
  faqQuestions.forEach(q => {
    q.addEventListener('click', () => {
      const item = q.parentElement;
      item.classList.toggle('active');
    });
  });

  const contactForm = document.getElementById('contactInquiryForm');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      showToast('🎉 ¡Consulta enviada con éxito! Un asesor técnico se comunicará a la brevedad.');
      contactForm.reset();
    });
  }
}

/* --------------------------------------------------------------------------
   10. Postal Code Shipping Calculator Helper
   -------------------------------------------------------------------------- */
function initShippingCalculator() {
  window.hmcCalcShipping = function(targetBoxId = 'shippingResultBox', inputId = 'shippingCpInput') {
    const cpInput = document.getElementById(inputId);
    const cp = cpInput ? cpInput.value.trim() : '';
    const resultBox = document.getElementById(targetBoxId);
    
    if (!cp || cp.length < 4) {
      showToast('Ingresá un código postal válido de 4 dígitos');
      return;
    }
    
    if (resultBox) {
      resultBox.innerHTML = `
        <div style="padding: 12px; background: #e8f5e9; border-radius: 6px; border: 1px solid #c8e6c9; margin-top: 10px; font-size: 0.85rem;">
          <div style="color: #2e7d32; font-weight: 700; margin-bottom: 4px;"><i class="fa-solid fa-truck-fast"></i> Opciones de entrega para CP ${cp}:</div>
          <div>• <strong>Envío Estándar a Domicilio:</strong> $4.200 (Llega en 48-72 hs hábiles)</div>
          <div>• <strong>Envío Exprés con Puesta en Marcha:</strong> $6.500 (Llega en 24-48 hs)</div>
          <div>• <strong>Retiro en Sucursal HMC HUB (Santa Rosa):</strong> <span style="color: #2e7d32; font-weight: 700;">¡GRATIS! (Listo en 2 hs)</span></div>
        </div>
      `;
    }
  };
}

/* --------------------------------------------------------------------------
   11. Newsletter Form Handler
   -------------------------------------------------------------------------- */
function initNewsletter() {
  const forms = document.querySelectorAll('.newsletter-form');
  forms.forEach(form => {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const input = form.querySelector('input[type="email"]');
      if (input && input.value.includes('@')) {
        showToast('🎉 ¡Gracias por suscribirte! Te enviamos tu cupón BIENVENIDO-HMC del 10% por email.');
        input.value = '';
      } else {
        showToast('Por favor, ingresá un email válido');
      }
    });
  });
}

/* --------------------------------------------------------------------------
   12. Mobile Off-Canvas Drawer Menu & Navigation System
   -------------------------------------------------------------------------- */
function initMobileMenu() {
  const openButtons = document.querySelectorAll('.js-open-mobile-menu, #mobileMenuToggle, #mobileDrawerOpenBtn');
  const drawer = document.getElementById('mobileDrawerMenu');
  const overlay = document.getElementById('mobileDrawerOverlay');
  const closeBtn = document.getElementById('mobileDrawerClose');
  const drawerSearchForm = document.getElementById('mobileDrawerSearchForm');
  const drawerSearchInput = document.getElementById('mobileDrawerSearchInput');

  function openDrawer() {
    if (!drawer || !overlay) return;
    drawer.classList.add('active');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeDrawer() {
    if (!drawer || !overlay) return;
    drawer.classList.remove('active');
    overlay.classList.remove('active');
    document.body.style.overflow = '';
  }

  openButtons.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openDrawer();
  }));

  if (closeBtn) closeBtn.addEventListener('click', closeDrawer);
  if (overlay) overlay.addEventListener('click', closeDrawer);

  // Drawer Category Accordion
  const accordionHeaders = document.querySelectorAll('.js-drawer-accordion');
  accordionHeaders.forEach(header => {
    header.addEventListener('click', () => {
      const content = header.nextElementSibling;
      const icon = header.querySelector('i.fa-chevron-down');
      if (content) {
        content.classList.toggle('active');
        if (icon) {
          icon.style.transform = content.classList.contains('active') ? 'rotate(180deg)' : 'rotate(0deg)';
          icon.style.transition = 'transform 0.2s ease';
        }
      }
    });
  });

  if (drawerSearchForm && drawerSearchInput) {
    drawerSearchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const q = drawerSearchInput.value.trim();
      if (q) {
        window.location.href = `catalog.html?q=${encodeURIComponent(q)}`;
      }
    });
  }
}

/* --------------------------------------------------------------------------
   13. Toast Notification Helper
   -------------------------------------------------------------------------- */
function showToast(message) {
  let container = document.querySelector('.toast-container');
  if (!container) {
    container = document.createElement('div');
    container.className = 'toast-container';
    document.body.appendChild(container);
  }
  
  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.innerHTML = `<i class="fa-solid fa-circle-check"></i> <span>${message}</span>`;
  
  container.appendChild(toast);
  setTimeout(() => toast.classList.add('show'), 50);
  
  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 400);
  }, 3500);
}
