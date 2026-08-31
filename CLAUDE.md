# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This repo develops a Tiendanube/Nuvemshop storefront theme for the client **HMC HUB**.

- `web_ftp/` — the theme source itself: a copy of the theme currently hosted on the live Tiendanube/Nuvemshop store, pulled via FTP. This is the store's legacy (pre-Nimbus) theme structure — pages are plain `.tpl` templates, reusable partials live in `snipplets/`, and theme-editor settings/translations are plain-text/JSON config files under `config/` (no sections/blocks JSON composition system). This is the current core for theme development.
- `assets/` — brand assets (logos in `Logos_JPG/` and `Logos_PNG/`, avatars, the brand manual PDF). Reference material for building the theme; not consumed directly by the theme code.
- `docs/` — project documentation for this engagement:
  - `docs/web_architecture.md` — full file tree of `web_ftp/` with a description of every file/folder and a summary of how the theme is structured (page templates, `snipplets/`, config, home composition). Start here to get oriented in the theme source.
  - `docs/instructivo_tiendabe_ftp_legacy.md` — reference for the `tiendanube theme ftp ...` CLI commands used to sync `web_ftp/` with the live store (setup/pull/push/watch).
  - `docs/design.md` — design/aesthetic spec (extracted from the brand manual): logo rules, color palette, typography, photography style. Source of truth for visual decisions.
  - `docs/specs.md` and `docs/task.md` — feature specs / task list. **Written against a since-removed sections/blocks theme structure — flagged as outdated at the top of each file, needs review before use as a guide for work on `web_ftp/`.**
  - `docs/progress.md` — running task tracker for the work to be done on `web_ftp/`; keep it updated as work progresses.
  - `docs/progress-web_fork-archive.md` — historical log of the home-page work completed on the old sections/blocks theme structure (now removed). Kept for reference only; not a guide for current work.

## Commands

`web_ftp/` is synced with the live Tiendanube/Nuvemshop store using the `@tiendanube/cli`'s FTP workflow (legacy themes don't support the section/block Fork workflow — see `docs/instructivo_tiendabe_ftp_legacy.md`). All commands are run from `web_ftp/`, under `tiendanube theme ftp <command>`:

```bash
cd web_ftp

tiendanube theme ftp setup --ftp-server FTP_HOST --ftp-username FTP_USER --ftp-password FTP_PASSWORD --store-url https://yourstore.mitiendanube.com
                                       # one-time: saves FTP credentials to .nuvem (get them from the store admin's theme settings, "Open FTP")
tiendanube theme ftp pull             # download the current remote theme state into this folder
tiendanube theme ftp push             # upload local changes (incremental: only changed files; also syncs deletions)
tiendanube theme ftp push --force     # upload every file, skipping the remote-comparison/incremental check
tiendanube theme ftp watch            # watch local files and auto-push on save; reloads a browser tab on the storefront after each sync
```

There is no local build/lint/test toolchain — `.tpl` files are rendered server-side by Tiendanube, so validating changes means pushing and checking the rendered store directly (no separate preview URL in the FTP workflow, unlike Fork).

`web_ftp/.nuvem` holds the FTP credentials and is gitignored — never commit it or print its decoded contents.

## Architecture (legacy FTP theme structure)

- **`layouts/layout.tpl`** — the outer HTML shell all pages render into (`<head>`, critical/async CSS loading, font/social-meta components, JS bootstrapping). Start here to understand global page structure.
- **`templates/*.tpl`** — one template per page type (`home.tpl`, `product.tpl`, `category.tpl`, `cart.tpl`, `contact.tpl`, `blog.tpl`, `blog-post.tpl`, `404.tpl`, `password.tpl`, `search.tpl`, `page.tpl`), plus `templates/account/` for account-related pages (login, register, orders, addresses, etc.). Page content is composed directly in these `.tpl` files rather than through a sections/blocks system.
- **`snipplets/`** (this is the actual folder name used by the theme, not a typo to fix) — reusable partials included via `{% snipplet 'path/to/file.tpl' %}` or `{% include 'snipplets/path/to/file.tpl' %}`, organized by domain: `header/`, `footer/`, `navigation/`, `home/`, `grid/`, `product/`, `forms/`, `shipping/`, `shipping_suboptions/`, `banner-services/`, `social/`, `svg/` (icon partials), `defaults/` (empty-state/help placeholders), plus standalone files like `breadcrumbs.tpl`, `card.tpl`, `modal.tpl`, `cart-panel.tpl`.
- **Home page composition** — `templates/home.tpl` loops over up to 21 numbered settings (`home_order_position_1` … `_21`), each holding the name of a home module (`slider`, `main_categories`, `welcome`, `brands`, `testimonials`, etc.); `snipplets/home/home-section-switch.tpl` resolves each name to its `snipplets/home/home-*.tpl` partial. Order and visibility of home content is driven entirely by these setting values, not a drag-and-drop sections/blocks JSON.
- **`config/`** — plain-text/JSON theme configuration: `settings.txt` (theme-editor setting field definitions, indentation-based DSL), `defaults.txt` (default values for those settings), `variants.txt` (predefined color-scheme presets), `sections.txt` (product collection/tag definitions like `primary`, `new`, `sale`), `translations.txt` (UI copy strings), `data.json` (preview/compiled-assets config).
- **`static/`** — `css/` (`style-critical.scss`, `style-async.scss`, `style-colors.scss`, `style-tokens.tpl`), `js/` (`store.js.tpl` and other external library `.tpl` files), and `checkout.scss.tpl`.

## 📱 Mobile-First & Responsiveness Rule (Mandatory Memory Bank Rule)

**CRITICAL MANDATE FOR ALL CODE MODIFICATIONS & NEW COMPONENTS:**
Whenever any component, UI block, navigation item, modal, drawer, filter, card, or page is created or modified (in `boceto_web/` prototype or `web_ftp/` Tiendanube theme), **its Mobile version (< 768px and < 480px) MUST be explicitly implemented, adapted, and tested concurrently**.

### Core Mobile Implementation Guidelines:
1. **Never ship desktop-only changes**: Every HTML/CSS/JS modification must have its corresponding mobile stylesheet rules, drawer/accordion behavior, and touch handling.
2. **Navigation & Menus**: Desktop mega-dropdowns (Categories, Brands 103 directory, etc.) must automatically have their mobile touch equivalents in `#mobileDrawerMenu` (via accordions, bottom sheets, or touch-friendly lists).
3. **Touch Targets**: Minimum clickable/tappable area must be $\ge 44 \times 44\text{px}$ with adequate tap spacing.
4. **No Horizontal Overflow**: Elements must be bounded by `max-width: 100%`, `overflow-x: hidden`, with responsive padding (`--container-padding: 16px` on mobile).
5. **Mobile Bottom App Bar**: Maintain integration with `.mobile-bottom-nav` (Home, Catalog, WhatsApp advice, Reactive Cart counter, Menu drawer).
6. **Modals & Drawers**: Modals, Cart Drawers, and Filters on mobile must adapt to full-height slide-over drawers or bottom sheets with visible touch close buttons and backdrop overlays.
