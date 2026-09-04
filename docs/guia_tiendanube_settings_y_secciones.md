# Guía Técnica: Edición y Creación de Variables y Secciones en Tiendanube (Legacy)

Esta guía documenta en detalle cómo funciona el motor de configuración del tema de Tiendanube en arquitectura **Legacy** (pre-Nimbus), cómo agregar nuevas variables al panel de administración (**"Personalizar diseño"**), cómo consumirlas en las plantillas `.tpl` (Twig) y cómo crear nuevas secciones configurables en la tienda.

---

## 1. Concepto Fundamental: Código (`static/`) vs. Contenido del Administrador (`settings`)

Uno de los puntos más frecuentes de confusión en Tiendanube es la diferencia entre **archivos estáticos del tema** y **datos cargados por el usuario en el panel**:

| Concepto | Dónde reside | Cómo se sube | Cómo se consume en `.tpl` | ¿Aparece en el editor de diseño? |
| :--- | :--- | :--- | :--- | :--- |
| **Archivos Estáticos** | Carpeta `static/` (CSS, JS, imágenes base, iconos SVG) | Vía **FTP** (`tiendanube theme ftp push`) | `{{ 'images/logo.svg' \| static_url }}` | **NO**. Es código fuente del tema. |
| **Variables del Editor** | Base de datos de Tiendanube (`settings.*`) | El usuario los carga en **Personalizar diseño** | `{{ settings.mi_variable }}` | **SÍ**. Definidos en `config/settings.txt`. |
| **Galerías del Editor** | Base de datos + almacenamiento de medios | El usuario sube imágenes en el panel | `{% for item in settings.mi_galeria %}` | **SÍ**. Los archivos los procesa la CDN de Tiendanube. |

> [!IMPORTANT]
> **¿Por qué las imágenes subidas por FTP no aparecen en la galería de Marcas del editor?**
> Porque la galería del editor (`gallery` con `name = brands`) es una tabla de base de datos donde el cliente sube sus propias imágenes a través de la interfaz web. La carpeta `static/images/brands/` es código del tema.
>
> En la plantilla `home-brands.tpl`, se configuró un **mecanismo dual**:
> - Si el administrador carga marcas en el panel $\rightarrow$ se usan esas (`settings.brands`).
> - Si la galería del panel está vacía $\rightarrow$ se toman automáticamente las 21 marcas oficiales de `static/images/brands/`.

---

## 2. Los Archivos de Configuración (`config/`)

En los temas Legacy, la interfaz del personalizador de diseño se define mediante archivos de texto plano estructurados por **indentación con tabulaciones** (`\t`):

* **`config/settings.txt`**: Define el formulario del personalizador (secciones, acordeones, campos, selectores, colores, imágenes).
* **`config/defaults.txt`**: Define los valores iniciales o por defecto para cada variable (clave = valor).
* **`config/translations.txt`**: Traducciones de las etiquetas del personalizador a español, portugués e inglés.

---

## 3. Catálogo de Campos en `config/settings.txt`

Todos los campos en `settings.txt` siguen esta convención de indentación:

```
tipo_de_campo
	name = nombre_de_la_variable
	description = Etiqueta visible en el editor
```

### 3.1. Texto Corto (`i18n_input` o `input`)
Permite ingresar una línea de texto. `i18n_input` crea un campo por cada idioma activo en la tienda:

```
i18n_input
	name = mi_seccion_titulo
	description = Título de la sección
```

### 3.2. Texto Largo (`i18n_textarea` o `textarea`)
Para párrafos, descripciones o bloques de texto multilínea:

```
i18n_textarea
	name = mi_seccion_descripcion
	description = Descripción detallada
```

### 3.3. Casilla de Verificación (`checkbox`)
Para activar o desactivar funciones (devuelve `true` o `false`):

```
checkbox
	name = mi_seccion_mostrar
	description = Mostrar esta sección en la página de inicio
```

### 3.4. Selector Desplegable (`dropdown`)
Para opciones predefinidas. Cada opción se declara bajo el bloque `values` en formato `clave = Etiqueta visible`:

```
dropdown
	name = mi_seccion_formato
	description = Formato de visualización:
	values
		grid = Cuadrícula (Grilla)
		carousel = Carrusel deslizable
		marquee = Marquesina continua
```

### 3.5. Selector de Color (`color`)
Muestra el color picker nativo de Tiendanube:

```
color
	name = mi_seccion_bg_color
	description = Color de fondo
```

### 3.6. Subida de Imagen Individual (`image`)
Permite al usuario subir una imagen fija para la sección:

```
image
	name = mi_banner_destacado.jpg
	description = Imagen del banner principal
	width = 1200
	height = 400
```

### 3.7. Galería Repetible (`gallery`)
Permite al usuario agregar múltiples imágenes con links opcionales (ideal para sliders, marcas, banners en carrusel):

```
gallery
	name = mis_logos
	gallery_image = Agregar logo
	gallery_link = [Opcional] Enlace al hacer clic
	gallery_width = 300
	gallery_height = 150
```

### 3.8. Selector de Tipografía (`font`)
Ofrece el catálogo de tipografías web de Tiendanube:

```
font
	name = mi_fuente_titulos
	description = Tipografía de títulos
```

---

## 4. Agrupamiento y Estructuración de Secciones en el Editor

Para organizar los campos en el panel lateral de Tiendanube se usan directivas de bloque:

### 4.1. Acordeón Colapsable (`collapse`)
Agrupa campos dentro de un panel desplegable:

```
title
	title = Página de inicio
collapse
	title = Sección de Novedades
	backto = home_order_position

	checkbox
		name = novedades_activas
		description = Mostrar novedades

	i18n_input
		name = novedades_titulo
		description = Título del bloque
```

* `title`: Crea un encabezado de grupo mayor.
* `collapse`: Crea el acordeón desplegable.
* `backto = home_order_position`: Agrega un botón de navegación rápida para volver al reordenador de secciones del home.

---

## 5. Definir Valores por Defecto (`config/defaults.txt`)

Siempre que se crea una nueva variable en `settings.txt`, es **obligatorio** declarar su valor por defecto en `defaults.txt`. Esto evita que la tienda genere valores nulos o cadenas vacías antes de que el cliente guarde el diseño:

```ini
# En config/defaults.txt
mi_seccion_mostrar = 1
mi_seccion_formato = marquee
mi_seccion_bg_color = #F4F4F4
mi_seccion_titulo = Nuestras Marcas
```

---

## 6. Cómo Usar las Variables en las Plantillas Twig (`.tpl`)

Todas las variables declaradas quedan disponibles en el array global `settings`.

### 6.1. Textos y Títulos
```twig
{% if settings.mi_seccion_titulo %}
    <h2 class="section-title">{{ settings.mi_seccion_titulo }}</h2>
{% endif %}
```

### 6.2. Condicionales y Checkboxes
```twig
{% if settings.mi_seccion_mostrar %}
    <section class="mi-seccion">
        ...
    </section>
{% endif %}
```

### 6.3. Selectores Desplegables (`dropdown`)
```twig
{% if settings.mi_seccion_formato == 'marquee' %}
    {# Renderizar marquesina #}
{% elseif settings.mi_seccion_formato == 'grid' %}
    {# Renderizar grilla #}
{% else %}
    {# Renderizar carrusel #}
{% endif %}
```

### 6.4. Manejo Seguro de Strings Vacíos (`default` en Twig)
> [!WARNING]
> En el motor Twig de Tiendanube, si una variable contiene un string vacío `""`, el filtro `default('valor')` **no se activa** porque el string existe y no es nulo. Para valores numéricos o velocidades seguras, usar un ternario explícito:

```twig
{# Forma vulnerable a cadenas vacías: #}
{% set velocidad = settings.brands_marquee_speed | default(42) %} {# Si vale "", devuelve "" #}

{# Forma robusta recomendada: #}
{% set velocidad = (settings.brands_marquee_speed and settings.brands_marquee_speed in ['25', '42', '55']) ? settings.brands_marquee_speed : '42' %}
```

### 6.5. Imágenes Subidas en el Editor (`image` o `gallery`)
Las imágenes cargadas mediante `settings` deben procesarse con el filtro `settings_image_url`:

```twig
{# Imagen única: #}
{% if "mi_banner_destacado.jpg" | has_custom_image %}
    <img src="{{ 'mi_banner_destacado.jpg' | static_url | settings_image_url('large') }}" alt="Banner">
{% endif %}

{# Galería repetible: #}
{% for slide in settings.mis_logos %}
    <a href="{{ slide.link | setting_url }}">
        <img src="{{ slide.image | static_url | settings_image_url('medium') }}" alt="Logo">
    </a>
{% endfor %}
```

### 6.6. Imágenes Estáticas del Tema (`static/`)
Los assets fijos subidos por FTP en `static/images/` se llaman **directamente con `static_url`** (sin `settings_image_url`):

```twig
<img src="{{ 'images/brands/bosch.svg' | static_url }}" alt="Bosch" loading="lazy">
```

---

## 7. Cómo Agregar una Nueva Sección Modular a la Página de Inicio

La página de inicio de Tiendanube (`templates/home.tpl`) administra las secciones mediante un selector de orden (`home_order_position`). Para añadir una sección nueva modular:

### Paso 1: Agregar la sección a `config/settings.txt`
1. Buscar el bloque `dropdown` con `name = home_order_position_1` (se repite hasta `_21`).
2. En la lista `values`, añadir el identificador de la nueva sección:
   ```
   mi_nueva_seccion = Mi Nueva Sección
   ```
3. Debajo en `settings.txt`, crear el bloque `collapse` con los campos propios de esa sección:
   ```
   collapse
       title = Mi Nueva Sección
       backto = home_order_position

       checkbox
           name = mi_nueva_seccion_activa
           description = Mostrar sección

       i18n_input
           name = mi_nueva_seccion_titulo
           description = Título
   ```

### Paso 2: Crear el Snipplet (`web_ftp/snipplets/home/home-mi-seccion.tpl`)
Crear la plantilla de visualización con el HTML y Twig necesario:

```twig
{# web_ftp/snipplets/home/home-mi-seccion.tpl #}
{% if settings.mi_nueva_seccion_activa %}
    <section class="section-mi-seccion">
        <div class="container">
            {% if settings.mi_nueva_seccion_titulo %}
                <h2>{{ settings.mi_nueva_seccion_titulo }}</h2>
            {% endif %}
            {# Contenido del módulo #}
        </div>
    </section>
{% endif %}
```

### Paso 3: Conectar el Switch (`web_ftp/snipplets/home/home-section-switch.tpl`)
Buscar el bloque `{% if section_select == ... %}` y añadir la nueva rama:

```twig
{% elseif section_select == 'mi_nueva_seccion' %}

    {% include 'snipplets/home/home-mi-seccion.tpl' %}
```

### Paso 4: Dar soporte al previsualizador de temas (`templates/home.tpl`)
En la lista de `Hidden Sections` de `templates/home.tpl`, incluir el identificador para que el editor en vivo pueda previsualizarla:

```twig
{% for section_select in [..., 'brands', 'mi_nueva_seccion', 'new_block'] %}
```

---

## 8. Procedimiento de Publicación vía FTP

Una vez editados los archivos en `web_ftp/`:

```bash
# Dentro de la carpeta web_ftp:
npx -y @tiendanube/cli theme ftp push -y
```

### Lista de Control Post-Deploy:
1. Abrir el administrador de Tiendanube $\rightarrow$ **Personalizar diseño actual**.
2. Verificar que los nuevos campos aparezcan en el panel lateral.
3. Configurar los valores deseados y hacer clic en **Guardar cambios**.
4. Abrir la tienda online con hard-refresh (`Ctrl + F5`) para comprobar que el HTML renderiza correctamente los valores guardados.
