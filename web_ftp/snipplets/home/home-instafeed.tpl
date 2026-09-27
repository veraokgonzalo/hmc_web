{# /*============================================================================
  #Home Instagram Feed & Community (HMC HUB)
==============================================================================*/ #}

{% set instagram_handle = store.instagram ? (store.instagram | trim('/') | split('/') | last) : 'hmchub' %}
{% set instagram_url = store.instagram ? store.instagram : 'https://instagram.com/hmchub' %}

<section class="section-padding instafeed-section" id="comunidad" data-store="home-instagram-feed">
	<div class="container">
		<div class="section-header">
			<div class="section-tag"><i class="fa-brands fa-instagram mr-1"></i> @{{ instagram_handle }}</div>
			<h2 class="section-title">{{ 'Comunidad en Obra y Campo' | translate }}</h2>
			<p class="section-subtitle">{{ 'Seguinos en redes para ver tips de mantenimiento, demostraciones de herramientas y novedades de catálogo.' | translate }}</p>
		</div>

		{% if store.hasInstagramToken() %}
			<div class="js-ig-success insta-grid"
				data-ig-feed
				data-ig-items-count="6"
				data-ig-item-class="insta-item"
				data-ig-link-class="insta-item-link"
				data-ig-image-class="insta-img fade-in"
				data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}"
				style="display: none;">
			</div>
			<div class="js-ig-fallback insta-grid">
				{% set default_ig_images = [
					'images/products/prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp',
					'images/products/prod-06-martillo-demoledor-dewalt-d25960-principal.webp',
					'images/products/prod-07-taladro-impacto-einhell-te-cd18-principal.webp',
					'images/products/prod-03-martillo-demoledor-bosch-gsh11e-principal.webp',
					'images/products/prod-11-motoguadana-shindaiwa-b530-principal.webp',
					'images/products/prod-12-motoguadana-sensei-bd26-principal.webp'
				] %}
				{% for img_path in default_ig_images %}
					<a href="{{ instagram_url }}" target="_blank" rel="noopener noreferrer" class="insta-item" aria-label="Instagram @{{ instagram_handle }}">
						<img src="{{ img_path | static_url }}" alt="Instagram HMC Hub {{ loop.index }}" class="insta-img" loading="lazy">
						<div class="insta-overlay"><i class="fa-brands fa-instagram"></i></div>
					</a>
				{% endfor %}
			</div>
		{% else %}
			{% set default_ig_images = [
				'images/products/prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp',
				'images/products/prod-06-martillo-demoledor-dewalt-d25960-principal.webp',
				'images/products/prod-07-taladro-impacto-einhell-te-cd18-principal.webp',
				'images/products/prod-03-martillo-demoledor-bosch-gsh11e-principal.webp',
				'images/products/prod-11-motoguadana-shindaiwa-b530-principal.webp',
				'images/products/prod-12-motoguadana-sensei-bd26-principal.webp'
			] %}
			<div class="insta-grid">
				{% for img_path in default_ig_images %}
					<a href="{{ instagram_url }}" target="_blank" rel="noopener noreferrer" class="insta-item" aria-label="Instagram @{{ instagram_handle }}">
						<img src="{{ img_path | static_url }}" alt="Instagram HMC Hub {{ loop.index }}" class="insta-img" loading="lazy">
						<div class="insta-overlay"><i class="fa-brands fa-instagram"></i></div>
					</a>
				{% endfor %}
			</div>
		{% endif %}
	</div>
</section>
