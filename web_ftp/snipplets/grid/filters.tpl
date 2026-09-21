{% if applied_filters %}

    {# Applied filters chips #}

    {% if has_applied_filters %}
        <div class="active-filter-chips d-flex flex-wrap align-items-center">
            <span class="font-weight-bold font-small d-none d-md-inline mr-2 text-muted">{{ 'Filtros aplicados:' | translate }}</span>
            {% for product_filter in product_filters %}
                {% for value in product_filter.values %}

                    {# List applied filters as tags #}
                    
                    {% if value.selected %}
                        <button class="js-remove-filter chip filter-chip" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.pill-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}" title="{{ 'Eliminar filtro' | translate }}">
                            <span>{{ value.pill_label }}</span>
                            {% include "snipplets/svg/times.tpl" with {svg_custom_class: "icon-inline chip-remove-icon ml-1"} %}
                        </button>
                    {% endif %}
                {% endfor %}
            {% endfor %}
            <a href="#" class="js-remove-all-filters clear-filters-btn btn-link d-inline-block ml-md-2 mt-1 mt-md-0 font-small" data-component="filter-delete">
                <i class="fa-solid fa-trash-can mr-1"></i> {{ 'Borrar filtros' | translate }}
            </a> 
        </div>
    {% endif %}
{% else %}
    {% if product_filters is not empty %}
        
        {# Filters list #}

        <div id="filters" class="visible-when-content-ready" data-store="filters-nav">
            {% for product_filter in product_filters %}
                {% if product_filter.type == 'price' %}
                    {% set price_container_classes = 'filter-accordion' %}
                    {% set price_btn_classes = 'd-inline-block' %}
                    {% if not modal %}
                        {% set price_container_classes = 'card px-3 py-2' %}
                        {% set price_btn_classes = 'btn-small' %}
                    {% endif %}
                    {{ component(
                        'price-filter',
                        {'group_class': 'price-filter-container ' ~ price_container_classes, 'title_class': 'h5 font-big font-md-small mt-1 mb-3 text-uppercase', 'button_class': 'btn btn-default ' ~ price_btn_classes }
                    ) }}

                {% else %}
                    {% if product_filter.has_products %}
                    
                        <div class="js-accordion-container js-filter-container {% if not modal %}card px-3{% else %}filter-accordion{% endif %}" data-store="filters-group" data-component="list.filter-{{ product_filter.type }}" data-component-value="{{ product_filter.key }}">
                            <div class="h6 font-big mb-0">
                                <a href="#" class="js-accordion-toggle font-md-small text-uppercase row no-gutters align-items-center py-md-2" data-accordion-target="{{ product_filter.key }}">
                                    <div class="col my-1 pr-3 d-flex align-items-center">
                                        {{product_filter.name}}
                                        {% if has_applied_filters %}
                                            <span class="js-filters-badge filters-badge" style="display: none;"></span>
                                        {% endif %}
                                    </div>
                                    <div class="col-auto my-1">
                                        <span class="js-accordion-toggle-inactive" style="display: none;">
                                          {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline svg-icon-text icon-lg font-big font-md-body mr-1"} %}
                                        </span>
                                        <span class="js-accordion-toggle-active">
                                          {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline svg-icon-text icon-lg font-big font-md-body"} %}
                                        </span>
                                    </div>
                                </a>
                            </div>
                            <div class="js-accordion-content mt-md-1 my-3"> 
                                {% set index = 0 %}
                                {% for value in product_filter.values %}
                                    {% if value.product_count > 0 %}
                                        {% set index = index + 1 %}

                                        <label class="js-filter-checkbox {% if not value.selected %}js-apply-filter{% else %}js-remove-filter active font-weight-bold{% endif %} checkbox-container" data-filter-name="{{ product_filter.key }}" data-filter-value="{{ value.name }}" data-component="filter.option" data-component-value="{{ value.name }}">
                                            <input type="checkbox" autocomplete='off' {% if value.selected %}checked{% endif %}/>
                                            <span class="checkbox {% if loop.last and product_filter.values_with_products < 8 %}mb-0{% endif %}">
                                                <span class="checkbox-icon"></span>
                                                <span class="checkbox-text">
                                                    {{ value.name }} <span class="filter-badge ml-1">({{ value.product_count }})</span>
                                                </span>
                                            </span>
                                        </label>
                                        {% if index == 8 and product_filter.values_with_products > 8 %}
                                            <div class="js-accordion-container">
                                                <div class="js-accordion-content" style="display: none;">
                                        {% endif %}
                                        
                                    {% endif %}
                                    {% if loop.last and product_filter.values_with_products > 8 %}
                                                </div>
                                                <a href="#" class="js-accordion-toggle d-inline-block btn-link font-small mt-1">
                                                    <span class="js-accordion-toggle-inactive">{{ 'Ver todos' | translate }}</span>
                                                    <span class="js-accordion-toggle-active" style="display: none;">{{ 'Ver menos' | translate }}</span>
                                                </a>
                                            </div>
                                    {% endif %}
                                {% endfor %}
                            </div>
                        </div>
                    {% endif %}
                {% endif %}
            {% endfor %}
        </div>
    {% endif %}
{% endif %}