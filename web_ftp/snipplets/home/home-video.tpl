{# /*============================================================================
  #Home Video Showcase (HMC HUB - Cinematic Ambient Bleed)
==============================================================================*/ #}

{% set whatsapp_number = store.whatsapp_number ? store.whatsapp_number : '5492954696231' %}
{% set whatsapp_text = 'Hola HMC Hub, quiero consultar por servicio técnico y mantenimiento' | url_encode %}
{% set whatsapp_url = 'https://wa.me/' ~ whatsapp_number ~ '?text=' ~ whatsapp_text %}

{% if settings.video_embed %}
	<section class="section-video-home position-relative" data-store="home-video">
		<div class="container py-4">
			{% if settings.video_title %}
				<div class="text-center mb-3">
					<h2 class="h3 font-weight-bold">{{ settings.video_title }}</h2>
				</div>
			{% endif %}
			<div class="embed-responsive embed-responsive-16by9">
				{% set video_url = settings.video_embed %}
				{% if '/watch?v=' in settings.video_embed %}
					{% set video_id = video_url | split('/watch?v=') | last | split('&') | first %}
					<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/{{ video_id }}" allowfullscreen loading="lazy"></iframe>
				{% elseif '/youtu.be/' in settings.video_embed %}
					{% set video_id = video_url | split('/youtu.be/') | last | split('?') | first %}
					<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/{{ video_id }}" allowfullscreen loading="lazy"></iframe>
				{% else %}
					<iframe class="embed-responsive-item" src="{{ video_url }}" allowfullscreen loading="lazy"></iframe>
				{% endif %}
			</div>
		</div>
	</section>
{% else %}
	<section class="video-section-bleed" id="video-showcase" data-store="home-video-showcase">
		{# Ambient Video Bleed #}
		<div class="video-ambient-bleed" id="videoAmbientWrapper">
			<div class="video-ambient-overlay"></div>
			<img src="{{ 'images/video-poster.jpg' | static_url }}" alt="HMC Taller y Mantenimiento" class="video-ambient-poster" id="showcaseVideoPoster" loading="lazy">
			<button class="video-play-btn" id="videoPlayBtn" title="{{ 'Reproducir / Pausar video' | translate }}" aria-label="{{ 'Reproducir o pausar video' | translate }}">
				<i class="fa-solid fa-play"></i>
			</button>
		</div>

		{# Text Content Container #}
		<div class="container video-bleed-container">
			<div class="video-info-bleed">
				<div class="video-section-tag">
					<i class="fa-solid fa-screwdriver-wrench mr-1"></i> {{ 'Servicio Técnico Especializado' | translate }}
				</div>
				<h2 class="video-title">{{ settings.video_title | default('Taller Propio y Mantenimiento de Maquinaria' | translate) }}</h2>
				<p class="video-desc">
					{{ settings.video_text | default('Diagnóstico oficial, puesta en marcha garantizada y provisión de repuestos legítimos para todas las líneas de herramientas industriales y de jardín.' | translate) }}
				</p>
				<div class="video-actions">
					<a href="{{ whatsapp_url }}" target="_blank" rel="noopener noreferrer" class="btn btn-primary btn-lg">
						<i class="fa-brands fa-whatsapp mr-2"></i> {{ 'Consultar al Taller' | translate }}
					</a>
				</div>
			</div>
		</div>
	</section>

	<script>
	(function() {
		function initHmcVideoBleed() {
			var playBtn = document.getElementById('videoPlayBtn');
			var wrapper = document.getElementById('videoAmbientWrapper');
			if (!playBtn && !wrapper) return;

			var isPlaying = false;
			function toggleVideoState() {
				isPlaying = !isPlaying;
				if (playBtn) {
					if (isPlaying) {
						playBtn.classList.add('playing');
						playBtn.innerHTML = '<i class="fa-solid fa-pause"></i>';
					} else {
						playBtn.classList.remove('playing');
						playBtn.innerHTML = '<i class="fa-solid fa-play"></i>';
					}
				}
			}

			if (playBtn) {
				playBtn.addEventListener('click', function(e) {
					e.stopPropagation();
					toggleVideoState();
				});
			}
			if (wrapper) {
				wrapper.addEventListener('click', toggleVideoState);
			}
		}

		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', initHmcVideoBleed);
		} else {
			initHmcVideoBleed();
		}
	})();
	</script>
{% endif %}
