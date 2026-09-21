{# /*============================================================================
  #Mobile Bottom App Bar (HMC HUB - 5 Core Actions)
==============================================================================*/ #}

<nav class="mobile-bottom-nav d-md-none" aria-label="{{ 'Navegación rápida inferior' | translate }}">
  <a href="{{ store.home_url }}" class="mobile-nav-btn {% if template == 'home' %}active{% endif %}" data-page="index">
    <i class="fa-solid fa-house"></i>
    <span>{{ 'Inicio' | translate }}</span>
  </a>

  <a href="{% if store.categories_url %}{{ store.categories_url }}{% else %}{{ store.products_url }}{% endif %}" class="mobile-nav-btn {% if template == 'category' %}active{% endif %}" data-page="categories">
    <i class="fa-solid fa-layer-group"></i>
    <span>{{ 'Categorías' | translate }}</span>
  </a>

  <a href="{{ store.products_url }}?brand_filter=true" class="mobile-nav-btn" data-page="brands">
    <i class="fa-solid fa-certificate"></i>
    <span>{{ 'Marcas' | translate }}</span>
  </a>

  <a {% if settings.ajax_cart and template != 'cart' %}href="#" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"{% else %}href="{{ store.cart_url }}"{% endif %} class="mobile-nav-btn js-open-cart {% if settings.ajax_cart and template != 'cart' %}js-modal-open js-fullscreen-modal-open{% endif %}" data-page="cart">
    <div class="position-relative d-inline-block">
      <i class="fa-solid fa-cart-shopping"></i>
      <span class="cart-count-badge js-cart-widget-amount js-cart-count">{{ cart.items_count }}</span>
    </div>
    <span>{{ 'Carrito' | translate }}</span>
  </a>

  <button type="button" class="mobile-nav-btn js-open-mobile-menu" data-page="menu" aria-label="{{ 'Abrir menú de navegación' | translate }}">
    <i class="fa-solid fa-bars"></i>
    <span>{{ 'Menú' | translate }}</span>
  </button>
</nav>
