{% include "snipplets/breadcrumbs-bar.tpl" with {breadcrumbs_bar_class: 'mb-0'} %}

<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container background-secondary pb-4 pt-md-4 pb-md-3" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container pt-md-1">
        <div class="row">
            <div class="col-md-7 pb-3">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
    </div>

    {# Product Tabs Section (Single Source of Truth matching boceto_web/product.html) #}
    <div class="container mt-4 pt-2 mb-4">
        {% include 'snipplets/product/product-tabs.tpl' %}
    </div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}

{# Mobile Sticky Buy Bar #}
{% include 'snipplets/product/product-sticky-buy-bar.tpl' %}
