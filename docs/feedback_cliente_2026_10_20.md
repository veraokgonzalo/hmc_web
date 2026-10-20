# Feedback del Cliente — 2026-10-20

Revisión del cliente sobre la versión actual del tema en `web_ftp/`. Estado: **pendiente**.

Todo cambio visual debe implementarse también en su versión mobile (ver regla Mobile-First en `CLAUDE.md`).

## Tema (`web_ftp/`)

### Promociones y precios

- [ ] **Descuento del 5% por transferencia bancaria en todos los productos.** Comunicarlo en:
  - el marquee de la topbar (`snipplets/header/header-advertising.tpl`), en ambas copias del track (la visible y la `aria-hidden`);
  - la ficha de producto, junto al precio;
  - el checkout.

### Stock

- [ ] Mostrar indicadores de stock **cualitativos** ("Hay stock" / "Sin stock") en lugar de cantidades.

### Contacto y sucursal

- [ ] Actualizar la dirección a **Av. Circunvalación Santiago Marzo (Norte) 171** en todos los lugares donde aparece (contacto, footer, sucursal, etc.).
- [ ] Corregir el mapa de la sección de contacto para que muestre la nueva dirección.

### Preguntas frecuentes (contacto)

- [ ] **"¿Cuentan con repuestos originales de las marcas que comercializan?"**: actualizar la respuesta con las marcas de las que HMC es efectivamente Service Oficial. Según `docs/feedback_cliente.md`: Echo, Toro, Honda, Husqvarna, Sensei, Kohler y Briggs & Stratton (a confirmar con el cliente).
- [ ] **"¿Hacen envíos de generadores y maquinaria pesada a todo el país?"**: quitar la oración sobre envío gratis en compras mayores a $300.000. No hay envío gratis.

### Footer — Botón de arrepentimiento

- [ ] **A consultar:** hoy el botón lleva a la página de contacto. ¿Es suficiente? La normativa argentina (Res. 424/2020) exige un acceso directo y fácil para que el cliente pueda arrepentirse de la compra, y que la tienda le informe un código de identificación de la solicitud. Evaluar un formulario o página dedicada en lugar del contacto genérico.

### Header (mobile)

- [ ] **Bug:** el ícono de la lupa del header no responde al tocarlo en mobile.

### Marcas

- [ ] Corregir los logos de las marcas. El cliente compartió una carpeta de Google Drive con los logos oficiales; usar esos archivos.
- [ ] Agregar botones de flecha a ambos lados del marquee de marcas en la home para desplazarlo manualmente. Hoy hay que esperar a que la marca buscada aparezca en pantalla para poder seleccionarla.

### Nosotros

- [ ] Reemplazar la foto del equipo (la pareja) por otra imagen.

### Búsqueda

- [ ] Al hacer una búsqueda no aparecen las categorías en la columna izquierda. Deben mostrarse igual que en el catálogo.

### Filtros (mobile)

- [ ] **Bug:** en el modal de filtros, al marcar el checkbox de una marca se deshabilitan todos los demás y no se pueden seleccionar varias marcas a la vez. Debe permitir selección múltiple.

## Configuración de la tienda (admin / integraciones)

Pendientes que no dependen del código del tema:

- [ ] Configurar las opciones de pago en Mercado Pago.
- [ ] Configurar Andreani como método de envío.
- [ ] Conectar Finnegans con Tiendanube.
- [ ] Conectar Instagram.
- [ ] Conectar Google Analytics 4 (GA4) y Meta Pixel.
- [ ] Conectar Google Ads.
- [ ] Activar protecciones contra el robo de datos (copia de contenido, scraping).
- [ ] Actualizar el nombre "hmchub" en Google (perfil de empresa / resultados de búsqueda).
