{# /*============================================================================
  #Home Sale Offers with Countdown Timer (HMC HUB)
==============================================================================*/ #}

{# Aggregate all genuine offers from available store sections on the home page #}
{% set real_offers = [] %}
{% set offer_product_ids = [] %}

{# 1. Products explicitly assigned to sections.sale (Configured under Productos en Oferta) #}
{% if sections.sale.products and sections.sale.products is not empty %}
	{% for product in sections.sale.products %}
		{% if product.id not in offer_product_ids %}
			{% set real_offers = real_offers | merge([product]) %}
			{% set offer_product_ids = offer_product_ids | merge([product.id]) %}
		{% endif %}
	{% endfor %}
{% endif %}

{# 2. Products explicitly assigned to sections.promotion (Configured under Promociones) #}
{% if sections.promotion.products and sections.promotion.products is not empty %}
	{% for product in sections.promotion.products %}
		{% if product.id not in offer_product_ids %}
			{% set real_offers = real_offers | merge([product]) %}
			{% set offer_product_ids = offer_product_ids | merge([product.id]) %}
		{% endif %}
	{% endfor %}
{% endif %}

{# 3. Dynamic Scan: Check all products in primary (destacados), new (novedades), and best_seller for active promotional prices or discounts #}
{% set candidate_products = [] %}
{% if sections.primary.products %}
	{% set candidate_products = candidate_products | merge(sections.primary.products) %}
{% endif %}
{% if sections.new.products %}
	{% set candidate_products = candidate_products | merge(sections.new.products) %}
{% endif %}
{% if sections.best_seller.products %}
	{% set candidate_products = candidate_products | merge(sections.best_seller.products) %}
{% endif %}

{% for product in candidate_products %}
	{% if product.id not in offer_product_ids %}
		{% set is_discounted = (product.compare_at_price and (product.compare_at_price > product.price)) or product.promotional_offer or product.has_discount or product.hasVisiblePromotionLabel %}
		{% if is_discounted %}
			{% set real_offers = real_offers | merge([product]) %}
			{% set offer_product_ids = offer_product_ids | merge([product.id]) %}
		{% endif %}
	{% endif %}
{% endfor %}

{# The offers section ONLY renders if real, verified offers exist in the store #}
{% if real_offers and real_offers is not empty %}
<section class="section-padding timer-offers-section" id="ofertas" data-store="home-offers-timer">
	<div class="container">
		
		{# Countdown Banner Header #}
		<div class="timer-banner">
			<div class="timer-banner-info">
				<h3>{{ settings.sale_products_title | default('Ofertas Especiales de Temporada' | translate) }}</h3>
				<p>{{ 'Aprovechá descuentos exclusivos y financiación en cuotas fijas antes de que finalice la promoción.' | translate }}</p>
			</div>

			<div class="countdown-clock" id="js-offers-countdown">
				<div class="countdown-segment">
					<div class="countdown-box" id="cd-days">04</div>
					<span class="countdown-label">{{ 'Días' | translate }}</span>
				</div>
				<span class="countdown-sep">:</span>
				<div class="countdown-segment">
					<div class="countdown-box" id="cd-hours">18</div>
					<span class="countdown-label">{{ 'Horas' | translate }}</span>
				</div>
				<span class="countdown-sep">:</span>
				<div class="countdown-segment">
					<div class="countdown-box" id="cd-mins">32</div>
					<span class="countdown-label">{{ 'Min' | translate }}</span>
				</div>
				<span class="countdown-sep">:</span>
				<div class="countdown-segment">
					<div class="countdown-box" id="cd-secs">45</div>
					<span class="countdown-label">{{ 'Seg' | translate }}</span>
				</div>
			</div>
		</div>

		{# Offers Products Grid (Real offers only, aligned to the left) #}
		<div class="row row-grid offers-grid-row">
			{% for product in real_offers | slice(0, 4) %}
				{% include 'snipplets/grid/item.tpl' with {
					'horizontal_item': false,
					'section_columns_desktop': 4,
					'columns_desktop': 4,
					'section_columns_mobile': 2,
					'columns_mobile': 2
				} %}
			{% endfor %}
		</div>

		{# CTA to all offers #}
		<div class="text-center mt-4 pt-2">
			<a href="{{ store.products_url ? (store.products_url ~ '?offers=true') : '/productos?offers=true' }}" class="btn btn-primary btn-lg">
				<i class="fa-solid fa-tag mr-2"></i> {{ 'Ver todas las Ofertas' | translate }}
			</a>
		</div>
	</div>
</section>

<script>
(function() {
	function initHmcCountdown() {
		var daysEl = document.getElementById('cd-days');
		var hoursEl = document.getElementById('cd-hours');
		var minsEl = document.getElementById('cd-mins');
		var secsEl = document.getElementById('cd-secs');

		if (!daysEl || !hoursEl || !minsEl || !secsEl) return;

		var STORAGE_KEY = 'hmc_offers_countdown_target';
		var savedTarget = null;
		try { savedTarget = localStorage.getItem(STORAGE_KEY); } catch(e) {}
		var targetTime = savedTarget ? parseInt(savedTarget, 10) : null;
		var now = new Date().getTime();

		if (!targetTime || targetTime <= now) {
			targetTime = now + (4 * 24 * 60 * 60 * 1000) + (18 * 60 * 60 * 1000) + (32 * 60 * 1000);
			try { localStorage.setItem(STORAGE_KEY, targetTime); } catch(e) {}
		}

		function updateClock() {
			var current = new Date().getTime();
			var diff = targetTime - current;

			if (diff <= 0) {
				daysEl.textContent = '00';
				hoursEl.textContent = '00';
				minsEl.textContent = '00';
				secsEl.textContent = '00';
				return;
			}

			var days = Math.floor(diff / (1000 * 60 * 60 * 24));
			var hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			var mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
			var secs = Math.floor((diff % (1000 * 60)) / 1000);

			daysEl.textContent = days < 10 ? '0' + days : days;
			hoursEl.textContent = hours < 10 ? '0' + hours : hours;
			minsEl.textContent = mins < 10 ? '0' + mins : mins;
			secsEl.textContent = secs < 10 ? '0' + secs : secs;
		}

		updateClock();
		setInterval(updateClock, 1000);
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', initHmcCountdown);
	} else {
		initHmcCountdown();
	}
})();
</script>
{% endif %}
