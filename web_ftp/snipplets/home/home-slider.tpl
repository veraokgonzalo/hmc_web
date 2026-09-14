{% set has_custom_slider = settings.slider and settings.slider is not empty %}

{% if has_custom_slider %}
    {% set slider_items = settings.slider %}
{% else %}
    {% set default_slides = [
        {
            'title': 'Hacé tu compra <span>online</span>',
            'image': 'images/hero/hero-slide-2-respaldo-generadores.jpg',
            'alt': 'Respaldo técnico HMC Hub',
            'button': 'Accedé a la tienda',
            'link': (store.products_url ? store.products_url : '/productos'),
            'icon': 'fa-solid fa-cart-shopping',
            'target_blank': false
        },
        {
            'title': 'Potencia y Rendimiento Para <span>Tu Trabajo</span>',
            'image': 'images/hero/hero-slide-1-ofertas-motosierras.jpg',
            'alt': 'Ofertas de temporada HMC Hub',
            'button': 'Ofertas',
            'link': (store.products_url ? (store.products_url ~ '?offers=true') : '/productos?offers=true'),
            'icon': 'fa-solid fa-tag',
            'target_blank': false
        },
        {
            'title': 'Servicio Técnico Oficial <span>y Repuestos Originales</span>',
            'image': 'images/hero/hero-slide-3-servicio-tecnico-taller.jpg',
            'alt': 'Servicio Técnico Oficial HMC Hub',
            'button': 'Solicitar Asistencia',
            'link': (store.whatsapp ? ('https://wa.me/' ~ store.whatsapp) : 'https://wa.me/5492954696231'),
            'icon': 'fa-solid fa-phone',
            'target_blank': true
        }
    ] %}
    {% set slider_items = default_slides %}
{% endif %}

<section class="hero-slider-section" data-store="home-slider">
    <div class="hero-slider-wrapper">
        {% for slide in slider_items %}
            {% set is_active = loop.first %}
            <div class="hero-slide{% if is_active %} active{% endif %}" data-slide-index="{{ loop.index0 }}">
                {% if has_custom_slider %}
                    <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('1080p') }}" alt="{{ slide.title ? (slide.title | striptags) : ('Slide ' ~ loop.index) }}" class="hero-slide-bg lazyload">
                {% else %}
                    <img src="{{ slide.image | static_url }}" alt="{{ slide.alt }}" class="hero-slide-bg" {% if loop.first %}fetchpriority="high"{% else %}loading="lazy"{% endif %}>
                {% endif %}
                <div class="hero-slide-overlay"></div>
                <div class="container">
                    <div class="hero-content">
                        {% if slide.title %}
                            <h1 class="hero-title">{{ slide.title | raw }}</h1>
                        {% endif %}
                        {% if slide.description %}
                            <p class="hero-description">{{ slide.description }}</p>
                        {% endif %}
                        {% if slide.button and slide.link %}
                            <div class="hero-buttons">
                                <a href="{{ has_custom_slider ? (slide.link | setting_url) : slide.link }}" class="btn btn-primary btn-lg" {% if slide.target_blank %}target="_blank" rel="noopener noreferrer"{% endif %}>
                                    {% if slide.icon %}
                                        <i class="{{ slide.icon }}"></i>
                                    {% endif %}
                                    {{ slide.button }}
                                </a>
                            </div>
                        {% endif %}
                    </div>
                </div>
            </div>
        {% endfor %}
    </div>

    {% if slider_items | length > 1 %}
        <!-- Slider Navigation Buttons -->
        <div class="hero-slider-nav">
            <button class="hero-slider-btn hero-prev-btn" title="Anterior" aria-label="Anterior"><i class="fa-solid fa-chevron-left"></i></button>
            <button class="hero-slider-btn hero-next-btn" title="Siguiente" aria-label="Siguiente"><i class="fa-solid fa-chevron-right"></i></button>
        </div>

        <!-- Slider Dots -->
        <div class="hero-slider-dots">
            {% for slide in slider_items %}
                <div class="hero-dot{% if loop.first %} active{% endif %}" data-dot-index="{{ loop.index0 }}" aria-label="Slide {{ loop.index }}"></div>
            {% endfor %}
        </div>
    {% endif %}
</section>

<script>
(function() {
    function initHmcHeroSlider() {
        var sliderEl = document.querySelector('.hero-slider-wrapper');
        var slides = document.querySelectorAll('.hero-slide');
        var dots = document.querySelectorAll('.hero-dot');
        var prevBtn = document.querySelector('.hero-prev-btn');
        var nextBtn = document.querySelector('.hero-next-btn');

        if (!slides.length || !sliderEl) return;

        var currentSlide = 0;
        var slideInterval = null;

        function showSlide(index) {
            for (var i = 0; i < slides.length; i++) {
                slides[i].classList.toggle('active', i === index);
            }
            for (var j = 0; j < dots.length; j++) {
                dots[j].classList.toggle('active', j === index);
            }
            currentSlide = index;
        }

        function nextSlide() {
            var next = (currentSlide + 1) % slides.length;
            showSlide(next);
        }

        function prevSlide() {
            var prev = (currentSlide - 1 + slides.length) % slides.length;
            showSlide(prev);
        }

        function startAutoplay() {
            stopAutoplay();
            slideInterval = setInterval(nextSlide, 8500);
        }

        function stopAutoplay() {
            if (slideInterval) clearInterval(slideInterval);
        }

        if (nextBtn) nextBtn.addEventListener('click', function() { nextSlide(); startAutoplay(); });
        if (prevBtn) prevBtn.addEventListener('click', function() { prevSlide(); startAutoplay(); });

        dots.forEach(function(dot, idx) {
            dot.addEventListener('click', function() {
                showSlide(idx);
                startAutoplay();
            });
        });

        var touchStartX = 0;
        var touchEndX = 0;
        sliderEl.addEventListener('touchstart', function(e) {
            touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });
        sliderEl.addEventListener('touchend', function(e) {
            touchEndX = e.changedTouches[0].screenX;
            if (touchStartX - touchEndX > 45) {
                nextSlide();
                startAutoplay();
            } else if (touchEndX - touchStartX > 45) {
                prevSlide();
                startAutoplay();
            }
        }, { passive: true });

        startAutoplay();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initHmcHeroSlider);
    } else {
        initHmcHeroSlider();
    }
})();
</script>