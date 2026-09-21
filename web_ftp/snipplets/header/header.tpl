{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>

{# 1. Top Announcement Bar (HMC HUB Marquee) #}
{% snipplet "header/header-advertising.tpl" %}

{# 2. Main Sticky Header & Navigation #}
<header class="header-main" data-store="head">
  <div class="container header-inner">
    
    <!-- Brand Logo -->
    <div class="logo-container">
      <a href="{{ store.home_url }}" class="logo-link">
        <img src="{{ 'images/logos/logo-horizontal-color.png' | static_url }}" alt="{{ store.name | default('HMC HUB') }}" class="logo-img">
      </a>
    </div>

    <!-- Live Search Form (Desktop) -->
    <div class="header-search d-none d-lg-block">
      <form class="search-form js-search-form" action="{{ store.search_url | default('/search/') }}" method="get">
        <input type="search" name="q" id="mainSearchInput" class="search-input js-search-input" placeholder="{{ 'Buscar demoledores, taladros, motoguadañas, bombas, sierras...' | translate }}" autocomplete="off">
        <button type="submit" class="search-btn js-search-input-submit" title="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscar' | translate }}">
          <i class="fa-solid fa-magnifying-glass"></i>
        </button>
      </form>
      <div id="searchDropdown" class="search-dropdown js-search-form-suggestions">
        <div class="search-dropdown-header">{{ 'Sugerencias destacadas' | translate }}</div>
        <div id="searchResultsList" class="js-search-results"></div>
      </div>
    </div>

    <!-- Header Utility Actions -->
    <div class="header-utilities">
      <!-- Mobile Search Toggle Button -->
      <button type="button" class="utility-btn btn-mobile-search-toggle js-toggle-mobile-search d-lg-none" id="btnMobileSearchToggle" title="{{ 'Buscar productos' | translate }}" aria-label="{{ 'Abrir buscador' | translate }}">
        <i class="fa-solid fa-magnifying-glass"></i>
      </button>

      <!-- Account Link -->
      <a href="{% if not customer %}{{ store.customer_login_url }}{% else %}{{ store.customer_home_url }}{% endif %}" class="utility-btn" title="{% if not customer %}{{ 'Mi Cuenta' | translate }}{% else %}{{ customer.name | split(' ') | first }}{% endif %}">
        <i class="fa-regular fa-user"></i>
        <span class="d-none-mobile">{% if not customer %}{{ 'Mi Cuenta' | translate }}{% else %}{{ customer.name | split(' ') | first }}{% endif %}</span>
      </a>

      <!-- Shopping Cart Button -->
      <a {% if settings.ajax_cart and template != 'cart' %}href="#" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% else %}href="{{ store.cart_url }}"{% endif %} class="utility-btn js-open-cart {% if settings.ajax_cart and template != 'cart' %}js-modal-open js-fullscreen-modal-open{% endif %}" title="{{ 'Carrito de Compras' | translate }}" data-component="cart-button">
        <i class="fa-solid fa-cart-shopping"></i>
        <span class="d-none-mobile">{{ 'Carrito' | translate }}</span>
        <span class="cart-count-badge js-cart-widget-amount js-cart-count">{{ cart.items_count }}</span>
      </a>

      <!-- Mobile Hamburger Toggle -->
      <button type="button" class="mobile-menu-toggle js-open-mobile-menu d-lg-none" id="mobileMenuToggle" title="{{ 'Abrir Menú' | translate }}" aria-label="{{ 'Abrir Menú' | translate }}">
        <i class="fa-solid fa-bars"></i>
      </button>
    </div>

  </div>

  <!-- Mobile Slide-Down Search Bar -->
  <div class="mobile-search-bar" id="mobileSearchBar">
    <div class="container mobile-search-container">
      <form class="mobile-search-form js-search-form" id="mobileHeaderSearchForm" action="{{ store.search_url | default('/search/') }}" method="get">
        <div class="mobile-search-input-box">
          <i class="fa-solid fa-magnifying-glass mobile-search-icon"></i>
          <input type="search" name="q" id="mobileHeaderSearchInput" class="mobile-search-input js-search-input" placeholder="{{ 'Buscar herramientas, bombas, repuestos...' | translate }}" autocomplete="off">
          <button type="button" class="mobile-search-clear js-empty-search" id="mobileSearchClearBtn" title="{{ 'Limpiar texto' | translate }}" style="display: none;">
            <i class="fa-solid fa-xmark"></i>
          </button>
        </div>
        <button type="button" class="mobile-search-close-btn js-close-mobile-search" id="mobileSearchCloseBtn" title="{{ 'Cerrar buscador' | translate }}">
          {{ 'Cancelar' | translate }}
        </button>
      </form>
      <div id="mobileSearchDropdown" class="search-dropdown mobile-search-dropdown js-search-form-suggestions">
        <div class="search-dropdown-header">{{ 'Sugerencias destacadas' | translate }}</div>
        <div id="mobileSearchResultsList" class="js-search-results"></div>
      </div>
    </div>
  </div>

  <!-- 3. Desktop Main Navigation Bar with Mega-Dropdowns -->
  <nav class="nav-bar d-none d-lg-block">
    <div class="container nav-inner">
      <ul class="nav-list">
        <!-- 1. Inicio -->
        <li class="nav-item">
          <a href="{{ store.home_url }}" class="nav-link {% if template == 'home' %}active{% endif %}">
            <i class="fa-solid fa-house"></i> {{ 'Inicio' | translate }}
          </a>
        </li>

        <!-- 2. Categorías Mega Dropdown -->
        <li class="nav-item has-mega-dropdown">
          <a href="{% if store.categories_url %}{{ store.categories_url }}{% else %}{{ store.products_url }}{% endif %}" class="nav-link {% if template == 'category' %}active{% endif %}">
            {{ 'Categorías' | translate }} <i class="fa-solid fa-chevron-down" style="font-size: 0.75em; margin-left: 2px;"></i>
          </a>
          <div class="mega-dropdown mega-dropdown-categories-featured">
            <div class="dropdown-categories-wrapper">
              <div class="dropdown-categories-header">
                <div class="dropdown-categories-title">
                  <h4>{{ 'Categorías Principales' | translate }}</h4>
                </div>
                <span class="badge-official-pill"><i class="fa-solid fa-boxes-stacked"></i> Catálogo HMC</span>
              </div>

              <!-- 12 Top Categories Grid (4 cols x 3 rows, Dynamic & Alphabetical) -->
              <div class="dropdown-categories-grid">
                {% include "snipplets/navigation/navigation-categories-dropdown.tpl" %}
              </div>

              <!-- Footer CTA Button -->
              <div class="dropdown-categories-footer">
                <div class="dropdown-categories-footer-text">
                  <i class="fa-solid fa-layer-group text-primary"></i>
                  <span>Más de <strong>13 rubros industriales</strong> y 460 subrubros con stock y repuestos.</span>
                </div>
                <a href="{% if store.categories_url %}{{ store.categories_url }}{% else %}{{ store.products_url }}{% endif %}" class="btn btn-primary btn-sm btn-explore-categories">
                  {{ 'Todas las categorías →' | translate }}
                </a>
              </div>
            </div>
          </div>
        </li>

        <!-- 3. Marcas Dropdown -->
        <li class="nav-item has-mega-dropdown">
          <a href="{{ store.products_url }}?brand_filter=true" class="nav-link">
            {{ 'Marcas' | translate }} <i class="fa-solid fa-chevron-down" style="font-size: 0.75em; margin-left: 2px;"></i>
          </a>
          
          <div class="mega-dropdown mega-dropdown-brands-featured">
            <div class="dropdown-brands-wrapper">
              <div class="dropdown-brands-header">
                <div class="dropdown-brands-title">
                  <h4>{{ 'Marcas Destacadas' | translate }}</h4>
                </div>
                <span class="badge-official-pill"><i class="fa-solid fa-shield-halved"></i> Garantía Oficial</span>
              </div>

              <!-- 8 Featured Brands Grid -->
              <div class="dropdown-brands-grid">
                {% set official_brands = ["OREGON", "NIWA", "BOSCH", "EINHELL", "HUSQVARNA", "GARDENA", "SENSEI", "HONDA"] %}
                {% for brand in official_brands %}
                  <a href="{{ store.products_url }}?brand={{ brand | url_encode }}" class="dropdown-brand-card" title="Ver catálogo oficial {{ brand }}">
                    <div class="dropdown-brand-name">
                      <span>{{ brand }}</span>
                    </div>
                  </a>
                {% endfor %}
              </div>

              <!-- Footer CTA Button -->
              <div class="dropdown-brands-footer">
                <div class="dropdown-brands-footer-text">
                  <i class="fa-solid fa-layer-group text-primary"></i>
                  <span>Representamos a más de <strong>100 fabricantes líderes</strong> con stock y repuestos.</span>
                </div>
                <a href="{{ store.products_url }}?brand_filter=true" class="btn btn-primary btn-sm btn-explore-brands">
                  {{ 'Todas las marcas →' | translate }}
                </a>
              </div>
            </div>
          </div>
        </li>

        <!-- 4. Ofertas -->
        <li class="nav-item">
          <a href="{{ store.products_url }}?offers=true" class="nav-link has-badge">{{ 'Ofertas' | translate }}</a>
        </li>

        <!-- 5. Nosotros -->
        <li class="nav-item">
          <a href="{{ store.about_url | default('/nosotros') }}" class="nav-link">{{ 'Nosotros' | translate }}</a>
        </li>

        <!-- 6. Contacto -->
        <li class="nav-item">
          <a href="{{ store.contact_url }}" class="nav-link">{{ 'Contacto' | translate }}</a>
        </li>
      </ul>

      <!-- Direct Technical Advice Link in Navbar -->
      <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="nav-support-link">
        <i class="fa-brands fa-whatsapp"></i> {{ 'Asesoría Técnica' | translate }}
      </a>
    </div>
  </nav>
</header>

{{ component('nubesdk-slot', { type: "after_header" }) }}

{# 4. Mobile Off-Canvas Drawer Menu #}
{% include "snipplets/navigation/navigation-drawer.tpl" %}

{# Show cookie validation message #}
{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Header modals (Cart Modal, etc.) #}
{% include "snipplets/header/header-modals.tpl" %}
