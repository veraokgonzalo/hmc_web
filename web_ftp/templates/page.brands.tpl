{# /*============================================================================
  #Institutional Page: Directorio de Marcas Oficiales (HMC HUB)
==============================================================================*/ #}

{% set brand_groups = {
  '#': [
    {'name': '3M', 'count': 12}
  ],
  'A': [
    {'name': 'ACA', 'count': 1},
    {'name': 'ADIABATIC', 'count': 2},
    {'name': 'ALIAFOR', 'count': 13}
  ],
  'B': [
    {'name': 'BAHCO', 'count': 11},
    {'name': 'BEAR CAT', 'count': 4},
    {'name': 'BELLOTA', 'count': 7},
    {'name': 'BIASSONI', 'count': 84},
    {'name': 'BLACK & DECKER', 'count': 1},
    {'name': 'BLU', 'count': 3},
    {'name': 'BORDER', 'count': 2},
    {'name': 'BOSCH', 'count': 214},
    {'name': 'BTA', 'count': 57}
  ],
  'C': [
    {'name': 'CARBORUNDUM', 'count': 2},
    {'name': 'CATANESE', 'count': 10},
    {'name': 'CHERTA', 'count': 11},
    {'name': 'CRAFTSMAN', 'count': 10},
    {'name': 'CROSSMASTER', 'count': 79},
    {'name': 'CUB CADET', 'count': 1}
  ],
  'D': [
    {'name': 'DEWALT', 'count': 22},
    {'name': 'DIBRA', 'count': 4},
    {'name': 'DOBLE A', 'count': 4},
    {'name': 'DOLPHIN', 'count': 4},
    {'name': 'DORMER', 'count': 1},
    {'name': 'DOWEN PAGIO', 'count': 103},
    {'name': 'DREMEL', 'count': 44},
    {'name': 'DUCA', 'count': 17},
    {'name': 'DUKE', 'count': 6},
    {'name': 'DUROLL', 'count': 8}
  ],
  'E': [
    {'name': 'ECHO', 'count': 52},
    {'name': 'EINHELL', 'count': 193},
    {'name': 'EL CENCERRO', 'count': 7},
    {'name': 'ENERTIK', 'count': 3},
    {'name': 'ESAB', 'count': 10},
    {'name': 'ESLINGAR', 'count': 4},
    {'name': 'EUREKA', 'count': 1},
    {'name': 'EURODRIP', 'count': 5},
    {'name': 'EXPLORER', 'count': 11}
  ],
  'F': [
    {'name': 'FASSI', 'count': 13},
    {'name': 'FEMA', 'count': 34},
    {'name': 'FGP', 'count': 40},
    {'name': 'FIASA', 'count': 37},
    {'name': 'FRAMER', 'count': 3},
    {'name': 'FRAVIDA', 'count': 1},
    {'name': 'FREPLAST', 'count': 14}
  ],
  'G': [
    {'name': 'GAMMA', 'count': 9},
    {'name': 'GARDENA', 'count': 159},
    {'name': 'GARDEX', 'count': 47},
    {'name': 'GIBER', 'count': 28},
    {'name': 'GREENWORKS', 'count': 9},
    {'name': 'GROWATT', 'count': 7},
    {'name': 'GTM', 'count': 8}
  ],
  'H': [
    {'name': 'HI-FLEX', 'count': 1},
    {'name': 'HONDA', 'count': 74},
    {'name': 'HUNTER', 'count': 75},
    {'name': 'HUSQVARNA', 'count': 193}
  ],
  'I': [
    {'name': 'INDELPLAS', 'count': 1},
    {'name': 'INVT', 'count': 2},
    {'name': 'IRIMO', 'count': 18},
    {'name': 'ITALIMPIA', 'count': 6}
  ],
  'K': [
    {'name': 'KARCHER', 'count': 7},
    {'name': 'KEX', 'count': 4},
    {'name': 'KOHLER', 'count': 10},
    {'name': 'KWB', 'count': 63}
  ],
  'L': [
    {'name': 'LAHUEN', 'count': 4},
    {'name': 'LATYN', 'count': 19},
    {'name': 'LIBUS', 'count': 23},
    {'name': 'LOCTITE', 'count': 1},
    {'name': 'LUSQTOFF', 'count': 43}
  ],
  'M': [
    {'name': 'MAZAFERRO', 'count': 8},
    {'name': 'METABO', 'count': 49},
    {'name': 'MILWAUKEE', 'count': 27},
    {'name': 'MOURA', 'count': 12}
  ],
  'N': [
    {'name': 'NIWA', 'count': 240},
    {'name': 'NUVIS', 'count': 5}
  ],
  'O': [
    {'name': 'OLEO MAC', 'count': 3},
    {'name': 'OMBU', 'count': 9},
    {'name': 'OREGON', 'count': 433}
  ],
  'P': [
    {'name': 'PAMPA PRO', 'count': 10},
    {'name': 'PATROLL', 'count': 3},
    {'name': 'PEGASO', 'count': 2},
    {'name': 'PERFECTO', 'count': 1},
    {'name': 'PICASSO', 'count': 34},
    {'name': 'PLASTICA ALFA', 'count': 72},
    {'name': 'POLIMEX', 'count': 126},
    {'name': 'POWERCLEAN', 'count': 3}
  ],
  'R': [
    {'name': 'RERAR', 'count': 2},
    {'name': 'RIVULIS', 'count': 5}
  ],
  'S': [
    {'name': 'SANMARQ', 'count': 7},
    {'name': 'SANOGASS', 'count': 1},
    {'name': 'SEERY', 'count': 6},
    {'name': 'SEGOD', 'count': 3},
    {'name': 'SENNINGER', 'count': 8},
    {'name': 'SENSEI', 'count': 96},
    {'name': 'SENSEI PARTS', 'count': 109},
    {'name': 'SHINDAIWA', 'count': 3},
    {'name': 'SHIZEN', 'count': 4},
    {'name': 'SINCROLAMP', 'count': 1},
    {'name': 'SOCH', 'count': 4},
    {'name': 'STANLEY', 'count': 53},
    {'name': 'SUPER SCRUBBER', 'count': 2},
    {'name': 'SUPER SPEED', 'count': 22}
  ],
  'T': [
    {'name': 'TACSA', 'count': 2},
    {'name': 'TECOMEC', 'count': 2},
    {'name': 'TORLETTI', 'count': 11},
    {'name': 'TORO', 'count': 5},
    {'name': 'TORQUE TOOLS', 'count': 4},
    {'name': 'TREBO', 'count': 19},
    {'name': 'TRICOLOR', 'count': 5},
    {'name': 'TROY-BILT', 'count': 5}
  ],
  'U': [
    {'name': 'UNIVERSAL', 'count': 3}
  ],
  'V': [
    {'name': 'VENTURO', 'count': 1},
    {'name': 'VULCANO', 'count': 1}
  ]
} %}

<!-- Breadcrumbs Navigation -->
<div class="breadcrumbs-section">
	<div class="container">
		<div class="breadcrumb-list">
			<div class="breadcrumb-item"><a href="/" data-link-home="true">{{ "Inicio" | translate }}</a></div>
			<div class="breadcrumb-sep"><i class="fa-solid fa-chevron-right"></i></div>
			<div class="breadcrumb-item active">{{ "Directorio de Marcas" | translate }}</div>
		</div>
	</div>
</div>

<!-- Brands Page Main Section -->
<main class="brands-page-section visible-when-content-ready mb-4" id="brandsPageLayout" style="padding: 40px 0 80px 0;">
	<div class="container">

		<!-- Directorio Alfabético Completo -->
		<section class="brands-directory-section" id="directorio">
			
			<!-- Header & Control Bar -->
			<div class="brands-directory-panel">
				
				<div class="directory-panel-top">
					<div class="directory-panel-heading">
						<i class="fa-solid fa-tags text-primary" style="font-size: 1.6rem;"></i>
						<div>
							<h1 class="directory-panel-title">{{ "Directorio Alfabético Completo" | translate }}</h1>
							<p class="directory-panel-desc">{{ "Explorá nuestro catálogo organizado alfabéticamente o utilizá el buscador para encontrar tu fabricante." | translate }}</p>
						</div>
					</div>
					
					<form class="directory-search-form" id="brandsPageSearchForm" role="search" action="" method="get">
						<div class="directory-search-wrapper">
							<i class="fa-solid fa-magnifying-glass search-icon"></i>
							<input type="text" name="q" id="brandsPageSearchInput" class="js-brands-page-search" placeholder="{{ 'Bosch, DeWalt, Einhell...' | translate }}" autocomplete="off" enterkeyhint="search" aria-label="{{ 'Buscar marca' | translate }}">
							<button type="button" class="btn-clear-search" id="brandsPageClearSearch" title="{{ 'Limpiar búsqueda' | translate }}" style="display: none;">
								<i class="fa-solid fa-xmark"></i>
							</button>
						</div>
						<!-- Mobile: la búsqueda se ejecuta al tocar "Buscar" (en desktop filtra en vivo) -->
						<button type="submit" class="btn btn-primary btn-directory-search">
							<i class="fa-solid fa-magnifying-glass"></i> {{ 'Buscar' | translate }}
						</button>
					</form>

					<div class="directory-counter-box">
						<span class="brands-counter-pill js-brands-page-count">
							<strong>113</strong> {{ "marcas disponibles" | translate }}
						</span>
					</div>
				</div>

				<!-- Fast Jump Alphabet Bar -->
				<div class="brands-alphabet-bar js-brands-page-alpha-bar">
					<button type="button" class="alpha-btn active" data-letter="ALL">{{ "TODAS" | translate }}</button>
					<button type="button" class="alpha-btn" data-letter="#"># / 0-9</button>
					{% for letter in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'V'] %}
						<button type="button" class="alpha-btn" data-letter="{{ letter }}">{{ letter }}</button>
					{% endfor %}
				</div>

			</div>

			<!-- Alphabetical Brand Groups Grid -->
			<div class="brands-alphabet-grid js-brands-page-grid" id="brandsAlphabetGrid">
				{% for letter, brands_in_group in brand_groups %}
					<div class="brand-group-card js-brand-group-card" id="brand-group-{{ letter }}" data-letter="{{ letter }}">
						<div class="brand-group-card-header">
							<span class="brand-group-letter">{{ letter }}</span>
							<span class="brand-group-count js-brand-group-count">{{ brands_in_group | length }}</span>
						</div>
						<div class="brand-group-card-body">
							{% for item in brands_in_group %}
								<a href="{{ store.search_url | default('/search/') }}?q={{ item.name | url_encode }}" class="brand-directory-item js-brand-item" data-brand="{{ item.name | lower }}" title="{{ 'Ver {1} productos de {2} en el catálogo' | translate(item.count, item.name) }}">
									<span class="brand-item-name">{{ item.name }}</span>
									<span class="brand-count-badge">{{ item.count }}</span>
								</a>
							{% endfor %}
						</div>
					</div>
				{% endfor %}

				<!-- Empty State for Search Filter -->
				<div class="brands-empty-state" id="brandsEmptyState" style="display: none;">
					<i class="fa-solid fa-circle-exclamation"></i>
					<h4>{{ "No encontramos marcas con" | translate }} "<span class="js-empty-query"></span>"</h4>
					<p>{{ "Verificá la ortografía o consultá con nuestros especialistas técnicos para cotizar repuestos o equipos a pedido." | translate }}</p>
					<button type="button" class="btn btn-primary" id="btnResetBrandsFilter">
						<i class="fa-solid fa-rotate-left mr-2"></i> {{ "Restablecer Directorio Completo" | translate }}
					</button>
				</div>
			</div>

		</section>

		{% if page.content %}
			<div class="user-content mt-4 pt-4 border-top">
				{{ page.content }}
			</div>
		{% endif %}

	</div>
</main>
