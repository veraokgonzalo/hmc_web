{# /*============================================================================
  #Page breadcrumbs
==============================================================================*/
#Properties

#Breadcrumb
    //breadcrumbs_custom_class for custom CSS classes

#Same markup as the custom pages (page.about.tpl, contact.tpl, page.brands.tpl):
#.breadcrumb-list with .breadcrumb-item / chevron .breadcrumb-sep. For the full-width
#gray bar use snipplets/breadcrumbs-bar.tpl.
#}

{% set breadcrumb_sep %}<div class="breadcrumb-sep"><i class="fa-solid fa-chevron-right"></i></div>{% endset %}

{% if breadcrumbs %}
    <div class="breadcrumb-list {{ breadcrumbs_custom_class }}">
        <div class="breadcrumb-item"><a href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a></div>
        {{ breadcrumb_sep }}
        {% if template == 'page' %}
            <div class="breadcrumb-item active">{{ page.name }}</div>
        {% elseif template == 'cart' %}
            <div class="breadcrumb-item active">{{ "Carrito de compras" | translate }}</div>
        {% elseif template == 'search' %}
            <div class="breadcrumb-item active">{{ "Resultados de búsqueda" | translate }}</div>
        {% elseif template == 'account.order' %}
            <div class="breadcrumb-item active">{{ 'Orden {1}' | translate(order.number) }}</div>
        {% elseif template == 'blog' %}
            <div class="breadcrumb-item active">{{ 'Blog' | translate }}</div>
        {% elseif template == 'blog-post' %}
            <div class="breadcrumb-item"><a href="{{ store.blog_url }}" title="{{ 'Blog' | translate }}">{{ 'Blog' | translate }}</a></div>
            {{ breadcrumb_sep }}
            <div class="breadcrumb-item active">{{ post.title }}</div>
        {% else %}
            {% for crumb in breadcrumbs %}
                {% if crumb.last %}
                    <div class="breadcrumb-item active">{{ template == 'category' ? crumb.name | capitalize : crumb.name }}</div>
                {% else %}
                    <div class="breadcrumb-item"><a href="{{ crumb.url }}" title="{{ crumb.name }}">{{ crumb.name | capitalize }}</a></div>{# intermediate crumbs are categories #}
                    {{ breadcrumb_sep }}
                {% endif %}
            {% endfor %}
        {% endif %}
    </div>
{% endif %}
