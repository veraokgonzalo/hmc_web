{# /*============================================================================
  #Breadcrumbs bar
==============================================================================*/
#Full-width gray breadcrumb bar at the top of the page, same as the custom pages
#("Nosotros" page.about.tpl, contact.tpl, page.brands.tpl).
#  //breadcrumbs_bar_class: extra classes for the bar (e.g. spacing)
#}

{% if breadcrumbs %}
	<div class="breadcrumbs-section {{ breadcrumbs_bar_class }}">
		<div class="container">
			{% include 'snipplets/breadcrumbs.tpl' %}
		</div>
	</div>
{% endif %}
