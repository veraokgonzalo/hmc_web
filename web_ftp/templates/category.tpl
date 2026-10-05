{% set is_real_category = category and category.id and category.handle not in ['productos', 'todos-los-productos'] and category.name | lower not in ['productos', 'todos los productos', 'todo el catalogo', 'catalogo'] %}
{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty or is_real_category) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% paginate by 12 %}
{% else %}
	{% if settings.grid_columns_desktop == '5' %}
		{% paginate by 50 %}
	{% else %}
		{% paginate by 48 %}
	{% endif %}
{% endif %}

{# Root Marcas Category Interceptor -> Official Brands Directory #}
{% set is_marcas_root = category and (category.handle in ['marcas', 'brands', 'fabricantes'] or category.name | lower in ['marcas', 'marcas oficiales', 'marcas destacadas']) and (not parent_category or parent_category.id == 0) %}

{% if is_marcas_root %}
	{% include 'templates/page.brands.tpl' %}
{% elseif not show_help %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}

{% if category_banner %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

{% include 'snipplets/breadcrumbs-bar.tpl' with {breadcrumbs_bar_class: 'mb-md-3'} %}
<h1 class="sr-only">{{ is_real_category ? category.name : ('Productos' | translate) }}</h1>

{% include 'snipplets/grid/filters-modals.tpl' %}
<section class="js-category-controls-prev category-controls-sticky-detector"></section>

<section class="category-body" data-store="category-grid{% if category.id %}-{{ category.id }}{% endif %}">
	<div class="container mt-3 mb-5">
		{# Dynamic Promotional Offers Banner #}
		{% set is_offers_category = params.offers == 'true' or (category and category.name | lower in ['ofertas', 'liquidación', 'liquidacion', 'promociones']) %}
		<div id="catalogOffersPromoBanner" class="catalog-offers-banner mb-4" {% if not is_offers_category %}style="display: none;"{% endif %}>
			<div class="catalog-offers-banner-inner">
				<div class="catalog-offers-text">
					<div class="section-tag section-tag-danger mb-2">
						<i class="fa-solid fa-bolt mr-1"></i> {{ 'Oportunidades por Tiempo Limitado' | translate }}
					</div>
					<h2 class="catalog-offers-title mb-1">{{ 'Liquidación y Ofertas Especiales' | translate }}</h2>
					<p class="catalog-offers-desc mb-0">
						{{ 'Equipos de primeras marcas con importantes descuentos, financiación y garantía oficial de fábrica.' | translate }}
					</p>
				</div>
				<div class="catalog-offers-pill">
					<i class="fa-solid fa-tags mr-2"></i> {{ 'Precios Promocionales' | translate }}
				</div>
			</div>
		</div>

		<div class="row">
			{% if has_filters_available %} 
				{% include 'snipplets/grid/filters-sidebar.tpl' %}
			{% endif %}
			{% include 'snipplets/grid/products-list.tpl' %}
		</div>
	</div>
</section>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}