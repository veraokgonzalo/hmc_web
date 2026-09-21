{% set whatsapp_link = store.whatsapp ? store.whatsapp : 'https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico' %}

<a href="{{ whatsapp_link }}" target="_blank" class="{% if header %}btn btn-utility{% else %}js-btn-fixed-bottom btn-whatsapp floating-whatsapp{% endif %}" aria-label="{{ 'Comunicate por WhatsApp' | translate }}">
    {% if header %}
        {% include "snipplets/svg/whatsapp-line.tpl" with {svg_custom_class: "icon-inline utilities-icon"} %}
    {% else %}
        <i class="fa-brands fa-whatsapp"></i>
    {% endif %}
</a>
