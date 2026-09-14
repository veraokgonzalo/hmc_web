{% set has_custom_brands = settings.brands and settings.brands is not empty %}
{# En HMC Hub, la sección de marcas se muestra siempre como Marquee continuo por defecto a menos que se configure explícitamente en Grilla #}
{% set is_marquee = settings.brands_format != 'grid' %}

{% if not has_custom_brands %}
	{% set default_brands = [
		{'name': 'BOSCH', 'image': 'images/brands/bosch.svg', 'link': '/search/?q=BOSCH'},
		{'name': 'DEWALT', 'image': 'images/brands/dewalt.svg', 'link': '/search/?q=DEWALT'},
		{'name': 'HUSQVARNA', 'image': 'images/brands/husqvarna.svg', 'link': '/search/?q=HUSQVARNA'},
		{'name': 'STIHL', 'image': 'images/brands/stihl.svg', 'link': '/search/?q=STIHL'},
		{'name': 'EINHELL', 'image': 'images/brands/einhell.svg', 'link': '/search/?q=EINHELL'},
		{'name': 'HONDA', 'image': 'images/brands/honda.svg', 'link': '/search/?q=HONDA'},
		{'name': 'GARDENA', 'image': 'images/brands/gardena.svg', 'link': '/search/?q=GARDENA'},
		{'name': 'NIWA', 'image': 'images/brands/niwa.svg', 'link': '/search/?q=NIWA'},
		{'name': 'SENSEI', 'image': 'images/brands/sensei.png', 'link': '/search/?q=SENSEI'},
		{'name': 'OREGON', 'image': 'images/brands/oregon.png', 'link': '/search/?q=OREGON'},
		{'name': 'DOWEN PAGIO', 'image': 'images/brands/dowen-pagio.svg', 'link': '/search/?q=DOWEN+PAGIO'},
		{'name': 'MAKITA', 'image': 'images/brands/makita.svg', 'link': '/search/?q=MAKITA'},
		{'name': 'SHINDAIWA', 'image': 'images/brands/shindaiwa.svg', 'link': '/search/?q=SHINDAIWA'},
		{'name': 'BAHCO', 'image': 'images/brands/bahco.svg', 'link': '/search/?q=BAHCO'},
		{'name': 'STANLEY', 'image': 'images/brands/stanley.svg', 'link': '/search/?q=STANLEY'},
		{'name': 'ECHO', 'image': 'images/brands/echo.svg', 'link': '/search/?q=ECHO'},
		{'name': 'LUSQTOFF', 'image': 'images/brands/lusqtoff.svg', 'link': '/search/?q=LUSQTOFF'},
		{'name': 'HUNTER', 'image': 'images/brands/hunter.png', 'link': '/search/?q=HUNTER'},
		{'name': 'METABO', 'image': 'images/brands/metabo.svg', 'link': '/search/?q=METABO'},
		{'name': 'DREMEL', 'image': 'images/brands/dremel.svg', 'link': '/search/?q=DREMEL'},
		{'name': 'KARCHER', 'image': 'images/brands/karcher.svg', 'link': '/search/?q=KARCHER'}
	] %}
	{% set brands_items = default_brands %}
{% else %}
	{% set brands_items = settings.brands %}
{% endif %}

<section class="section-brands-home {% if settings.brands_colors %}section-brands-home-colors{% endif %} overflow-none" data-store="home-brands">
	<div class="container">
		{% if settings.brands_title %}
			<div class="text-center mb-3">
				<h2 class="h5 m-0 font-weight-bold">{{ settings.brands_title }}</h2>
			</div>
		{% endif %}
		<div class="row align-items-center">
			<div class="col-12">
				{% if is_marquee %}
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
												<img src="{{ slide.image | static_url }}" alt="{{ slide.name }}" loading="lazy">
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
												<img src="{{ slide.image | static_url }}" alt="" loading="lazy">
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
	</div>
</section>
