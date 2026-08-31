/**
 * HMC HUB - Master Interactive Application Logic
 * Prototype Architecture for Tiendanube Legacy & Nimbus Conversion
 */

document.addEventListener('DOMContentLoaded', () => {
  initHeroSlider();
  initCountdown();
  initCartSystem();
  initQuickViewModal();
  initCatalogTabs();
  initLiveSearch();
  initVideoPlayer();
  initNewsletter();
  initShippingCalculator();
  initPromoPopup();
  initMobileMenu();
});

/* --------------------------------------------------------------------------
   1. Data Store / Mock Database
   -------------------------------------------------------------------------- */
const PRODUCT_CATALOG = [
  {
    id: 1,
    name: "Motosierra Profesional 52cc Espada 20\" Motor 2T",
    category: "motosierras",
    categoryName: "Motosierras",
    brand: "STIHL",
    price: 349990,
    oldPrice: 419990,
    image: "assets/images/products/DSC00883.jpg",
    gallery: ["assets/images/products/DSC00883.jpg", "assets/images/products/DSC00885.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 16,
    tab: "bestsellers",
    desc: "Motosierra de alta potencia para trabajos forestales exigentes, tala y poda pesada. Cilindrada 52cc con sistema de arranque fácil y freno de cadena instantáneo.",
    specs: ["Cilindrada: 52 cc", "Espada: 20 pulgadas", "Capacidad de tanque: 550 ml", "Garantía: 12 meses"]
  },
  {
    id: 2,
    name: "Generador Eléctrico 6.5 KVA Monofásico Naftero",
    category: "generadores",
    categoryName: "Generadores",
    brand: "HONDA",
    price: 890500,
    oldPrice: 990000,
    image: "assets/images/products/DSC00887.jpg",
    gallery: ["assets/images/products/DSC00887.jpg", "assets/images/products/DSC00888.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 10,
    tab: "heavy",
    desc: "Grupo electrógeno robusto de 4 tiempos con regulación AVR de voltaje. Ideal para obras, respaldo comercial o campo.",
    specs: ["Potencia máxima: 6500W", "Arranque: Eléctrico y manual", "Autonomía: 10 hs al 50%", "Garantía: 24 meses"]
  },
  {
    id: 3,
    name: "Hidrolavadora Alta Presión 180 Bar Profesional",
    category: "hidrolavadoras",
    categoryName: "Hidrolavadoras",
    brand: "BOSCH",
    price: 289000,
    oldPrice: 345000,
    image: "assets/images/products/DSC00893.jpg",
    gallery: ["assets/images/products/DSC00893.jpg", "assets/images/products/DSC00895.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 16,
    tab: "bestsellers",
    desc: "Bomba de latón reforzada y motor a inducción de servicio continuo. Incluye lanza con boquilla turbo rotativa y depósito de detergente integrado.",
    specs: ["Presión: 180 Bar", "Caudal: 520 L/h", "Potencia: 2400W", "Manguera: 8 metros de acero mallada"]
  },
  {
    id: 4,
    name: "Desmalezadora Naftera 52cc 2T Profesional Eje Recto",
    category: "desmalezadoras",
    categoryName: "Desmalezadoras",
    brand: "HUSQVARNA",
    price: 310000,
    oldPrice: 365000,
    image: "assets/images/products/DSC00903.jpg",
    gallery: ["assets/images/products/DSC00903.jpg", "assets/images/products/DSC00904.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "new",
    desc: "Especialmente diseñada para desmalezado intenso de campos, parques y terrenos difíciles. Manillar ergonómico asimétrico y arnés profesional incluido.",
    specs: ["Motor: 52 cc 2T", "Cuchilla 3 puntas + carretel", "Peso: 7.8 kg", "Garantía: 12 meses"]
  },
  {
    id: 5,
    name: "Compresor de Aire 50L 2.5 HP Lubricado a Pistón",
    category: "ferreteria",
    categoryName: "Ferretería",
    brand: "GAMMA",
    price: 245000,
    oldPrice: 285000,
    image: "assets/images/products/DSC00909.jpg",
    gallery: ["assets/images/products/DSC00909.jpg", "assets/images/products/DSC00912.jpg"],
    inStock: true,
    freeShipping: false,
    discount: 14,
    tab: "heavy",
    desc: "Compresor de aire con tanque de 50 litros. Presostato electromecánico con válvula de seguridad y ruedas para fácil transporte en taller.",
    specs: ["Capacidad: 50 Litros", "Presión máx: 8 bar (115 PSI)", "Caudal de aire: 206 L/min", "Voltaje: 220V"]
  },
  {
    id: 6,
    name: "Cortadora de Césped Naftera 6 HP con Bolsa Recolectora",
    category: "jardineria",
    categoryName: "Jardinería",
    brand: "ECHO",
    price: 475000,
    oldPrice: 530000,
    image: "assets/images/products/DSC00915.jpg",
    gallery: ["assets/images/products/DSC00915.jpg", "assets/images/products/DSC00918.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 10,
    tab: "bestsellers",
    desc: "Chasis de acero estampado de 20 pulgadas con regulación de altura de 6 posiciones en una sola palanca.",
    specs: ["Motor: 4T OHV 6 HP", "Ancho de corte: 51 cm", "Capacidad bolsa: 60 Litros", "Descarga: Trasera y lateral"]
  },
  {
    id: 7,
    name: "Rotomartillo SDS Plus 1100W Maletín y Mechas",
    category: "ferreteria",
    categoryName: "Ferretería",
    brand: "DEWALT",
    price: 198000,
    oldPrice: 230000,
    image: "assets/images/products/DSC00923.jpg",
    gallery: ["assets/images/products/DSC00923.jpg", "assets/images/products/DSC00925.jpg"],
    inStock: true,
    freeShipping: false,
    discount: 13,
    tab: "new",
    desc: "3 modos: taladro, martillo y cincelado. Embrague de seguridad para proteger al usuario en caso de atasco de mecha.",
    specs: ["Potencia: 1100W", "Fuerza de impacto: 3.5 Joules", "Mandril: SDS Plus", "Incluye: 3 mechas + 2 cinceles"]
  },
  {
    id: 8,
    name: "Bomba Sumergible para Pozo Profundo 1.5 HP Acero Inox",
    category: "hidrolavadoras",
    categoryName: "Maquinaria",
    brand: "LUSQTOFF",
    price: 215000,
    oldPrice: 260000,
    image: "assets/images/products/DSC00928.jpg",
    gallery: ["assets/images/products/DSC00928.jpg", "assets/images/products/DSC00932.jpg"],
    inStock: true,
    freeShipping: true,
    discount: 17,
    tab: "heavy",
    desc: "Cuerpo íntegramente en acero inoxidable para extracción de agua en pozos de hasta 60 metros. Tablero de comando con protector térmico.",
    specs: ["Potencia: 1.5 HP", "Elevación máxima: 65 m", "Caudal máximo: 4500 L/h", "Diámetro: 4 pulgadas"]
  }
];

/* --------------------------------------------------------------------------
   2. Hero Slider Component
   -------------------------------------------------------------------------- */
function initHeroSlider() {
  const slides = document.querySelectorAll('.hero-slide');
  const dots = document.querySelectorAll('.hero-dot');
  const prevBtn = document.querySelector('.hero-prev-btn');
  const nextBtn = document.querySelector('.hero-next-btn');
  
  if (!slides.length) return;
  
  let currentSlide = 0;
  let slideInterval = null;
  
  function showSlide(index) {
    slides.forEach((s, i) => {
      s.classList.toggle('active', i === index);
    });
    dots.forEach((d, i) => {
      d.classList.toggle('active', i === index);
    });
    currentSlide = index;
  }
  
  function nextSlide() {
    let next = (currentSlide + 1) % slides.length;
    showSlide(next);
  }
  
  function prevSlide() {
    let prev = (currentSlide - 1 + slides.length) % slides.length;
    showSlide(prev);
  }
  
  function startAutoplay() {
    stopAutoplay();
    slideInterval = setInterval(nextSlide, 5500);
  }
  
  function stopAutoplay() {
    if (slideInterval) clearInterval(slideInterval);
  }
  
  if (nextBtn) {
    nextBtn.addEventListener('click', () => {
      nextSlide();
      startAutoplay();
    });
  }
  
  if (prevBtn) {
    prevBtn.addEventListener('click', () => {
      prevSlide();
      startAutoplay();
    });
  }
  
  dots.forEach((dot, idx) => {
    dot.addEventListener('click', () => {
      showSlide(idx);
      startAutoplay();
    });
  });
  
  // Pause on hover
  const sliderSection = document.querySelector('.hero-slider-section');
  if (sliderSection) {
    sliderSection.addEventListener('mouseenter', stopAutoplay);
    sliderSection.addEventListener('mouseleave', startAutoplay);
  }
  
  startAutoplay();
}

/* --------------------------------------------------------------------------
   3. Live Countdown Timer (spec §5)
   -------------------------------------------------------------------------- */
function initCountdown() {
  const daysEl = document.getElementById('cd-days');
  const hoursEl = document.getElementById('cd-hours');
  const minsEl = document.getElementById('cd-mins');
  const secsEl = document.getElementById('cd-secs');
  
  if (!daysEl) return;
  
  // Target: 4 days, 18 hours, 32 minutes from now
  const targetDate = new Date();
  targetDate.setDate(targetDate.getDate() + 4);
  targetDate.setHours(targetDate.getHours() + 18);
  targetDate.setMinutes(targetDate.getMinutes() + 32);
  
  function updateTimer() {
    const now = new Date().getTime();
    const diff = targetDate - now;
    
    if (diff <= 0) {
      daysEl.textContent = '00';
      hoursEl.textContent = '00';
      minsEl.textContent = '00';
      secsEl.textContent = '00';
      return;
    }
    
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const secs = Math.floor((diff % (1000 * 60)) / 1000);
    
    daysEl.textContent = String(days).padStart(2, '0');
    hoursEl.textContent = String(hours).padStart(2, '0');
    minsEl.textContent = String(mins).padStart(2, '0');
    secsEl.textContent = String(secs).padStart(2, '0');
  }
  
  updateTimer();
  setInterval(updateTimer, 1000);
}

/* --------------------------------------------------------------------------
   4. AJAX Cart Drawer System
   -------------------------------------------------------------------------- */
let cart = JSON.parse(localStorage.getItem('hmc_cart')) || [
  { id: 1, qty: 1 }
];

const FREE_SHIPPING_THRESHOLD = 300000; // $300.000 ARS

function initCartSystem() {
  const drawer = document.getElementById('cartDrawer');
  const overlay = document.getElementById('cartOverlay');
  const openButtons = document.querySelectorAll('.js-open-cart');
  const closeBtn = document.getElementById('cartCloseBtn');
  
  function openCart() {
    drawer.classList.add('active');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
    renderCart();
  }
  
  function closeCart() {
    drawer.classList.remove('active');
    overlay.classList.remove('active');
    document.body.style.overflow = '';
  }
  
  openButtons.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openCart();
  }));
  
  if (closeBtn) closeBtn.addEventListener('click', closeCart);
  if (overlay) overlay.addEventListener('click', closeCart);
  
  // Expose global methods
  window.hmcAddToCart = function(productId, quantity = 1) {
    const existing = cart.find(item => item.id === productId);
    if (existing) {
      existing.qty += quantity;
    } else {
      cart.push({ id: productId, qty: quantity });
    }
    saveCart();
    renderCart();
    const product = PRODUCT_CATALOG.find(p => p.id === productId);
    showToast(`¡"${product ? product.name.substring(0, 30) + '...' : 'Producto'}" añadido al carrito!`);
    openCart();
  };
  
  window.hmcUpdateQty = function(productId, delta) {
    const item = cart.find(i => i.id === productId);
    if (!item) return;
    item.qty += delta;
    if (item.qty <= 0) {
      cart = cart.filter(i => i.id !== productId);
    }
    saveCart();
    renderCart();
  };
  
  window.hmcRemoveItem = function(productId) {
    cart = cart.filter(i => i.id !== productId);
    saveCart();
    renderCart();
    showToast('Producto eliminado del carrito');
  };
  
  renderCart();
}

function saveCart() {
  localStorage.setItem('hmc_cart', JSON.stringify(cart));
  updateCartBadges();
}

function updateCartBadges() {
  const totalCount = cart.reduce((acc, item) => acc + item.qty, 0);
  document.querySelectorAll('.js-cart-count').forEach(el => {
    el.textContent = totalCount;
  });
}

function formatCurrency(amount) {
  return '$' + Number(amount).toLocaleString('es-AR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
}

function renderCart() {
  const container = document.getElementById('cartItemsContainer');
  const subtotalEl = document.getElementById('cartSubtotal');
  const totalEl = document.getElementById('cartTotalFinal');
  const fillBar = document.getElementById('shippingBarFill');
  const shipText = document.getElementById('shippingBarText');
  
  updateCartBadges();
  
  if (!container) return;
  
  if (cart.length === 0) {
    container.innerHTML = `
      <div class="cart-empty-state">
        <i class="fa-solid fa-cart-shopping"></i>
        <h4>Tu carrito está vacío</h4>
        <p>Explorá nuestro catálogo de maquinaria y herramientas con respaldo técnico.</p>
        <button class="btn btn-primary btn-sm" style="margin-top: 16px;" onclick="document.getElementById('cartCloseBtn').click()">Ver Productos</button>
      </div>
    `;
    if (subtotalEl) subtotalEl.textContent = '$0';
    if (totalEl) totalEl.textContent = '$0';
    if (fillBar) fillBar.style.width = '0%';
    if (shipText) shipText.innerHTML = `<span>Agregá <strong>${formatCurrency(FREE_SHIPPING_THRESHOLD)}</strong> para <strong>Envío Gratis</strong></span>`;
    return;
  }
  
  let subtotal = 0;
  let html = '';
  
  cart.forEach(item => {
    const prod = PRODUCT_CATALOG.find(p => p.id === item.id);
    if (!prod) return;
    const itemTotal = prod.price * item.qty;
    subtotal += itemTotal;
    
    html += `
      <div class="cart-item">
        <img src="${prod.image}" alt="${prod.name}" class="cart-item-img">
        <div class="cart-item-info">
          <h4 class="cart-item-title">${prod.name}</h4>
          <div class="cart-item-price">${formatCurrency(prod.price)}</div>
          <div class="cart-item-controls">
            <div class="qty-selector">
              <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, -1)">-</button>
              <span class="qty-val">${item.qty}</span>
              <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, 1)">+</button>
            </div>
            <button class="cart-item-remove" onclick="hmcRemoveItem(${prod.id})" title="Eliminar">
              <i class="fa-solid fa-trash-can"></i>
            </button>
          </div>
        </div>
      </div>
    `;
  });
  
  container.innerHTML = html;
  if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);
  if (totalEl) totalEl.textContent = formatCurrency(subtotal);
  
  // Calculate Free Shipping Progress
  if (fillBar && shipText) {
    const progress = Math.min(100, Math.round((subtotal / FREE_SHIPPING_THRESHOLD) * 100));
    fillBar.style.width = `${progress}%`;
    
    if (subtotal >= FREE_SHIPPING_THRESHOLD) {
      shipText.innerHTML = `<span>🎉 <strong>¡Felicitaciones! Tenés Envío Gratis</strong> en tu pedido</span>`;
    } else {
      const remaining = FREE_SHIPPING_THRESHOLD - subtotal;
      shipText.innerHTML = `<span>Te faltan <strong>${formatCurrency(remaining)}</strong> para <strong>Envío Gratis</strong></span>`;
    }
  }
}

/* --------------------------------------------------------------------------
   5. Quick View Modal Component
   -------------------------------------------------------------------------- */
function initQuickViewModal() {
  const modal = document.getElementById('quickViewModal');
  const overlay = modal;
  const closeBtn = document.getElementById('quickViewClose');
  
  if (!modal) return;
  
  window.hmcOpenQuickView = function(productId) {
    const prod = PRODUCT_CATALOG.find(p => p.id === productId);
    if (!prod) return;
    
    document.getElementById('qvBrand').textContent = prod.brand;
    document.getElementById('qvTitle').textContent = prod.name;
    document.getElementById('qvPrice').textContent = formatCurrency(prod.price);
    document.getElementById('qvOldPrice').textContent = formatCurrency(prod.oldPrice);
    document.getElementById('qvDiscount').textContent = `-${prod.discount}%`;
    document.getElementById('qvDesc').textContent = prod.desc;
    document.getElementById('qvImage').src = prod.image;
    
    const specsList = document.getElementById('qvSpecs');
    if (specsList) {
      specsList.innerHTML = prod.specs.map(s => `<li><i class="fa-solid fa-check text-primary"></i> ${s}</li>`).join('');
    }
    
    const addBtn = document.getElementById('qvAddToCartBtn');
    if (addBtn) {
      addBtn.onclick = function() {
        const qty = parseInt(document.getElementById('qvQtyInput').value) || 1;
        hmcAddToCart(prod.id, qty);
        modal.classList.remove('active');
      };
    }
    
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
  };
  
  function closeModal() {
    modal.classList.remove('active');
    document.body.style.overflow = '';
  }
  
  if (closeBtn) closeBtn.addEventListener('click', closeModal);
  if (overlay) {
    overlay.addEventListener('click', (e) => {
      if (e.target === overlay) closeModal();
    });
  }
}

/* --------------------------------------------------------------------------
   6. Catalog Tabs Filtering
   -------------------------------------------------------------------------- */
function initCatalogTabs() {
  const tabs = document.querySelectorAll('.catalog-tab');
  const container = document.getElementById('featuredProductsGrid');
  
  if (!tabs.length || !container) return;
  
  function renderProducts(filter = 'all') {
    let filtered = PRODUCT_CATALOG;
    if (filter !== 'all') {
      filtered = PRODUCT_CATALOG.filter(p => p.tab === filter);
    }
    
    container.innerHTML = filtered.map(prod => `
      <div class="product-card" data-category="${prod.category}">
        <div class="product-badge-group">
          ${prod.discount ? `<span class="badge badge-discount">-${prod.discount}% OFF</span>` : ''}
          ${prod.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <button class="product-wishlist-btn" onclick="showToast('Guardado en favoritos')" title="Favorito">
          <i class="fa-regular fa-heart"></i>
        </button>
        <div class="product-image-box">
          <img src="${prod.image}" alt="${prod.name}" class="product-img" loading="lazy">
          <div class="product-quick-actions">
            <button class="btn-quick-view" onclick="hmcOpenQuickView(${prod.id})">
              <i class="fa-solid fa-eye"></i> Vista Rápida
            </button>
          </div>
        </div>
        <div class="product-details">
          <div class="product-brand">${prod.brand}</div>
          <h4 class="product-name" title="${prod.name}">${prod.name}</h4>
          <div class="product-price-box">
            <div>
              <span class="price-old">${formatCurrency(prod.oldPrice)}</span>
              <span class="price-current">${formatCurrency(prod.price)}</span>
            </div>
            <div class="installments-info">
              <i class="fa-solid fa-credit-card"></i> <strong>6 cuotas</strong> sin interés
            </div>
          </div>
          <button class="btn btn-primary btn-add-to-cart" onclick="hmcAddToCart(${prod.id})">
            <i class="fa-solid fa-cart-plus"></i> Comprar
          </button>
        </div>
      </div>
    `).join('');
  }
  
  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      renderProducts(tab.dataset.tab);
    });
  });
  
  renderProducts('all');
}

/* --------------------------------------------------------------------------
   7. Live Search Suggestions
   -------------------------------------------------------------------------- */
function initLiveSearch() {
  const searchInput = document.getElementById('mainSearchInput');
  const dropdown = document.getElementById('searchDropdown');
  const resultsContainer = document.getElementById('searchResultsList');
  
  if (!searchInput || !dropdown || !resultsContainer) return;
  
  searchInput.addEventListener('input', (e) => {
    const query = e.target.value.trim().toLowerCase();
    if (query.length < 2) {
      dropdown.classList.remove('active');
      return;
    }
    
    const matches = PRODUCT_CATALOG.filter(p => 
      p.name.toLowerCase().includes(query) || 
      p.brand.toLowerCase().includes(query) ||
      p.categoryName.toLowerCase().includes(query)
    ).slice(0, 4);
    
    if (matches.length > 0) {
      resultsContainer.innerHTML = matches.map(p => `
        <div class="search-result-item" onclick="hmcOpenQuickView(${p.id})">
          <img src="${p.image}" alt="${p.name}">
          <div class="search-result-info">
            <h5>${p.name}</h5>
            <span>${formatCurrency(p.price)}</span>
          </div>
        </div>
      `).join('');
      dropdown.classList.add('active');
    } else {
      resultsContainer.innerHTML = `<div style="padding: 16px; font-size: 0.88rem; color: #777;">No se encontraron productos para "${query}"</div>`;
      dropdown.classList.add('active');
    }
  });
  
  document.addEventListener('click', (e) => {
    if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
      dropdown.classList.remove('active');
    }
  });
}

/* --------------------------------------------------------------------------
   8. Custom Video Player Controls
   -------------------------------------------------------------------------- */
function initVideoPlayer() {
  const video = document.getElementById('showcaseVideo');
  const playBtn = document.getElementById('videoPlayBtn');
  
  if (!video || !playBtn) return;
  
  playBtn.addEventListener('click', () => {
    if (video.paused) {
      video.play();
      playBtn.classList.add('playing');
    } else {
      video.pause();
      playBtn.classList.remove('playing');
    }
  });
  
  video.addEventListener('play', () => playBtn.classList.add('playing'));
  video.addEventListener('pause', () => playBtn.classList.remove('playing'));
}

/* --------------------------------------------------------------------------
   9. Newsletter Form Validation
   -------------------------------------------------------------------------- */
function initNewsletter() {
  const form = document.getElementById('newsletterForm');
  if (!form) return;
  
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const input = form.querySelector('input[type="email"]');
    if (input && input.value.includes('@')) {
      showToast('🎉 ¡Gracias por suscribirte! Te enviamos tu cupón del 10% por email.');
      input.value = '';
    } else {
      showToast('Por favor, ingresá un email válido');
    }
  });
}

/* --------------------------------------------------------------------------
   10. Postal Code Shipping Calculator
   -------------------------------------------------------------------------- */
function initShippingCalculator() {
  window.hmcCalcShipping = function() {
    const cp = document.getElementById('shippingCpInput')?.value;
    const resultBox = document.getElementById('shippingResultBox');
    
    if (!cp || cp.length < 4) {
      showToast('Ingresá un código postal válido de 4 dígitos');
      return;
    }
    
    if (resultBox) {
      resultBox.innerHTML = `
        <div style="padding: 12px; background: #e8f5e9; border-radius: 6px; border: 1px solid #c8e6c9; margin-top: 10px; font-size: 0.85rem;">
          <div style="color: #2e7d32; font-weight: 700; margin-bottom: 4px;"><i class="fa-solid fa-truck"></i> Envío a CP ${cp}:</div>
          <div>• <strong>Envío Estándar:</strong> $4.200 (Llega en 48-72 hs)</div>
          <div>• <strong>Retiro en Sucursal HMC:</strong> <span style="color: #2e7d32; font-weight: 700;">¡GRATIS!</span> (Disponible hoy)</div>
        </div>
      `;
    }
  };
}

/* --------------------------------------------------------------------------
   11. Promotional Popup (Welcome Modal)
   -------------------------------------------------------------------------- */
function initPromoPopup() {
  const popup = document.getElementById('promoPopup');
  const closeBtn = document.getElementById('promoPopupClose');
  
  if (!popup) return;
  
  // Show after 3 seconds if not dismissed in this session
  if (!sessionStorage.getItem('hmc_promo_seen')) {
    setTimeout(() => {
      popup.classList.add('active');
    }, 2800);
  }
  
  function closePromo() {
    popup.classList.remove('active');
    sessionStorage.setItem('hmc_promo_seen', 'true');
  }
  
  if (closeBtn) closeBtn.addEventListener('click', closePromo);
  popup.addEventListener('click', (e) => {
    if (e.target === popup) closePromo();
  });
}

/* --------------------------------------------------------------------------
   12. Mobile Menu Drawer
   -------------------------------------------------------------------------- */
function initMobileMenu() {
  const toggleBtn = document.getElementById('mobileMenuToggle');
  const navBar = document.querySelector('.nav-bar');
  
  if (!toggleBtn || !navBar) return;
  
  toggleBtn.addEventListener('click', () => {
    if (navBar.style.display === 'block') {
      navBar.style.display = 'none';
    } else {
      navBar.style.display = 'block';
    }
  });
}

/* --------------------------------------------------------------------------
   13. Toast Notification Helper
   -------------------------------------------------------------------------- */
function showToast(message) {
  let container = document.querySelector('.toast-container');
  if (!container) {
    container = document.createElement('div');
    container.className = 'toast-container';
    document.body.appendChild(container);
  }
  
  const toast = document.createElement('div');
  toast.className = 'toast';
  toast.innerHTML = `<i class="fa-solid fa-circle-check"></i> <span>${message}</span>`;
  
  container.appendChild(toast);
  setTimeout(() => toast.classList.add('show'), 50);
  
  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 400);
  }, 3500);
}
