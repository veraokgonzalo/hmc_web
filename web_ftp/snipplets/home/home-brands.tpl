{% set has_custom_brands = settings.brands and settings.brands is not empty %}
{# En HMC Hub, la sección de marcas se muestra siempre como Marquee continuo por defecto a menos que se configure explícitamente en Grilla #}
{% set is_marquee = settings.brands_format != 'grid' %}

{% if not has_custom_brands %}
	{% set default_brands = [
		{'name': 'ALPEN', 'image': 'images/brands/alpen.png', 'link': '/search/?q=ALPEN'},
		{'name': 'BEAR CAT', 'image': 'images/brands/bear-cat.png', 'link': '/search/?q=BEAR+CAT'},
		{'name': 'ECHO', 'image': 'images/brands/echo.png', 'link': '/search/?q=ECHO'},
		{'name': 'FELCO', 'image': 'images/brands/felco.png', 'link': '/search/?q=FELCO'},
		{'name': 'GARDENA', 'image': 'images/brands/gardena.png', 'link': '/search/?q=GARDENA'},
		{'name': 'GREENWORKS', 'image': 'images/brands/greenworks.png', 'link': '/search/?q=GREENWORKS'},
		{'name': 'GRUPO RUMBO', 'image': 'images/brands/grupo-rumbo.png', 'link': '/search/?q=RUMBO'},
		{'name': 'HUNTER', 'image': 'images/brands/hunter.png', 'link': '/search/?q=HUNTER'},
		{'name': 'HUSQVARNA', 'image': 'images/brands/husqvarna.png', 'link': '/search/?q=HUSQVARNA'},
		{'name': 'METABO', 'image': 'images/brands/metabo.png', 'link': '/search/?q=METABO'},
		{'name': 'NIWA', 'image': 'images/brands/niwa.png', 'link': '/search/?q=NIWA'},
		{'name': 'OREGON', 'image': 'images/brands/oregon.png', 'link': '/search/?q=OREGON'},
		{'name': 'PAMPA PRO', 'image': 'images/brands/pampa-pro.png', 'link': '/search/?q=PAMPA+PRO'},
		{'name': 'SENSEI', 'image': 'images/brands/sensei.png', 'link': '/search/?q=SENSEI'},
		{'name': 'SHIZEN', 'image': 'images/brands/shizen.png', 'link': '/search/?q=SHIZEN'},
		{'name': 'TECMATER', 'image': 'images/brands/tecmater.png', 'link': '/search/?q=TECMATER'},
		{'name': 'TECOMEC', 'image': 'images/brands/tecomec.png', 'link': '/search/?q=TECOMEC'},
		{'name': 'TORO', 'image': 'images/brands/toro.png', 'link': '/search/?q=TORO'},
		{'name': 'TROY-BILT', 'image': 'images/brands/troy-bilt.png', 'link': '/search/?q=TROY-BILT'},
		{'name': 'ZODIAC', 'image': 'images/brands/zodiac.png', 'link': '/search/?q=ZODIAC'}
	] %}
	{% set brands_items = default_brands %}
{% else %}
	{% set brands_items = settings.brands %}
{% endif %}

<section class="section-brands-home brands-section {% if settings.brands_colors %}section-brands-home-colors{% endif %} overflow-none" id="marcas" data-store="home-brands">
	<div class="container">
		<div class="section-header" style="margin-bottom: 32px;">
			<h2 class="section-title">{{ settings.brands_title | default('Nuestras Marcas' | translate) }}</h2>
		</div>
		<div class="row align-items-center">
			<div class="col-12">
				{% if is_marquee %}
					<div class="brands-marquee-wrapper">
						<button type="button" class="brands-marquee-arrow brands-marquee-arrow-prev js-brands-marquee-prev" aria-label="{{ 'Anterior' | translate }}" title="{{ 'Anterior' | translate }}">
							<i class="fa-solid fa-chevron-left" style="pointer-events: none;"></i>
						</button>
						<div class="brands-marquee-container" data-speed="{{ settings.brands_marquee_speed | default(42) }}">
						<div class="brands-marquee-track" style="--marquee-speed: {{ settings.brands_marquee_speed | default(42) }}s;">
							<div class="brands-marquee-group">
								{% for slide in brands_items %}
									{% set slide_url = slide.link ? (has_custom_brands ? slide.link | setting_url : slide.link) : '' %}
									{% if slide_url %}
										<a href="{{ slide_url }}" class="brand-marquee-card" title="{{ slide.name ? slide.name : ('Marca {1}' | translate(loop.index)) }}">
									{% else %}
										<div class="brand-marquee-card">
									{% endif %}
											{% if has_custom_brands %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload" alt="{{ slide.name ? slide.name : ('Marca {1}' | translate(loop.index)) }}">
											{% else %}
												<img src="{{ slide.image | static_url }}" alt="{{ slide.name }}">
											{% endif %}
									{% if slide_url %}
										</a>
									{% else %}
										</div>
									{% endif %}
								{% endfor %}
							</div>
							<div class="brands-marquee-group" aria-hidden="true">
								{% for slide in brands_items %}
									{% set slide_url = slide.link ? (has_custom_brands ? slide.link | setting_url : slide.link) : '' %}
									{% if slide_url %}
										<a href="{{ slide_url }}" class="brand-marquee-card" tabindex="-1">
									{% else %}
										<div class="brand-marquee-card" tabindex="-1">
									{% endif %}
											{% if has_custom_brands %}
												<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload" alt="">
											{% else %}
												<img src="{{ slide.image | static_url }}" alt="">
											{% endif %}
									{% if slide_url %}
										</a>
									{% else %}
										</div>
									{% endif %}
								{% endfor %}
							</div>
						</div>
						</div>
						<button type="button" class="brands-marquee-arrow brands-marquee-arrow-next js-brands-marquee-next" aria-label="{{ 'Siguiente' | translate }}" title="{{ 'Siguiente' | translate }}">
							<i class="fa-solid fa-chevron-right" style="pointer-events: none;"></i>
						</button>
					</div>
				{% else %}
					<div class="row justify-content-center">
						{% for slide in brands_items %}
							{% set slide_url = slide.link ? (has_custom_brands ? slide.link | setting_url : slide.link) : '' %}
							<div class="col-md-2 col-4 text-center mb-3">
								{% if slide_url %}
									<a href="{{ slide_url }}" class="brand-marquee-card w-100" title="{{ slide.name ? slide.name : ('Marca {1}' | translate(loop.index)) }}">
								{% else %}
									<div class="brand-marquee-card w-100">
								{% endif %}
									{% if has_custom_brands %}
										<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload" alt="{{ slide.name ? slide.name : ('Marca {1}' | translate(loop.index)) }}">
									{% else %}
										<img src="{{ slide.image | static_url }}" alt="{{ slide.name }}" loading="lazy">
									{% endif %}
								{% if slide_url %}
									</a>
								{% else %}
									</div>
								{% endif %}
							</div>
						{% endfor %}
					</div>
				{% endif %}
			</div>
		</div>

		<div style="text-align: center; margin-top: 32px;">
			<a href="/marcas" class="btn btn-outline-primary btn-lg">
				<i class="fa-solid fa-layer-group mr-2"></i> {{ 'Directorio de marcas' | translate }}
			</a>
		</div>
	</div>
</section>
