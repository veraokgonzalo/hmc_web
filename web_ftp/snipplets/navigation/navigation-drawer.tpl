{# /*============================================================================
  #Mobile Off-Canvas Drawer Menu (HMC HUB)
==============================================================================*/ #}

{% set core_categories = [
  {'slug': 'agua', 'name': 'Agua', 'link': '/agua'},
  {'slug': 'construccion', 'name': 'Construcción', 'link': '/construccion'},
  {'slug': 'consumibles-e-insumos', 'name': 'Consumibles e Insumos', 'link': '/consumibles-e-insumos'},
  {'slug': 'ferreteria', 'name': 'Ferretería', 'link': '/ferreteria'},
  {'slug': 'generacion-energia', 'name': 'Generación Energía', 'link': '/generacion-energia'},
  {'slug': 'jardin', 'name': 'Jardín', 'link': '/jardin'},
  {'slug': 'maquina-a-bateria', 'name': 'Máquinas a Batería', 'link': '/maquina-a-bateria'},
  {'slug': 'maquina-a-explosion', 'name': 'Máquinas a Explosión', 'link': '/maquina-a-explosion'},
  {'slug': 'maquina-electrica', 'name': 'Máquinas Eléctricas', 'link': '/maquina-electrica'},
  {'slug': 'producto-de-fuerza', 'name': 'Productos de Fuerza', 'link': '/producto-de-fuerza'},
  {'slug': 'repuestos', 'name': 'Repuestos', 'link': '/repuestos'},
  {'slug': 'riego', 'name': 'Riego', 'link': '/riego'}
] %}

{% set official_brands = ["OREGON", "NIWA", "BOSCH", "EINHELL", "HUSQVARNA", "GARDENA", "SENSEI", "HONDA"] %}

<div class="mobile-drawer-overlay js-drawer-overlay" id="mobileDrawerOverlay"></div>

<aside class="mobile-drawer-menu" id="mobileDrawerMenu" aria-label="{{ 'Menú lateral de navegación' | translate }}">
  <div class="mobile-drawer-header">
    <img src="{{ 'images/logos/logo-horizontal-white.png' | static_url }}" alt="{{ store.name | default('HMC HUB') }}" class="mobile-drawer-logo">
    <button type="button" class="mobile-drawer-close js-close-mobile-menu" id="mobileDrawerClose" title="{{ 'Cerrar' | translate }}" aria-label="{{ 'Cerrar' | translate }}">
      <i class="fa-solid fa-xmark"></i>
    </button>
  </div>

  <div class="mobile-drawer-search">
    <form id="mobileDrawerSearchForm" action="{{ store.search_url | default('/search/') }}" method="get">
      <input type="search" name="q" id="mobileDrawerSearchInput" placeholder="{{ 'Buscar herramientas, bombas, repuestos...' | translate }}" autocomplete="off">
      <button type="submit" title="{{ 'Buscar' | translate }}" aria-label="{{ 'Buscar' | translate }}">
        <i class="fa-solid fa-magnifying-glass"></i>
      </button>
    </form>
  </div>

  <div class="mobile-drawer-nav">
    <!-- 1. Inicio -->
    <a href="{{ store.home_url }}" class="mobile-nav-link-item {% if template == 'home' %}active{% endif %}">
      <span><i class="fa-solid fa-house mr-2"></i> {{ 'Inicio' | translate }}</span>
    </a>
    
    <!-- 2. Categorías -->
    <div class="mobile-drawer-accordion-header js-drawer-accordion" data-nav="categories">
      <span>{{ 'Categorías' | translate }}</span>
      <i class="fa-solid fa-chevron-down"></i>
    </div>
    <div class="mobile-drawer-accordion-content">
      {% for cat in core_categories %}
        {% set cat_url = cat.link %}
        {% set cat_name = cat.name %}
        {% for db_cat in categories %}
          {% if db_cat.handle == cat.slug or (db_cat.url and db_cat.url | trim('/') | split('/') | last == cat.slug) %}
            {% set cat_url = db_cat.url %}
            {% set cat_name = db_cat.name %}
          {% endif %}
        {% endfor %}
        <a href="{{ cat_url }}" class="mobile-subnav-link">{{ cat_name }}</a>
      {% endfor %}
      <a href="{% if store.categories_url %}{{ store.categories_url }}{% else %}{{ store.products_url }}{% endif %}" class="mobile-subnav-link mobile-subnav-link-cta">
        <span>{{ 'Todas las categorías →' | translate }}</span>
      </a>
    </div>

    <!-- 3. Marcas -->
    <div class="mobile-drawer-accordion-header js-drawer-accordion" data-nav="brands">
      <span>{{ 'Marcas' | translate }}</span>
      <i class="fa-solid fa-chevron-down"></i>
    </div>
    <div class="mobile-drawer-accordion-content">
      {% for brand in official_brands %}
        <a href="{{ store.products_url }}?brand={{ brand | url_encode }}" class="mobile-subnav-link">{{ brand }}</a>
      {% endfor %}
      <a href="{{ store.products_url }}?brand_filter=true" class="mobile-subnav-link mobile-subnav-link-cta">
        <span>{{ 'Todas las marcas →' | translate }}</span>
      </a>
    </div>

    <!-- 4. Ofertas -->
    <a href="{{ store.products_url }}?offers=true" class="mobile-nav-link-item">
      <span>{{ 'Ofertas' | translate }}</span>
      <span class="badge badge-discount">OFF</span>
    </a>

    <!-- 5. Nosotros -->
    <a href="{{ store.about_url | default('/nosotros') }}" class="mobile-nav-link-item">
      <span>{{ 'Nosotros' | translate }}</span>
    </a>

    <!-- 6. Contacto -->
    <a href="{{ store.contact_url }}" class="mobile-nav-link-item">
      <span>{{ 'Contacto' | translate }}</span>
    </a>

    <!-- 7. Mi Cuenta -->
    <a href="{% if not customer %}{{ store.customer_login_url }}{% else %}{{ store.customer_home_url }}{% endif %}" class="mobile-nav-link-item">
      <span><i class="fa-regular fa-user mr-2"></i> {% if not customer %}{{ 'Iniciar Sesión / Registro' | translate }}{% else %}{{ customer.name }}{% endif %}</span>
    </a>

    <!-- 8. Asesoría Técnica -->
    <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="mobile-nav-link-item mobile-nav-support-link" style="color: var(--color-primary-dark); font-weight: 700;">
      <span><i class="fa-brands fa-whatsapp" style="color: #25D366; margin-right: 6px;"></i> {{ 'Asesoría Técnica' | translate }}</span>
    </a>
  </div>

  <div class="mobile-drawer-footer">
    <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="mobile-drawer-wa-card">
      <i class="fa-brands fa-whatsapp"></i>
      <div>
        <div>{{ 'Asesoría Técnica Directa' | translate }}</div>
        <small>{{ 'Respuesta en menos de 15 min' | translate }}</small>
      </div>
    </a>
  </div>
</aside>
