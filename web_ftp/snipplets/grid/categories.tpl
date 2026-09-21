{% if not modal %}
    <div class="visible-when-content-ready card px-3 mb-3 d-none d-md-block">
        {% if parent_category and parent_category.id!=0 %}
            <a href="{{ parent_category.url }}" title="{{ parent_category.name }}" class="category-back d-block{% if filter_categories %} mb-4{% endif %}">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline mr-2 svg-icon-text"} %}{{ parent_category.name }}</a>
        {% endif %}
{% endif %}
        {% if filter_categories %}
        {% set current_page_category_id = category.id %}
        <div class="js-accordion-container {% if modal %}filter-accordion{% endif %}">
            <div class="h6 font-big mb-0">
                <a href="#" class="js-accordion-toggle font-md-small text-uppercase row no-gutters align-items-center py-md-2">
                    <div class="col pr-3 my-1 font-weight-bold">
                        {{ "Categorías" | translate }}
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
                {% for cat in filter_categories %}
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

                    {% if loop.index == 8 and filter_categories | length > 8 %}
                        <div class="js-accordion-container">
                            <div class="js-accordion-content" style="display: none;">
                    {% endif %}
                    {% if loop.last and filter_categories | length > 8 %}
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
{% if not modal %}
    </div>
{% endif %}