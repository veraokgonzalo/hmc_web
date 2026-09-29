{# /*============================================================================
  #Page breadcrumbs
==============================================================================*/
#Properties

#Breadcrumb
    //breadcrumbs_custom_class for custom CSS classes
#}

{% if breadcrumbs %}
    <div class="breadcrumbs {{ breadcrumbs_custom_class }}">
        <a class="crumb nav-link-home" href="/" data-link-home="true" title="{{ store.name | default('HMC HUB') }}">{{ "Inicio" | translate }}</a>
        <span class="separator">></span>
        {% if template == 'page' %}
            <span class="crumb active">{{ page.name }}</span>
        {% elseif template == 'cart' %}
            <span class="crumb active">{{ "Carrito de compras" | translate }}</span>
        {% elseif template == 'search' %}
            <span class="crumb active">{{ "Resultados de búsqueda" | translate }}</span>
        {% elseif template == 'account.order' %}
             <span class="crumb active">{{ 'Orden {1}' | translate(order.number) }}</span>
        {% elseif template == 'blog' %}
            <span class="crumb active">{{ 'Blog' | translate }}</span>
        {% elseif template == 'blog-post' %}
            <a class="crumb" href={{ store.blog_url }} title="{{ 'Blog' | translate }}">{{ 'Blog' | translate }}</a>
            <span class="separator">></span>
            <span class="crumb active">{{ post.title }}</span>
        {% else %}
            {% set has_products_crumb = false %}
            {% for c in breadcrumbs %}
                {% if c.url == '/productos' or c.url == store.products_url %}
                    {% set has_products_crumb = true %}
                {% endif %}
            {% endfor %}
            {% set is_real_cat = category and category.id and category.handle not in ['productos', 'todos-los-productos'] and category.name | lower not in ['productos', 'todos los productos', 'todo el catalogo', 'catalogo'] %}
            {% if (template == 'category' and is_real_cat and not has_products_crumb) or (template == 'product' and not has_products_crumb) %}
                <a class="crumb" href="/productos" title="{{ 'Productos' | translate }}">{{ 'Productos' | translate }}</a>
                <span class="separator">></span>
            {% endif %}
            {% for crumb in breadcrumbs %}
                {% if crumb.last %}
                    <span class="crumb active">{{ crumb.name }}</span>
                {% else %}
                    <a class="crumb" href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name }}</a>
    	            <span class="separator">></span>
                {% endif %}
            {% endfor %}
        {% endif %}
    </div>
{% endif %}
