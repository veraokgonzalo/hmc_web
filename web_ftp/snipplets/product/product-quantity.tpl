{# Product quantity #}

{% set label_text = product.isSubscribable() ? 'Cantidad' | translate %}

<div class="col-4 {% if not quickshop %}col-md-3{% endif %} pr-0 {{ product_quantity_container_class }}">
    {% embed "snipplets/forms/form-input.tpl" with{
    type_number: true, input_value: '1',
    input_name: 'quantity' ~ item.id, 
    input_custom_class: 'js-quantity-input form-control-big', 
    input_label_text: label_text,
    input_append_content: true, 
    input_group_custom_class: 'js-quantity', 
    form_control_container_custom_class: 'col px-0',
    form_data_component: 'product.adding-amount',
    form_control_quantity: true,
    input_min: '1',
    data_component: 'adding-amount.value',
    input_aria_label: 'Cambiar cantidad' | translate } %}
        {% block input_prepend_content %}
        <div class="form-quantity d-flex flex-nowrap form-row m-0 align-items-center" data-component="product.quantity">
            <span class="js-quantity-down form-quantity-icon icon-30px font-small d-flex align-items-center justify-content-center" data-component="product.quantity.minus">
                {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline"} %}
            </span>
        {% endblock input_prepend_content %}
        {% block input_append_content %}
            <span class="js-quantity-up form-quantity-icon icon-30px font-small d-flex align-items-center justify-content-center" data-component="product.quantity.plus">
                {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline"} %}
            </span>
        </div>
        {% endblock input_append_content %}
    {% endembed %}
    {% if settings.product_stock %}
        <div class="font-small py-2 text-center js-product-stock-container">
            <span class="js-product-stock font-weight-bold {% if product.selected_or_first_available_variant.has_stock %}text-primary{% else %}text-danger{% endif %}">
                {% if product.selected_or_first_available_variant.has_stock %}
                    {{ "Hay stock" | translate }}
                {% else %}
                    {{ "Sin stock" | translate }}
                {% endif %}
            </span>
        </div>
    {% endif %}
</div>