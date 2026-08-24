# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This repo develops a Tiendanube/Nuvemshop storefront theme for the client **HMC HUB**.

- `web_fork/` — the theme source itself (Nimbus template engine: `.tpl` files with Twig-like syntax). This is what gets synced to the live store.
- `assets/` — brand assets (logos in `Logos_JPG/` and `Logos_PNG/`, avatars, the brand manual PDF). Reference material for building the theme; not consumed directly by the theme code.
- `docs/` — project documentation for this engagement:
  - `docs/design.md` — design/aesthetic spec (extracted from the brand manual): logo rules, color palette, typography, photography style. Source of truth for visual decisions.
  - `docs/specs.md` — feature specs: what functionality/sections/pages need to be built.
  - `docs/progress.md` — running task tracker for the work to be done; keep it updated as work progresses.

## Commands

Theme sync is done with the `@tiendanube/cli` (`tiendanube`), installed globally. All `theme` subcommands must be run from `web_fork/` — that's where the `.nuvem` link file lives, connecting this folder to the store's theme.

```bash
cd web_fork

tiendanube theme current              # show which store/theme this folder is linked to
tiendanube theme authorize            # sign in via browser (needed once per machine/session)
tiendanube theme pull                 # download the current remote theme state into this folder
tiendanube theme diff                 # preview what a push would change on the store
tiendanube theme push                 # upload local changes to the store
tiendanube theme watch                # watch local files and auto-push on save (use while developing)
tiendanube theme preview              # get a shareable preview URL before publishing
tiendanube theme performance          # run a Lighthouse report against the current theme version
tiendanube theme publish              # make this theme the live version of the store
```

There is no local build/lint/test toolchain — `.tpl` files are rendered server-side by Nuvemshop's Nimbus engine, so validating changes means pushing/previewing and checking the rendered store (`tiendanube theme diff` first, then `preview`).

`web_fork/.nuvem` holds the store's public API token and is gitignored — never commit it or print its decoded contents.

## Architecture (Nimbus theme structure)

- **`layouts/layout.tpl`** — the outer HTML shell all pages render into (`<head>`, critical/async CSS loading, header/footer layout templates, cart/quick-shop modals, JS bootstrapping). Start here to understand global page structure.
- **`sections/`** — top-level, page-composable units (hero, header, footer, product grid, etc.). Each section file has two parts: the Twig template markup and a `{% schema %}...{% endschema %}` JSON block defining its theme-editor settings, block whitelist, and presets.
- **`blocks/`** — smaller content units placed inside a section's block list (button, heading, text, image, etc.), rendered via `{% include 'blocks/' ~ block.type ~ '.tpl' with { block: block } %}`. Same two-part structure (markup + `{% schema %}`) as sections.
- **`snippets/`** — reusable partials included by sections/blocks/layout (organized by domain: `cart/`, `product/`, `header/`, `navigation/`, `structured-data/`, etc.), plus standalone files like `image.tpl` and `breadcrumbs.tpl`.
- **`templates/pages/*.json`** and **`templates/layout/*.json`** — define which sections appear on each page type (home, product, cart, category, etc.) and the header/footer layout templates, by referencing section files and their settings.
- **`config/settings_schema.json`** — defines the global theme-editor settings (colors, typography, etc.) shown in the Nuvemshop admin; **`config/settings_data.json`** holds the current values for those settings plus the page-composition data (which sections/blocks are on each page, in what order).
- **`translations/`** — per-locale JSON strings (`es`, `es_AR`, `es_CL`, `es_CO`, `es_MX`, `en`, `pt.default`) referenced in templates via `t:` schema keys and the `| t` filter; each locale has a paired `.schema.json` for editor-facing labels.
- **`static/`** — theme assets not resolved through the template engine's asset pipeline in the same way: `css/` (critical/async/utilities stylesheets loaded from `layout.tpl`), `js/` (standalone libraries loaded blocking, plus `store.js` loaded after `LS.ready`), and `images/placeholders/`.
- **`layouts/resources/`** — shared includes pulled into `layout.tpl` (`style-tokens.tpl` for CSS custom properties from settings, `icons-sprite.tpl` for the SVG icon sprite).

### Section/block schema convention

Every section and block file defines its editor-facing configuration inline via `{% schema %}`. Settings entries use `"type": "setting"` with a `setting_type` (e.g. `color`, `image_picker`, `range`, `radio`, `toggle`, `url`) and reference translation keys (`t:settings.*`, `t:names.*`) rather than hardcoded labels. `visible_if`/`disabled_if` (Twig-boolean strings evaluated against `section.settings`/`block.settings`) drive conditional field visibility. New sections/blocks should follow this same pattern rather than hardcoding text or styles.
