{# /*============================================================================
  #Contact Page (HMC HUB)
==============================================================================*/ #}

{% set has_contact_info = store.whatsapp or store.phone or store.email or store.address or store.blog or store.contact_intro %}
{% set is_order_cancellation_without_id = params.order_cancellation_without_id == 'true' %}

<!-- Breadcrumbs Navigation -->
<div class="breadcrumbs-section">
	<div class="container">
		<div class="breadcrumb-list">
			<div class="breadcrumb-item"><a href="{{ store.url }}">{{ "Inicio" | translate }}</a></div>
			<div class="breadcrumb-sep"><i class="fa-solid fa-chevron-right"></i></div>
			<div class="breadcrumb-item active">{{ "Contacto & Soporte Técnico" | translate }}</div>
		</div>
	</div>
</div>

<!-- Contact Main Section -->
<main class="contact-page contact-page-section visible-when-content-ready mb-4" id="contactPageLayout">
	<div class="container">

		<!-- Section Header -->
		<div class="section-header" style="margin-bottom: 36px; text-align: left;">
			{% if is_order_cancellation %}
				<h1 class="section-title" data-store="page-title" style="font-size: 2.4rem;">{{ "Pedí la cancelación de tu última compra" | translate }}</h1>
			{% else %}
				<h1 class="section-title" data-store="page-title" style="font-size: 2.4rem;">{{ "Contacto y Sucursales" | translate }}</h1>
			{% endif %}
		</div>

		<!-- Main Form & Branches Grid -->
		<div class="contact-main-grid">

			<!-- Contact Form Card -->
			<div class="contact-form-card">
				<h3 style="font-size: 1.35rem; margin-bottom: 8px; font-weight: 700;">{{ "Envianos tu consulta o visitanos en nuestra sucursal de Santa Rosa" | translate }}</h3>
				<p style="color: #666; font-size: 0.9rem; margin-bottom: 24px;">{{ "Completá el siguiente formulario y un técnico especialista responderá lo antes posible. Para respuestas más rápidas, no dudes en escribirnos por WhatsApp." | translate }}</p>

				{% if product %}
					<div class="row align-items-center mb-3" style="display: flex; align-items: center; gap: 16px; margin-bottom: 20px; padding: 12px; background: #F8FAFC; border-radius: 8px; border: 1px solid #E2E8F0;">
						<div class="col-auto">
							<img src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" style="width: 56px; height: 56px; object-fit: contain;" />
						</div>
						<div class="col-auto pl-2">
							<p class="mb-0" style="font-size: 0.88rem; color: #555;">{{ "Estás consultando por el producto:" | translate }} <br> <a href="{{ product.url }}" style="font-weight: 700; color: #3FAA47; text-decoration: none;">{{ product.name }}</a></p>
						</div>
					</div>
				{% endif %}

				{% if contact %}
					{% if contact.success %}
						{% if is_order_cancellation %}
							<div class="alert alert-success" data-component="order-cancellation-success-message" style="margin-bottom: 20px; padding: 16px; border-radius: 8px; background: #e8f5e9; color: #1b5e20; border: 1px solid #c8e6c9;">
								{{ "¡Tu pedido de cancelación fue enviado!" | translate }}
								<br>
								<p class="mb-0 mt-2">{{ "Vamos a ponernos en contacto con vos apenas veamos tu mensaje." | translate }}</p>
								<br>
								<strong>{{ "Tu código de trámite es" | translate }} #{{ last_order_id }}</strong>
							</div>
						{% else %}
							<div class="alert alert-success" data-component="contact-success-message" style="margin-bottom: 20px; padding: 16px; border-radius: 8px; background: #e8f5e9; color: #1b5e20; border: 1px solid #c8e6c9;">
								{{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}
							</div>
						{% endif %}
					{% else %}
						<div class="alert alert-danger" style="margin-bottom: 20px; padding: 16px; border-radius: 8px; background: #ffebee; color: #b71c1c; border: 1px solid #ffcdd2;">
							{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}
						</div>
					{% endif %}
				{% endif %}

				{% if is_order_cancellation %}
					<div class="mb-4" data-component="order-cancellation-disclaimer">
						<p>{{ "Si te arrepentiste, podés pedir la cancelación enviando este formulario. Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
						<a class="btn-link" href="{{ status_page_url_regret }}"><strong>{{ 'Ver detalle de la compra >' | translate }}</strong></a>
					</div>
				{% endif %}

				{% if is_order_cancellation_without_id %}
					<p class="mb-3" data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste de una compra, podés pedir la cancelación enviando este formulario <strong>con tu número de orden.</strong> Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
				{% endif %}

				<form action="/winnie-pooh" method="post" id="contactInquiryForm" class="contact-form js-winnie-pooh-form" data-store="contact-form">
					<div class="winnie-pooh hidden" style="display: none !important;">
						<label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label>
						<input type="text" id="winnie-pooh" name="winnie-pooh">
					</div>
					<input type="hidden" value="{{ product.id }}" name="product"/>
					<input type="hidden" name="type" value="{% if is_order_cancellation or is_order_cancellation_without_id %}order_cancellation{% else %}contact{% endif %}" />

					<div class="form-group-hmc">
						<label for="contactName">{{ "Nombre y Apellido / Razón Social *" | translate }}</label>
						<input type="text" id="contactName" name="name" class="form-input-hmc" value="{{ contact.name }}" placeholder="{{ 'Ej: Ing. Juan Pérez o Constructora del Plata' | translate }}" required>
					</div>

					<div class="contact-form-row-2col">
						<div class="form-group-hmc">
							<label for="contactEmail">{{ "Correo Electrónico *" | translate }}</label>
							<input type="email" id="contactEmail" name="email" class="form-input-hmc" value="{{ contact.email }}" placeholder="tuemail@dominio.com" required>
						</div>
						<div class="form-group-hmc">
							<label for="contactPhone">{{ "Teléfono / Celular *" | translate }}</label>
							<input type="tel" id="contactPhone" name="phone" class="form-input-hmc" value="{{ contact.phone }}" placeholder="{{ 'Ej: 11 4455-6677' | translate }}" required>
						</div>
					</div>

					<div class="form-group-hmc">
						<label for="contactType">{{ "Tipo de Consulta *" | translate }}</label>
						<select id="contactType" name="inquiry_type" class="form-input-hmc form-select-hmc" required>
							<option value="">{{ "Seleccioná un motivo..." | translate }}</option>
							<option value="asesoria">{{ "Asesoramiento técnico para elegir una máquina" | translate }}</option>
							<option value="presupuesto">{{ "Presupuesto para empresa / Factura A" | translate }}</option>
							<option value="repuestos">{{ "Repuestos, servicio técnico o puesta en marcha" | translate }}</option>
							<option value="envio">{{ "Consulta sobre estado de pedido o envío" | translate }}</option>
							<option value="otro">{{ "Otras consultas" | translate }}</option>
						</select>
					</div>

					<div class="form-group-hmc">
						<label for="contactMessage">{{ "Mensaje o Detalle del Requerimiento *" | translate }}</label>
						<textarea id="contactMessage" name="message" class="form-input-hmc" rows="4" placeholder="{{ 'Detallanos el trabajo a realizar, potencia requerida o equipo de interés...' | translate }}" required>{{ contact.message }}</textarea>
					</div>

					<button type="submit" name="contact" class="btn btn-primary btn-lg" style="width: 100%;">
						<i class="fa-solid fa-paper-plane mr-2"></i> {{ "Enviar Mensaje a HMC" | translate }}
					</button>
				</form>
			</div>

			<!-- Branches and Physical Presence -->
			<div class="contact-branches-col">
				<h3 style="font-size: 1.35rem; margin-bottom: 20px; text-align: center; font-weight: 700;">
					<i class="fa-solid fa-location-dot text-primary mr-1"></i> {{ "Sucursal y Punto de Retiro" | translate }}
				</h3>

				<div class="branch-card">
					<h4>
						<i class="fa-solid fa-store text-primary mr-2"></i> {{ "Sucursal HMC HUB — Santa Rosa" | translate }}
					</h4>
					<p class="branch-card-line">
						<strong>{{ "Dirección:" | translate }}</strong> {{ store.address ? store.address : 'Av. Santiago Marzo (Norte) 171, Santa Rosa, La Pampa, Argentina.' }}
					</p>
					<p class="branch-card-line">
						<strong>{{ "Horarios:" | translate }}</strong> {{ 'Lunes a Viernes de 8:30 a 12:30 hs. y de 15:30 a 19:30 hs. | Sábados de 8:30 a 13:00 hs.' | translate }}
					</p>
					<p class="branch-card-highlight">
						{{ "✓ Showroom de maquinaria, taller oficial y retiro con prueba de arranque sin cargo." | translate }}
					</p>
					<div class="branch-map">
						<iframe
							src="https://www.google.com/maps?q=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina&output=embed"
							loading="lazy"
							referrerpolicy="no-referrer-when-downgrade"
							title="{{ 'Ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}"
							aria-label="{{ 'Mapa con la ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}">
						</iframe>
					</div>
					<a href="https://www.google.com/maps/dir/?api=1&destination=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina" target="_blank" rel="noopener noreferrer" class="branch-map-directions">
						<i class="fa-solid fa-diamond-turn-right mr-1"></i> {{ "Cómo llegar" | translate }}
					</a>
				</div>

				<!-- Trust Callout -->
				<div class="contact-trust-callout" style="background: var(--color-surface-dark, #1B1E22); color: #fff; border-radius: var(--radius-md, 8px); padding: 20px; border-left: 4px solid var(--color-primary, #3FAA47);">
					<h5 style="color: #fff; font-size: 0.95rem; margin-bottom: 6px; font-weight: 700;">
						<i class="fa-solid fa-shield-check text-primary mr-1"></i> {{ "Respaldo de fábrica garantizado" | translate }}
					</h5>
					<p style="font-size: 0.84rem; color: #aaa; margin: 0; line-height: 1.5;">
						{{ "Todos los equipos se entregan con factura oficial, garantía registrada y número de serie homologado por el fabricante." | translate }}
					</p>
				</div>
			</div>

		</div>

		<!-- FAQ Accordion -->
		<section class="faq-accordion">
			<div class="section-header" style="margin-bottom: 24px;">
				<div class="section-tag">
					<i class="fa-solid fa-circle-question mr-1"></i> {{ "Dudas Frecuentes" | translate }}
				</div>
				<h2 class="section-title" style="font-size: 1.8rem;">{{ "Preguntas Frecuentes" | translate }}</h2>
			</div>

			<div class="faq-item">
				<div class="faq-question">
					<span>{{ "¿Los equipos se entregan listos para usar o hay que armarlos?" | translate }}</span>
					<i class="fa-solid fa-chevron-down"></i>
				</div>
				<div class="faq-answer">
					{{ "En los retiros por sucursal entregamos las máquinas armadas, con fluidos revisados y prueba de marcha sin costo. Para envíos al interior, viajan en su caja original de fábrica con manuales en español y ofrecemos asistencia remota guiada por videollamada para el primer encendido." | translate }}
				</div>
			</div>

			<div class="faq-item">
				<div class="faq-question">
					<span>{{ "¿Hacen envíos de generadores y maquinaria pesada a todo el país?" | translate }}</span>
					<i class="fa-solid fa-chevron-down"></i>
				</div>
				<div class="faq-answer">
					{{ "Sí. Coordinamos envíos paletizados y asegurados a través de expresos y transportes de carga con seguimiento en tiempo real hasta tu obra o depósito. Superando los $300.000 el envío es gratis en productos seleccionados." | translate }}
				</div>
			</div>

			<div class="faq-item">
				<div class="faq-question">
					<span>{{ "¿Cómo solicito Factura A para mi empresa o CUIT?" | translate }}</span>
					<i class="fa-solid fa-chevron-down"></i>
				</div>
				<div class="faq-answer">
					{{ "Al momento de realizar la compra, simplemente ingresá tu CUIT y Razón Social en el campo de facturación. La factura electrónica A se genera automáticamente y se envía a tu correo en formato PDF." | translate }}
				</div>
			</div>

			<div class="faq-item">
				<div class="faq-question">
					<span>{{ "¿Cuentan con repuestos originales de las marcas que comercializan?" | translate }}</span>
					<i class="fa-solid fa-chevron-down"></i>
				</div>
				<div class="faq-answer">
					{{ "Sí, somos distribuidores y centro de servicio oficial de STIHL, HONDA, HUSQVARNA, BOSCH, DEWALT y marcas asociadas. Disponemos de stock permanente de espadas, cadenas, bujías, filtros, cuchillas y lubricantes originales." | translate }}
				</div>
			</div>
		</section>

	</div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function() {
	var faqQuestions = document.querySelectorAll('.faq-question');
	faqQuestions.forEach(function(q) {
		q.addEventListener('click', function(e) {
			e.preventDefault();
			var item = q.parentElement;
			item.classList.toggle('active');
		});
	});
});
</script>
