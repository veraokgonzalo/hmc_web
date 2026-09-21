{# /*============================================================================
  #Top Announcement Bar (HMC HUB Marquee & Direct Links)
==============================================================================*/ #}

<div class="top-bar" data-store="top-bar">
  <div class="container top-bar-inner">
    <div class="top-bar-slider">
      <div class="top-bar-marquee-track">
        <div class="top-bar-marquee-content">
          <span><i class="fa-solid fa-truck-fast"></i> {{ 'Envíos a todo el país' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
          <span><i class="fa-solid fa-credit-card"></i> <strong>{{ '6 cuotas fijas' | translate }}</strong> {{ 'sin interés' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
          <span><i class="fa-solid fa-screwdriver-wrench"></i> {{ 'Puesta en marcha oficial' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
        </div>
        <div class="top-bar-marquee-content" aria-hidden="true">
          <span><i class="fa-solid fa-truck-fast"></i> {{ 'Envíos a todo el país' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
          <span><i class="fa-solid fa-credit-card"></i> <strong>{{ '6 cuotas fijas' | translate }}</strong> {{ 'sin interés' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
          <span><i class="fa-solid fa-screwdriver-wrench"></i> {{ 'Puesta en marcha oficial' | translate }}</span>
          <span class="top-bar-marquee-sep">•</span>
        </div>
      </div>
    </div>
    <div class="top-bar-links">
      <a href="{{ store.contact_url }}" class="top-bar-link">
        <i class="fa-solid fa-location-dot"></i> {{ 'Sucursal: Santa Rosa, La Pampa' | translate }}
      </a>
      <a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" class="top-bar-link">
        <i class="fa-brands fa-whatsapp"></i> {{ 'Ventas y Factura A' | translate }}
      </a>
    </div>
  </div>
</div>
