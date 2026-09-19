{# /*============================================================================
  #Home Showroom Parallax Experience (HMC HUB - Casa Central Santa Rosa)
==============================================================================*/ #}

{% set whatsapp_number = store.whatsapp_number ? store.whatsapp_number : '5492954696231' %}
{% set whatsapp_text = 'Hola HMC Hub, quiero hacer una consulta para la sucursal Santa Rosa' | url_encode %}
{% set whatsapp_url = 'https://wa.me/' ~ whatsapp_number ~ '?text=' ~ whatsapp_text %}

<section class="hmc-parallax-section home-showroom-parallax" id="sucursal-central" data-store="home-showroom-parallax">
	<div class="hmc-parallax-overlay"></div>
	<div class="container hmc-parallax-container">
		<div class="hmc-parallax-content">
			<h2 class="hmc-parallax-title">{{ settings.institutional_title | default('Conocé Nuestra Casa Central en Santa Rosa' | translate) }}</h2>
			<p class="hmc-parallax-desc">
				{{ settings.institutional_description | default('Más de 30 años respaldando el trabajo en obra y campo.' | translate) }}
			</p>

			<div class="hmc-parallax-pills">
				<span class="parallax-pill">
					<i class="fa-solid fa-location-dot"></i> {{ store.address ? store.address : 'Av. Santiago Marzo (Norte) 171, Santa Rosa, La Pampa' }}
				</span>
			</div>

			<div class="hmc-parallax-actions">
				<a href="https://www.google.com/maps/dir/?api=1&amp;destination=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina" target="_blank" rel="noopener noreferrer" class="btn btn-primary btn-lg">
					<i class="fa-solid fa-map"></i> {{ 'Cómo Llegar' | translate }}
				</a>
			</div>
		</div>
	</div>
</section>
