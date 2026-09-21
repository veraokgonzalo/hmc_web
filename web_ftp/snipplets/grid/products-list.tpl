{% set noFilterResult = "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." %}
{% set list_data_store = template == 'category' ? 'category-grid-' ~ category.id : 'search-grid' %}

{% if products or template == 'category' %}
    <div class="col" data-store="{{ list_data_store}}">
{% endif %}
    {% if products %}
        {# Catalog Toolbar with results count, sort trigger, and grid/list view switcher #}
        <div class="catalog-toolbar mb-4">
            <div class="catalog-results-count">
                {{ 'Mostrando' | translate }} <strong>{{ products_count }}</strong> {{ 'productos' | translate }}
            </div>
            
            <div class="catalog-toolbar-actions">
                <a href="#" class="catalog-sort-btn js-modal-open d-inline-flex align-items-center" data-toggle="#sort-by">
                    {% include "snipplets/svg/sort.tpl" with { svg_custom_class: "icon-inline mr-2"} %}
                    <span>{{ 'Ordenar por' | translate }}</span>
                </a>

                <div class="catalog-view-modes d-none d-sm-flex">
                    <button type="button" class="view-mode-btn js-view-mode active" data-view="grid" title="{{ 'Vista en Grilla' | translate }}"><i class="fa-solid fa-table-cells-large"></i></button>
                    <button type="button" class="view-mode-btn js-view-mode" data-view="list" title="{{ 'Vista en Lista' | translate }}"><i class="fa-solid fa-list"></i></button>
                </div>
            </div>
        </div>

        <div class="js-product-table row row-grid">
            {% include 'snipplets/product_grid.tpl' %}
        </div>
        {% if settings.pagination == 'infinite' %}
            {% set pagination_type_val = true %}
        {% else %}
            {% set pagination_type_val = false %}
        {% endif %}
        {% include "snipplets/grid/pagination.tpl" with {infinite_scroll: pagination_type_val} %}

        {# Technical Advice Assistance Banner #}
        {% set whatsapp_url = store.whatsapp ? store.whatsapp : 'https://wa.me/5492954696231' %}
        <div class="technical-assistance-banner mt-5">
            <div class="technical-assistance-content">
                <h3 class="technical-assistance-title mb-1">{{ '¿Necesitás asesoramiento sobre qué equipo elegir?' | translate }}</h3>
                <p class="technical-assistance-desc mb-0">{{ 'Nuestros técnicos te orientan según los requerimientos de tu obra o campo.' | translate }}</p>
            </div>
            <a href="{{ whatsapp_url }}" target="_blank" class="btn btn-primary technical-assistance-btn" rel="noopener">
                <i class="fa-brands fa-whatsapp mr-2"></i> {{ 'Hablar con un Asesor Técnico' | translate }}
            </a>
        </div>
    {% else %}
        {% if template == 'category' %}
            <div class="h6 text-center" data-component="filter.message">
                {{(has_filters_enabled ? noFilterResult : "Próximamente") | translate}}
            </div>
        {% elseif template == 'search' %}
            <h5 class="my-4 {% if has_applied_filters %}text-center{% endif %} {% if not has_applied_filters %}text-uppercase font-weight-normal{% endif %}">
                {{ ((has_applied_filters and query) or has_applied_filters ?  noFilterResult : "Escribilo de otra forma y volvé a intentar.") | translate }}
            </h5>
        {% endif %}
    {% endif %}
{% if products or template == 'category'%}
    </div>
{% endif %}

