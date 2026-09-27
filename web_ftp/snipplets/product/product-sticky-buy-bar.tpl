{% if product.available and product.display_price %}
    <div class="mobile-sticky-buy-bar js-mobile-sticky-buy-bar" id="mobileStickyBuyBar" data-store="product-sticky-buy-bar">
        <div class="mobile-buy-bar-info">
            {% if product.featured_image %}
                <img src="{{ product.featured_image | product_image_url('thumb') }}" alt="{{ product.name }}" class="mobile-buy-bar-img" loading="lazy">
            {% endif %}
            <div class="mobile-buy-bar-details">
                <span class="mobile-buy-bar-title text-truncate">{{ product.name }}</span>
                <span class="mobile-buy-bar-price text-accent font-weight-bold">{{ product.price | money }}</span>
            </div>
        </div>
        <button type="button" class="btn btn-primary btn-sm mobile-buy-bar-btn js-sticky-buy-bar-btn" onclick="document.getElementById('product_form') ? document.getElementById('product_form').submit() : null;">
            <i class="fa-solid fa-cart-plus mr-1"></i> {{ 'Comprar' | translate }}
        </button>
    </div>
{% endif %}
