{# /*============================================================================
  #Home Featured Categories (HMC HUB)
==============================================================================*/ #}

{% set has_custom_categories = settings.slider_categories and settings.slider_categories is not empty %}

{% set default_categories = [
	{
		'slug': 'agua',
		'name': 'Agua',
		'image': 'images/categories/categoria-3-agua-bombeo.webp',
		'count': 'Equipos de Bombeo',
		'link': '/agua'
	},
	{
		'slug': 'construccion',
		'name': 'Construcción',
		'image': 'images/categories/categoria-4-construccion.webp',
		'count': 'Maquinaria Pesada',
		'link': '/construccion'
	},
	{
		'slug': 'consumibles-e-insumos',
		'name': 'Consumibles e Insumos',
		'image': 'images/categories/categoria-6-accesorios-insumos.webp',
		'count': 'Discos, Mechas e Insumos',
		'link': '/consumibles-e-insumos'
	},
	{
		'slug': 'ferreteria',
		'name': 'Ferretería',
		'image': 'images/categories/categoria-1-ferreteria.webp',
		'count': 'Herramientas y Bulonería',
		'link': '/ferreteria'
	},
	{
		'slug': 'maquina-a-bateria',
		'name': 'Herramientas a Batería',
		'image': 'images/categories/categoria-5-herramientas-bateria.webp',
		'count': 'Líneas 18V y Brushless',
		'link': '/maquina-a-bateria'
	},
	{
		'slug': 'maquina-a-explosion',
		'name': 'Máquinas a Explosión',
		'image': 'images/categories/categoria-2-maquinas-explosion.webp',
		'count': 'Motosierras y Generadores',
		'link': '/maquina-a-explosion'
	}
] %}

<section class="section-padding categories-section" id="categorias" data-store="home-categories-featured">
	<div class="container">
		<div class="section-header text-center mb-4">
			<h2 class="section-title h2 font-weight-bold mb-2">{{ settings.main_categories_title | default('Categorías Destacadas' | translate) }}</h2>
		</div>

		<div class="categories-grid">
			{% if has_custom_categories %}
				{% for slide in settings.slider_categories %}
					{% set slide_url = slide.link ? slide.link | setting_url : '#' %}
					<div class="category-card" onclick="location.href='{{ slide_url }}'">
						<div class="category-img-wrapper">
							<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('medium') }}" class="category-img lazyload" alt="{{ 'Categoría' | translate }} {{ loop.index }}">
						</div>
						<h3 class="category-name">
							{% set category_handle = slide.link | trim('/') | split('/') | last %}
							{% include 'snipplets/home/home-categories-name.tpl' %}
						</h3>
					</div>
				{% endfor %}
			{% else %}
				{% for cat in default_categories %}
					{% set cat_url = cat.link %}
					{% set cat_name = cat.name %}
					{% set cat_count = cat.count %}
					{% for db_cat in categories %}
						{% if db_cat.handle == cat.slug or (db_cat.url and db_cat.url | trim('/') | split('/') | last == cat.slug) %}
							{% set cat_url = db_cat.url %}
							{% set cat_name = db_cat.name %}
							{% if db_cat.products_count and db_cat.products_count > 0 %}
								{% set cat_count = db_cat.products_count ~ ' ' ~ ('Equipos' | translate) %}
							{% endif %}
						{% endif %}
					{% endfor %}
					<div class="category-card" onclick="location.href='{{ cat_url }}'">
						<div class="category-img-wrapper">
							<img src="{{ cat.image | static_url }}" alt="{{ cat_name }}" class="category-img" loading="lazy">
						</div>
						<h3 class="category-name">{{ cat_name }}</h3>
						<span class="category-count">{{ cat_count }}</span>
					</div>
				{% endfor %}
			{% endif %}
		</div>

		<div class="text-center mt-4 pt-2">
			<a href="{{ store.products_url ? store.products_url : '/productos' }}" class="btn btn-primary btn-lg">
				<i class="fa-solid fa-layer-group mr-2"></i> {{ 'Explorar Catálogo' | translate }}
			</a>
		</div>
	</div>
</section>
