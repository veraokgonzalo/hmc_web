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
			<div class="section-tag-light mb-3">
				<i class="fa-solid fa-store mr-1"></i> {{ 'Casa Central & Showroom' | translate }}
			</div>
			<h2 class="hmc-parallax-title">Conocé Nuestra Casa Central en Santa Rosa</h2>
			<p class="hmc-parallax-desc">
				Más de 30 años respaldando el trabajo en obra y campo. Showroom oficial Husqvarna y Niwa, taller propio de puesta en marcha y stock permanente de repuestos legítimos.
			</p>

			<div class="hmc-parallax-pills">
				<span class="parallax-pill">
					<i class="fa-solid fa-location-dot"></i> Av. Santiago Marzo (Norte) 171, Santa Rosa, La Pampa
				</span>
				<span class="parallax-pill">
					<i class="fa-solid fa-clock"></i> Lunes a Viernes 8:00 a 18:00 hs
				</span>
			</div>

			<div class="hmc-parallax-actions">
				<a href="https://www.google.com/maps/dir/?api=1&amp;destination=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina" target="_blank" rel="noopener noreferrer" class="btn btn-primary btn-lg">
					<i class="fa-solid fa-map mr-2"></i> {{ 'Cómo Llegar' | translate }}
				</a>
				<a href="{{ whatsapp_url }}" target="_blank" rel="noopener noreferrer" class="btn btn-outline-white btn-lg">
					<i class="fa-brands fa-whatsapp mr-2"></i> {{ 'Hablar con Mostrador' | translate }}
				</a>
			</div>
		</div>
	</div>
</section>
