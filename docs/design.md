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

- **Quedora** (variable, pesos *semibold* y *medium*) — tipografía nombrada explícitamente en el manual, de estilo geométrico/técnico (misma familia usada en el logotipo). Se muestra en mayúsculas y minúsculas.
- El manual incluye además una muestra "Aa" en gris, sin nombre de fuente asociado — presumiblemente pensada como tipografía complementaria para texto de cuerpo, pero no está identificada. **Pendiente de confirmar con el cliente/diseñador** qué tipografía usar para body copy si no se quiere usar Quedora para todo (Quedora, por su estilo display/condensado, es más apta para títulos y logotipo que para párrafos largos).

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
- `font_headings`: Quedora (si está disponible como web font; si no, buscar geométrica condensada similar)
- `font_rest`: pendiente de definición (ver punto 3)
