{# /*============================================================================
  #Home Testimonials & Reviews (HMC HUB - Google Reviews 5.0 ★)
==============================================================================*/ #}

{% set has_custom_testimonials = settings.testimonial_01_description or settings.testimonial_01_name %}

<section class="section-padding testimonials-section" id="nosotros" data-store="home-testimonials">
	<div class="container">
		<div class="section-header">
			<h2 class="section-title">{{ settings.testimonials_title | default('La Opinión de Quienes Confiaron en Nosotros' | translate) }}</h2>
		</div>

		<div class="testimonials-grid">
			{% if has_custom_testimonials %}
				{% for testimonial in ['testimonial_01', 'testimonial_02', 'testimonial_03'] %}
					{% set testimonial_image = "#{testimonial}.jpg" | has_custom_image %}
					{% set testimonial_name = attribute(settings, "#{testimonial}_name") %}
					{% set testimonial_description = attribute(settings, "#{testimonial}_description") %}
					{% if testimonial_name or testimonial_description %}
						<div class="testimonial-card">
							<div>
								<div class="testimonial-rating">
									<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
								</div>
								<p class="testimonial-quote">"{{ testimonial_description }}"</p>
							</div>
							<div class="testimonial-author">
								{% if testimonial_image %}
									<img src="{{ "#{testimonial}.jpg" | static_url | settings_image_url('small') }}" alt="{{ testimonial_name }}" class="author-avatar" loading="lazy">
								{% else %}
									<img src="{{ 'images/logos/logo-circular-green.png' | static_url }}" alt="{{ testimonial_name }}" class="author-avatar" loading="lazy">
								{% endif %}
								<div class="author-info">
									<h5 class="m-0 font-weight-bold">{{ testimonial_name }}</h5>
									<span class="text-muted font-smallest">{{ 'Cliente verificado' | translate }}</span>
								</div>
							</div>
						</div>
					{% endif %}
				{% endfor %}
			{% else %}
				{# 3 Google Reviews Verificadas de HMC HUB #}
				<div class="testimonial-card">
					<div>
						<div class="testimonial-rating">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
						</div>
						<p class="testimonial-quote">"Fuimos por una cortadora de pasto y bordeadora y la atención fue excelente. La chica que nos atendió nos informó muy bien sobre cada característica de las máquinas y también nos aconsejó para su buen uso. Antes de entregar las máquinas, las probaron para ver que funcionen bien. También ofrecen garantía y service."</p>
					</div>
					<div class="testimonial-author">
						<img src="{{ 'images/logos/logo-circular-green.png' | static_url }}" alt="Milena Ormeño" class="author-avatar" loading="lazy">
						<div class="author-info">
							<h5 class="m-0 font-weight-bold">Milena Ormeño</h5>
							<span class="text-muted font-smallest">Cliente verificado · Google Reviews</span>
						</div>
					</div>
				</div>

				<div class="testimonial-card">
					<div>
						<div class="testimonial-rating">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
						</div>
						<p class="testimonial-quote">"Excelente atención. Gran variedad de productos y repuestos del rubro. Muy buen taller de reparaciones. Totalmente recomendable."</p>
					</div>
					<div class="testimonial-author">
						<img src="{{ 'images/logos/logo-circular-dark.png' | static_url }}" alt="Ricardo Dimartino" class="author-avatar" loading="lazy">
						<div class="author-info">
							<h5 class="m-0 font-weight-bold">Ricardo Dimartino</h5>
							<span class="text-muted font-smallest">Cliente verificado · Google Reviews</span>
						</div>
					</div>
				</div>

				<div class="testimonial-card">
					<div>
						<div class="testimonial-rating">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
						</div>
						<p class="testimonial-quote">"Excelente atención y muy buenos precios, y variedad en repuestos, recomendable."</p>
					</div>
					<div class="testimonial-author">
						<img src="{{ 'images/logos/logo-circular-badge.png' | static_url }}" alt="Luis Rodrigo Wiggenhuaser" class="author-avatar" loading="lazy">
						<div class="author-info">
							<h5 class="m-0 font-weight-bold">Luis Rodrigo Wiggenhuaser</h5>
							<span class="text-muted font-smallest">Cliente verificado · Google Reviews</span>
						</div>
					</div>
				</div>
			{% endif %}
		</div>
	</div>
</section>