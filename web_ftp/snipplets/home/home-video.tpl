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
		{# Ambient Video Bleed (Right >50% of screen with leftward feather fade) #}
		<div class="video-ambient-bleed" id="videoAmbientWrapper">
			<div class="video-ambient-overlay"></div>
			<video id="showcaseVideo" poster="{{ 'videos/poster_v2.jpg' | static_url }}" autoplay muted loop playsinline preload="auto">
				<source src="{{ 'videos/hmc_mantenimientos_v2.mp4' | static_url }}" type="video/mp4">
				<source src="{{ 'videos/hmc_mantenimientos_v2.webm' | static_url }}" type="video/webm">
				{{ 'Tu navegador no soporta video HTML5.' | translate }}
			</video>
			<button class="video-play-btn" id="videoPlayBtn" title="{{ 'Reproducir / Pausar video' | translate }}" aria-label="{{ 'Reproducir o pausar video' | translate }}">
				<i class="fa-solid fa-play"></i>
			</button>
		</div>

		{# Text Content Container (Left side floating over seamless dark background) #}
		<div class="container video-bleed-container">
			<div class="video-info-bleed">
				<h2 class="video-title">{{ settings.video_title | default('Taller Propio y Mantenimiento de Maquinaria' | translate) }}</h2>
				<div class="video-actions">
					<a href="{{ whatsapp_url }}" target="_blank" rel="noopener noreferrer" class="btn btn-primary btn-lg">
						<i class="fa-brands fa-whatsapp"></i> {{ 'Consultar al Taller' | translate }}
					</a>
				</div>
			</div>
		</div>
	</section>

	<script>
	(function() {
		function initHmcVideoBleed() {
			var video = document.getElementById('showcaseVideo');
			var playBtn = document.getElementById('videoPlayBtn');
			var wrapper = document.getElementById('videoAmbientWrapper');
			if (!video) return;

			function updateButton() {
				if (!playBtn) return;
				if (video.paused) {
					playBtn.classList.remove('playing');
					playBtn.innerHTML = '<i class="fa-solid fa-play"></i>';
				} else {
					playBtn.classList.add('playing');
					playBtn.innerHTML = '<i class="fa-solid fa-pause"></i>';
				}
			}

			function togglePlay(e) {
				if (e) {
					e.preventDefault();
					e.stopPropagation();
				}
				if (video.paused) {
					var p = video.play();
					if (p && p.catch) {
						p.catch(function() {});
					}
				} else {
					video.pause();
				}
				updateButton();
			}

			if (playBtn) {
				playBtn.addEventListener('click', togglePlay);
			}

			if (wrapper) {
				wrapper.addEventListener('click', function(e) {
					if (e.target !== playBtn && (!playBtn || !playBtn.contains(e.target))) {
						togglePlay(e);
					}
				});
			}

			video.addEventListener('play', updateButton);
			video.addEventListener('playing', updateButton);
			video.addEventListener('pause', updateButton);
			video.addEventListener('timeupdate', function() {
				if (!video.paused && playBtn && !playBtn.classList.contains('playing')) {
					updateButton();
				}
			});

			// Sincronización tras el arranque de autoplay
			setTimeout(updateButton, 200);
			setTimeout(updateButton, 800);
			setTimeout(updateButton, 2000);
		}

		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', initHmcVideoBleed);
		} else {
			initHmcVideoBleed();
		}
	})();
	</script>
{% endif %}
