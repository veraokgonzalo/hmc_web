{% set has_contact_info = store.whatsapp or store.phone or store.email or store.address or store.blog or store.contact_intro %}
{% set is_order_cancellation_without_id = params.order_cancellation_without_id == 'true' %}

{% include "snipplets/breadcrumbs.tpl" with {breadcrumbs_custom_class: 'mb-3'} %}

<section class="contact-page visible-when-content-ready mb-4">
	<div class="container">

		<div class="section-header contact-section-header">
			{% if not is_order_cancellation %}
				<div class="section-tag">
					{% include "snipplets/svg/chat.tpl" with {svg_custom_class: "icon-inline"} %}
					{{ "Canales de Atención" | translate }}
				</div>
				<h1 class="section-title" data-store="page-title">{{ "Contacto & Sucursales" | translate }}</h1>
				<p class="section-subtitle">{{ "Envianos tu consulta técnica, cotización corporativa o visitanos en nuestra sucursal de Santa Rosa." | translate }}</p>
			{% else %}
				<h1 class="section-title" data-store="page-title">{{ "Pedí la cancelación de tu última compra" | translate }}</h1>
			{% endif %}
		</div>

		<div class="row contact-main-grid">

			{# Contact Form Column #}
			<div class="col-md-7 mb-4 mb-md-0">
				<div class="contact-form-card">

					{% if product %}
						<div class="row align-items-center justify-content-md-left mb-3">
							<div class="col-auto">
								<img src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" class="d-flex img-fluid" />
							</div>
							<div class="col-auto pl-3">
								<p class="mb-0">{{ "Estás consultando por el producto:" | translate }} </br> {{ product.name | a_tag(product.url) }}</p>
							</div>
						</div>
					{% endif %}

					{% if contact %}
						{% if contact.success %}
							{% if is_order_cancellation %}
								<div class="alert alert-success" data-component="order-cancellation-success-message">{{ "¡Tu pedido de cancelación fue enviado!" | translate }}
								<br>
								<p class="mb-0 mt-2">{{ "Vamos a ponernos en contacto con vos apenas veamos tu mensaje." | translate }}</p>
								<br>
								<strong>{{ "Tu código de trámite es" | translate }} #{{ last_order_id }}</strong></div>
							{% else %}
								<div class="alert alert-success" data-component="contact-success-message">{{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}</div>
							{% endif %}
						{% else %}
							<div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}</div>
						{% endif %}
					{% endif %}

					{% if is_order_cancellation %}
						<div class="mb-4" data-component="order-cancellation-disclaimer">
							<p>{{ "Si te arrepentiste, podés pedir la cancelación enviando este formulario. Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
							<a class="btn-link" href="{{ status_page_url_regret }}"><strong>{{ 'Ver detalle de la compra >' | translate }}</strong></a>
						</div>
						{% if has_contact_info %}
							<h5 class="mb-1">{{ 'Si tenés problemas con otra compra, contactanos:' | translate }}</h5>
							<div class="divider mt-0 mb-3"></div>
							{% if store.contact_intro %}
								<p class="mb-4">{{ store.contact_intro }}</p>
							{% endif %}
							{% include "snipplets/contact-links.tpl" with {btn_link: true} %}
						{% endif %}
					{% else %}
						<h3 class="contact-form-card-title">{{ "Envianos tu Consulta o Solicitud de Cotización" | translate }}</h3>
						<p class="contact-form-card-copy">{{ "Completá el siguiente formulario y un técnico especialista responderá lo antes posible. Para respuestas más rápidas, no dudes en escribirnos por WhatsApp." | translate }}</p>
					{% endif %}

					{% if is_order_cancellation_without_id %}
						<p class="mb-3" data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste de una compra, podés pedir la cancelación enviando este formulario <strong>con tu número de orden.</strong> Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
					{% endif %}

					{% embed "snipplets/forms/form.tpl" with{form_id: 'contact-form', form_custom_class: 'js-winnie-pooh-form', form_action: '/winnie-pooh', submit_custom_class: 'btn-block', submit_name: 'contact', submit_text: 'Enviar Mensaje a HMC' | translate, data_store: 'contact-form' }  %}
						{% block form_body %}

							{# Hidden inputs used to send attributes #}

							<div class="winnie-pooh hidden">
								<label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label>
								<input type="text" id="winnie-pooh" name="winnie-pooh">
							</div>
							<input type="hidden" value="{{ product.id }}" name="product"/>

							{% if is_order_cancellation or is_order_cancellation_without_id %}
								<input type="hidden" name="type" value="order_cancellation" />
							{% else %}
								<input type="hidden" name="type" value="contact" />
							{% endif %}

							{# Name input #}

							{% embed "snipplets/forms/form-input.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_required: true, input_label_text: 'Nombre y Apellido / Razón Social' | translate, input_placeholder: 'Ej: Ing. Juan Pérez o Constructora del Plata' | translate } %}
							{% endembed %}

							<div class="row">
								{# Email input #}

								{% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_required: true, input_group_custom_class: 'col-md-6', input_label_text: 'Correo Electrónico' | translate, input_placeholder: 'tuemail@dominio.com' | translate } %}
								{% endembed %}

								{% if not is_order_cancellation %}
									{# Phone input #}

									{% embed "snipplets/forms/form-input.tpl" with{input_for: 'phone', type_tel: true, input_name: 'phone', input_id: 'phone', input_required: true, input_group_custom_class: 'col-md-6', input_label_text: 'Teléfono / Celular' | translate, input_placeholder: 'Ej: 11 4455-6677' | translate } %}
									{% endembed %}
								{% endif %}
							</div>

							{% if not is_order_cancellation %}

								{# Inquiry type select #}

								{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_for: 'inquiry_type', select_name: 'inquiry_type', select_id: 'inquiry_type', select_required: true, select_label_name: 'Tipo de Consulta' | translate, select_aria_label: 'Tipo de Consulta' | translate } %}
									{% block select_options %}
										<option value="">{{ 'Seleccioná un motivo...' | translate }}</option>
										<option value="asesoria">{{ 'Asesoramiento técnico para elegir una máquina' | translate }}</option>
										<option value="presupuesto">{{ 'Presupuesto para empresa / Factura A' | translate }}</option>
										<option value="repuestos">{{ 'Repuestos, servicio técnico o puesta en marcha' | translate }}</option>
										<option value="envio">{{ 'Consulta sobre estado de pedido o envío' | translate }}</option>
										<option value="otro">{{ 'Otras consultas' | translate }}</option>
									{% endblock select_options%}
								{% endembed %}

								{# Message textarea #}

								{% embed "snipplets/forms/form-input.tpl" with{text_area: true, input_for: 'message', input_name: 'message', input_id: 'message', input_required: true, input_rows: '4', input_label_text: 'Mensaje o Detalle del Requerimiento' | translate, input_placeholder: 'Detallanos el trabajo a realizar, potencia requerida o equipo de interés...' | translate } %}
								{% endembed %}

							{% endif %}
						{% endblock %}
					{% endembed %}
				</div>
			</div>

			{# Branches Column #}
			<div class="col-md-5">
				<div class="contact-branches-col">
					<h3 class="contact-branches-title">
						{% include "snipplets/svg/map-marker-alt.tpl" with {svg_custom_class: "icon-inline mr-2"} %}
						{{ "Sucursal y Punto de Retiro" | translate }}
					</h3>

					<div class="branch-card">
						<h4>
							{% include "snipplets/svg/store.tpl" with {svg_custom_class: "icon-inline mr-2"} %}
							{{ "Sucursal HMC HUB — Santa Rosa" | translate }}
						</h4>
						{% if store.address %}
							<p class="branch-card-line"><strong>{{ 'Dirección:' | translate }}</strong> {{ store.address }}</p>
						{% endif %}
						<p class="branch-card-line"><strong>{{ 'Horarios:' | translate }}</strong> {{ 'Lunes a Viernes de 8:00 a 18:00 hs | Sábados de 8:30 a 13:00 hs.' | translate }}</p>
						<p class="branch-card-highlight">{{ '✓ Showroom de maquinaria, taller oficial y retiro con prueba de arranque sin cargo.' | translate }}</p>
						<div class="branch-map">
							<iframe
								src="https://www.google.com/maps?q=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina&output=embed"
								loading="lazy"
								referrerpolicy="no-referrer-when-downgrade"
								title="{{ 'Ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}"
								aria-label="{{ 'Mapa con la ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}">
							</iframe>
						</div>
						<a href="https://www.google.com/maps/dir/?api=1&destination=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina" target="_blank" class="branch-map-directions">
							{% include "snipplets/svg/arrow-right.tpl" with {svg_custom_class: "icon-inline"} %}
							{{ "Cómo llegar" | translate }}
						</a>
					</div>

					<div class="contact-trust-callout">
						<h5>
							{% include "snipplets/svg/security.tpl" with {svg_custom_class: "icon-inline mr-2"} %}
							{{ "Respaldo de fábrica garantizado" | translate }}
						</h5>
						<p>{{ "Todos los equipos se entregan con factura oficial, garantía registrada y número de serie homologado por el fabricante." | translate }}</p>
					</div>

					{% if has_contact_info and not is_order_cancellation %}
						<div class="contact-other-channels">
							{% if store.contact_intro %}
								<p class="mb-2">{{ store.contact_intro }}</p>
							{% endif %}
							{% include "snipplets/contact-links.tpl" with {with_icons: true} %}
						</div>
					{% endif %}
				</div>
			</div>

		</div>

		{# FAQ Accordion #}
		<section class="faq-accordion">
			<div class="section-header" style="margin-bottom: 24px;">
				<div class="section-tag">
					{% include "snipplets/svg/info-circle.tpl" with {svg_custom_class: "icon-inline"} %}
					{{ "Dudas Frecuentes" | translate }}
				</div>
				<h2 class="section-title faq-title">{{ "Preguntas Frecuentes" | translate }}</h2>
			</div>

			<div class="faq-item js-accordion-container">
				<a href="#" class="faq-question js-accordion-toggle">
					<span>{{ "¿Los equipos se entregan listos para usar o hay que armarlos?" | translate }}</span>
					<span class="js-accordion-toggle-inactive">
						{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
					<span class="js-accordion-toggle-active" style="display: none;">
						{% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
				</a>
				<div class="faq-answer js-accordion-content" style="display: none;">
					{{ "En los retiros por sucursal entregamos las máquinas armadas, con fluidos revisados y prueba de marcha sin costo. Para envíos al interior, viajan en su caja original de fábrica con manuales en español y ofrecemos asistencia remota guiada por videollamada para el primer encendido." | translate }}
				</div>
			</div>

			<div class="faq-item js-accordion-container">
				<a href="#" class="faq-question js-accordion-toggle">
					<span>{{ "¿Hacen envíos de generadores y maquinaria pesada a todo el país?" | translate }}</span>
					<span class="js-accordion-toggle-inactive">
						{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
					<span class="js-accordion-toggle-active" style="display: none;">
						{% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
				</a>
				<div class="faq-answer js-accordion-content" style="display: none;">
					{{ "Sí. Coordinamos envíos paletizados y asegurados a través de expresos y transportes de carga con seguimiento en tiempo real hasta tu obra o depósito. Superando los $300.000 el envío es gratis en productos seleccionados." | translate }}
				</div>
			</div>

			<div class="faq-item js-accordion-container">
				<a href="#" class="faq-question js-accordion-toggle">
					<span>{{ "¿Cómo solicito Factura A para mi empresa o CUIT?" | translate }}</span>
					<span class="js-accordion-toggle-inactive">
						{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
					<span class="js-accordion-toggle-active" style="display: none;">
						{% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
				</a>
				<div class="faq-answer js-accordion-content" style="display: none;">
					{{ "Al momento de realizar la compra, simplemente ingresá tu CUIT y Razón Social en el campo de facturación. La factura electrónica A se genera automáticamente y se envía a tu correo en formato PDF." | translate }}
				</div>
			</div>

			<div class="faq-item js-accordion-container">
				<a href="#" class="faq-question js-accordion-toggle">
					<span>{{ "¿Cuentan con repuestos originales de las marcas que comercializan?" | translate }}</span>
					<span class="js-accordion-toggle-inactive">
						{% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
					<span class="js-accordion-toggle-active" style="display: none;">
						{% include "snipplets/svg/chevron-up.tpl" with {svg_custom_class: "icon-inline"} %}
					</span>
				</a>
				<div class="faq-answer js-accordion-content" style="display: none;">
					{{ "Sí, somos distribuidores y centro de servicio oficial de STIHL, HONDA, HUSQVARNA, BOSCH, DEWALT y marcas asociadas. Disponemos de stock permanente de espadas, cadenas, bujías, filtros, cuchillas y lubricantes originales." | translate }}
				</div>
			</div>
		</section>

	</div>
</section>
