{# /*============================================================================
  #Institutional Page: Sobre Nosotros (HMC HUB)
==============================================================================*/ #}

<!-- Breadcrumbs Navigation -->
<div class="breadcrumbs-section">
	<div class="container">
		<div class="breadcrumb-list">
			<div class="breadcrumb-item"><a href="/" data-link-home="true">{{ "Inicio" | translate }}</a></div>
			<div class="breadcrumb-sep"><i class="fa-solid fa-chevron-right"></i></div>
			<div class="breadcrumb-item active">{{ "Sobre Nosotros" | translate }}</div>
		</div>
	</div>
</div>

<!-- About Page Main Section -->
<main class="about-page about-page-section visible-when-content-ready mb-4" id="aboutPageLayout">
	<div class="container">

		<!-- Company Identity & Philosophy -->
		<div class="about-identity-grid">
			<div class="about-identity-text">
				<div class="section-tag">
					<i class="fa-solid fa-building"></i> {{ "Nuestra Identidad" | translate }}
				</div>
				<h1 class="about-identity-title">
					{{ "Más que una tienda, tu socio técnico en cada proyecto" | translate }}
				</h1>
				<p class="about-identity-desc">
					{{ "En <strong>1996</strong> iniciamos nuestro camino con un propósito claro: brindar un servicio técnico confiable, rápido y eficiente." | translate }}
				</p>
				<p class="about-identity-desc">
					{{ "Con el paso del tiempo, el avance de la tecnología y las exigencias del mercado, asumimos el desafío de ir un paso más allá. Nos fuimos profesionalizando, expandiendo nuestro conocimiento y equipamiento." | translate }}
				</p>
				<p class="about-identity-desc">
					{{ "Esa evolución constante nos transformó en lo que somos hoy: <strong>HMC HUB</strong>, un centro integral que combina nuestra sólida experiencia técnica con la provisión de las mejores herramientas del mercado." | translate }}
				</p>
			</div>
			<div class="about-identity-media">
				<div class="about-identity-img-wrapper">
					<img src="{{ 'images/about-us-we.webp' | static_url }}" alt="{{ 'Equipo y Taller HMC HUB' | translate }}" class="about-identity-img" loading="lazy">
				</div>
			</div>
		</div>

		<!-- 4 Pillars Grid (Valores y Diferenciales) -->
		<div class="about-section-spacer">
			<div class="section-header">
				<div class="section-tag">
					<i class="fa-solid fa-award"></i> {{ "Valores y Diferenciales" | translate }}
				</div>
				<h2 class="section-title">{{ "Por Qué Elegir HMC HUB" | translate }}</h2>
				<p class="section-subtitle">{{ "Cuatro pilares innegociables que sustentan nuestra relación a largo plazo con cada cliente." | translate }}</p>
			</div>

			<div class="value-props-grid">
				<!-- Pilar 1: Asesoría Especializada -->
				<div class="value-prop-card">
					<div class="value-prop-icon">
						<i class="fa-solid fa-headset"></i>
					</div>
					<div class="value-prop-content">
						<h3 class="value-prop-title">{{ "Asesoría Especializada" | translate }}</h3>
						<p class="value-prop-desc">{{ "Personal especializado a tu disposición para guiarte en la elección de la máquina exacta para vos." | translate }}</p>
					</div>
				</div>

				<!-- Pilar 2: Servicio de Post Venta (Feedback Cliente aplicado) -->
				<div class="value-prop-card">
					<div class="value-prop-icon">
						<i class="fa-solid fa-screwdriver-wrench"></i>
					</div>
					<div class="value-prop-content">
						<h3 class="value-prop-title">{{ "Servicio de Post Venta" | translate }}</h3>
						<p class="value-prop-desc">{{ "Taller propio homologado, puesta en marcha oficial sin cargo, servicio de post venta y mantenimiento preventivo continuo." | translate }}</p>
					</div>
				</div>

				<!-- Pilar 3: Repuestos 100% Legítimos -->
				<div class="value-prop-card">
					<div class="value-prop-icon">
						<i class="fa-solid fa-box-open"></i>
					</div>
					<div class="value-prop-content">
						<h3 class="value-prop-title">{{ "Repuestos 100% Legítimos" | translate }}</h3>
						<p class="value-prop-desc">{{ "Stock permanente de insumos, cuchillas, carbones, bujes y piezas originales de cada fabricante oficial." | translate }}</p>
					</div>
				</div>

				<!-- Pilar 4: Logística Nacional y Factura A -->
				<div class="value-prop-card">
					<div class="value-prop-icon">
						<i class="fa-solid fa-truck-fast"></i>
					</div>
					<div class="value-prop-content">
						<h3 class="value-prop-title">{{ "Logística Nacional y Factura A" | translate }}</h3>
						<p class="value-prop-desc">{{ "Envíos rápidos a todo el país con embalaje reforzado y emisión inmediata de Factura A y B para empresas." | translate }}</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Metrics and Achievements -->
		<div class="about-metrics-card">
			<div class="about-metrics-grid">
				<div class="about-metric-item">
					<div class="about-metric-number">+30</div>
					<div class="about-metric-label">{{ "Años de Trayectoria" | translate }}</div>
					<div class="about-metric-sub">{{ "En el mercado de maquinaria" | translate }}</div>
				</div>
				<div class="about-metric-item">
					<div class="about-metric-number">+12.000</div>
					<div class="about-metric-label">{{ "Clientes Atendidos" | translate }}</div>
					<div class="about-metric-sub">{{ "Empresas, campo y profesionales" | translate }}</div>
				</div>
				<div class="about-metric-item">
					<div class="about-metric-number">+100</div>
					<div class="about-metric-label">{{ "Marcas Oficiales" | translate }}</div>
					<div class="about-metric-sub">{{ "Distribución y servicio directo" | translate }}</div>
				</div>
				<div class="about-metric-item">
					<div class="about-metric-number">1</div>
					<div class="about-metric-label">{{ "Sucursal Física Central" | translate }}</div>
					<div class="about-metric-sub">{{ "Santa Rosa, La Pampa" | translate }}</div>
				</div>
			</div>
		</div>

		<!-- Physical Presence & Branch Santa Rosa -->
		<div class="about-section-spacer">
			<div class="section-header">
				<h2 class="section-title">{{ "Nuestra Casa Central en Santa Rosa" | translate }}</h2>
				<p class="section-subtitle">{{ "Vení a conocer nuestro showroom, asesorarte cara a cara con especialistas y retirar tus compras con puesta en marcha oficial." | translate }}</p>
			</div>

			<div class="about-branch-layout">
				<div class="about-branch-media">
					<div class="about-branch-img-wrapper">
						<img src="{{ 'images/sucursal-foto-vertical.webp' | static_url }}" alt="{{ 'Showroom oficial y Casa Central HMC HUB en Santa Rosa' | translate }}" class="about-branch-img" loading="lazy">
					</div>
				</div>
				<div class="branch-card about-branch-card">
					<h4><i class="fa-solid fa-store text-primary mr-2"></i> {{ "Sucursal HMC HUB — Santa Rosa" | translate }}</h4>
					<p class="about-branch-info">
						<strong>{{ "Dirección:" | translate }}</strong> {{ store.address ? store.address : "Av. Santiago Marzo (Norte) 171, Santa Rosa, La Pampa, Argentina." }}
					</p>
					<p class="about-branch-schedule">
						<strong>{{ "Horarios:" | translate }}</strong> {{ "Lunes a Viernes de 8:30 a 12:30 hs. y de 15:30 a 19:30 hs. | Sábados de 8:30 a 13:00 hs." | translate }}
					</p>
					<div class="branch-map about-branch-map">
						<iframe
							src="https://www.google.com/maps?q=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina&amp;output=embed"
							loading="lazy"
							referrerpolicy="no-referrer-when-downgrade"
							title="{{ 'Ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}"
							aria-label="{{ 'Mapa con la ubicación de la sucursal HMC HUB en Santa Rosa, La Pampa' | translate }}">
						</iframe>
					</div>
					<div class="about-branch-actions">
						{% if store.whatsapp %}
							<a href="{{ store.whatsapp }}" target="_blank" class="btn btn-primary btn-sm">
								<i class="fa-brands fa-whatsapp mr-1"></i> {{ "Contactar Sucursal" | translate }}
							</a>
						{% else %}
							<a href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20quiero%20consultar%20por%20retiro%20en%20sucursal" target="_blank" class="btn btn-primary btn-sm">
								<i class="fa-brands fa-whatsapp mr-1"></i> {{ "Contactar Sucursal" | translate }}
							</a>
						{% endif %}
						<a href="https://www.google.com/maps/dir/?api=1&amp;destination=Av.+Santiago+Marzo+(Norte)+171,+Santa+Rosa,+La+Pampa,+Argentina" target="_blank" class="btn btn-outline-dark btn-sm">
							<i class="fa-solid fa-diamond-turn-right mr-1"></i> {{ "Cómo Llegar" | translate }}
						</a>
					</div>
				</div>
			</div>
		</div>

		{% if page.content %}
			<div class="user-content mt-4 pt-4 border-top">
				{{ page.content }}
			</div>
		{% endif %}

	</div>
</main>

{# Instagram Community Feed #}
{% include 'snipplets/home/home-instafeed.tpl' %}
