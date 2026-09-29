{% if page.handle in ['nosotros', 'quienes-somos', 'sobre-nosotros', 'about', 'empresa'] or template == 'page.about' %}
	{% include 'templates/page.about.tpl' %}
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
