{# /*============================================================================
  #Mega Dropdown Categorías Principales (12 Top Categories - 4 cols x 3 rows)
==============================================================================*/ #}

{% set core_categories = [
  {'slug': 'agua', 'name': 'Agua', 'count': '19 productos', 'link': '/agua'},
  {'slug': 'construccion', 'name': 'Construcción', 'count': '151 productos', 'link': '/construccion'},
  {'slug': 'consumibles-e-insumos', 'name': 'Consumibles e Insumos', 'count': '82 productos', 'link': '/consumibles-e-insumos'},
  {'slug': 'ferreteria', 'name': 'Ferretería', 'count': '1.192 productos', 'link': '/ferreteria'},
  {'slug': 'generacion-energia', 'name': 'Generación Energía', 'count': '112 productos', 'link': '/generacion-energia'},
  {'slug': 'jardin', 'name': 'Jardín', 'count': '287 productos', 'link': '/jardin'},
  {'slug': 'maquina-a-bateria', 'name': 'Máquinas a Batería', 'count': '159 productos', 'link': '/maquina-a-bateria'},
  {'slug': 'maquina-a-explosion', 'name': 'Máquinas a Explosión', 'count': '265 productos', 'link': '/maquina-a-explosion'},
  {'slug': 'maquina-electrica', 'name': 'Máquinas Eléctricas', 'count': '108 productos', 'link': '/maquina-electrica'},
  {'slug': 'producto-de-fuerza', 'name': 'Productos de Fuerza', 'count': '96 productos', 'link': '/producto-de-fuerza'},
  {'slug': 'repuestos', 'name': 'Repuestos', 'count': '563 productos', 'link': '/repuestos'},
  {'slug': 'riego', 'name': 'Riego', 'count': '200 productos', 'link': '/riego'}
] %}

{% for cat in core_categories %}
  {% set cat_url = cat.link %}
  {% set cat_name = cat.name %}
  {% set cat_count = cat.count %}
  {% for db_cat in categories %}
    {% if db_cat.handle == cat.slug or (db_cat.url and db_cat.url | trim('/') | split('/') | last == cat.slug) %}
      {% set cat_url = db_cat.url %}
      {% set cat_name = db_cat.name %}
      {% if db_cat.products_count and db_cat.products_count > 0 %}
        {% set cat_count = db_cat.products_count ~ ' ' ~ ('productos' | translate) %}
      {% endif %}
    {% endif %}
  {% endfor %}
  <a href="{{ cat_url }}" class="dropdown-category-card" title="Ver {{ cat_name }}">
    <div class="dropdown-category-info">
      <span class="dropdown-category-name">{{ cat_name }}</span>
      <span class="dropdown-category-count">{{ cat_count }}</span>
    </div>
  </a>
{% endfor %}
