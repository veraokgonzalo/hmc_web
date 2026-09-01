# Manual de marca — HMC Hub

Extracto de reglas de diseño para uso durante el desarrollo del tema Tiendanube. Fuente: `assets/Manual de marca HMC HUB.pdf` (Brandbook, TRASMEDIA, Agosto 2026).

> Nota: las páginas 3, 10 y 17 del PDF son separadores de sección con texto de plantilla ("Lorem ipsum") sin reemplazar por el diseñador — no aportan contenido, se ignoran acá.

## 1. Logo

**Elementos:** isotipo (hoja/planta estilizada dentro de un cuadrado con esquinas redondeadas, en verde de marca) + logotipo "HMC" (trazo grueso) "Hub" (trazo más fino, en gris).

**Variaciones:**
- **Horizontal** — isotipo a la izquierda, "HMC Hub" a la derecha. Versión principal.
- **Vertical** — isotipo arriba, "HMC" / "Hub" apilados debajo, centrados.
- **Circular** — isotipo al centro, "HMC HUB" en arco alrededor. Pensada para avatares/redes sociales.

**Área de seguridad:** debe respetarse un margen libre alrededor del logo (en las tres variaciones) donde ningún otro elemento gráfico, tipografía o imagen puede invadir el signo marcario. El manual lo ilustra con marcadores en los bordes pero no da una medida numérica exacta — a confirmar con el cliente si se necesita un valor en píxeles/porcentaje para casos límite (ej. header angosto en mobile).

**Usos correctos — fondos admitidos:**
| Fondo | Tratamiento del logo |
|---|---|
| Verde de marca (`#3FAA47`) | Versión monocromática blanca (isotipo y texto en blanco) |
| Negro (`#000000`) | Isotipo en verde, texto en blanco |
| Gris oscuro (`#494848`) | Isotipo en verde, texto en blanco |
| Gris claro (`#CCCCCC`) | Isotipo en verde, texto en negro |
| Blanco / fondos claros | Isotipo en verde, "HMC" en negro, "Hub" en gris oscuro (versión a color, por defecto) |

**Usos incorrectos (prohibido):**
- Editar, rehacer o alterar el logotipo de cualquier forma (recomponer el orden de los elementos, separar el isotipo del texto de forma no prevista, etc.).
- Rotarlo (solo se permite a 90°) o deformarlo/escalarlo de forma no proporcional.

## 2. Colores

Paleta de marca, 4 colores:

| Color | HEX | Uso |
|---|---|---|
| Verde primario | `#3FAA47` | Color de marca, isotipo, acentos, CTAs |
| Negro | `#000000` | Texto principal / fondos oscuros |
| Gris oscuro | `#494848` | Texto secundario / fondos oscuros alternativos |
| Gris claro | `#CCCCCC` | Fondos neutros claros / elementos secundarios |

No se define un color de error/éxito/advertencia ni una escala de tintes (tints/shades) — para estados de UI (badges, alerts, precios tachados, etc.) que no cubre la paleta, definir criterio propio manteniendo la sobriedad de la paleta (evitar colores saturados ajenos a esta lista salvo necesidad funcional, ej. rojo para errores).

## 3. Tipografía

- **Quedora** (variable, pesos *regular*, *medium*, *semibold*, *bold*, *extrabold*) — tipografía principal nombrada explícitamente en el manual de marca, de estilo geométrico/técnico (misma familia usada en el logotipo). Se utiliza para encabezados principales, títulos de secciones (`h1`, `h2`, `h3`), logotipos y elementos display.
- **Plus Jakarta Sans** (pesos *medium (500)*, *semibold (600)*, *bold (700)*, *extrabold (800)* y variantes itálicas) — **tipografía secundaria oficial del proyecto** (ubicada en `boceto_web/assets/fonts/`). Diseñada para máxima legibilidad en texto de cuerpo (*body copy*), fichas técnicas, subtítulos, navegación, botones, inputs y UI en general. Reemplaza a las fuentes genéricas y brinda una presencia moderna, técnica y sobria alineada al rubro industrial.

## 4. Estilo fotográfico

Principio rector: **HMC no compite por precio, compite por respaldo técnico, trayectoria y asesoramiento** — esto tiene que verse en la foto, no solo decirse en el texto.

**Implicancia para el tema:** las fotos de producto que suba el cliente (o placeholders mientras tanto) deberían priorizar imágenes de uso real/contexto de obra sobre packshots de estudio, cuando el catálogo lo permita. Esto es una guía de curaduría de contenido, no algo que el tema pueda forzar por código.

## 5. Aplicaciones (referencia)

El manual muestra mockups de merchandising y redes ya usando las reglas anteriores, sin agregar reglas nuevas:
- Remera: logo horizontal chico en pecho, isotipo grande centrado en espalda.
- Perfil de Instagram: logo circular como avatar.
- Hojas membretadas: logo horizontal en encabezado.

## Resumen rápido para el tema (settings del editor)

Para cargar en `config/settings.txt` / `config/defaults.txt`:

- `background_color`: `#FFFFFF` (o `#CCCCCC` si se prefiere un fondo neutro gris claro)
- `text_color`: `#000000` (texto principal) — usar `#494848` para texto secundario/atenuado
- `accent_color` / color de botones y CTAs: `#3FAA47`
- `font_headings`: Quedora (fallback: Plus Jakarta Sans / Chakra Petch / Montserrat / sans-serif)
- `font_rest`: Plus Jakarta Sans (fallback: Inter / system-ui / sans-serif)

## 6. Reglas de Diseño Mobile-First & Responsividad Obligatoria (Memory Bank)

**Regla Mandatoria del Proyecto:**
Cada vez que se cree, modifique o refactorice un componente (en el prototipo `boceto_web/` o en las plantillas de Tiendanube `web_ftp/`), **es obligatorio diseñar e implementar su comportamiento móvil de forma simultánea**.

### Estándares de Experiencia Móvil:
1. **Breakpoints Oficiales:**
   - Desktop amplio: $\ge 1200\text{px}$
   - Tablet / Laptop compacta: $769\text{px} - 1024\text{px}$
   - Mobile estándar: $\le 768\text{px}$
   - Mobile compacto: $\le 480\text{px}$
2. **Navegación y Menús:**
   - Todo mega-menú de escritorio (como Categorías o el Directorio de 103 Marcas) debe mapearse a su versión táctil en el `#mobileDrawerMenu` mediante acordeones colapsables (`.js-drawer-accordion`).
   - Mantener siempre visible la barra de navegación inferior fija estilo app (`.mobile-bottom-nav`) con acceso a *Inicio*, *Catálogo*, *Asesoría WhatsApp*, *Carrito con contador reactivo* y *Menú*.
3. **Áreas de Toque (Touch Targets):**
   - Todos los botones, enlaces interactivos e inputs deben tener una altura/área táctil mínima de **44px** y separación adecuada para evitar toques erróneos.
4. **Grillas y Layouts:**
   - Grilla de productos en móvil: 2 columnas compactas con tipografía adaptada y sin desbordes horizontales.
   - Tablas de carrito: Transformación automática a tarjetas verticales individuales.
   - Filtros laterales: Conversión a hoja deslizable / Bottom Sheet táctil.
