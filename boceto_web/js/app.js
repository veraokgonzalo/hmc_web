/**
 * HMC HUB - Master Application Logic (Senior Architecture Prototype)
 * Modular Multi-Page Storefront for Tiendanube Legacy & Nimbus Conversion
 */

document.addEventListener('DOMContentLoaded', () => {
  // Global Components
  initCartSystem();
  initLiveSearch();
  initQuickViewModal();
  initNewsletter();
  initMobileMenu();

  // Page-Specific Dispatcher
  if (document.querySelector('.hero-slider-section')) {
    initHeroSlider();
    initCountdown();
    initCatalogTabs();
    initVideoPlayer();
    initPromoPopup();
  }

  if (document.getElementById('catalogPageLayout')) {
    initCatalogPage();
  }

  if (document.getElementById('productDetailLayout')) {
    initProductPage();
  }

  if (document.getElementById('cartPageLayout')) {
    initCartPage();
  }

  if (document.getElementById('contactPageLayout')) {
    initContactPage();
  }
});

/* --------------------------------------------------------------------------
   1. Master Product Database
   -------------------------------------------------------------------------- */
const PRODUCT_CATALOG = [
  {
    id: 1,
    sku: "HMC-MOT-052",
    name: "Motosierra Profesional 52cc Espada 20\" Motor 2T",
    category: "motosierras",
    categoryName: "Motosierras",
    brand: "STIHL",
    price: 349990,
    oldPrice: 419990,
    image: "assets/images/products/prod-01-motosierra-stihl-52cc-principal.jpg",
    gallery: [
      "assets/images/products/prod-01-motosierra-stihl-52cc-principal.jpg",
      "assets/images/products/prod-01-motosierra-stihl-52cc-detalle-espada.jpg",
      "assets/images/products/prod-01-motosierra-stihl-52cc-detalle-motor.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 16,
    tab: "bestsellers",
    rating: 5.0,
    reviewsCount: 28,
    desc: "Motosierra de alta potencia diseñada para trabajos forestales exigentes, tala continua y poda pesada. Cilindrada de 52cc con sistema de arranque fácil ElastoStart, freno de cadena QuickStop de acción inmediata y lubricación de cadena Ematic.",
    specs: [
      { label: "Cilindrada", val: "52 cc (Motor 2 Tiempos)" },
      { label: "Potencia", val: "3.4 HP / 2.5 kW" },
      { label: "Largo de Espada", val: "20 pulgadas (50 cm)" },
      { label: "Paso de Cadena", val: "3/8\" Rapid Super" },
      { label: "Capacidad de Tanque", val: "550 ml (Mezcla nafta/aceite)" },
      { label: "Peso en Seco", val: "5.4 kg" },
      { label: "Garantía Oficial", val: "12 meses con servicio oficial HMC" }
    ],
    applications: "Apta para obra civil pesada, corte de tirantes y postes, desmonte en campo agrícola y aserrado intensivo."
  },
  {
    id: 2,
    sku: "HMC-GEN-065",
    name: "Generador Eléctrico 6.5 KVA Monofásico Naftero",
    category: "generadores",
    categoryName: "Generadores",
    brand: "HONDA",
    price: 890500,
    oldPrice: 990000,
    image: "assets/images/products/prod-02-generador-honda-65kva-principal.jpg",
    gallery: [
      "assets/images/products/prod-02-generador-honda-65kva-principal.jpg",
      "assets/images/products/prod-02-generador-honda-65kva-detalle-panel.jpg",
      "assets/images/products/prod-02-generador-honda-65kva-detalle-chasis.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 10,
    tab: "heavy",
    rating: 4.9,
    reviewsCount: 34,
    desc: "Grupo electrógeno robusto de 4 tiempos con regulación AVR de voltaje estable para equipos sensibles. Chasis tubular de acero de 32mm reforzado, arranque eléctrico con batería incluida y alerta de nivel bajo de aceite con parada automática.",
    specs: [
      { label: "Potencia Máxima", val: "6.5 KVA (6500 Watts)" },
      { label: "Potencia Nominal", val: "5.5 KVA (5500 Watts)" },
      { label: "Motor", val: "Honda GX390 OHV 13 HP" },
      { label: "Voltaje de Salida", val: "220V - 50Hz Monofásico" },
      { label: "Regulación de Voltaje", val: "AVR Digital Automático" },
      { label: "Autonomía", val: "10.5 horas al 50% de carga" },
      { label: "Garantía Oficial", val: "24 meses respaldo oficial" }
    ],
    applications: "Respaldo integral para obradores, bombas sumergibles, herramientas pesadas de taller y comercios medianos."
  },
  {
    id: 3,
    sku: "HMC-HID-180",
    name: "Hidrolavadora Alta Presión 180 Bar Profesional",
    category: "hidrolavadoras",
    categoryName: "Hidrolavadoras",
    brand: "BOSCH",
    price: 289000,
    oldPrice: 345000,
    image: "assets/images/products/prod-03-hidrolavadora-bosch-180bar-principal.jpg",
    gallery: [
      "assets/images/products/prod-03-hidrolavadora-bosch-180bar-principal.jpg",
      "assets/images/products/prod-03-hidrolavadora-bosch-180bar-detalle-lanza.jpg",
      "assets/images/products/prod-03-hidrolavadora-bosch-180bar-detalle-bomba.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 16,
    tab: "bestsellers",
    rating: 4.8,
    reviewsCount: 19,
    desc: "Bomba de latón forjado reforzada con pistones de acero inox y motor a inducción de servicio continuo. Incluye lanza de abanico variable, lanza turbo rotativa para suciedad incrustada y depósito de detergente con dosificador regulable.",
    specs: [
      { label: "Presión Máxima", val: "180 Bar (2610 PSI)" },
      { label: "Caudal de Agua", val: "520 Litros/hora" },
      { label: "Potencia Eléctrica", val: "2400 Watts / Motor Inducción" },
      { label: "Manguera", val: "8 metros de goma con malla metálica" },
      { label: "Temperatura Máx. Entrada", val: "50 °C" },
      { label: "Garantía Oficial", val: "12 meses Bosch Professional" }
    ],
    applications: "Limpieza profunda de maquinaria pesada, camiones, fachadas en altura, veredas y talleres mecánicos."
  },
  {
    id: 4,
    sku: "HMC-DES-052",
    name: "Desmalezadora Naftera 52cc 2T Profesional Eje Recto",
    category: "desmalezadoras",
    categoryName: "Desmalezadoras",
    brand: "HUSQVARNA",
    price: 310000,
    oldPrice: 365000,
    image: "assets/images/products/prod-04-desmalezadora-husqvarna-52cc-principal.jpg",
    gallery: [
      "assets/images/products/prod-04-desmalezadora-husqvarna-52cc-principal.jpg",
      "assets/images/products/prod-04-desmalezadora-husqvarna-52cc-detalle-manillar.jpg",
      "assets/images/products/prod-04-desmalezadora-husqvarna-52cc-detalle-cuchilla.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 15,
    tab: "new",
    rating: 4.9,
    reviewsCount: 22,
    desc: "Desmalezadora de alto rendimiento para desmalezado intenso de campos, parques y terrenos duros con maleza leñosa. Manillar ergonómico asimétrico con mando integrado y arnés profesional acolchado de 4 puntos.",
    specs: [
      { label: "Motor", val: "52 cc 2 Tiempos refrigerado por aire" },
      { label: "Potencia", val: "2.8 HP" },
      { label: "Transmisión", val: "Eje cardánico macizo de 8mm" },
      { label: "Corte", val: "Cuchilla 3 puntas 300mm + Carretel nylon" },
      { label: "Peso", val: "7.8 kg" },
      { label: "Garantía Oficial", val: "12 meses oficial Husqvarna" }
    ],
    applications: "Mantenimiento intensivo de banquinas, campos agrícolas, borduras de alambrados y loteos."
  },
  {
    id: 5,
    sku: "HMC-COM-050",
    name: "Compresor de Aire 50L 2.5 HP Lubricado a Pistón",
    category: "ferreteria",
    categoryName: "Ferretería & Taller",
    brand: "GAMMA",
    price: 245000,
    oldPrice: 285000,
    image: "assets/images/products/prod-05-compresor-gamma-50l-principal.jpg",
    gallery: [
      "assets/images/products/prod-05-compresor-gamma-50l-principal.jpg",
      "assets/images/products/prod-05-compresor-gamma-50l-detalle-manometros.jpg",
      "assets/images/products/prod-05-compresor-gamma-50l-detalle-tanque.jpg"
    ],
    inStock: true,
    freeShipping: false,
    discount: 14,
    tab: "heavy",
    rating: 4.7,
    reviewsCount: 15,
    desc: "Compresor de aire con tanque de 50 litros homologado. Presostato electromecánico con válvula de alivio, manómetro doble (presión de tanque y de salida regulada) y ruedas macizas de fácil transporte.",
    specs: [
      { label: "Capacidad de Tanque", val: "50 Litros" },
      { label: "Potencia de Motor", val: "2.5 HP (1800W)" },
      { label: "Presión Máxima", val: "8 Bar (115 PSI)" },
      { label: "Caudal de Aire", val: "206 L/min" },
      { label: "Voltaje", val: "220V - 50 Hz" },
      { label: "Garantía Oficial", val: "12 meses con repuestos oficiales" }
    ],
    applications: "Pintura con soplete, pistolas de impacto neumáticas, inflado de neumáticos y soplado en taller."
  },
  {
    id: 6,
    sku: "HMC-COR-006",
    name: "Cortadora de Césped Naftera 6 HP Autopropulsada",
    category: "jardineria",
    categoryName: "Jardinería & Agro",
    brand: "ECHO",
    price: 475000,
    oldPrice: 530000,
    image: "assets/images/products/prod-06-cortadora-cesped-echo-6hp-principal.jpg",
    gallery: [
      "assets/images/products/prod-06-cortadora-cesped-echo-6hp-principal.jpg",
      "assets/images/products/prod-06-cortadora-cesped-echo-6hp-detalle-ruedas.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 10,
    tab: "bestsellers",
    rating: 4.9,
    reviewsCount: 17,
    desc: "Chasis de acero estampado de 20 pulgadas con regulación de altura en una sola palanca (6 posiciones). Sistema 3 en 1: recolección en bolsa de 60L, descarga lateral y triturado mulching.",
    specs: [
      { label: "Motor", val: "4T OHV 6 HP con arranque ReadyStart" },
      { label: "Ancho de Corte", val: "51 cm (20 pulgadas)" },
      { label: "Tracción", val: "Autopropulsada en ruedas traseras" },
      { label: "Bolsa Recolectora", val: "60 Litros con tela antipolvo" },
      { label: "Regulación de Altura", val: "25 a 75 mm (6 puntos)" },
      { label: "Garantía Oficial", val: "12 meses" }
    ],
    applications: "Corte profesional en countries, parques de empresas, canchas de fútbol y grandes jardines."
  },
  {
    id: 7,
    sku: "HMC-ROT-110",
    name: "Rotomartillo SDS Plus 1100W Maletín y Cinceles",
    category: "ferreteria",
    categoryName: "Ferretería & Taller",
    brand: "DEWALT",
    price: 198000,
    oldPrice: 230000,
    image: "assets/images/products/prod-07-rotomartillo-dewalt-1100w-principal.jpg",
    gallery: [
      "assets/images/products/prod-07-rotomartillo-dewalt-1100w-principal.jpg",
      "assets/images/products/prod-07-rotomartillo-dewalt-1100w-detalle-maletin.jpg"
    ],
    inStock: true,
    freeShipping: false,
    discount: 13,
    tab: "new",
    rating: 5.0,
    reviewsCount: 42,
    desc: "Rotomartillo electro-neumático de 3 modos: taladrado simple, taladro con percusión y cincelado/demolición ligera. Embrague de seguridad que desconecta el par motor en caso de bloqueo de broca.",
    specs: [
      { label: "Potencia", val: "1100 Watts" },
      { label: "Fuerza de Impacto", val: "3.5 Joules EPTA" },
      { label: "Encastre", val: "SDS Plus sellado contra polvo" },
      { label: "Capacidad Hormigón", val: "Hasta 28 mm" },
      { label: "Incluye", val: "Maletín de transporte, 3 mechas + 2 cinceles" },
      { label: "Garantía", val: "36 meses DeWalt Oficial" }
    ],
    applications: "Perforación en hormigón armado, mampostería, apertura de canaletas para cañerías e instalaciones eléctricas."
  },
  {
    id: 8,
    sku: "HMC-BOM-015",
    name: "Bomba Sumergible Pozo Profundo 1.5 HP Acero Inox",
    category: "hidrolavadoras",
    categoryName: "Maquinaria & Bombeo",
    brand: "LUSQTOFF",
    price: 215000,
    oldPrice: 260000,
    image: "assets/images/products/prod-08-bomba-sumergible-lusqtoff-15hp-principal.jpg",
    gallery: [
      "assets/images/products/prod-08-bomba-sumergible-lusqtoff-15hp-principal.jpg",
      "assets/images/products/prod-08-bomba-sumergible-lusqtoff-15hp-detalle-tablero.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 17,
    tab: "heavy",
    rating: 4.8,
    reviewsCount: 14,
    desc: "Cuerpo íntegramente en acero inoxidable AISI 304 para extracción de agua limpia en perforaciones profundas de hasta 65 metros. Incluye tablero de comando exterior con capacitor y protector térmico.",
    specs: [
      { label: "Potencia", val: "1.5 HP (1100W) Monofásica" },
      { label: "Elevación Máxima", val: "65 metros" },
      { label: "Caudal Máximo", val: "4500 Litros/hora" },
      { label: "Diámetro de Bomba", val: "4 pulgadas (100 mm)" },
      { label: "Salida de Descarga", val: "1 1/4\" rosca hembra" },
      { label: "Garantía Oficial", val: "12 meses Lüsqtoff" }
    ],
    applications: "Abastecimiento domiciliario, llenado de tanques australianos, sistemas de riego y extracción de napas."
  },
  {
    id: 9,
    sku: "HMC-MOT-018",
    name: "Motosierra Eléctrica 1800W Espada 16\" Silenciosa",
    category: "motosierras",
    categoryName: "Motosierras",
    brand: "MAKITA",
    price: 185000,
    oldPrice: 215000,
    image: "assets/images/products/prod-09-motosierra-electrica-makita-1800w-principal.jpg",
    gallery: [
      "assets/images/products/prod-09-motosierra-electrica-makita-1800w-principal.jpg",
      "assets/images/products/prod-01-motosierra-stihl-52cc-detalle-espada.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 14,
    tab: "new",
    rating: 4.9,
    reviewsCount: 12,
    desc: "Motosierra eléctrica de alto torque sin emisiones de humo, perfecta para carpintería, leña y poda en zonas residenciales. Tensado de cadena lateral sin necesidad de herramientas y mirilla de nivel de aceite.",
    specs: [
      { label: "Potencia", val: "1800 Watts (220V)" },
      { label: "Espada", val: "16 pulgadas (40 cm)" },
      { label: "Velocidad de Cadena", val: "14.5 m/s" },
      { label: "Freno de Seguridad", val: "Freno inercial Safety Brake" },
      { label: "Garantía Oficial", val: "12 meses Makita Oficial" }
    ],
    applications: "Poda urbana sin ruidos molestos, corte de leña doméstica, carpintería y techistas."
  },
  {
    id: 10,
    sku: "HMC-GEN-024",
    name: "Generador Inverter Silencioso 2400W Ultra Portátil",
    category: "generadores",
    categoryName: "Generadores",
    brand: "BRIGGS & STRATTON",
    price: 640000,
    oldPrice: 720000,
    image: "assets/images/products/prod-10-generador-inverter-briggs-2400w-principal.jpg",
    gallery: [
      "assets/images/products/prod-10-generador-inverter-briggs-2400w-principal.jpg",
      "assets/images/products/prod-02-generador-honda-65kva-detalle-panel.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 11,
    tab: "bestsellers",
    rating: 5.0,
    reviewsCount: 26,
    desc: "Tecnología Inverter con onda senoidal pura (<3% THD) ideal para laptops, instrumental de medición, drones y motorhomes. Cabina insonorizada con nivel de ruido de apenas 58 dB a 7 metros.",
    specs: [
      { label: "Potencia Máxima", val: "2400 Watts" },
      { label: "Potencia Continua", val: "1800 Watts" },
      { label: "Nivel Sonoro", val: "58 dB (Modo Eco silencioso)" },
      { label: "Conexiones", val: "2x 220V + 2x USB + 1x 12V" },
      { label: "Peso", val: "22 kg con manija de transporte" },
      { label: "Garantía", val: "24 meses B&S" }
    ],
    applications: "Equipos electrónicos delicados, eventos al aire libre, food trucks, motorhomes y camping."
  },
  {
    id: 11,
    sku: "HMC-BOM-030",
    name: "Motobomba de Caudal 3 Pulgadas 4T Naftera",
    category: "hidrolavadoras",
    categoryName: "Maquinaria & Bombeo",
    brand: "HONDA",
    price: 520000,
    oldPrice: 590000,
    image: "assets/images/products/prod-11-motobomba-honda-3pulgadas-principal.jpg",
    gallery: [
      "assets/images/products/prod-08-bomba-sumergible-lusqtoff-15hp-principal.jpg",
      "assets/images/products/prod-02-generador-honda-65kva-detalle-chasis.jpg"
    ],
    inStock: true,
    freeShipping: true,
    discount: 12,
    tab: "heavy",
    rating: 4.8,
    reviewsCount: 11,
    desc: "Motobomba autocebante de fundición de aluminio para trasvase masivo de agua en obras, desagotes pluviales y riego agropecuario. Rotor y voluta de fundición gris de alta durabilidad.",
    specs: [
      { label: "Boca de Entrada / Salida", val: "3 pulgadas (80 mm)" },
      { label: "Caudal Máximo", val: "60.000 Litros/hora (1000 L/min)" },
      { label: "Altura de Elevación", val: "28 metros" },
      { label: "Motor", val: "Honda GX160 5.5 HP 4 Tiempos" },
      { label: "Garantía Oficial", val: "24 meses" }
    ],
    applications: "Desagote de subsuelos inundados, drenaje en excavaciones, llenado de represas y camiones cisterna."
  },
  {
    id: 12,
    sku: "HMC-TAL-075",
    name: "Taladro Percutor 750W Velocidad Variable y Reversa",
    category: "ferreteria",
    categoryName: "Ferretería & Taller",
    brand: "BOSCH",
    price: 115000,
    oldPrice: 135000,
    image: "assets/images/products/prod-12-taladro-percutor-bosch-750w-principal.jpg",
    gallery: [
      "assets/images/products/prod-07-rotomartillo-dewalt-1100w-principal.jpg",
      "assets/images/products/prod-05-compresor-gamma-50l-detalle-manometros.jpg"
    ],
    inStock: true,
    freeShipping: false,
    discount: 15,
    tab: "bestsellers",
    rating: 4.9,
    reviewsCount: 38,
    desc: "Taladro percutor ergonómico para uso continuo en mampostería, metal y madera. Mandril metálico de 13mm con llave y empuñadura auxiliar con tope de profundidad.",
    specs: [
      { label: "Potencia", val: "750 Watts" },
      { label: "Mandril", val: "13 mm (1/2 pulgada)" },
      { label: "Impactos por Minuto", val: "48.000 IPM" },
      { label: "Velocidad", val: "0 a 3000 RPM con selector electrónico" },
      { label: "Garantía", val: "24 meses Bosch Heavy Duty" }
    ],
    applications: "Perforación en ladrillo común, hueco, perfiles de acero, tirantes de madera y atornillado."
  }
];

/* --------------------------------------------------------------------------
   2. Cart & Storage Engine
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
    if (!drawer || !overlay) return;
    drawer.classList.add('active');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
    renderCart();
  }
  
  function closeCart() {
    if (!drawer || !overlay) return;
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
  
  // Global cart methods
  window.hmcAddToCart = function(productId, quantity = 1) {
    const existing = cart.find(item => item.id === productId);
    if (existing) {
      existing.qty += quantity;
    } else {
      cart.push({ id: productId, qty: quantity });
    }
    saveCart();
    renderCart();
    
    // Refresh full cart page if present
    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }

    const product = PRODUCT_CATALOG.find(p => p.id === productId);
    showToast(`¡"${product ? product.name.substring(0, 32) + '...' : 'Producto'}" agregado al carrito!`);
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

    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }
  };
  
  window.hmcRemoveItem = function(productId) {
    cart = cart.filter(i => i.id !== productId);
    saveCart();
    renderCart();

    if (document.getElementById('cartPageLayout')) {
      renderFullCartPage();
    }
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
        <a href="catalog.html" class="btn btn-primary btn-sm" style="margin-top: 16px; display: inline-block;">Ver Catálogo</a>
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
          <a href="product.html?id=${prod.id}" class="cart-item-title">${prod.name}</a>
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
   3. Live Search Bar & Suggestions
   -------------------------------------------------------------------------- */
function initLiveSearch() {
  const searchInput = document.getElementById('mainSearchInput');
  const dropdown = document.getElementById('searchDropdown');
  const resultsContainer = document.getElementById('searchResultsList');
  const searchForm = document.querySelector('.search-form');
  
  if (!searchInput) return;

  if (searchForm) {
    searchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const q = searchInput.value.trim();
      if (q.length > 0) {
        window.location.href = `catalog.html?q=${encodeURIComponent(q)}`;
      }
    });
  }
  
  if (!dropdown || !resultsContainer) return;
  
  searchInput.addEventListener('input', (e) => {
    const query = e.target.value.trim().toLowerCase();
    if (query.length < 2) {
      dropdown.classList.remove('active');
      return;
    }
    
    const matches = PRODUCT_CATALOG.filter(p => 
      p.name.toLowerCase().includes(query) || 
      p.brand.toLowerCase().includes(query) ||
      p.categoryName.toLowerCase().includes(query) ||
      p.sku.toLowerCase().includes(query)
    ).slice(0, 5);
    
    if (matches.length > 0) {
      resultsContainer.innerHTML = matches.map(p => `
        <div class="search-result-item" onclick="window.location.href='product.html?id=${p.id}'">
          <img src="${p.image}" alt="${p.name}">
          <div class="search-result-info">
            <h5>${p.name}</h5>
            <span>${formatCurrency(p.price)} • <strong style="color: var(--color-primary);">${p.brand}</strong></span>
          </div>
        </div>
      `).join('') + `
        <div style="padding: 10px 16px; background: #fafafa; border-top: 1px solid #eee; text-align: center;">
          <a href="catalog.html?q=${encodeURIComponent(query)}" style="font-size: 0.85rem; font-weight: 700; color: var(--color-primary-dark);">
            Ver todos los resultados para "${query}" →
          </a>
        </div>
      `;
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
   4. Quick View Modal Component
   -------------------------------------------------------------------------- */
function initQuickViewModal() {
  const modal = document.getElementById('quickViewModal');
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
      specsList.innerHTML = prod.specs.slice(0, 4).map(s => `<li><i class="fa-solid fa-check text-primary"></i> <strong>${s.label}:</strong> ${s.val}</li>`).join('');
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
  modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
  });
}

/* --------------------------------------------------------------------------
   5. Home Page Components
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
    slides.forEach((s, i) => s.classList.toggle('active', i === index));
    dots.forEach((d, i) => d.classList.toggle('active', i === index));
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
  
  if (nextBtn) nextBtn.addEventListener('click', () => { nextSlide(); startAutoplay(); });
  if (prevBtn) prevBtn.addEventListener('click', () => { prevSlide(); startAutoplay(); });
  
  dots.forEach((dot, idx) => {
    dot.addEventListener('click', () => {
      showSlide(idx);
      startAutoplay();
    });
  });
  
  // Touch Swipe for Mobile
  let touchStartX = 0;
  let touchEndX = 0;
  const sliderEl = document.querySelector('.hero-slider-wrapper');
  if (sliderEl) {
    sliderEl.addEventListener('touchstart', e => {
      touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });
    sliderEl.addEventListener('touchend', e => {
      touchEndX = e.changedTouches[0].screenX;
      if (touchStartX - touchEndX > 45) {
        nextSlide();
        startAutoplay();
      } else if (touchEndX - touchStartX > 45) {
        prevSlide();
        startAutoplay();
      }
    }, { passive: true });
  }
  
  startAutoplay();
}

function initCountdown() {
  const daysEl = document.getElementById('cd-days');
  const hoursEl = document.getElementById('cd-hours');
  const minsEl = document.getElementById('cd-mins');
  const secsEl = document.getElementById('cd-secs');
  
  if (!daysEl) return;
  
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
          <a href="product.html?id=${prod.id}">
            <img src="${prod.image}" alt="${prod.name}" class="product-img" loading="lazy">
          </a>
          <div class="product-quick-actions">
            <button class="btn-quick-view" onclick="hmcOpenQuickView(${prod.id})">
              <i class="fa-solid fa-eye"></i> Vista Rápida
            </button>
          </div>
        </div>
        <div class="product-details">
          <div class="product-brand">${prod.brand}</div>
          <h4 class="product-name" title="${prod.name}">
            <a href="product.html?id=${prod.id}">${prod.name}</a>
          </h4>
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

function initPromoPopup() {
  const popup = document.getElementById('promoPopup');
  const closeBtn = document.getElementById('promoPopupClose');
  
  if (!popup) return;
  
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
   6. Dedicated Catalog / Search Page Engine (catalog.html)
   -------------------------------------------------------------------------- */
function initCatalogPage() {
  const gridContainer = document.getElementById('catalogProductsGrid');
  const countEl = document.getElementById('catalogResultsCount');
  const sortSelect = document.getElementById('catalogSortSelect');
  const activeChipsContainer = document.getElementById('activeFilterChips');
  const viewGridBtn = document.getElementById('viewGridBtn');
  const viewListBtn = document.getElementById('viewListBtn');
  const categoryCheckboxes = document.querySelectorAll('.js-filter-category');
  const brandCheckboxes = document.querySelectorAll('.js-filter-brand');
  const freeShipCheckbox = document.getElementById('filterFreeShipping');
  const inStockCheckbox = document.getElementById('filterInStock');
  const offersCheckbox = document.getElementById('filterOffers');
  const minPriceInput = document.getElementById('priceMinInput');
  const maxPriceInput = document.getElementById('priceMaxInput');
  const applyPriceBtn = document.getElementById('applyPriceBtn');
  
  // Read URL query params
  const urlParams = new URLSearchParams(window.location.search);
  const paramCategory = urlParams.get('category') || urlParams.get('cat');
  const paramBrand = urlParams.get('brand');
  const paramSearch = urlParams.get('q');
  const paramOffers = urlParams.get('offers');

  if (paramCategory) {
    categoryCheckboxes.forEach(cb => {
      if (cb.value === paramCategory) cb.checked = true;
    });
  }

  if (paramBrand) {
    brandCheckboxes.forEach(cb => {
      if (cb.value.toUpperCase() === paramBrand.toUpperCase()) cb.checked = true;
    });
  }

  if (paramOffers === 'true') {
    if (offersCheckbox) offersCheckbox.checked = true;
  }

  function applyFilters() {
    const selectedCategories = Array.from(categoryCheckboxes).filter(cb => cb.checked).map(cb => cb.value);
    const selectedBrands = Array.from(brandCheckboxes).filter(cb => cb.checked).map(cb => cb.value.toUpperCase());
    const onlyFreeShipping = freeShipCheckbox ? freeShipCheckbox.checked : false;
    const onlyInStock = inStockCheckbox ? inStockCheckbox.checked : false;
    const onlyOffers = offersCheckbox ? offersCheckbox.checked : false;
    const minP = minPriceInput && minPriceInput.value ? Number(minPriceInput.value) : 0;
    const maxP = maxPriceInput && maxPriceInput.value ? Number(maxPriceInput.value) : Infinity;
    const searchQuery = (paramSearch || '').toLowerCase();

    let results = PRODUCT_CATALOG.filter(item => {
      if (selectedCategories.length > 0 && !selectedCategories.includes(item.category)) return false;
      if (selectedBrands.length > 0 && !selectedBrands.includes(item.brand.toUpperCase())) return false;
      if (onlyFreeShipping && !item.freeShipping) return false;
      if (onlyInStock && !item.inStock) return false;
      if (onlyOffers && (!item.discount || item.discount <= 0)) return false;
      if (item.price < minP || item.price > maxP) return false;
      if (searchQuery) {
        const matches = item.name.toLowerCase().includes(searchQuery) ||
                        item.brand.toLowerCase().includes(searchQuery) ||
                        item.categoryName.toLowerCase().includes(searchQuery) ||
                        item.sku.toLowerCase().includes(searchQuery);
        if (!matches) return false;
      }
      return true;
    });

    // Sorting
    const sortVal = sortSelect ? sortSelect.value : 'featured';
    if (sortVal === 'price-asc') {
      results.sort((a, b) => a.price - b.price);
    } else if (sortVal === 'price-desc') {
      results.sort((a, b) => b.price - a.price);
    } else if (sortVal === 'discount') {
      results.sort((a, b) => (b.discount || 0) - (a.discount || 0));
    } else if (sortVal === 'name-asc') {
      results.sort((a, b) => a.name.localeCompare(b.name));
    }

    renderCatalogResults(results);
    renderActiveFilterChips(selectedCategories, selectedBrands, onlyFreeShipping, onlyOffers, searchQuery);
  }

  function renderCatalogResults(results) {
    if (countEl) {
      countEl.innerHTML = `Mostrando <strong>${results.length}</strong> de <strong>${PRODUCT_CATALOG.length}</strong> equipos`;
    }

    if (!gridContainer) return;

    if (results.length === 0) {
      gridContainer.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; background: #fff; border: 1px dashed var(--color-gray-border); border-radius: var(--radius-lg);">
          <i class="fa-solid fa-magnifying-glass" style="font-size: 3rem; color: #bbb; margin-bottom: 16px;"></i>
          <h3>No encontramos equipos con los filtros seleccionados</h3>
          <p style="color: #666; margin-bottom: 20px;">Probá modificando el rango de precios o quitando filtros de marca o categoría.</p>
          <button class="btn btn-primary" onclick="window.location.href='catalog.html'">Ver Todo el Catálogo</button>
        </div>
      `;
      return;
    }

    gridContainer.innerHTML = results.map(prod => `
      <div class="product-card">
        <div class="product-badge-group">
          ${prod.discount ? `<span class="badge badge-discount">-${prod.discount}% OFF</span>` : ''}
          ${prod.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <button class="product-wishlist-btn" onclick="showToast('Guardado en favoritos')" title="Favorito">
          <i class="fa-regular fa-heart"></i>
        </button>
        <div class="product-image-box">
          <a href="product.html?id=${prod.id}">
            <img src="${prod.image}" alt="${prod.name}" class="product-img" loading="lazy">
          </a>
          <div class="product-quick-actions">
            <button class="btn-quick-view" onclick="hmcOpenQuickView(${prod.id})">
              <i class="fa-solid fa-eye"></i> Vista Rápida
            </button>
          </div>
        </div>
        <div class="product-details">
          <div class="product-brand">${prod.brand}</div>
          <h4 class="product-name" title="${prod.name}">
            <a href="product.html?id=${prod.id}">${prod.name}</a>
          </h4>
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
            <i class="fa-solid fa-cart-plus"></i> Comprar Ahora
          </button>
        </div>
      </div>
    `).join('');
  }

  function renderActiveFilterChips(categories, brands, freeShip, offers, search) {
    if (!activeChipsContainer) return;
    let chipsHtml = '';

    if (search) {
      chipsHtml += `<span class="filter-chip">Búsqueda: "${search}" <button onclick="window.location.href='catalog.html'">✕</button></span>`;
    }
    categories.forEach(c => {
      chipsHtml += `<span class="filter-chip">Categoría: ${c} <button onclick="document.querySelector('.js-filter-category[value=${c}]').click()">✕</button></span>`;
    });
    brands.forEach(b => {
      chipsHtml += `<span class="filter-chip">Marca: ${b} <button onclick="document.querySelector('.js-filter-brand[value=${b}]').click()">✕</button></span>`;
    });
    if (freeShip) {
      chipsHtml += `<span class="filter-chip">Envío Gratis <button onclick="document.getElementById('filterFreeShipping').click()">✕</button></span>`;
    }
    if (offers) {
      chipsHtml += `<span class="filter-chip">En Oferta <button onclick="document.getElementById('filterOffers').click()">✕</button></span>`;
    }

    if (chipsHtml) {
      chipsHtml += `<button class="clear-filters-btn" onclick="window.location.href='catalog.html'">Limpiar todo</button>`;
      activeChipsContainer.innerHTML = chipsHtml;
    } else {
      activeChipsContainer.innerHTML = '';
    }
  }

  // Listeners
  categoryCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));
  brandCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));
  if (freeShipCheckbox) freeShipCheckbox.addEventListener('change', applyFilters);
  if (inStockCheckbox) inStockCheckbox.addEventListener('change', applyFilters);
  if (offersCheckbox) offersCheckbox.addEventListener('change', applyFilters);
  if (sortSelect) sortSelect.addEventListener('change', applyFilters);
  if (applyPriceBtn) applyPriceBtn.addEventListener('click', applyFilters);

  // View modes
  if (viewGridBtn && viewListBtn && gridContainer) {
    viewGridBtn.addEventListener('click', () => {
      viewGridBtn.classList.add('active');
      viewListBtn.classList.remove('active');
      gridContainer.classList.remove('list-view');
    });
    viewListBtn.addEventListener('click', () => {
      viewListBtn.classList.add('active');
      viewGridBtn.classList.remove('active');
      gridContainer.classList.add('list-view');
    });
  }

  // Mobile Filter Bottom Sheet Drawer controls
  const btnOpenMobileFilter = document.getElementById('btnOpenMobileFilter');
  const btnCloseMobileFilter = document.getElementById('btnCloseMobileFilter');
  const catalogSidebar = document.querySelector('.catalog-sidebar');
  const mobileDrawerOverlay = document.getElementById('mobileDrawerOverlay');

  function openMobileFilters() {
    if (catalogSidebar) catalogSidebar.classList.add('mobile-sheet-active');
    if (mobileDrawerOverlay) mobileDrawerOverlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeMobileFilters() {
    if (catalogSidebar) catalogSidebar.classList.remove('mobile-sheet-active');
    if (mobileDrawerOverlay) mobileDrawerOverlay.classList.remove('active');
    document.body.style.overflow = '';
  }

  if (btnOpenMobileFilter) btnOpenMobileFilter.addEventListener('click', openMobileFilters);
  if (btnCloseMobileFilter) btnCloseMobileFilter.addEventListener('click', closeMobileFilters);

  applyFilters();
}

/* --------------------------------------------------------------------------
   7. Dedicated Product Detail Page Engine (product.html)
   -------------------------------------------------------------------------- */
function initProductPage() {
  const urlParams = new URLSearchParams(window.location.search);
  const prodId = parseInt(urlParams.get('id')) || 1;
  const prod = PRODUCT_CATALOG.find(p => p.id === prodId) || PRODUCT_CATALOG[0];

  // Populate Meta & Breadcrumb
  document.title = `${prod.name} | HMC HUB`;
  const breadcrumbCat = document.getElementById('breadcrumbCategory');
  const breadcrumbProd = document.getElementById('breadcrumbProduct');
  if (breadcrumbCat) {
    breadcrumbCat.textContent = prod.categoryName;
    breadcrumbCat.href = `catalog.html?category=${prod.category}`;
  }
  if (breadcrumbProd) breadcrumbProd.textContent = prod.name;

  // Populate Details
  const titleEl = document.getElementById('productTitle');
  const brandEl = document.getElementById('productBrand');
  const skuEl = document.getElementById('productSku');
  const priceEl = document.getElementById('productPrice');
  const oldPriceEl = document.getElementById('productOldPrice');
  const discountEl = document.getElementById('productDiscountBadge');
  const installmentsEl = document.getElementById('productInstallmentsText');
  const descEl = document.getElementById('productFullDesc');
  const appDescEl = document.getElementById('productApplications');
  const mainImgEl = document.getElementById('productMainImg');
  const thumbsContainer = document.getElementById('productThumbsContainer');
  const specsTableBody = document.getElementById('productSpecsTableBody');
  const whatsappAdviceBtn = document.getElementById('productWhatsappBtn');
  
  if (titleEl) titleEl.textContent = prod.name;
  if (brandEl) brandEl.textContent = prod.brand;
  if (skuEl) skuEl.textContent = `SKU: ${prod.sku}`;
  if (priceEl) priceEl.textContent = formatCurrency(prod.price);
  if (oldPriceEl) oldPriceEl.textContent = formatCurrency(prod.oldPrice);
  if (discountEl) discountEl.textContent = `-${prod.discount}% OFF`;
  if (descEl) descEl.textContent = prod.desc;
  if (appDescEl) appDescEl.textContent = prod.applications || '';

  // Installments calculation
  if (installmentsEl) {
    const installmentVal = Math.round(prod.price / 6);
    installmentsEl.innerHTML = `<strong>6 cuotas fijas</strong> sin interés de <strong>${formatCurrency(installmentVal)}</strong> con todas las tarjetas`;
  }

  // Gallery
  if (mainImgEl) mainImgEl.src = prod.image;
  if (thumbsContainer && prod.gallery) {
    thumbsContainer.innerHTML = prod.gallery.map((imgSrc, idx) => `
      <div class="gallery-thumb ${idx === 0 ? 'active' : ''}" onclick="hmcSwitchProductImage('${imgSrc}', this)">
        <img src="${imgSrc}" alt="${prod.name}">
      </div>
    `).join('');
  }

  window.hmcSwitchProductImage = function(src, thumbEl) {
    if (mainImgEl) mainImgEl.src = src;
    document.querySelectorAll('.gallery-thumb').forEach(t => t.classList.remove('active'));
    if (thumbEl) thumbEl.classList.add('active');
  };

  // Specs Table
  if (specsTableBody && prod.specs) {
    specsTableBody.innerHTML = prod.specs.map(s => `
      <tr>
        <th>${s.label}</th>
        <td>${s.val}</td>
      </tr>
    `).join('');
  }

  // WhatsApp Technical Inquiry prefill
  if (whatsappAdviceBtn) {
    const msg = encodeURIComponent(`Hola HMC Hub, estoy viendo el equipo "${prod.name}" (SKU: ${prod.sku}) en la web y me gustaría recibir asesoramiento técnico para mi trabajo.`);
    whatsappAdviceBtn.href = `https://wa.me/5491100000000?text=${msg}`;
  }

  // Quantity and Actions
  const qtyInput = document.getElementById('productDetailQty');
  const qtyMinusBtn = document.getElementById('qtyMinusBtn');
  const qtyPlusBtn = document.getElementById('qtyPlusBtn');
  const addToCartBtn = document.getElementById('productAddToCartBtn');
  const buyNowBtn = document.getElementById('productBuyNowBtn');

  if (qtyMinusBtn && qtyInput) {
    qtyMinusBtn.onclick = () => {
      let val = parseInt(qtyInput.value) || 1;
      if (val > 1) qtyInput.value = val - 1;
    };
  }

  if (qtyPlusBtn && qtyInput) {
    qtyPlusBtn.onclick = () => {
      let val = parseInt(qtyInput.value) || 1;
      if (val < 99) qtyInput.value = val + 1;
    };
  }

  if (addToCartBtn) {
    addToCartBtn.onclick = () => {
      const q = parseInt(qtyInput ? qtyInput.value : 1) || 1;
      hmcAddToCart(prod.id, q);
    };
  }

  if (buyNowBtn) {
    buyNowBtn.onclick = () => {
      const q = parseInt(qtyInput ? qtyInput.value : 1) || 1;
      hmcAddToCart(prod.id, q);
      window.location.href = 'cart.html';
    };
  }

  // Product Tabs Switcher
  const tabButtons = document.querySelectorAll('.product-tab-btn');
  const tabPanels = document.querySelectorAll('.product-tab-panel');
  tabButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      tabButtons.forEach(b => b.classList.remove('active'));
      tabPanels.forEach(p => p.classList.remove('active'));
      btn.classList.add('active');
      const targetId = btn.dataset.tab;
      const targetPanel = document.getElementById(targetId);
      if (targetPanel) targetPanel.classList.add('active');
    });
  });

  // Related Products
  const relatedGrid = document.getElementById('relatedProductsGrid');
  if (relatedGrid) {
    const related = PRODUCT_CATALOG.filter(p => p.category === prod.category && p.id !== prod.id).slice(0, 4);
    const fallback = related.length ? related : PRODUCT_CATALOG.filter(p => p.id !== prod.id).slice(0, 4);
    
    relatedGrid.innerHTML = fallback.map(item => `
      <div class="product-card">
        <div class="product-badge-group">
          ${item.discount ? `<span class="badge badge-discount">-${item.discount}% OFF</span>` : ''}
          ${item.freeShipping ? `<span class="badge badge-shipping"><i class="fa-solid fa-truck-fast"></i> Envío Gratis</span>` : ''}
        </div>
        <div class="product-image-box">
          <a href="product.html?id=${item.id}">
            <img src="${item.image}" alt="${item.name}" class="product-img">
          </a>
        </div>
        <div class="product-details">
          <div class="product-brand">${item.brand}</div>
          <h4 class="product-name"><a href="product.html?id=${item.id}">${item.name}</a></h4>
          <div class="product-price-box">
            <div>
              <span class="price-current">${formatCurrency(item.price)}</span>
            </div>
          </div>
          <button class="btn btn-primary btn-add-to-cart" onclick="hmcAddToCart(${item.id})">
            <i class="fa-solid fa-cart-plus"></i> Comprar
          </button>
        </div>
      </div>
    `).join('');
  }

  // Mobile Sticky Bottom Buy Bar
  const stickyBuyBar = document.getElementById('mobileStickyBuyBar');
  const stickyImg = document.getElementById('stickyBuyBarImg');
  const stickyTitle = document.getElementById('stickyBuyBarTitle');
  const stickyPrice = document.getElementById('stickyBuyBarPrice');
  const stickyBtn = document.getElementById('stickyBuyBarBtn');

  if (stickyBuyBar && prod) {
    if (stickyImg) stickyImg.src = prod.image;
    if (stickyTitle) stickyTitle.textContent = prod.name;
    if (stickyPrice) stickyPrice.textContent = formatCurrency(prod.price);
    if (stickyBtn) {
      stickyBtn.onclick = () => {
        hmcAddToCart(prod.id, 1);
      };
    }

    window.addEventListener('scroll', () => {
      if (window.scrollY > 380 && window.innerWidth <= 768) {
        stickyBuyBar.classList.add('active');
      } else {
        stickyBuyBar.classList.remove('active');
      }
    }, { passive: true });
  }
}

/* --------------------------------------------------------------------------
   8. Dedicated Full Cart Page Engine (cart.html)
   -------------------------------------------------------------------------- */
let appliedCoupon = null;

function initCartPage() {
  renderFullCartPage();

  const couponInput = document.getElementById('cartCouponInput');
  const couponBtn = document.getElementById('cartApplyCouponBtn');

  if (couponBtn && couponInput) {
    couponBtn.addEventListener('click', () => {
      const code = couponInput.value.trim().toUpperCase();
      if (code === 'BIENVENIDO-HMC' || code === 'HMC10') {
        appliedCoupon = { code: code, discountPct: 10 };
        showToast('🎉 ¡Cupón aplicado! 10% de descuento en tu compra.');
        renderFullCartPage();
      } else if (code === 'HMCPRO') {
        appliedCoupon = { code: code, discountPct: 15 };
        showToast('🎉 ¡Cupón PRO aplicado! 15% de descuento especial.');
        renderFullCartPage();
      } else {
        showToast('El cupón ingresado no es válido o está vencido.');
      }
    });
  }
}

function renderFullCartPage() {
  const tableBody = document.getElementById('cartPageTableBody');
  const emptyBox = document.getElementById('cartPageEmptyState');
  const contentLayout = document.getElementById('cartPageContentGrid');
  const subtotalEl = document.getElementById('cartPageSubtotal');
  const discountRow = document.getElementById('cartPageDiscountRow');
  const discountValEl = document.getElementById('cartPageDiscountVal');
  const totalEl = document.getElementById('cartPageTotalFinal');
  const freeShipBar = document.getElementById('cartPageShippingProgress');
  const freeShipMsg = document.getElementById('cartPageShippingMsg');
  const crossSellContainer = document.getElementById('cartCrossSellGrid');

  updateCartBadges();

  if (cart.length === 0) {
    if (emptyBox) emptyBox.style.display = 'block';
    if (contentLayout) contentLayout.style.display = 'none';
    return;
  }

  if (emptyBox) emptyBox.style.display = 'none';
  if (contentLayout) contentLayout.style.display = 'grid';

  let subtotal = 0;
  let rowsHtml = '';

  cart.forEach(item => {
    const prod = PRODUCT_CATALOG.find(p => p.id === item.id);
    if (!prod) return;
    const itemTotal = prod.price * item.qty;
    subtotal += itemTotal;

    rowsHtml += `
      <tr>
        <td>
          <div class="cart-product-cell">
            <img src="${prod.image}" alt="${prod.name}" class="cart-product-img">
            <div class="cart-product-meta">
              <h4><a href="product.html?id=${prod.id}">${prod.name}</a></h4>
              <span>Marca: <strong>${prod.brand}</strong> | SKU: ${prod.sku}</span>
            </div>
          </div>
        </td>
        <td style="font-weight: 600;">${formatCurrency(prod.price)}</td>
        <td>
          <div class="qty-selector">
            <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, -1)">-</button>
            <span class="qty-val">${item.qty}</span>
            <button class="qty-btn" onclick="hmcUpdateQty(${prod.id}, 1)">+</button>
          </div>
        </td>
        <td style="font-weight: 700; color: var(--color-primary); font-size: 1.05rem;">
          ${formatCurrency(itemTotal)}
        </td>
        <td>
          <button class="cart-item-remove" onclick="hmcRemoveItem(${prod.id})" title="Eliminar ítem">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </td>
      </tr>
    `;
  });

  if (tableBody) tableBody.innerHTML = rowsHtml;
  if (subtotalEl) subtotalEl.textContent = formatCurrency(subtotal);

  // Apply discount if coupon present
  let discountAmount = 0;
  if (appliedCoupon) {
    discountAmount = Math.round(subtotal * (appliedCoupon.discountPct / 100));
    if (discountRow) discountRow.style.display = 'flex';
    if (discountValEl) discountValEl.textContent = `-${formatCurrency(discountAmount)} (${appliedCoupon.discountPct}%)`;
  } else {
    if (discountRow) discountRow.style.display = 'none';
  }

  const grandTotal = subtotal - discountAmount;
  if (totalEl) totalEl.textContent = formatCurrency(grandTotal);

  // Free shipping progress
  if (freeShipBar && freeShipMsg) {
    const progress = Math.min(100, Math.round((subtotal / FREE_SHIPPING_THRESHOLD) * 100));
    freeShipBar.style.width = `${progress}%`;
    if (subtotal >= FREE_SHIPPING_THRESHOLD) {
      freeShipMsg.innerHTML = `🎉 <strong>¡Tenés Envío Gratis garantizado en todo el país!</strong>`;
    } else {
      const remaining = FREE_SHIPPING_THRESHOLD - subtotal;
      freeShipMsg.innerHTML = `Sumá <strong>${formatCurrency(remaining)}</strong> más a tu compra para obtener <strong>Envío Gratis</strong>`;
    }
  }

  // Cross Sell Strip
  if (crossSellContainer) {
    const crossSellCandidates = PRODUCT_CATALOG.filter(p => !cart.some(c => c.id === p.id)).slice(0, 3);
    crossSellContainer.innerHTML = crossSellCandidates.map(p => `
      <div class="product-card" style="box-shadow: none; border: 1px solid var(--color-gray-border);">
        <div class="product-image-box" style="height: 160px;">
          <img src="${p.image}" alt="${p.name}" class="product-img">
        </div>
        <div class="product-details" style="padding: 14px;">
          <h4 style="font-size: 0.88rem; margin-bottom: 6px;"><a href="product.html?id=${p.id}">${p.name.substring(0, 38)}...</a></h4>
          <span style="color: var(--color-primary); font-weight: 700;">${formatCurrency(p.price)}</span>
          <button class="btn btn-dark btn-sm" style="margin-top: 10px; width: 100%; font-size: 0.82rem;" onclick="hmcAddToCart(${p.id})">
            <i class="fa-solid fa-plus"></i> Sumar al pedido
          </button>
        </div>
      </div>
    `).join('');
  }
}

/* --------------------------------------------------------------------------
   9. Contact Page Engine (contact.html)
   -------------------------------------------------------------------------- */
function initContactPage() {
  const faqQuestions = document.querySelectorAll('.faq-question');
  faqQuestions.forEach(q => {
    q.addEventListener('click', () => {
      const item = q.parentElement;
      item.classList.toggle('active');
    });
  });

  const contactForm = document.getElementById('contactInquiryForm');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      showToast('🎉 ¡Consulta enviada con éxito! Un asesor técnico se comunicará a la brevedad.');
      contactForm.reset();
    });
  }
}

/* --------------------------------------------------------------------------
   10. Postal Code Shipping Calculator Helper
   -------------------------------------------------------------------------- */
function initShippingCalculator() {
  window.hmcCalcShipping = function(targetBoxId = 'shippingResultBox', inputId = 'shippingCpInput') {
    const cpInput = document.getElementById(inputId);
    const cp = cpInput ? cpInput.value.trim() : '';
    const resultBox = document.getElementById(targetBoxId);
    
    if (!cp || cp.length < 4) {
      showToast('Ingresá un código postal válido de 4 dígitos');
      return;
    }
    
    if (resultBox) {
      resultBox.innerHTML = `
        <div style="padding: 12px; background: #e8f5e9; border-radius: 6px; border: 1px solid #c8e6c9; margin-top: 10px; font-size: 0.85rem;">
          <div style="color: #2e7d32; font-weight: 700; margin-bottom: 4px;"><i class="fa-solid fa-truck-fast"></i> Opciones de entrega para CP ${cp}:</div>
          <div>• <strong>Envío Estándar a Domicilio:</strong> $4.200 (Llega en 48-72 hs hábiles)</div>
          <div>• <strong>Envío Exprés con Puesta en Marcha:</strong> $6.500 (Llega en 24-48 hs)</div>
          <div>• <strong>Retiro en Sucursal Central Zárate / Munro:</strong> <span style="color: #2e7d32; font-weight: 700;">¡GRATIS! (Listo en 2 hs)</span></div>
        </div>
      `;
    }
  };
}

/* --------------------------------------------------------------------------
   11. Newsletter Form Handler
   -------------------------------------------------------------------------- */
function initNewsletter() {
  const forms = document.querySelectorAll('.newsletter-form');
  forms.forEach(form => {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const input = form.querySelector('input[type="email"]');
      if (input && input.value.includes('@')) {
        showToast('🎉 ¡Gracias por suscribirte! Te enviamos tu cupón BIENVENIDO-HMC del 10% por email.');
        input.value = '';
      } else {
        showToast('Por favor, ingresá un email válido');
      }
    });
  });
}

/* --------------------------------------------------------------------------
   12. Mobile Off-Canvas Drawer Menu & Navigation System
   -------------------------------------------------------------------------- */
function initMobileMenu() {
  const openButtons = document.querySelectorAll('.js-open-mobile-menu, #mobileMenuToggle, #mobileDrawerOpenBtn');
  const drawer = document.getElementById('mobileDrawerMenu');
  const overlay = document.getElementById('mobileDrawerOverlay');
  const closeBtn = document.getElementById('mobileDrawerClose');
  const drawerSearchForm = document.getElementById('mobileDrawerSearchForm');
  const drawerSearchInput = document.getElementById('mobileDrawerSearchInput');

  function openDrawer() {
    if (!drawer || !overlay) return;
    drawer.classList.add('active');
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeDrawer() {
    if (!drawer || !overlay) return;
    drawer.classList.remove('active');
    overlay.classList.remove('active');
    document.body.style.overflow = '';
  }

  openButtons.forEach(btn => btn.addEventListener('click', (e) => {
    e.preventDefault();
    openDrawer();
  }));

  if (closeBtn) closeBtn.addEventListener('click', closeDrawer);
  if (overlay) overlay.addEventListener('click', closeDrawer);

  // Drawer Category Accordion
  const accordionHeaders = document.querySelectorAll('.js-drawer-accordion');
  accordionHeaders.forEach(header => {
    header.addEventListener('click', () => {
      const content = header.nextElementSibling;
      const icon = header.querySelector('i.fa-chevron-down');
      if (content) {
        content.classList.toggle('active');
        if (icon) {
          icon.style.transform = content.classList.contains('active') ? 'rotate(180deg)' : 'rotate(0deg)';
          icon.style.transition = 'transform 0.2s ease';
        }
      }
    });
  });

  if (drawerSearchForm && drawerSearchInput) {
    drawerSearchForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const q = drawerSearchInput.value.trim();
      if (q) {
        window.location.href = `catalog.html?q=${encodeURIComponent(q)}`;
      }
    });
  }
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
