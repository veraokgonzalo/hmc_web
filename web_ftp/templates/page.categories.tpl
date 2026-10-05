{# /*============================================================================
  #Institutional Page: Directorio Jerárquico de Categorías (HMC HUB)
  #Master-Detail B2B Architecture (13 Rubros, 79 Subcategorías, 464 Familias)
==============================================================================*/ #}

{% set master_rubros = [
  {'id': 'agua', 'name': 'Agua', 'count': 19, 'desc': 'Electrobombas centrífugas, presurizadoras, sumergibles y bombas solares.'},
  {'id': 'construccion', 'name': 'Construcción', 'count': 151, 'desc': 'Compactación, cortadoras de concreto, allanadoras, medición láser y demolición.'},
  {'id': 'consumibles-e-insumos', 'name': 'Consumibles e Insumos', 'count': 82, 'desc': 'Discos diamantados, abrasivos, lubricantes y elementos de protección personal.'},
  {'id': 'ferreteria', 'name': 'Ferretería', 'count': 1192, 'desc': 'Herramientas de mano, bulonería, fijaciones, compresores y soldadura.'},
  {'id': 'generacion-energia', 'name': 'Generación Energía', 'count': 112, 'desc': 'Grupos electrógenos nafteros y diesel, paneles solares e inversores.'},
  {'id': 'jardin', 'name': 'Jardín', 'count': 287, 'desc': 'Cortadoras de césped, bordeadoras, tractores, sopladores y tijeras de poda.'},
  {'id': 'maquina-a-bateria', 'name': 'Máquinas a Batería', 'count': 159, 'desc': 'Taladros, amoladoras, sierras y combos inalámbricos 18V / 20V / 36V.'},
  {'id': 'maquina-a-explosion', 'name': 'Máquinas a Explosión', 'count': 265, 'desc': 'Motosierras, motoguadañas, cortacerco, hoyadoras y fumigadores.'},
  {'id': 'maquina-electrica', 'name': 'Máquinas Eléctricas', 'count': 108, 'desc': 'Herramientas cableadas de taller, lijadoras, fresadoras y caladoras.'},
  {'id': 'maquina-manual', 'name': 'Máquinas Manuales', 'count': 8, 'desc': 'Herramientas de tiro, dobladoras y equipos de accionamiento manual.'},
  {'id': 'producto-de-fuerza', 'name': 'Productos de Fuerza', 'count': 96, 'desc': 'Motores estacionarios, hidrolavadoras de alta presión y motobombas.'},
  {'id': 'repuestos', 'name': 'Repuestos', 'count': 563, 'desc': 'Despieces oficiales, filtros, carburadores, cadenas, cuchillas y encendidos.'},
  {'id': 'riego', 'name': 'Riego', 'count': 200, 'desc': 'Aspersores, toberas, válvulas solenoides, goteros y controladores programables.'}
] %}

<!-- Breadcrumbs Navigation -->
<div class="breadcrumbs-section">
	<div class="container">
		<div class="breadcrumb-list">
			<div class="breadcrumb-item"><a href="/" data-link-home="true">{{ "Inicio" | translate }}</a></div>
			<div class="breadcrumb-sep"><i class="fa-solid fa-chevron-right"></i></div>
			<div class="breadcrumb-item active">{{ "Directorio de Categorías" | translate }}</div>
		</div>
	</div>
</div>

<!-- Categories Page Main Content -->
<main class="categories-page-section visible-when-content-ready mb-4" id="categoriesPageLayout" style="padding: 32px 0 70px 0;">
	<div class="container">

		<!-- Directorio Jerárquico Master-Detail -->
		<section class="categories-directory-section mobile-step-categories" id="directorioCategorias">
			
			<!-- Header Superior Informativo B2B -->
			<div class="categories-page-header">
				<div class="categories-header-main">
					<div class="categories-header-icon">
						<i class="fa-solid fa-layer-group"></i>
					</div>
					<div class="categories-header-text">
						<h1 class="categories-page-title">{{ "Directorio de Categorías" | translate }}</h1>
						<p class="categories-page-subtitle">{{ "Explorá nuestro catálogo organizado por rubros industriales, máquinas, herramientas y familias de repuestos." | translate }}</p>
					</div>
				</div>
				<div class="categories-header-stats js-categories-page-count">
					<strong>13</strong> {{ "rubros" | translate }} • <strong>3.242</strong> {{ "productos" | translate }}
				</div>
			</div>

			<!-- Master-Detail Layout -->
			<div class="categories-master-detail-layout" id="categoriesMasterDetailLayout">
				
				<!-- Sidebar Izquierda: Master (Lista de Rubros + Buscador) -->
				<aside class="categories-master-sidebar" id="categoriesMasterSidebar" aria-label="{{ 'Navegación de Rubros' | translate }}">
					
					<!-- Buscador Integrado en Sidebar -->
					<form class="master-search-card" id="categoriesPageSearchForm" role="search" action="" method="get">
						<div class="master-search-box">
							<i class="fa-solid fa-magnifying-glass search-icon"></i>
							<input type="text" name="q" id="categoriesPageSearchInput" class="js-categories-page-search" placeholder="{{ 'Buscar categoría o repuesto...' | translate }}" autocomplete="off" enterkeyhint="search" aria-label="{{ 'Buscar categoría o repuesto...' | translate }}">
							<button type="button" class="btn-clear-search" id="categoriesPageClearSearch" title="{{ 'Limpiar búsqueda' | translate }}" style="display: none;">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
						<!-- Mobile: la búsqueda se ejecuta al tocar "Buscar" (en desktop filtra en vivo) -->
						<button type="submit" class="btn btn-primary btn-master-search">
							<i class="fa-solid fa-magnifying-glass"></i> {{ 'Buscar' | translate }}
						</button>
					</form>

					<div class="master-nav-heading">
						<span>{{ "Rubros Principales" | translate }}</span>
						<span class="master-nav-count-badge" id="categoriesSidebarCount">13</span>
					</div>

					<!-- Lista de 13 Rubros (Master Nav) -->
					<nav class="master-categories-nav" id="categoriesMasterNavList" aria-label="{{ 'Lista de rubros' | translate }}">
						{% for rubro in master_rubros %}
							<button type="button" class="master-nav-item {% if loop.first %}active{% endif %}" data-cat-id="{{ rubro.id }}">
								<span class="master-nav-name">{{ rubro.name | capitalize }}</span>
								<i class="fa-solid fa-chevron-right master-nav-arrow"></i>
							</button>
						{% endfor %}
					</nav>
				</aside>

				<!-- Panel Derecho: Detail (Subcategorías + Familias y Repuestos) -->
				<main class="categories-detail-panel" id="categoriesDetailPanel">
					
					<!-- Mobile Back Bar (Paso 2 -> Paso 1 en móviles) -->
					<div class="mobile-back-bar" id="mobileBackBar">
						<button type="button" class="btn-mobile-back-rubros" id="btnMobileBackToRubros">
							<i class="fa-solid fa-arrow-left"></i>
							<span>{{ "Volver a todos los rubros" | translate }}</span>
						</button>
					</div>

					<!-- Marco Unificado del Detalle de Rubro (Header + Subcategorías + Botón Catálogo) -->
					<div class="category-detail-hero" id="categoryDetailHero">
						<!-- Dynamically populated by JS engine -->
					</div>

				</main>

			</div>

		</section>

		{% if page.content %}
			<div class="user-content mt-4 pt-4 border-top">
				{{ page.content }}
			</div>
		{% endif %}

	</div>
</main>

<!-- Master Real Categories Tree Dataset -->
<script src="{{ 'js/categories-data.js' | static_url }}"></script>
