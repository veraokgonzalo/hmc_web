# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This repo develops a Tiendanube/Nuvemshop storefront theme for the client **HMC HUB**.

- `web_ftp/` — the theme source itself: a copy of the theme currently hosted on the live Tiendanube/Nuvemshop store, pulled via FTP. This is the store's legacy (pre-Nimbus) theme structure — pages are plain `.tpl` templates, reusable partials live in `snipplets/`, and theme-editor settings/translations are plain-text/JSON config files under `config/` (no sections/blocks JSON composition system). This is the current core for theme development.
- `assets/` — brand assets (logos in `Logos_JPG/` and `Logos_PNG/`, avatars, the brand manual PDF). Reference material for building the theme; not consumed directly by the theme code.
- `docs/` — project documentation for this engagement:
  - `docs/web_architecture.md` — full file tree of `web_ftp/` with a description of every file/folder and a summary of how the theme is structured (page templates, `snipplets/`, config, home composition). Start here to get oriented in the theme source.
  - `docs/design.md` — design/aesthetic spec (extracted from the brand manual): logo rules, color palette, typography, photography style. Source of truth for visual decisions.
  - `docs/specs.md` and `docs/task.md` — feature specs / task list. **Written against a since-removed sections/blocks theme structure — flagged as outdated at the top of each file, needs review before use as a guide for work on `web_ftp/`.**
  - `docs/progress.md` — running task tracker for the work to be done on `web_ftp/`; keep it updated as work progresses.
  - `docs/progress-web_fork-archive.md` — historical log of the home-page work completed on the old sections/blocks theme structure (now removed). Kept for reference only; not a guide for current work.

## Commands

`web_ftp/` is synced with the live Tiendanube/Nuvemshop store via FTP. There is no local build/lint/test toolchain and no CLI wired up in this repo — `.tpl` files are rendered server-side by Tiendanube, so validating changes means uploading the modified files via FTP and checking the rendered store (or store preview, if the FTP workflow provides one) directly.

FTP connection details/credentials are not stored in this repo — never hardcode or commit them.

## Architecture (legacy FTP theme structure)

- **`layouts/layout.tpl`** — the outer HTML shell all pages render into (`<head>`, critical/async CSS loading, font/social-meta components, JS bootstrapping). Start here to understand global page structure.
- **`templates/*.tpl`** — one template per page type (`home.tpl`, `product.tpl`, `category.tpl`, `cart.tpl`, `contact.tpl`, `blog.tpl`, `blog-post.tpl`, `404.tpl`, `password.tpl`, `search.tpl`, `page.tpl`), plus `templates/account/` for account-related pages (login, register, orders, addresses, etc.). Page content is composed directly in these `.tpl` files rather than through a sections/blocks system.
- **`snipplets/`** (this is the actual folder name used by the theme, not a typo to fix) — reusable partials included via `{% snipplet 'path/to/file.tpl' %}` or `{% include 'snipplets/path/to/file.tpl' %}`, organized by domain: `header/`, `footer/`, `navigation/`, `home/`, `grid/`, `product/`, `forms/`, `shipping/`, `shipping_suboptions/`, `banner-services/`, `social/`, `svg/` (icon partials), `defaults/` (empty-state/help placeholders), plus standalone files like `breadcrumbs.tpl`, `card.tpl`, `modal.tpl`, `cart-panel.tpl`.
- **Home page composition** — `templates/home.tpl` loops over up to 21 numbered settings (`home_order_position_1` … `_21`), each holding the name of a home module (`slider`, `main_categories`, `welcome`, `brands`, `testimonials`, etc.); `snipplets/home/home-section-switch.tpl` resolves each name to its `snipplets/home/home-*.tpl` partial. Order and visibility of home content is driven entirely by these setting values, not a drag-and-drop sections/blocks JSON.
- **`config/`** — plain-text/JSON theme configuration: `settings.txt` (theme-editor setting field definitions, indentation-based DSL), `defaults.txt` (default values for those settings), `variants.txt` (predefined color-scheme presets), `sections.txt` (product collection/tag definitions like `primary`, `new`, `sale`), `translations.txt` (UI copy strings), `data.json` (preview/compiled-assets config).
- **`static/`** — `css/` (`style-critical.scss`, `style-async.scss`, `style-colors.scss`, `style-tokens.tpl`), `js/` (`store.js.tpl` and other external library `.tpl` files), and `checkout.scss.tpl`.
