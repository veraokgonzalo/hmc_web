{# /*============================================================================
  #Home Sale Offers with Countdown Timer (HMC HUB)
==============================================================================*/ #}

{% set has_db_sale = sections.sale.products and sections.sale.products is not empty %}
{% set has_db_primary = sections.primary.products and sections.primary.products is not empty %}

<section class="section-padding timer-offers-section" id="ofertas" data-store="home-offers-timer">
	<div class="container">
		
		{# Countdown Banner Header #}
		<div class="timer-banner">
			<div class="timer-banner-info">
				<div class="d-flex align-items-center mb-2">
					<span class="badge badge-discount mr-2"><i class="fa-solid fa-bolt"></i> {{ 'Liquidación' | translate }}</span>
					<span class="badge badge-shipping"><i class="fa-solid fa-clock"></i> {{ 'Tiempo Limitado' | translate }}</span>
				</div>
				<h3 class="m-0">{{ settings.sale_products_title | default('Ofertas Especiales' | translate) }}</h3>
				<p class="m-0 mt-1 text-muted-light">{{ 'Aprovechá descuentos exclusivos por tiempo limitado en equipos seleccionados.' | translate }}</p>
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

		{# Offers Products Grid #}
		{% if has_db_sale %}
			<div class="row row-grid offers-grid-row">
				{% for product in sections.sale.products | slice(0, 4) %}
					{% include 'snipplets/grid/item.tpl' with {'horizontal_item': false, 'columns_desktop': 4, 'columns_mobile': 2} %}
				{% endfor %}
			</div>
		{% elseif has_db_primary %}
			<div class="row row-grid offers-grid-row">
				{% for product in sections.primary.products | slice(0, 4) %}
					{% include 'snipplets/grid/item.tpl' with {'horizontal_item': false, 'columns_desktop': 4, 'columns_mobile': 2} %}
				{% endfor %}
			</div>
		{% else %}
			{# Curated Fallback with Real HMC Catalog Products #}
			{% set curated_offers = [
				{
					'id': 1,
					'brand': 'NIWA',
					'name': 'Bomba Centrífuga Niwa WENW-50C 0.5 HP 16m - 4.2 m³/h 1"',
					'image': 'images/products/prod-01-bomba-centrifuga-niwa-wenw50c-principal.webp',
					'discount': '-14% OFF',
					'price_old': '$169.000',
					'price_current': '$145.000',
					'link': (store.products_url ? store.products_url ~ '?q=NIWA' : '/search/?q=NIWA')
				},
				{
					'id': 7,
					'brand': 'EINHELL',
					'name': 'Taladro Percutor Inalámbrico Einhell TE-CD 18/44 Li-i 18V',
					'image': 'images/products/prod-07-taladro-impacto-einhell-te-cd18-principal.webp',
					'discount': '-15% OFF',
					'price_old': '$198.000',
					'price_current': '$168.000',
					'link': (store.products_url ? store.products_url ~ '?q=EINHELL' : '/search/?q=EINHELL')
				},
				{
					'id': 3,
					'brand': 'BOSCH',
					'name': 'Martillo Demoledor Bosch GSH 11 E Professional 1500W SDS Max',
					'image': 'images/products/prod-03-martillo-demoledor-bosch-gsh11e-principal.webp',
					'discount': '-15% OFF',
					'price_old': '$1.150.000',
					'price_current': '$980.000',
					'link': (store.products_url ? store.products_url ~ '?q=BOSCH' : '/search/?q=BOSCH')
				},
				{
					'id': 11,
					'brand': 'SHINDAIWA',
					'name': 'Motoguadaña Profesional Shindaiwa B530 INTL 53.2cc 2T',
					'image': 'images/products/prod-11-motoguadana-shindaiwa-b530-principal.webp',
					'discount': '-12% OFF',
					'price_old': '$960.000',
					'price_current': '$840.000',
					'link': (store.products_url ? store.products_url ~ '?q=SHINDAIWA' : '/search/?q=SHINDAIWA')
				}
			] %}
			<div class="offers-grid">
				{% for item in curated_offers %}
					<div class="product-card">
						<div class="product-badge-group">
							<span class="badge badge-discount">{{ item.discount }}</span>
							<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> {{ 'Envío Gratis' | translate }}</span>
						</div>
						<div class="product-image-box">
							<a href="{{ item.link }}">
								<img src="{{ item.image | static_url }}" alt="{{ item.name }}" class="product-img" loading="lazy">
							</a>
						</div>
						<div class="product-details">
							<div class="product-brand">{{ item.brand }}</div>
							<h4 class="product-name">
								<a href="{{ item.link }}">{{ item.name }}</a>
							</h4>
							<div class="product-price-box">
								<div>
									<span class="price-old">{{ item.price_old }}</span>
									<span class="price-current">{{ item.price_current }}</span>
								</div>
								<div class="installments-info">
									<i class="fa-solid fa-credit-card mr-1"></i> <strong>6 cuotas</strong> sin interés
								</div>
							</div>
							<a href="{{ item.link }}" class="btn btn-primary btn-add-to-cart text-center">
								<i class="fa-solid fa-cart-plus mr-1"></i> {{ 'Comprar Ahora' | translate }}
							</a>
						</div>
					</div>
				{% endfor %}
			</div>
		{% endif %}

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
