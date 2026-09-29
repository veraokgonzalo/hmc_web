{% set is_real_cat = category and category.id and category.handle not in ['productos', 'todos-los-productos'] and category.name | lower not in ['productos', 'todos los productos', 'todo el catalogo', 'catalogo'] %}
{% set list_categories = filter_categories is not empty ? filter_categories : (is_real_cat ? categories : null) %}
{% set current_page_category_id = is_real_cat ? category.id : null %}

{% if not modal %}
<div class="visible-when-content-ready card px-3 py-3 mb-3 d-none d-md-block">
{% else %}
<div class="filter-modal-categories px-3 pt-3 pb-2">
{% endif %}

    {# 1. Navigation Back Button (Shown ONLY when in a specific category, NEVER in general /productos) #}
    {% if is_real_cat %}
        <div class="category-nav-back mb-3">
            {% if parent_category and parent_category.id != 0 %}
                <a href="{{ parent_category.url }}" title="{{ parent_category.name }}" class="category-back-btn d-flex align-items-center">
                    <i class="fa-solid fa-arrow-left mr-2"></i>
                    <span class="text-truncate">{{ 'Volver a' | translate }} <strong>{{ parent_category.name }}</strong></span>
                </a>
            {% else %}
                <a href="/productos" title="{{ 'Ver todos los productos' | translate }}" class="category-back-btn d-flex align-items-center">
                    <i class="fa-solid fa-arrow-left mr-2"></i>
                    <span>{{ 'Ver todo el catálogo' | translate }}</span>
                </a>
            {% endif %}
        </div>
    {% endif %}

    {# 2. Categories Accordion List with Dynamic Superior Category Title #}
    {% if list_categories %}
        {% if is_real_cat %}
            {% if filter_categories is not empty %}
                {% set superior_name = (parent_category and parent_category.id != 0) ? parent_category.name : category.name %}
                {% set accordion_title = ('Subcategorías de' | translate) ~ ' ' ~ superior_name %}
            {% else %}
                {% set accordion_title = 'Todas las Categorías' | translate %}
            {% endif %}
        {% else %}
            {% set accordion_title = 'Categorías' | translate %}
        {% endif %}

        <div class="js-accordion-container {% if modal %}filter-accordion{% endif %}">
            <div class="h6 font-big mb-0">
                <a href="#" class="js-accordion-toggle font-md-small text-uppercase row no-gutters align-items-center py-md-2">
                    <div class="col pr-3 my-1 font-weight-bold">
                        {{ accordion_title }}
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
            <ul class="js-accordion-content list-unstyled mt-md-1 my-3"> 
                {% for cat in list_categories %}
                    {% set is_selected = (current_page_category_id and cat.id == current_page_category_id) or cat.active or (selected_category and cat.id == selected_category.id) %}
                    <li data-item="{{ loop.index }}" class="filter-item mb-2 pb-md-1 {% if is_selected %}active font-weight-bold{% endif %}">
                        <a href="{{ cat.url }}" title="{{ cat.name }}" class="{% if is_selected %}text-primary font-weight-bold{% else %}btn-link{% endif %} font-small no-underline d-flex align-items-center justify-content-between">
                            <span class="d-flex align-items-center">
                                {% if is_selected %}
                                    <i class="fa-solid fa-check text-primary mr-2" style="font-size: 0.85rem;"></i>
                                {% else %}
                                    <i class="fa-regular fa-circle text-muted mr-2" style="font-size: 0.65rem; opacity: 0.4;"></i>
                                {% endif %}
                                {{ cat.name }}
                            </span>
                            {% if cat.products_count %}
                                <span class="filter-badge">({{ cat.products_count }})</span>
                            {% endif %}
                        </a>
                    </li>

                    {% if loop.index == 8 and list_categories | length > 8 %}
                        <div class="js-accordion-container">
                            <div class="js-accordion-content" style="display: none;">
                    {% endif %}
                    {% if loop.last and list_categories | length > 8 %}
                            </div>
                            <a href="#" class="js-accordion-toggle d-inline-block btn-link font-small mt-1">
                                <span class="js-accordion-toggle-inactive">{{ 'Ver más' | translate }}</span>
                                <span class="js-accordion-toggle-active" style="display: none;">{{ 'Ver menos' | translate }}</span>
                            </a>
                        </div>
                    {% endif %}
                {% endfor %}
            </ul>
        </div>
    {% endif %}

</div>