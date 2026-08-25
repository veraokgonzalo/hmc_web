{# 
  Dynamic Brands Marquee for Tiendanube
  Finds the category 'Nuestras marcas' (or 'Marcas') and loops over all its subcategories dynamically
  Square cards with product image in background and brand name overlaid. Zero emojis.
#}

{% set brands_category = null %}
{% for cat in categories %}
	{% set cat_name_clean = cat.name | lower | trim %}
	{% if cat.handle == 'nuestras-marcas' or cat.handle == 'marcas' or cat_name_clean == 'nuestras marcas' or cat_name_clean == 'marcas' or 'marca' in cat_name_clean %}
		{% set brands_category = cat %}
	{% endif %}
{% endfor %}

{% set brand_subcategories = [] %}
{% if brands_category %}
	{% set brand_subcategories = brands_category.subcategories %}
{% endif %}

{% set has_custom_subcats = brand_subcategories is not empty %}
{% set brand_slides = settings.brands %}
{% set has_custom_slides = brand_slides and brand_slides is not empty %}

{# Calculate a slow, comfortable scroll duration proportional to the number of brands (8s per brand) #}
{% set brand_count = has_custom_subcats ? (brand_subcategories | length) : (has_custom_slides ? (brand_slides | length) : 8) %}
{% set marquee_duration = max(45, brand_count * 6) %}

<section class="section-brands-marquee" data-store="home-brands">
	<style>
		.section-brands-marquee {
			width: 100%;
			overflow: hidden;
			background-color: #F8F9FA;
			border-top: 1px solid #E2E8F0;
			border-bottom: 1px solid #E2E8F0;
			padding: 32px 0;
			margin: 24px 0;
		}
		.hmc-marquee-header {
			text-align: center;
			margin-bottom: 20px;
		}
		.hmc-marquee-title {
			font-family: "Chakra Petch", "Inter", sans-serif;
			font-size: 1rem;
			font-weight: 700;
			text-transform: uppercase;
			letter-spacing: 2px;
			color: #1A202C;
			margin: 0;
		}
		.hmc-marquee-container {
			overflow: hidden;
			width: 100%;
			position: relative;
			display: flex;
			user-select: none;
			mask-image: linear-gradient(to right, transparent, black 5%, black 95%, transparent);
			-webkit-mask-image: linear-gradient(to right, transparent, black 5%, black 95%, transparent);
		}
		.hmc-marquee-track {
			display: flex !important;
			width: max-content !important;
			animation: hmc-marquee-scroll {{ marquee_duration }}s linear infinite !important;
		}
		.hmc-marquee-container:hover .hmc-marquee-track {
			animation-play-state: paused !important;
		}
		.hmc-marquee-content {
			display: flex !important;
			flex-shrink: 0 !important;
			align-items: center !important;
			gap: 20px !important;
			padding-right: 20px !important;
			white-space: nowrap !important;
		}
		.hmc-brand-square-card {
			position: relative;
			display: block;
			width: 160px;
			height: 160px;
			min-width: 160px;
			min-height: 160px;
			border-radius: 10px;
			overflow: hidden;
			background-color: #FFFFFF;
			border: 1.5px solid #E2E8F0;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
			text-decoration: none !important;
			transition: border-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
			cursor: pointer;
		}
		.hmc-brand-square-card:hover {
			border-color: #3FAA47;
			transform: translateY(-5px);
			box-shadow: 0 10px 24px rgba(63, 170, 71, 0.2);
		}
		.hmc-brand-img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			display: block;
			transition: transform 0.4s ease;
		}
		.hmc-brand-square-card:hover .hmc-brand-img {
			transform: scale(1.08);
		}
		.hmc-brand-img-fallback {
			width: 100%;
			height: 100%;
			background: linear-gradient(135deg, #2D3748 0%, #1A202C 100%);
			display: flex;
			align-items: center;
			justify-content: center;
		}
		.hmc-brand-initials {
			font-family: "Chakra Petch", sans-serif;
			font-size: 2.5rem;
			font-weight: 700;
			color: rgba(255, 255, 255, 0.15);
			letter-spacing: 2px;
		}
		.hmc-brand-overlay {
			position: absolute;
			bottom: 0;
			left: 0;
			right: 0;
			top: 0;
			background: linear-gradient(to top, rgba(0, 0, 0, 0.88) 0%, rgba(0, 0, 0, 0.45) 45%, rgba(0, 0, 0, 0.05) 100%);
			display: flex;
			flex-direction: column;
			justify-content: flex-end;
			padding: 12px;
			box-sizing: border-box;
		}
		.hmc-brand-title {
			font-family: "Chakra Petch", "Inter", sans-serif;
			font-size: 0.92rem;
			font-weight: 700;
			text-transform: uppercase;
			letter-spacing: 0.8px;
			color: #FFFFFF;
			margin: 0;
			line-height: 1.2;
			text-shadow: 0 2px 4px rgba(0, 0, 0, 0.6);
			white-space: normal;
			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;
			overflow: hidden;
		}
		.hmc-brand-subtitle {
			font-family: "Inter", sans-serif;
			font-size: 0.7rem;
			font-weight: 500;
			color: #3FAA47;
			margin-top: 4px;
			letter-spacing: 0.5px;
			text-transform: uppercase;
		}
		@keyframes hmc-marquee-scroll {
			0% { transform: translateX(0); }
			100% { transform: translateX(-50%); }
		}
	</style>

	<div class="container">
		<div class="hmc-marquee-header">
			<h2 class="hmc-marquee-title">
				{{ brands_category ? brands_category.name : (settings.brands_title | default('Nuestras Marcas')) }}
			</h2>
		</div>
	</div>

	<div class="hmc-marquee-container">
		<div class="hmc-marquee-track">
			{# Track 1 #}
			<div class="hmc-marquee-content">
				{% if has_custom_subcats %}
					{% for subcat in brand_subcategories %}
						{% set sample_product = subcat.products ? (subcat.products | first) : null %}
						{% set prod_count = subcat.products_count | default(subcat.products | length) %}
						<a href="{{ subcat.url }}" class="hmc-brand-square-card" title="{{ subcat.name }}">
							{% if sample_product and sample_product.featured_image %}
								<img src="{{ sample_product.featured_image | product_image_url('medium') }}" alt="{{ subcat.name }}" class="hmc-brand-img" loading="lazy" />
							{% elseif subcat.has_image %}
								<img src="{{ subcat.image | category_image_url('medium') }}" alt="{{ subcat.name }}" class="hmc-brand-img" loading="lazy" />
							{% else %}
								<div class="hmc-brand-img-fallback">
									<span class="hmc-brand-initials">{{ subcat.name | slice(0, 2) | upper }}</span>
								</div>
							{% endif %}
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">{{ subcat.name }}</span>
								<span class="hmc-brand-subtitle">
									{% if prod_count > 0 %}
										{{ prod_count }} {{ prod_count == 1 ? 'producto' : 'productos' }}
									{% else %}
										Ver marca
									{% endif %}
								</span>
							</div>
						</a>
					{% endfor %}
				{% elseif has_custom_slides %}
					{% for slide in brand_slides %}
						<a href="{{ slide.link ? (slide.link | setting_url) : '#' }}" class="hmc-brand-square-card">
							<img src="{{ slide.image | static_url | settings_image_url('medium') }}" alt="Marca" class="hmc-brand-img" loading="lazy" />
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">Marca Oficial</span>
								<span class="hmc-brand-subtitle">Ver productos</span>
							</div>
						</a>
					{% endfor %}
				{% else %}
					{% for fallback_brand in ['DEWALT', 'BOSCH', 'MAKITA', 'STANLEY', 'BLACK+DECKER', 'STIHL', 'LUSQTOFF', 'DOWEN PAGIO'] %}
						<a href="/{{ fallback_brand | lower | replace({' ': '-', '+': ''}) }}/" class="hmc-brand-square-card">
							<div class="hmc-brand-img-fallback">
								<span class="hmc-brand-initials">{{ fallback_brand | slice(0, 2) }}</span>
							</div>
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">{{ fallback_brand }}</span>
								<span class="hmc-brand-subtitle">Ver catálogo</span>
							</div>
						</a>
					{% endfor %}
				{% endif %}
			</div>

			{# Track 2 (duplicate for seamless infinite marquee) #}
			<div class="hmc-marquee-content" aria-hidden="true">
				{% if has_custom_subcats %}
					{% for subcat in brand_subcategories %}
						{% set sample_product = subcat.products ? (subcat.products | first) : null %}
						{% set prod_count = subcat.products_count | default(subcat.products | length) %}
						<a href="{{ subcat.url }}" class="hmc-brand-square-card" tabindex="-1">
							{% if sample_product and sample_product.featured_image %}
								<img src="{{ sample_product.featured_image | product_image_url('medium') }}" alt="{{ subcat.name }}" class="hmc-brand-img" loading="lazy" />
							{% elseif subcat.has_image %}
								<img src="{{ subcat.image | category_image_url('medium') }}" alt="{{ subcat.name }}" class="hmc-brand-img" loading="lazy" />
							{% else %}
								<div class="hmc-brand-img-fallback">
									<span class="hmc-brand-initials">{{ subcat.name | slice(0, 2) | upper }}</span>
								</div>
							{% endif %}
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">{{ subcat.name }}</span>
								<span class="hmc-brand-subtitle">
									{% if prod_count > 0 %}
										{{ prod_count }} {{ prod_count == 1 ? 'producto' : 'productos' }}
									{% else %}
										Ver marca
									{% endif %}
								</span>
							</div>
						</a>
					{% endfor %}
				{% elseif has_custom_slides %}
					{% for slide in brand_slides %}
						<a href="{{ slide.link ? (slide.link | setting_url) : '#' }}" class="hmc-brand-square-card" tabindex="-1">
							<img src="{{ slide.image | static_url | settings_image_url('medium') }}" alt="Marca" class="hmc-brand-img" loading="lazy" />
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">Marca Oficial</span>
								<span class="hmc-brand-subtitle">Ver productos</span>
							</div>
						</a>
					{% endfor %}
				{% else %}
					{% for fallback_brand in ['DEWALT', 'BOSCH', 'MAKITA', 'STANLEY', 'BLACK+DECKER', 'STIHL', 'LUSQTOFF', 'DOWEN PAGIO'] %}
						<a href="/{{ fallback_brand | lower | replace({' ': '-', '+': ''}) }}/" class="hmc-brand-square-card" tabindex="-1">
							<div class="hmc-brand-img-fallback">
								<span class="hmc-brand-initials">{{ fallback_brand | slice(0, 2) }}</span>
							</div>
							<div class="hmc-brand-overlay">
								<span class="hmc-brand-title">{{ fallback_brand }}</span>
								<span class="hmc-brand-subtitle">Ver catálogo</span>
							</div>
						</a>
					{% endfor %}
				{% endif %}
			</div>
		</div>
	</div>
</section>
