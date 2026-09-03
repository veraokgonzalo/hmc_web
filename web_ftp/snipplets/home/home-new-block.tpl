{# Nuevo Bloque Personalizado (Título y Par de Imágenes) #}

{% set new_block_has_img1 = "new_block_image_01.jpg" | has_custom_image %}
{% set new_block_has_img2 = "new_block_image_02.jpg" | has_custom_image %}

{% if settings.new_block and (settings.new_block_title or new_block_has_img1 or new_block_has_img2) %}
  {# Estilos específicos para el nuevo bloque, asegurando bordes limpios y hovers elegantes #}
  <style>
    .new-block-section {
      padding: 60px 0;
      background-color: {{ settings.background_color | default('#ffffff') }};
    }
    .new-block-title {
      text-align: center;
      margin-bottom: 40px;
      font-weight: 700;
      color: {{ settings.text_color | default('#222222') }};
    }
    .new-block-card {
      display: block;
      overflow: hidden;
      border-radius: 8px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      background-color: #ffffff;
    }
    .new-block-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    .new-block-img {
      width: 100%;
      height: auto;
      display: block;
      object-fit: cover;
      transition: opacity 0.3s ease;
    }
    @media (max-width: 767px) {
      .new-block-card {
        margin-bottom: 20px;
      }
    }
  </style>

  <section class="new-block-section" data-store="home-new-block">
    <div class="container">
      {% if settings.new_block_title %}
        <h2 class="new-block-title h3">{{ settings.new_block_title }}</h2>
      {% endif %}
      
      <div class="row align-items-stretch">
        {# Imagen 1 #}
        {% if new_block_has_img1 %}
          <div class="col-md-6 col-12">
            {% if settings.new_block_image_01_link %}
              <a href="{{ settings.new_block_image_01_link | setting_url }}" class="new-block-card">
            {% else %}
              <div class="new-block-card">
            {% endif %}
              <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'new_block_image_01.jpg' | static_url | settings_image_url('large') }}" class="lazyload new-block-img" alt="{{ settings.new_block_title | default('Imagen destacada 1') }}">
            {% if settings.new_block_image_01_link %}
              </a>
            {% else %}
              </div>
            {% endif %}
          </div>
        {% endif %}

        {# Imagen 2 #}
        {% if new_block_has_img2 %}
          <div class="col-md-6 col-12">
            {% if settings.new_block_image_02_link %}
              <a href="{{ settings.new_block_image_02_link | setting_url }}" class="new-block-card">
            {% else %}
              <div class="new-block-card">
            {% endif %}
              <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'new_block_image_02.jpg' | static_url | settings_image_url('large') }}" class="lazyload new-block-img" alt="{{ settings.new_block_title | default('Imagen destacada 2') }}">
            {% if settings.new_block_image_02_link %}
              </a>
            {% else %}
              </div>
            {% endif %}
          </div>
        {% endif %}
      </div>
    </div>
  </section>
{% endif %}
