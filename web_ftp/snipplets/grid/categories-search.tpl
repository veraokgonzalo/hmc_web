{# /*============================================================================
  #Category Filters for Search Results (Desktop Sidebar & Mobile Modal)
==============================================================================*/ #}

{# 1. Extract root categories deduplicated by normalized name #}
{% set search_roots = [] %}
{% set search_root_names = [] %}

{% if products %}
    {% for prod in products %}
        {% if prod.category %}
            {% set r_cat = prod.category %}
            {% if r_cat.parent %}
                {% set r_cat = r_cat.parent %}
                {% if r_cat.parent %}
                    {% set r_cat = r_cat.parent %}
                {% endif %}
            {% endif %}

            {% set r_name = r_cat.name | lower | trim %}
            {% if r_name not in search_root_names %}
                {% set search_root_names = search_root_names | merge([r_name]) %}

                {% set r_count = 0 %}
                {% set r_ids = [] %}
                {% for p2 in products %}
                    {% if p2.category %}
                        {% set p2_root = p2.category %}
                        {% if p2_root.parent %}
                            {% set p2_root = p2_root.parent %}
                            {% if p2_root.parent %}
                                {% set p2_root = p2_root.parent %}
                            {% endif %}
                        {% endif %}
                        {% if (p2_root.name | lower | trim) == r_name %}
                            {% set r_count = r_count + 1 %}
                            {% if p2_root.id not in r_ids %}
                                {% set r_ids = r_ids | merge([p2_root.id]) %}
                            {% endif %}
                        {% endif %}
                    {% endif %}
                {% endfor %}

                {% set search_roots = search_roots | merge([{
                    'id': r_cat.id,
                    'ids': r_ids | join(','),
                    'name': r_cat.name,
                    'count': r_count
                }]) %}
            {% endif %}
        {% endif %}
    {% endfor %}
{% endif %}

{# 2. Extract subcategories deduplicated by normalized name #}
{% set search_subs = [] %}
{% set search_sub_names = [] %}

{% if products %}
    {% for prod in products %}
        {% if prod.category and prod.category.parent %}
            {% set s_cat = prod.category %}
            {% set s_root = s_cat %}
            {% if s_root.parent %}
                {% set s_root = s_root.parent %}
                {% if s_root.parent %}
                    {% set s_root = s_root.parent %}
                {% endif %}
            {% endif %}

            {% set s_name = s_cat.name | lower | trim %}
            {% set r_name = s_root.name | lower | trim %}

            {# Only add if name is not root and not already in search_sub_names #}
            {% if s_name != r_name and s_name not in search_root_names and s_name not in search_sub_names %}
                {% set search_sub_names = search_sub_names | merge([s_name]) %}

                {% set s_count = 0 %}
                {% set s_ids = [] %}
                {% for p2 in products %}
                    {% if p2.category %}
                        {% set p2_cat = p2.category %}
                        {% set p2_match = false %}
                        {% if (p2_cat.name | lower | trim) == s_name %}
                            {% set p2_match = true %}
                            {% if p2_cat.id not in s_ids %}
                                {% set s_ids = s_ids | merge([p2_cat.id]) %}
                            {% endif %}
                        {% endif %}
                        {% if p2_cat.parent and (p2_cat.parent.name | lower | trim) == s_name %}
                            {% set p2_match = true %}
                            {% if p2_cat.parent.id not in s_ids %}
                                {% set s_ids = s_ids | merge([p2_cat.parent.id]) %}
                            {% endif %}
                        {% endif %}
                        {% if p2_match %}
                            {% set s_count = s_count + 1 %}
                        {% endif %}
                    {% endif %}
                {% endfor %}

                {% set search_subs = search_subs | merge([{
                    'id': s_cat.id,
                    'ids': s_ids | join(','),
                    'name': s_cat.name,
                    'root_id': s_root.id,
                    'count': s_count
                }]) %}
            {% endif %}
        {% endif %}
    {% endfor %}
{% endif %}

{# Flatten into display list preserving hierarchical parent-child order without duplicates #}
{% set display_items = [] %}
{% for root in search_roots %}
    {% set display_items = display_items | merge([{
        'id': root.id,
        'ids': root.ids,
        'name': root.name,
        'count': root.count,
        'is_sub': false,
        'parent_name': null
    }]) %}
    {% for sub in search_subs %}
        {% if sub.root_id == root.id %}
            {% set display_items = display_items | merge([{
                'id': sub.id,
                'ids': sub.ids,
                'name': sub.name,
                'count': sub.count,
                'is_sub': true,
                'parent_name': root.name
            }]) %}
        {% endif %}
    {% endfor %}
{% endfor %}

{% for sub in search_subs %}
    {% set already_in = false %}
    {% for di in display_items %}
        {% if (di.name | lower | trim) == (sub.name | lower | trim) %}
            {% set already_in = true %}
        {% endif %}
    {% endfor %}
    {% if not already_in %}
        {% set display_items = display_items | merge([{
            'id': sub.id,
            'ids': sub.ids,
            'name': sub.name,
            'count': sub.count,
            'is_sub': true,
            'parent_name': null
        }]) %}
    {% endif %}
{% endfor %}

<div class="js-accordion-container js-filter-container js-category-search-filter-container {% if not modal %}card px-3 mb-3{% else %}filter-accordion px-3 pt-3 pb-2{% endif %}" data-store="filters-group" data-filter-type="category" {% if display_items is empty %}style="display: none;"{% endif %}>
    <div class="h6 font-big mb-0">
        <a href="#" class="js-accordion-toggle font-md-small text-uppercase row no-gutters align-items-center py-md-2" data-accordion-target="search-categories">
            <div class="col my-1 pr-3 d-flex align-items-center font-weight-bold">
                {{ 'Categorías' | translate }}
                <span class="js-filters-badge js-category-filters-badge filters-badge ml-2" style="display: none;">0</span>
            </div>
            <div class="col-auto my-1">
                <span class="js-accordion-toggle-inactive" style="display: none;">
                  {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline svg-icon-text icon-lg font-big font-md-body mr-1"} %}
                </span>
                <span class="js-accordion-toggle-active">
                  {% include "snipplets/svg/chevron-down.tpl" with {svg_custom_class: "icon-inline svg-icon-text icon-lg font-big font-md-body"} %}
                </span>
            </div>
        </a>
    </div>
    <div class="js-accordion-content js-category-search-list mt-md-1 my-3"> 
        {% for item in display_items %}
            <label class="js-category-filter-checkbox js-filter-checkbox checkbox-container mb-2 {% if item.is_sub %}pl-3{% endif %}" data-category-name="{{ item.name | lower }}" data-category-id="{{ item.id }}" data-category-ids="{{ item.ids }}" {% if item.parent_name %}data-parent-name="{{ item.parent_name | lower }}"{% endif %}>
                <input type="checkbox" autocomplete="off" class="js-category-checkbox-input" value="{{ item.name | lower }}" data-category-id="{{ item.id }}" data-category-ids="{{ item.ids }}" />
                <span class="checkbox">
                    <span class="checkbox-icon"></span>
                    <span class="checkbox-text {% if not item.is_sub %}font-weight-bold{% else %}font-small text-muted{% endif %}">
                        {{ item.name | capitalize }} <span class="filter-badge ml-1">({{ item.count }})</span>
                    </span>
                </span>
            </label>
            {% if loop.index == 8 and display_items | length > 8 %}
                <div class="js-accordion-container">
                    <div class="js-accordion-content" style="display: none;">
            {% endif %}
            {% if loop.last and display_items | length > 8 %}
                    </div>
                    <a href="#" class="js-accordion-toggle d-inline-block btn-link font-small mt-1">
                        <span class="js-accordion-toggle-inactive">{{ 'Ver todos' | translate }}</span>
                        <span class="js-accordion-toggle-active" style="display: none;">{{ 'Ver menos' | translate }}</span>
                    </a>
                </div>
            {% endif %}
        {% endfor %}
    </div>
</div>

{% if not modal %}
<script>
(function() {
    if (window.__categorySearchFilterInitialized) return;
    window.__categorySearchFilterInitialized = true;

    function norm(str) {
        if (!str) return '';
        return str.toString().toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').trim();
    }

    function initCategorySearchFilters() {
        function getChecked() {
            var checked = [];
            document.querySelectorAll('.js-category-search-filter-container .js-category-checkbox-input:checked').forEach(function(input) {
                var val = norm(input.value);
                var id = (input.dataset.categoryId || input.closest('.js-category-filter-checkbox')?.dataset.categoryId || '').trim();
                var label = input.closest('.js-category-filter-checkbox');
                var textEl = label ? label.querySelector('.checkbox-text') : null;
                var displayName = textEl ? textEl.innerText.replace(/\(\d+\)/g, '').trim() : (val.charAt(0).toUpperCase() + val.slice(1));
                if (val || id) {
                    var exists = checked.some(function(c) {
                        return (val && c.val === val) || (id && c.id === id);
                    });
                    if (!exists) {
                        checked.push({ val: val, id: id, displayName: displayName });
                    }
                }
            });
            return checked;
        }

        function updateActiveChips(checked) {
            var chipsContainer = document.querySelector('.js-search-active-category-chips');
            var activeContainer = document.querySelector('.js-active-filters-container, .js-active-filters-modal-container');
            var removeAllBtn = document.querySelector('.js-remove-all-filters');

            if (chipsContainer) chipsContainer.innerHTML = '';
            if (checked.length === 0) {
                var hasBrandFilters = !!document.querySelector('.active-filter-chips .js-remove-filter:not(.js-remove-category-chip)');
                if (!hasBrandFilters && activeContainer) activeContainer.classList.add('d-none');
                if (!hasBrandFilters && removeAllBtn) removeAllBtn.classList.add('d-none');
                return;
            }

            if (activeContainer) activeContainer.classList.remove('d-none');
            if (removeAllBtn) removeAllBtn.classList.remove('d-none');

            if (chipsContainer) {
                checked.forEach(function(cat) {
                    var btn = document.createElement('button');
                    btn.type = 'button';
                    btn.className = 'js-remove-category-chip chip filter-chip mr-2 mb-2';
                    btn.dataset.categoryValue = cat.val;
                    btn.dataset.categoryId = cat.id;
                    btn.title = 'Eliminar filtro';
                    btn.innerHTML = '<span>Categoría: <strong>' + cat.displayName + '</strong></span><i class="fa-solid fa-xmark ml-2 chip-remove-icon"></i>';
                    chipsContainer.appendChild(btn);
                });
            }
        }

        function updateBadges(count) {
            document.querySelectorAll('.js-category-filters-badge').forEach(function(badge) {
                if (count > 0) {
                    badge.textContent = count;
                    badge.style.display = '';
                } else {
                    badge.style.display = 'none';
                }
            });
        }

        function updateUrl(checked) {
            try {
                var url = new URL(window.location.href);
                if (checked.length > 0) {
                    url.searchParams.set('categoria', checked.map(function(c) { return c.val; }).join(','));
                } else {
                    url.searchParams.delete('categoria');
                    url.searchParams.delete('cat');
                }
                url.searchParams.delete('page');
                window.history.replaceState({}, '', url.pathname + url.search);
            } catch(e) {}
        }

        function applyFilters() {
            var checked = getChecked();
            var items = document.querySelectorAll('.js-product-table .js-item-product');
            var visibleCount = 0;

            if (checked.length === 0) {
                items.forEach(function(item) {
                    item.classList.remove('d-none');
                    item.style.display = '';
                    visibleCount++;
                });
            } else {
                items.forEach(function(item) {
                    var itemCats = norm(item.dataset.categoryNames || '');
                    var itemIds = (item.dataset.categoryIds || '').split(',').map(function(s) { return s.trim(); });
                    var matches = checked.some(function(c) {
                        var nameMatch = c.val && itemCats.indexOf(c.val) !== -1;
                        var idMatch = c.id && itemIds.indexOf(c.id) !== -1;
                        return nameMatch || idMatch;
                    });
                    if (matches) {
                        item.classList.remove('d-none');
                        item.style.display = '';
                        visibleCount++;
                    } else {
                        item.classList.add('d-none');
                        item.style.display = 'none';
                    }
                });
            }

            var counter = document.querySelector('.catalog-results-count strong');
            if (counter) counter.textContent = visibleCount;

            var emptyMsg = document.querySelector('.js-search-no-category-results');
            if (visibleCount === 0 && checked.length > 0) {
                if (!emptyMsg) {
                    var div = document.createElement('div');
                    div.className = 'js-search-no-category-results col-12 text-center py-5 my-4';
                    div.innerHTML = '<div class="mb-3 text-muted"><i class="fa-solid fa-filter-circle-xmark fa-3x"></i></div>' +
                        '<h3 class="h5 font-weight-bold mb-2">No encontramos productos para la categoría seleccionada</h3>' +
                        '<p class="text-muted font-small mb-3">Probá seleccionando otra categoría o borrando los filtros activos.</p>' +
                        '<button type="button" class="btn btn-outline-primary btn-sm js-clear-category-filters"><i class="fa-solid fa-rotate-left mr-1"></i> Restablecer categorías</button>';
                    document.querySelector('.js-product-table')?.appendChild(div);
                } else {
                    emptyMsg.style.display = '';
                }
            } else if (emptyMsg) {
                emptyMsg.style.display = 'none';
            }

            updateBadges(checked.length);
            updateActiveChips(checked);
            updateUrl(checked);
        }

        // Global delegated click listeners
        document.addEventListener('click', function(e) {
            var label = e.target.closest('.js-category-filter-checkbox');
            if (label) {
                e.preventDefault();
                e.stopPropagation();

                var input = label.querySelector('.js-category-checkbox-input');
                if (!input) return;

                var isNowChecked = !input.checked;
                var val = norm(input.value);
                var catId = (input.dataset.categoryId || label.dataset.categoryId || '').trim();

                document.querySelectorAll('.js-category-checkbox-input').forEach(function(cb) {
                    var cbVal = norm(cb.value);
                    var cbId = (cb.dataset.categoryId || cb.closest('.js-category-filter-checkbox')?.dataset.categoryId || '').trim();
                    if ((val && cbVal === val) || (catId && cbId === catId)) {
                        cb.checked = isNowChecked;
                        cb.closest('.js-category-filter-checkbox')?.classList.toggle('active', isNowChecked);
                    }
                });

                applyFilters();
                return;
            }

            var chip = e.target.closest('.js-remove-category-chip');
            if (chip) {
                e.preventDefault();
                var chipVal = norm(chip.dataset.categoryValue);
                var chipId = (chip.dataset.categoryId || '').trim();

                document.querySelectorAll('.js-category-checkbox-input').forEach(function(cb) {
                    var cbVal = norm(cb.value);
                    var cbId = (cb.dataset.categoryId || cb.closest('.js-category-filter-checkbox')?.dataset.categoryId || '').trim();
                    if ((chipVal && cbVal === chipVal) || (chipId && cbId === chipId)) {
                        cb.checked = false;
                        cb.closest('.js-category-filter-checkbox')?.classList.remove('active');
                    }
                });

                applyFilters();
                return;
            }

            var clearBtn = e.target.closest('.js-clear-category-filters, .js-remove-all-filters');
            if (clearBtn) {
                document.querySelectorAll('.js-category-checkbox-input').forEach(function(cb) {
                    cb.checked = false;
                    cb.closest('.js-category-filter-checkbox')?.classList.remove('active');
                });
                applyFilters();
            }
        });

        // Restore from URL on initial load
        try {
            var urlParams = new URLSearchParams(window.location.search);
            var urlCat = urlParams.get('categoria') || urlParams.get('cat');
            if (urlCat) {
                var catsToSelect = urlCat.split(',').map(function(c) { return norm(c); });
                var found = false;
                catsToSelect.forEach(function(catName) {
                    document.querySelectorAll('.js-category-checkbox-input').forEach(function(cb) {
                        if (norm(cb.value) === catName) {
                            cb.checked = true;
                            cb.closest('.js-category-filter-checkbox')?.classList.add('active');
                            found = true;
                        }
                    });
                });
                if (found) {
                    applyFilters();
                }
            }
        } catch(e) {}
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initCategorySearchFilters);
    } else {
        initCategorySearchFilters();
    }
})();
</script>
{% endif %}
