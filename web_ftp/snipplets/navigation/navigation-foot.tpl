{# Footer navigation: same sections as the header navbar (replaces the admin-driven categories menu) #}
<ul class="list py-2 font-small">
	<li class="footer-menu-item"><a class="footer-menu-link" href="{{ store.home_url }}">{{ 'Inicio' | translate }}</a></li>
	<li class="footer-menu-item"><a class="footer-menu-link" href="{% if store.categories_url %}{{ store.categories_url }}{% else %}{{ store.products_url }}{% endif %}">{{ 'Categorías' | translate }}</a></li>
	<li class="footer-menu-item"><a class="footer-menu-link" href="{{ store.products_url }}?brand_filter=true">{{ 'Marcas' | translate }}</a></li>
	<li class="footer-menu-item"><a class="footer-menu-link" href="{{ store.products_url }}?offers=true">{{ 'Ofertas' | translate }}</a></li>
	<li class="footer-menu-item"><a class="footer-menu-link" href="{{ store.about_url | default('/nosotros') }}">{{ 'Nosotros' | translate }}</a></li>
	<li class="footer-menu-item"><a class="footer-menu-link" href="{{ store.contact_url }}">{{ 'Contacto' | translate }}</a></li>
	<li class="footer-menu-item mb-2"><a class="footer-menu-link" href="https://wa.me/5492954696231?text=Hola%20HMC%20Hub,%20necesito%20asesoramiento%20t%C3%A9cnico" target="_blank" rel="noopener noreferrer">{{ 'Asesoría Técnica' | translate }}</a></li>
</ul>
