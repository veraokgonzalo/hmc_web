{# /*============================================================================
  #Breadcrumbs bar
==============================================================================*/
#Full-width breadcrumb bar at the top of the page, same markup as the container
#version of snipplets/page-header.tpl (institutional pages like "Nosotros"),
#for templates that render their title elsewhere (product, contact).
#  //breadcrumbs_bar_class: spacing classes for the bar (default mb-4)
#}

<div class="background-secondary {{ breadcrumbs_bar_class ?? 'mb-4' }}">
	<div class="container">
		<section class="page-header pt-3 pt-md-4 pb-1">
			{% include 'snipplets/breadcrumbs.tpl' %}
		</section>
	</div>
</div>
