<div class="col-md-auto filters-sidebar d-none d-md-block visible-when-content-ready">
    <div class="catalog-sidebar-title mb-3">
        <span><i class="fa-solid fa-sliders text-primary mr-2"></i> {{ 'Filtros de Búsqueda' | translate }}</span>
    </div>
    {% if products %}
        {% if filter_categories is not empty %}
            {% include "snipplets/grid/categories.tpl" %}
        {% endif %}
        {% if product_filters is not empty %}	   
            {% include "snipplets/grid/filters.tpl" %}
        {% endif %}
    {% endif %}
</div>