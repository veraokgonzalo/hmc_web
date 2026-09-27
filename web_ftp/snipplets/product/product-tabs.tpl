<div class="product-tabs-wrapper">
    <div class="product-tabs-header">
        <button type="button" class="product-tab-btn active js-product-tab-btn" data-tab="tabDesc">
            <i class="fa-solid fa-circle-info"></i> {{ "Descripción & Aplicaciones" | translate }}
        </button>
        <button type="button" class="product-tab-btn js-product-tab-btn" data-tab="tabWarranty">
            <i class="fa-solid fa-award"></i> {{ "Garantía & Respaldo Oficial" | translate }}
        </button>
        <button type="button" class="product-tab-btn js-product-tab-btn" data-tab="tabReviews">
            <i class="fa-solid fa-star"></i> {{ "Opiniones de Clientes" | translate }}
        </button>
    </div>

    <div class="product-tab-content">
        <!-- Tab 1: Description & Technical Context -->
        <div class="product-tab-panel active js-product-tab-panel" id="tabDesc">
            {% if product.description is not empty %}
                <div class="user-content font-small mb-4 product-user-description">
                    {{ product.description }}
                </div>
            {% else %}
                <p class="font-small text-muted mb-4">{{ "Consultá las especificaciones y aplicaciones con nuestro equipo técnico oficial." | translate }}</p>
            {% endif %}

            <div class="product-maintenance-callout p-3 rounded mb-3">
                <h6 class="font-weight-bold mb-2 text-primary">
                    <i class="fa-solid fa-lightbulb"></i> {{ "Consejo de mantenimiento HMC:" | translate }}
                </h6>
                <p class="font-small mb-0 text-muted">
                    {{ "Revisá periódicamente los niveles de fluidos, filtros y utilizá consumibles y repuestos legítimos homologados para extender la vida útil del equipo y mantener la cobertura total de la garantía oficial." | translate }}
                </p>
            </div>

            {{ component('nubesdk-slot', { type: "after_product_description" }) }}

            {% if settings.show_product_fb_comment_box %}
                <div class="fb-comments section-fb-comments mb-3" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
            {% endif %}

            <div class="mt-4 pt-3 border-top">
                {% include 'snipplets/social/social-share.tpl' %}
            </div>
        </div>

        <!-- Tab 2: Warranty & Support -->
        <div class="product-tab-panel js-product-tab-panel" id="tabWarranty">
            <h5 class="font-weight-bold mb-3">{{ "Respaldo Directo y Servicio Postventa HMC Hub" | translate }}</h5>
            <p class="font-small text-muted mb-3">
                {{ "En HMC HUB no competimos por precio, competimos por" | translate }} <strong>{{ "respaldo técnico, trayectoria y asesoramiento especializado" | translate }}</strong>. {{ "Cada máquina y equipo cuenta con verificación previa y soporte directo para su correcta puesta en marcha." | translate }}
            </p>
            <ul class="list-unstyled font-small text-muted d-flex flex-column gap-2 mb-0">
                <li class="mb-2"><i class="fa-solid fa-check text-primary mr-2"></i> <strong>{{ "Red de talleres homologados:" | translate }}</strong> {{ "atención inmediata para mantenimiento preventivo y correctivo." | translate }}</li>
                <li class="mb-2"><i class="fa-solid fa-check text-primary mr-2"></i> <strong>{{ "Repuestos 100% legítimos:" | translate }}</strong> {{ "disponibilidad permanente de filtros, bujías, cuchillas y piezas oficiales." | translate }}</li>
                <li><i class="fa-solid fa-check text-primary mr-2"></i> <strong>{{ "Atención corporativa B2B:" | translate }}</strong> {{ "presupuestos en el acto, cuentas corrientes y Factura A para empresas y contratistas." | translate }}</li>
            </ul>
        </div>

        <!-- Tab 3: Reviews & Trust -->
        <div class="product-tab-panel js-product-tab-panel" id="tabReviews">
            <div id="reviewsapp"></div>
            <div class="product-verified-reviews-box p-3 rounded bg-light mb-3">
                <div class="d-flex align-items-center gap-3 mb-3 pb-3 border-bottom">
                    <div class="text-center pr-3 border-right">
                        <div class="h1 font-weight-bold mb-0 text-dark">5.0</div>
                        <div class="text-warning font-small">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                        </div>
                        <span class="font-smallest opacity-60">{{ "Opiniones verificadas" | translate }}</span>
                    </div>
                    <div class="pl-2">
                        <p class="font-small text-muted mb-0">
                            {{ "Respaldado por la satisfacción de nuestros clientes en obra, campo y talleres de todo el país." | translate }}
                        </p>
                    </div>
                </div>
                <div class="d-flex flex-column gap-2">
                    <div class="p-3 bg-white rounded border mb-2">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong class="font-small">Ing. Marcelo R. (Contratista)</strong>
                            <div class="text-warning font-smallest">
                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                            </div>
                        </div>
                        <p class="font-smallest text-muted mb-0">"Excelente equipo y atención. La puesta en marcha y la orientación técnica nos ahorraron mucho tiempo."</p>
                    </div>
                    <div class="p-3 bg-white rounded border">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong class="font-small">Daniel G. (Mantenimiento Agropecuario)</strong>
                            <div class="text-warning font-smallest">
                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                            </div>
                        </div>
                        <p class="font-smallest text-muted mb-0">"Muy buen asesoramiento previo a la compra. El equipo respondió con potencia continua."</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
