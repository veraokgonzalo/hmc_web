{% set has_custom_services = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_04_title or settings.banner_services_01_description or settings.banner_services_02_description) %}

<section class="value-props-section" data-store="banner-services">
    <div class="container">
        <div class="value-props-strip">
            {% if has_custom_services %}
                {% for banner in ['banner_services_01', 'banner_services_02', 'banner_services_03', 'banner_services_04'] %}
                    {% set banner_icon = attribute(settings, banner ~ '_icon') %}
                    {% set banner_title = attribute(settings, banner ~ '_title') %}
                    {% set banner_description = attribute(settings, banner ~ '_description') %}
                    {% set banner_url = attribute(settings, banner ~ '_url') %}
                    {% if banner_title or banner_description %}
                        {% if banner_url %}
                            <a href="{{ banner_url | setting_url }}" class="value-strip-item">
                        {% else %}
                            <div class="value-strip-item">
                        {% endif %}
                            {% if banner_icon == 'shipping' %}
                                <i class="fa-solid fa-truck-ramp-box"></i>
                            {% elseif banner_icon == 'card' or banner_icon == 'cash' %}
                                <i class="fa-solid fa-credit-card"></i>
                            {% elseif banner_icon == 'security' or banner_icon == 'returns' %}
                                <i class="fa-solid fa-shield-halved"></i>
                            {% elseif banner_icon == 'whatsapp' %}
                                <i class="fa-brands fa-whatsapp"></i>
                            {% else %}
                                <i class="fa-solid fa-headset"></i>
                            {% endif %}
                            <span>{{ banner_title ? banner_title : banner_description }}</span>
                        {% if banner_url %}
                            </a>
                        {% else %}
                            </div>
                        {% endif %}
                    {% endif %}
                {% endfor %}
            {% else %}
                <!-- Pilar 1: Garantía y Service Oficial -->
                <div class="value-strip-item">
                    <i class="fa-solid fa-shield-halved"></i>
                    <span>Garantía y Service Oficial</span>
                </div>

                <!-- Pilar 2: Envíos a Todo el País -->
                <div class="value-strip-item">
                    <i class="fa-solid fa-truck-ramp-box"></i>
                    <span>Envíos a Todo el País</span>
                </div>

                <!-- Pilar 3: Todos los Medios de Pago -->
                <div class="value-strip-item">
                    <i class="fa-solid fa-credit-card"></i>
                    <span>Todos los Medios de Pago</span>
                </div>

                <!-- Pilar 4: Asesoramiento Técnico (Diferencial Central) -->
                <div class="value-strip-item">
                    <i class="fa-solid fa-headset"></i>
                    <span>Asesoramiento Técnico</span>
                </div>
            {% endif %}
        </div>
    </div>
</section>