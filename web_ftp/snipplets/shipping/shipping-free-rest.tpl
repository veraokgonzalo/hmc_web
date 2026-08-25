{% if product_detail %}
	
	{% if not product.free_shipping %}

		{# Wording to notice that adding one more product free shipping is achieved #}

		<div class="js-shipping-add-product-label my-2 pt-1" style="display: none;">
			<span class='js-fs-add-this-product'>{{ "¡Agregá este producto y " | translate }}</span>
			<span class='js-fs-add-one-more' style='display: none;'>{{ "¡Agregá uno más y " | translate }}</span>
			<strong class='text-accent'>{{ "tenés envío gratis!" | translate }}</strong>
		</div>
	{% endif %}

{% else %}
	{{ component('free-shipping-bar', {
		progress_bar_classes: {
			container: 'js-ship-free-rest progress-bar mt-2 mb-5 pb-1',
			title_container: 'progress-bar-title-container',
			title: 'js-ship-free-rest-message ship-free-rest-message progress-bar-title font-weight-bold text-accent',
			track: 'bar-progress',
			fill: 'bar-progress-active transition-soft',
		},
		svg_sprites: false,
		progress_bar_custom_icon: include('snipplets/svg/truck.tpl', { svg_custom_class: 'icon-inline svg-icon-accent' }),
		show_check: false,
	}) }}
{% endif %}
