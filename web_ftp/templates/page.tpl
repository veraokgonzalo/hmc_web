{% if page.handle in ['nosotros', 'quienes-somos', 'sobre-nosotros', 'about', 'empresa'] or template == 'page.about' %}
	{% include 'templates/page.about.tpl' %}
{% elseif page.handle in ['marcas', 'marcas-1', 'marcas-2', 'brands', 'fabricantes', 'directorio-marcas', 'directorio-de-marcas'] or page.name | lower in ['marcas', 'brands', 'fabricantes', 'directorio de marcas', 'marcas oficiales'] or template == 'page.brands' %}
	{% include 'templates/page.brands.tpl' %}
{% else %}
	{% embed "snipplets/page-header.tpl" %}
		{% block page_header_text %}{{ page.name }}{% endblock page_header_text %}
	{% endembed %}

	{# Institutional page  #}
	<section class="user-content pb-5">
		<div class="container">
			<div class="row">
				<div class="col-md-8">
					{{ page.content }}
				</div>
			</div>
		</div>
	</section>
{% endif %}
