{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_free_shipping_bar = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{% set gift_progress_parameters = {
  show_check: false,
  svg_sprites: false,
  progress_bar_custom_icon: include('snipplets/svg/gift.tpl', { svg_custom_class: 'icon-inline svg-icon-accent icon-lg' }),
  progress_bar_classes: {
    container: 'progress-bar',
    title_container: 'progress-bar-title-container',
    title: 'progress-bar-title font-weight-bold text-accent',
    subtitle: 'progress-bar-subtitle opacity-60',
    track: 'bar-progress',
    fill: 'bar-progress-active transition-soft',
  }
} %}

{% set class_col_text = "col text-right" %}
{% set class_col_text_padding = class_col_text ~ " pr-md-0" %}
{% set class_col_text_padding_opacity = class_col_text_padding ~ " opacity-40" %}

{% if cart_page %}
  <div class="d-block d-md-none">
{% endif %}
    {{ component('gift-promotion-progress', gift_progress_parameters) }}
{% if cart_page %}
  </div>
{% endif %}

{% if has_free_shipping_bar %}

  {# includes free shipping progress bar: only if store has free shipping with a minimum #}

  {% if cart_page %}
    <div class="d-block d-md-none">
  {% endif %}
      {% include "snipplets/shipping/shipping-free-rest.tpl" %}
  {% if cart_page %}
    </div>
  {% endif %}

{% endif %}

{# Define conditions to show shipping calculator and store branches on cart #}

{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

{% if cart_page %}

  {# Cart page: sticky summary wrapper #}

  <div id="cart-sticky-summary" class="position-sticky-md cart-page-totals">
    <div class="d-none d-md-block">
      {{ component('gift-promotion-progress', gift_progress_parameters) }}
    </div>

    {% if has_free_shipping_bar %}
      {# includes free shipping progress bar: only if store has free shipping with a minimum #}

      <div class="d-none d-md-block">
        {% include "snipplets/shipping/shipping-free-rest.tpl" %}
      </div>
    {% endif %}

{% else %}

  {# Cart fulfillment #}

  {% include "snipplets/shipping/cart-fulfillment.tpl" %}
{% endif %}


    {# Coupon input #}

    {% if settings.cart_coupon %}
      <div class="js-visible-on-cart-filled mb-3" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>
        {{ component('coupon-input', {
          label_custom_icon: include('snipplets/svg/tag.tpl', { svg_custom_class: 'icon-inline svg-icon-text mr-2 align-middle' }),
          toggle_inactive_custom_icon: include('snipplets/svg/chevron-down.tpl', { svg_custom_class: 'icon-inline svg-icon-text' }),
          toggle_active_custom_icon: include('snipplets/svg/chevron-up.tpl', { svg_custom_class: 'icon-inline svg-icon-text' }),
          spinner_custom_icon: include('snipplets/svg/spinner-third.tpl', { svg_custom_class: 'icon-inline icon-spin icon-md ml-2' }),
          container_classes: {
            container: 'mb-3',
            toggle: 'd-flex align-items-center justify-content-between w-100',
            toggle_label: 'd-flex align-items-center',
            label: 'font-small',
            actions: 'mt-2',
            applied_row: 'd-flex align-items-center justify-content-between',
            applied_code: 'mr-4 font-body',
            remove_button: 'btn btn-link font-small float-right',
            form: 'form-group mb-0',
            input_wrapper: 'form-control-container d-flex',
            input: 'form-control',
            apply_button: 'btn btn-default col-auto ml-2 px-3',
            error: 'alert alert-danger mb-0 mt-2',
          }
        }) }}

        {# Divider between coupon input and subtotal #}
        <div class="divider"></div>
      </div>
    {% endif %}

    {# Cart totals #}

    {{ component('cart-totals', {
        shipping_enabled: show_calculator_on_cart,
        shipping_discount_row_enabled: true,
        payment_discount_price_enabled: settings.payment_discount_price,
        installments_enabled: not settings.payment_discount_price,
        totals_divider: false,
        text_classes: {
          subtotal: 'h5 row font-big font-weight-normal' ~ (cart_page ? ' no-gutters'),
          subtotal_label: cart_page ? 'col-auto pl-md-0' : 'col-7',
          subtotal_price: cart_page ? class_col_text_padding : class_col_text,
          price_without_taxes: 'row opacity-50 pb-2',
          price_without_taxes_label: 'col-auto',
          price_without_taxes_price: class_col_text,
          promotions: 'mt-2',
          discounts_row: 'row no-gutters mb-2',
          discounts_label: 'col pr-3',
          discounts_price: 'col-auto text-right text-accent',
          shipping_costs: 'h6 font-body font-weight-normal mb-2 row no-gutters',
          shipping_costs_label: 'col-auto pl-md-0',
          shipping_costs_price: class_col_text_padding_opacity,
          shipping_costs_calculating: class_col_text_padding_opacity,
          shipping_costs_empty: class_col_text_padding_opacity,
          shipping_discount_row: 'row no-gutters mb-3 font-weight-normal text-accent',
          shipping_discount_label: 'col-auto pl-md-0 text-uppercase',
          shipping_discount_price: class_col_text_padding,
          total: 'h2 row font-huge mb-3' ~ (cart_page ? ' no-gutters'),
          total_label: 'col-auto' ~ (cart_page ? ' pl-md-0'),
          total_price: class_col_text ~ (cart_page ? ' pr-md-0'),
          payment_discount_and_installments: 'h2 col-12 mb-3 px-0',
          payment_discount_price: 'font-small mt-1 text-right',
          installments: 'font-small mt-1 text-right',
        },
      })
    }}

    {{ component('nubesdk-slot', { type: "before_go_to_checkout" }) }}

    <div class="js-visible-on-cart-filled" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

      {# Cart page and popup CTA Module #}

      {% set has_validation_messages = cart.checkout_enabled_validation_messages | length > 0 %}
      {% set should_show_checkout_button = cart.checkout_enabled and has_validation_messages == false %}

      {% if cart_page %}

        {# Cart page CTA and minimum alert: Always render button to ensure it exists in DOM, control visibility via CSS/JS #}

        <input id="go-to-checkout" class="btn btn-primary btn-big btn-block mb-2" {{ not should_show_checkout_button ? 'style="display:none"' }} type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>

        {# Cart alert messages #}
        {{ component(
          'checkout-enabled-validation-messages', {
            alert_classes: 'alert alert-warning w-100 mb-2 text-center',
            cart_minimum_value: settings.cart_minimum_value
          })
        }}

      {% else %}

        {# Cart popup CTA and minimum alert #}

        <div class="js-ajax-cart-submit mb-3" {{ not should_show_checkout_button ? 'style="display:none"' }} id="ajax-cart-submit-div" >
          <input class="btn btn-primary btn-big btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" data-component="cart.checkout-button"/>
        </div>
        {# Cart alert messages #}
        {{ component(
          'checkout-enabled-validation-messages', {
            alert_classes: 'alert alert-warning mb-2 text-center',
            cart_minimum_value: settings.cart_minimum_value
          })
        }}

      {% endif %}

      {# Cart panel continue buying link #}

      {% if settings.continue_buying %}
        <div class="text-center w-100 {% if not cart_page %}mb-md-2{% endif %} pb-3">
          <a href="{% if cart_page %}{{ store.products_url }}{% else %}#{% endif %}" class="{% if not cart_page %}js-modal-close js-fullscreen-modal-close{% endif %} btn-link">{{ 'Ver más productos' | translate }}</a>
        </div>
      {% endif %}
    </div>

    {{ component('nubesdk-slot', { type: "after_go_to_checkout" }) }}

{% if cart_page %}
  {# End of sticky module #}
  </div>
{% endif %}
