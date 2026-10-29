# Feedback del Cliente — 2026-10-20

Revisión del cliente sobre la versión actual del tema en `web_ftp/`. Estado: **pendiente**.

Todo cambio visual debe implementarse también en su versión mobile (ver regla Mobile-First en `CLAUDE.md`).

## Tema (`web_ftp/`)

### Promociones y precios

- [x] **Descuento del 5% por transferencia bancaria en todos los productos.** Comunicarlo en:
  - el marquee de la topbar (`snipplets/header/header-advertising.tpl`), en ambas copias del track (la visible y la `aria-hidden`);
  - la ficha de producto, junto al precio;
  - el checkout.

### Stock

- [x] Mostrar indicadores de stock **cualitativos** ("Hay stock" / "Sin stock") en lugar de cantidades.

### Contacto y sucursal

- [x] Actualizar la dirección a **Av. Circunvalación Santiago Marzo (Norte) 171** en todos los lugares donde aparece (contacto, footer, sucursal, etc.).
- [x] Corregir el mapa de la sección de contacto para que muestre la nueva dirección.

### Preguntas frecuentes (contacto)

- [x] **"¿Cuentan con repuestos originales de las marcas que comercializan?"**: actualizar la respuesta con las marcas de las que HMC es efectivamente Service Oficial. Según `docs/feedback_cliente.md`: Echo, Toro, Honda, Husqvarna, Sensei, Kohler y Briggs & Stratton (a confirmar con el cliente).
- [x] **"¿Hacen envíos de generadores y maquinaria pesada a todo el país?"**: quitar la oración sobre envío gratis en compras mayores a $300.000. No hay envío gratis.

### Footer — Botón de arrepentimiento

- [ ] **A consultar:** hoy el botón lleva a la página de contacto. ¿Es suficiente? La normativa argentina (Res. 424/2020) exige un acceso directo y fácil para que el cliente pueda arrepentirse de la compra, y que la tienda le informe un código de identificación de la solicitud. Evaluar un formulario o página dedicada en lugar del contacto genérico.

### Header (mobile)

- [x] **Bug:** el ícono de la lupa del header no responde al tocarlo en mobile.

### Marcas

- [ ] Corregir los logos de las marcas. El cliente compartió una carpeta de Google Drive con los logos oficiales; usar esos archivos.
- [x] Agregar botones de flecha a ambos lados del marquee de marcas en la home para desplazarlo manualmente. Hoy hay que esperar a que la marca buscada aparezca en pantalla para poder seleccionarla.

### Nosotros

- [ ] Reemplazar la foto del equipo (la pareja) por otra imagen.

### Búsqueda

- [x] Al hacer una búsqueda no aparecen las categorías en la columna izquierda. Deben mostrarse igual que en el catálogo.

### Filtros (mobile)

- [x] **Bug:** en el modal de filtros, al marcar el checkbox de una marca se deshabilitan todos los demás y no se pueden seleccionar varias marcas a la vez. Debe permitir selección múltiple.

## Configuración de la tienda (admin / integraciones)

Pendientes que no dependen del código del tema:

- [ ] Configurar las opciones de pago en Mercado Pago.
- [ ] Configurar Andreani como método de envío. Es la app nueva de Andreani, en la categoría Logística. Requisitos:
  - Datos de facturación de la tienda completos.
  - Peso y medidas cargados en todos los productos; sin eso, Andreani no aparece en el checkout.
  - Usuario y contraseña de Andreani de HMC.

  Pedir también a HMC si tienen cuenta corriente con Andreani y qué modalidades quieren ofrecer: Estándar, Sucursal, Llega hoy o Bigger (para maquinaria pesada). Conviene hacerlo después de Finnegans, por si el ERP trae el peso y las medidas.
- [ ] Conectar Finnegans con Tiendanube. **Bloqueado (2026-10-28), esperando al soporte de Finnegans:**
  - Se instaló la app "Finnegans" desde la Tienda de Aplicaciones de Tiendanube. Al iniciar sesión en Finnegans GO, en el espacio de trabajo `HMCMAQUINAS`, apareció el mensaje "Debe seleccionar una opción de menú donde instalar la aplicación" y la instalación no se completó. La app no figura en Mis aplicaciones de Tiendanube.
  - En Finnegans GO, en Administrar → Plug & Go, aparece "Tienda Nube", pero la pantalla de configuración queda vacía. La consola del navegador repite el error `TypeError: Cannot read properties of undefined (reading 'templateId')`: Finnegans no encuentra la configuración de la integración para la cuenta.
  - Próximo paso: el soporte de Finnegans o el implementador de HMC tiene que revisar si la integración está habilitada para la cuenta y completar la instalación.
  - Antes de activar la sincronización, definir con Finnegans qué sistema manda en cada dato (stock, precios, alta de productos), para no pisar lo cargado en la tienda. Confirmar también si el ERP tiene cargados el peso y las medidas de los productos, que necesita Andreani.
- [x] Conectar Instagram (2026-10-28). Las publicaciones ya se ven en la sección "Comunidad" del home y en la página Nosotros.
  - **Cómo se conectó:** con una app en Meta Developers, usando la API con inicio de sesión con Instagram y la cuenta de HMC como evaluadora. El token está cargado en Tiendanube, en Tienda online → Link de redes sociales → "Token de Instagram".
  - **⚠️ El token vence a los 60 días, cerca del 2026-12-27.** Cuando vence, las publicaciones dejan de verse sin aviso. Para renovarlo, entrar en Meta Developers → la app → Casos de uso → Personalizar → "2. Genera identificadores de acceso" → **Generar identificador**, y pegar el token nuevo en Tiendanube.
- [x] Conectar Google Analytics 4 (GA4) y Meta Pixel. GA4 está cargado por la integración nativa de Tiendanube (Configuración → Códigos externos, con ID de medición y secreto de Measurement Protocol). Meta está conectado por Canales de venta → Instagram y Facebook, que activa también la API de Conversiones. No se usa Google Tag Manager.
- [ ] Conectar Google Ads. **En curso:** Google Shopping (Merchant Center) ya está conectado desde Más canales de venta → Google Shopping. La etiqueta de conversión de compra la crea esa integración; no se cargan códigos externos ni Tag Manager. El inicio de sesión de Google se destrabó desactivando por 10 minutos la verificación de acceso desde la consola de Workspace. Falta completar la facturación de la cuenta de Google Ads con estos datos, que tiene que pasar HMC:
  - CUIT de la razón social que recibe las facturas.
  - Condición frente al IVA.
  - Campo "GRT": a confirmar qué dato pide.
  - Medio de pago: tarjeta de la empresa, que conviene que cargue alguien de HMC.

  El tipo de cuenta debe ser **Empresa**. Los datos fiscales no se pueden cambiar una vez guardados.
- [ ] Activar protecciones contra el robo de datos (copia de contenido, scraping).
- [ ] Actualizar el nombre "hmchub" en Google (perfil de empresa / resultados de búsqueda).
