<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />

        {# Preload brand fonts #}
        <link rel="preload" href="{{ 'fonts/quedora-bold.otf' | static_url }}" as="font" type="font/otf" crossorigin />
        <link rel="preload" href="{{ 'fonts/PlusJakartaSans-Medium.ttf' | static_url }}" as="font" type="font/ttf" crossorigin />

        {# Google Fonts: Plus Jakarta Sans, Chakra Petch, Inter #}
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Chakra+Petch:ital,wght@0,500;0,600;0,700;0,800;1,700&family=Plus+Jakarta+Sans:ital,wght@0,400;0,500;0,600;0,700;0,800;1,400;1,600;1,700&family=Inter:wght@300;400;500;600;700;800&display=swap" />

        {# FontAwesome 6 Icons #}
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />

        {# Preload LCP home, category and product page elements #}

        {% snipplet 'preload-images.tpl' %}

        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        <style>
            {# Local Brand Fonts: Quedora (Headings) & Plus Jakarta Sans (Body & UI) #}
            @font-face {
                font-family: 'Quedora';
                src: url("{{ 'fonts/quedora-regular.otf' | static_url }}") format('opentype');
                font-weight: 400;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Quedora';
                src: url("{{ 'fonts/quedora-medium.otf' | static_url }}") format('opentype');
                font-weight: 500;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Quedora';
                src: url("{{ 'fonts/quedora-semibold.otf' | static_url }}") format('opentype');
                font-weight: 600;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Quedora';
                src: url("{{ 'fonts/quedora-bold.otf' | static_url }}") format('opentype');
                font-weight: 700;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Quedora';
                src: url("{{ 'fonts/quedora-extrabold.otf' | static_url }}") format('opentype');
                font-weight: 800;
                font-style: normal;
                font-display: swap;
            }

            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-Medium.ttf' | static_url }}") format('truetype');
                font-weight: 400 500;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-Italic.ttf' | static_url }}") format('truetype');
                font-weight: 400 500;
                font-style: italic;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-SemiBold.ttf' | static_url }}") format('truetype');
                font-weight: 600;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-SemiBoldItalic.ttf' | static_url }}") format('truetype');
                font-weight: 600;
                font-style: italic;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-Bold.ttf' | static_url }}") format('truetype');
                font-weight: 700;
                font-style: normal;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-BoldItalic.ttf' | static_url }}") format('truetype');
                font-weight: 700;
                font-style: italic;
                font-display: swap;
            }
            @font-face {
                font-family: 'Plus Jakarta Sans';
                src: url("{{ 'fonts/PlusJakartaSans-ExtraBold.ttf' | static_url }}") format('truetype');
                font-weight: 800;
                font-style: normal;
                font-display: swap;
            }

            {# Font families #}

            {{ component(
                'fonts',{
                    font_weights: '400,700',
                    font_settings: 'settings.font_headings, settings.font_rest'
                })
            }}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}
        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Colors and fonts used from settings.txt and defined on theme customization #}

        {{ 'css/style-colors.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {% if load_jquery %}

            {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {% endif %}

        {# Loads private Tiendanube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data-organization') }}
        {{ component('structured-data') }}

    </head>
    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

        {{ component('nubesdk-slot', { type: "before_main_content" }) }}

        {# Facebook comments on product page #}

        {% if template == 'product' %}

            {# Facebook comment box JS #}
            {% if settings.show_product_fb_comment_box %}
                {{ fb_js }}
            {% endif %}

            {# Pinterest share button JS #}
            {{ pin_js }}

        {% endif %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Header = Advertising + Nav + Logo + Search + Ajax Cart #}

        {% snipplet "header/header.tpl" %}

        {# Page content #}

        {% template_content %}

        {# Quickshop modal #}

        {% snipplet "grid/quick-shop.tpl" %}

        {# WhatsApp chat button #}

        {% if not settings.whatsapp_header_link %}
            {% snipplet "whatsapp-chat.tpl" %}
        {% endif %}

        {# Footer #}

        {% snipplet "footer/footer.tpl" %}

        {# Mobile Bottom App Bar #}

        {% snipplet "navigation/navigation-bottom-nav.tpl" %}

        {% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

            {# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}

            <span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
            <span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
            <span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
            <span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
        {% endif %}

        {#/*============================================================================
            #Javascript: Needed after HTML loads
        ==============================================================================*/#}

        {# Javascript used in the store #}

        <script type="text/javascript">

            {# Libraries that do NOT depend on other libraries, e.g: Jquery #}

            {% include "static/js/external-no-dependencies.js.tpl" %}

            {# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}

            LS.ready.then(function(){

                {# Libraries that requires Jquery to work #}

                {% include "static/js/external.js.tpl" %}

                {# Specific store JS functions: product variants, cart, shipping, etc #}

                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {# Google reCAPTCHA on register page #}

        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {# Google survey JS for Tiendanube Survey #}

        {{ component('google-survey') }}

        {# Store external codes added from admin #}

        {% if store.assorted_js %}
            <script>
                LS.ready.then(function() {
                    var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                    jQueryNuvem('body').append(trackingCode);
                });
            </script>
        {% endif %}
    </body>
</html>
