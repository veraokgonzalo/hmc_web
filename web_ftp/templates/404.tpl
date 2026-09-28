{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{# Here we will add an example as a help, you can delete this after you upload your products #}

{% if show_help %}
	<div id="product-example">
		{% snipplet 'defaults/show_help_product.tpl' %}
	</div>
{% else %}
	{% embed "snipplets/page-header.tpl" %}
		{% block page_header_text %}{{ "Error" | translate }} - {{ "404" | translate }}{% endblock page_header_text %}
	{% endembed %}
	<section id="page-error" class="page-error my-4">
		<div class="container mb-4">
			<h2 class="h4 mb-3">{{ "La página que estás buscando no existe o fue movida." | translate }}</h2>
			<div class="page-error-actions mb-4">
				<a href="{{ store.url | default('/') }}" class="btn btn-primary mr-2 mb-2">
					<i class="fa-solid fa-house mr-1"></i> {{ "Volver al inicio" | translate }}
				</a>
				<a href="{{ store.products_url | default('/productos') }}" class="btn btn-secondary mb-2">
					<i class="fa-solid fa-boxes-stacked mr-1"></i> {{ "Ver catálogo de productos" | translate }}
				</a>
			</div>
			{% set related_products = sections.primary.products | take(4) | shuffle %}
			{% if related_products | length > 1 %}
				<div class="mt-4 pt-3 font-weight-bold" style="border-top: 1px solid #eee;">{{ "Quizás te interesen los siguientes productos:" | translate }}</div>
			{% endif %}
			{% if related_products | length > 1 %}
				<div class="section-products-related overflow-none">
					<div class="row row-grid">
						{% for related in related_products %}
							{% include 'snipplets/grid/item.tpl' with {product : related} %}
						{% endfor %}
					</div>
				</div>
			{% endif %}
		</div>
	</section>
{% endif %}