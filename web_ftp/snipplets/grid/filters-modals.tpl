<section class="js-category-controls category-controls visible-when-content-ready d-md-none background-secondary">
	<div class="container category-controls-container">
		<div class="category-controls-row row">
			{% if products %}
				<div class="col category-control-item">
					<a href="#" class="js-modal-open d-block text-uppercase font-weight-bold font-small" data-toggle="#sort-by">
						<div class="d-flex justify-content-center align-items-center">
							{% include "snipplets/svg/sort.tpl" with { svg_custom_class: "icon-inline mr-2"} %}
							{{ 'Ordenar' | t }}
						</div>
					</a>
				</div>
			{% endif %}
			{% if has_filters_available %}
				<div class="visible-when-content-ready col category-control-item">
					<a href="#" class="js-modal-open js-fullscreen-modal-open d-block text-uppercase font-weight-bold font-small" data-toggle="#nav-filters" data-modal-url="modal-fullscreen-filters" data-component="filter-button">
						<div class="d-flex justify-content-center align-items-center">
							{% include "snipplets/svg/filter.tpl" with { svg_custom_class: "icon-inline mr-2"} %}
							{{ 'Filtrar' | t }}
						</div>
					</a>
				</div>
			{% endif %}
		</div>
	</div>
</section>

{# Global Modals (rendered outside d-md-none container so both desktop toolbar and mobile bar can trigger them) #}
{% if products %}
	{% embed "snipplets/modal.tpl" with {modal_id: 'sort-by', modal_class: 'bottom modal-centered modal-bottom-sheet modal-right-md', modal_position: 'bottom', modal_position_desktop: 'right', modal_width: 'docked-md', modal_transition: 'slide', modal_header_title: true} %}
		{% block modal_head %}
			{{'Ordenar' | translate }}
		{% endblock %}
		{% block modal_body %}
			{{ component(
				'sort-by',{
					list: true,
					list_title: false,
					svg_sprites: false,
					sort_by_classes: {
						list: "list-unstyled",
						radio_button: "radio-button radio-button-item",
						radio_button_content: "radio-button-content",
						radio_button_icons_container: "radio-button-icons-container",
						radio_button_icons: "radio-button-icons",
						radio_button_icon: "radio-button-icon",
						radio_button_label: "radio-button-label pt-0",
						applying_feedback_message: 'h5 mr-2',
					},
					applying_feedback_custom_icon: include("snipplets/svg/circle-notch.tpl",  {svg_custom_class: "icon-inline h5 icon-spin svg-icon-text"}),
				})
			}}
			<div class="js-sorting-overlay filters-overlay" style="display: none;">
				<div class="filters-updating-message">
					<span class="h5 mr-2">{{ 'Ordenando productos' | translate }}</span>
					<span>
						{% include "snipplets/svg/circle-notch.tpl" with {svg_custom_class: "icon-inline h5 icon-spin svg-icon-text"} %}
					</span>
				</div>
			</div>
		{% endblock %}
	{% endembed %}
{% endif %}

{% if has_filters_available %}
	{% embed "snipplets/modal.tpl" with {modal_id: 'nav-filters', modal_class: 'filters', modal_body_class: 'h-100 p-0', modal_position: 'right', modal_position_desktop: 'right', modal_transition: 'slide', modal_header_title: true, modal_width: 'docked-md', modal_mobile_full_screen: true, modal_url: 'modal-fullscreen-filters', modal_footer: true, modal_fixed_footer: true, modal_footer_class: 'filters-modal-footer'} %}
		{% block modal_head %}
			{{'Filtros ' | translate }}
		{% endblock %}
		{% block modal_body %}
			{% if has_filters_available %}
				{% set is_real_cat = category and category.id and category.handle not in ['productos', 'todos-los-productos'] and category.name | lower not in ['productos', 'todos los productos', 'todo el catalogo', 'catalogo'] %}
				{% if has_applied_filters or is_real_cat or template == 'search' %}
					<div class="px-3 pt-3 pb-2 border-bottom bg-light js-active-filters-modal-container {% if template == 'search' and not has_applied_filters %}d-none{% endif %}">
						{% include "snipplets/grid/filters.tpl" with {applied_filters: true} %}
					</div>
				{% endif %}
				<div class="filters-modal-content-wrapper">
					{% if template == 'search' %}
						{% include "snipplets/grid/categories-search.tpl" with {modal: true} %}
					{% elseif filter_categories is not empty or is_real_cat %}
						{% include "snipplets/grid/categories.tpl" with {modal: true} %}
					{% endif %}
					{% if product_filters is not empty %}
						{% include "snipplets/grid/filters.tpl" with {modal: true} %}
					{% endif %}
				</div>
				<div class="js-filters-overlay filters-overlay" style="display: none;">
					<div class="filters-updating-message">
						<span class="js-applying-filter h5 mr-2" style="display: none;">{{ 'Aplicando filtro' | translate }}</span>
						<span class="js-removing-filter h5 mr-2" style="display: none;">{{ 'Borrando filtro' | translate }}</span>
						<span class="js-filtering-spinner" style="display: none;">
							{% include "snipplets/svg/circle-notch.tpl" with {svg_custom_class: "icon-inline h5 icon-spin svg-icon-text"} %}
						</span>
					</div>
				</div>
			{% endif %}
		{% endblock %}
		{% block modal_foot %}
			<div class="filters-modal-actions d-flex align-items-center justify-content-between w-100">
				<button type="button" class="btn btn-outline-secondary js-modal-clear-filters font-weight-bold" style="min-width: 90px; height: 46px; border-radius: 8px;">
					{{ 'Limpiar' | translate }}
				</button>
				<button type="button" class="btn btn-primary js-modal-apply-filters font-weight-bold flex-grow-1 ml-2" style="height: 46px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 1rem;">
					<span class="js-apply-filters-text">{{ 'Aplicar filtros' | translate }}</span>
					<span class="js-modal-filter-count badge badge-light text-primary ml-2 font-weight-bold" style="display: none; border-radius: 12px; padding: 3px 8px;">0</span>
				</button>
			</div>
		{% endblock %}
	{% endembed %}
{% endif %}