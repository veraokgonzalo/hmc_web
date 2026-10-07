{# /*============================================================================
  #Mega Dropdown Categorías Principales (12 Top Categories - 4 cols x 3 rows)
==============================================================================*/ #}

{% set core_categories = [
  {'slug': 'agua', 'name': 'Agua', 'count': '25 productos', 'link': '/agua1'},
  {'slug': 'construccion', 'name': 'Construcción', 'count': '151 productos', 'link': '/construccion'},
  {'slug': 'consumibles-e-insumos', 'name': 'Consumibles e Insumos', 'count': '90 productos', 'link': '/consumibles-e-insumos'},
  {'slug': 'ferreteria', 'name': 'Ferretería', 'count': '1.204 productos', 'link': '/ferreteria'},
  {'slug': 'generacion-energia', 'name': 'Generación Energía', 'count': '134 productos', 'link': '/generacion-energia'},
  {'slug': 'jardin', 'name': 'Jardín', 'count': '294 productos', 'link': '/jardin'},
  {'slug': 'maquina-a-bateria', 'name': 'Máquinas a Batería', 'count': '159 productos', 'link': '/maquina-a-bateria'},
  {'slug': 'maquina-a-explosion', 'name': 'Máquinas a Explosión', 'count': '272 productos', 'link': '/maquina-a-explosion'},
  {'slug': 'maquina-electrica', 'name': 'Máquinas Eléctricas', 'count': '113 productos', 'link': '/maquina-electrica'},
  {'slug': 'producto-de-fuerza', 'name': 'Productos de Fuerza', 'count': '116 productos', 'link': '/producto-de-fuerza'},
  {'slug': 'repuestos', 'name': 'Repuestos', 'count': '1.231 productos', 'link': '/repuestos'},
  {'slug': 'riego', 'name': 'Riego', 'count': '565 productos', 'link': '/riego1'}
] %}

{% for cat in core_categories %}
  {% set cat_url = cat.link %}
  {% set cat_name = cat.name %}
  {% for db_cat in categories %}
    {% set is_root = not db_cat.parent or db_cat.parent == 0 or not db_cat.parent_id or db_cat.parent_id == 0 %}
    {% if is_root and (db_cat.handle == cat.slug or db_cat.handle == cat.slug ~ '1') %}
      {% set cat_url = db_cat.url %}
    {% endif %}
  {% endfor %}
  <a href="{{ cat_url }}" class="dropdown-category-card" title="Ver {{ cat_name | capitalize }}">
    <div class="dropdown-category-info">
      <span class="dropdown-category-name">{{ cat_name | capitalize }}</span>
    </div>
  </a>
{% endfor %}
