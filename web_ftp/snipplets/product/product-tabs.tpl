<div class="product-tabs-wrapper">
    <div class="product-tabs-header">
        <button type="button" class="product-tab-btn active js-product-tab-btn" data-tab="tabDesc">
            {{ "Descripción y Aplicaciones" | translate }}
        </button>
        <button type="button" class="product-tab-btn js-product-tab-btn" data-tab="tabWarranty">
            {{ "Garantía y Respaldo Oficial" | translate }}
        </button>
        <button type="button" class="product-tab-btn js-product-tab-btn d-none" data-tab="tabReviews" id="tabReviewsBtn">
            {{ "Opiniones de Clientes" | translate }}
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

        <!-- Tab 3: Reviews & Trust (Only shown if reviews app is active) -->
        <div class="product-tab-panel js-product-tab-panel d-none" id="tabReviews">
            <div id="reviewsapp"></div>
        </div>
    </div>
</div>

<script>
(function() {
    function initProductTabsReviewsCheck() {
        var reviewsApp = document.getElementById('reviewsapp');
        var reviewsBtn = document.getElementById('tabReviewsBtn');
        var reviewsPanel = document.getElementById('tabReviews');

        if (reviewsApp && reviewsBtn && reviewsPanel) {
            function checkReviewsApp() {
                var hasContent = reviewsApp.children.length > 0 || (reviewsApp.textContent && reviewsApp.textContent.trim().length > 0);
                if (hasContent) {
                    reviewsBtn.classList.remove('d-none');
                    reviewsPanel.classList.remove('d-none');
                }
            }
            checkReviewsApp();
            try {
                var observer = new MutationObserver(checkReviewsApp);
                observer.observe(reviewsApp, { childList: true, subtree: true });
            } catch(e) {}
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initProductTabsReviewsCheck);
    } else {
        initProductTabsReviewsCheck();
    }
})();
</script>
