{{ component('nubesdk-slot', { type: "before_line_item", pick: item.id }) }}

{% set is_gift = item.is_gift %}

<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} cart-item row no-gutters pt-3 pb-3 pl-3 {% if not loop.last %}bottom-line{% endif %} {% if cart_page %}align-items-md-center{% endif %}" data-item-id="{{ item.id }}" data-gift="{{ is_gift ? 'true' : 'false' }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">
  {% set hide_compare_price_subtotal = not item.compare_at_price_subtotal or item.is_subscription_item %}
  {% set discount_percentage = item.discount_percentage %}

  {# Cart item image #}
  <div class="col-auto">
    <a href="{{ item.url }}" class="d-block cart-item-image-col {% if cart_page%}cart-item-image-col-md{% endif %}">
      <img src="{{ item.featured_image | product_image_url('medium') }}" class="img-fluid cart-item-image {% if cart_page %}cart-item-image-md{% endif %}" />
    </a>
  </div>
  <div class="col pl-3 align-items-center">
    <div class="row align-items-center">
      
      <div class="col-12 {% if cart_page %}col-md-4 d-md-flex{% endif %}">

        {# Cart item name #}

        <div class="row w-100 no-gutters {% if cart_page %}align-items-md-center{% endif %}">

          <div class="cart-item-name-container col {% if cart_page %}col-md-8 font-md-body d-md-block{% endif %}" data-component="line-item.name">
            <a href="{{ item.url }}" data-component="name.short-name" class="cart-item-name d-block mb-2">
              {{ item.short_name }}
              <span class="font-small" data-component="name.short-variant-name">{{ item.short_variant_name }}</span>
            </a>

            {% if is_gift %}
              <div class="text-accent font-smallest font-weight-bold text-uppercase my-2">
                {{ "Regalo" | translate }}
              </div>
            {% endif %}

            {{ component(
              'cart-labels', {
                group: true,
                subscription_label: true,
                hide_percentage_off_label: true,
                labels_classes: {
                  group: 'mb-2',
                  label: 'text-accent font-smallest font-weight-bold text-uppercase w-100',
                  shipping: 'mb-1',
                  subscription: 'font-smallest opacity-80 mt-1 mb-2',
                },
              })
            }}
          </div>
          {# Cart item delete #}
          <div class="cart-item-delete col-auto {% if cart_page %}d-md-none{% endif %} text-center" >
            <button type="button" class="btn font-big pr-0 pl-2 {% if is_gift %}invisible{% endif %}" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
              {% include "snipplets/svg/trash-alt.tpl" with {svg_custom_class: "icon-inline icon-w-12 icon-lg"} %}
            </button>
          </div>
        </div>
      </div>

      {# Cart item quantity controls #}

      {% set cart_quantity_class = cart_page ? 'float-md-none m-auto ' : '' %}
      {% set cart_quantity_input_class = cart_page ? 'py-md-2 my-1' : '' %}

      <div class="cart-item-quantity col-auto mt-1" data-component="line-item.subtotal">
        {% set cart_qty_margin = '' %}
        {% if cart_page %}
          {% set cart_qty_margin = 'm-md-auto' %}
        {% endif %}
        {% embed "snipplets/forms/form-input.tpl" with{
          type_number: true, 
          input_value: item.quantity, 
          input_name: 'quantity[' ~ item.id ~ ']', 
          input_data_attr: 'item-id',
          input_data_val: item.id,
          input_group_custom_class: cart_quantity_class ~ ' float-left form-quantity cart-item-quantity small p-0 mb-0 ' ~ cart_qty_margin, 
          input_custom_class: 'js-cart-quantity-input text-center py-1 ' ~  cart_quantity_input_class,
          input_label: false, input_append_content: true,
          input_disabled: is_gift,
          data_component: 'quantity.value',
          form_control_container_custom_class: 'js-cart-quantity-container col px-0'} %}
            {% block input_prepend_content %}
            <div class="form-row m-0 align-items-center">
              <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.minus">
                {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline"} %}
              </span>
            {% endblock input_prepend_content %}
            {% block input_append_content %}
              
              {# Always place this spinner before the quantity input #}
        
              <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                {% include "snipplets/svg/spinner-third.tpl" with {svg_custom_class: "icon-inline icon-spin svg-icon-text"} %}
              </span>

              <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.plus">
                {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline"} %}
              </span>
            </div>
            {% endblock input_append_content %}
        {% endembed %}
      </div>

      {% if cart_page %}
        {# Cart item unit price #}
        <span class="col-3 d-none d-md-flex justify-content-center">
          {% if is_gift %}
            <span class="d-flex flex-column align-items-center align-self-center font-big" data-line-item-id="{{ item.id }}">
              <span class="price-compare font-small opacity-50">{{ item.compare_at_price | money }}</span>
              <span>{{ "Gratis" | translate }}</span>
            </span>
          {% else %}
            <span class="js-cart-item-unit-price d-flex align-self-center font-big" data-line-item-id="{{ item.id }}">{{ item.unit_price | money }}</span>
          {% endif %}
        </span>
      {% endif %}

      {# Cart item subtotal #}

      <div class="col {% if cart_page %}col-md-3 d-flex flex-column justify-content-end justify-content-md-center pr-md-0 font-md-big{% else %} text-right{% endif %} text-right">
        {% if is_gift %}
          <div class="js-cart-item-subtotal-compare-price-container pr-3" data-line-item-id="{{ item.id }}">
            <span class="price-compare font-small opacity-50" data-line-item-id="{{ item.id }}">{{ item.compare_at_price_subtotal | money }}</span>
          </div>
          <span class="mt-2 font-weight-bold {% if cart_page %}d-md-flex align-self-center{% endif %} pr-3" data-line-item-id="{{ item.id }}">{{ "Gratis" | translate }}</span>
        {% else %}
          <div class="js-cart-item-subtotal-compare-price-container pr-3" data-line-item-id="{{ item.id }}" {% if hide_compare_price_subtotal %}style="display: none"{% endif %}>
            {% if discount_percentage > 0 %}
              <span class="text-accent font-small font-weight-bold">-{{ discount_percentage }}%</span>
            {% endif %}
            <span class="js-cart-item-subtotal-compare-price price-compare font-small opacity-50" data-line-item-id="{{ item.id }}" data-component="subtotal_compare_price.value" data-component-value='{{ item.compare_at_price_subtotal | money }}'>{{ item.compare_at_price_subtotal | money }}</span>
          </div>
          <span class="js-cart-item-subtotal {% if not hide_compare_price_subtotal %}mt-2{% endif %} font-weight-bold {% if cart_page %}d-md-flex align-self-center{% endif %} pr-3" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value={{ item.subtotal | money }}'>{{ item.subtotal | money }}</span>
        {% endif %}
      </div>

      {% if cart_page and not is_gift %}
        {# Cart item delete #}
        <div class="cart-item-delete col d-none d-md-block text-center" >
          <button type="button" class="btn btn-link" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
            {% include "snipplets/svg/trash-alt.tpl" with {svg_custom_class: "icon-inline icon-w-12 cart-item-delete-icon"} %}
          </button>
        </div>
      {% endif %}
    </div>
  </div>
</div>