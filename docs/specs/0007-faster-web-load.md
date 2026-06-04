# 0007 — Faster Web Cold Load

**Status:** shipped
**Date:** 2026-06-04

## Context

After [0006](0006-remove-firebase-remote-config.md) removed Firebase and shortened the splash floor, the remaining first-load cost was the Flutter Web cold start itself:

1. **Blank white frame** before the engine boots. `web/index.html` was bare (just `flutter_bootstrap.js`), so the browser painted nothing until the engine downloaded and rendered the first frame.
2. **Runtime font fetch.** `google_fonts` downloaded Inter / Space Grotesk / JetBrains Mono from `fonts.gstatic.com` on first paint, adding a network round-trip and a font-swap flash (FOUT).
3. **Engine size.** The default `flutter build web` ships the CanvasKit JS engine (~1.5MB+). Flutter 3.44 can build WasmGC (skwasm), which is faster to load and execute, with an automatic JS/CanvasKit fallback for browsers without WasmGC.

This spec covers the three fixes.

## Requirements

* `web/index.html` shall paint an instant splash (matching the in-app `LoadingPage`: `#0A1628` background + primary `#6C63FF` spinner) before the engine boots, and remove it on the engine's `flutter-first-frame` event.
* Fonts shall be self-hosted (bundled in the app) with **no runtime network fetch**. `google_fonts` shall be removed from `pubspec.yaml`.
* The production build shall compile with `--wasm` so modern browsers load skwasm and others fall back to CanvasKit JS.
* Bundled fonts shall be **subset to Latin** (Basic Latin + Latin-1 Supplement + smart punctuation) so they carry only the glyphs the site uses.
* `font_awesome_flutter` shall be removed (it bundled ~0.5MB of unused Solid/Regular icon fonts; only the GitHub + LinkedIn brand marks are used). Those two render as vendored SVGs via `flutter_svg`.
* `flutter analyze` zero issues, `flutter test` all green, and `flutter build web --release --wasm` succeeds.

## Design

### Instant HTML splash

`web/index.html` gains an inline `<style>` + a `#splash` div (a CSS-animated spinner) painted immediately by the browser. A small inline script listens for `window`'s `flutter-first-frame` event, fades the splash via a CSS opacity transition, and removes it on `transitionend`. No assets referenced (avoids hashed-asset path issues), so it works from the very first byte of HTML.

The splash colors mirror the dark `midnightOcean` preset (the default `ThemeCubit` start mode), so the handoff from HTML splash → Flutter `LoadingPage` is seamless.

### Self-hosted fonts

`google_fonts` is removed. Font files live in `lib/app/assets/fonts/` and are declared under `pubspec.yaml`'s `flutter: fonts:`:

* `Inter-Variable.ttf` — variable font, spans all weights used (400/500/600/700).
* `SpaceGrotesk-Variable.ttf` — variable font (600/700 used).
* `JetBrainsMono-Regular.ttf` — static; only w400 is used.

Variable fonts let one file cover every weight; Flutter maps `fontWeight` to the `wght` axis automatically. `AppTheme` no longer calls `GoogleFonts.*` — it builds the type scale once in `_textTheme(TextTheme base, AppColorsExtension colors)` (deduping what were two identical blocks across light/dark) using `base.apply(fontFamily: 'Inter')` + `TextStyle(fontFamily: ...)` per role.

`test/flutter_test_config.dart`'s `HttpOverrides` (previously there to silence `google_fonts` fetches) stays as a generic hermetic-tests safety net; its comment is updated.

### `--wasm` build

`.github/workflows/deploy.yml`'s build step adds `--wasm`. Flutter 3.44's `--wasm` emits a build that runs skwasm on browsers with WasmGC (Chrome 119+, Firefox 120+, Safari 18.2+) and falls back to the CanvasKit JS engine elsewhere, so enabling it is safe for all visitors. Verified to compile locally.

### Font subsetting

Bundling full font files (Inter 859KB, Space Grotesk 133KB, JetBrains Mono 264KB) traded the runtime fetch for ~1.2MB of first-load payload. The fonts are subset (harfbuzz, via the `subset-font` tool) to Basic Latin + Latin-1 Supplement (covers Portuguese accents in names) + smart punctuation, keeping the variable weight axes intact: Inter 859→211KB, Space Grotesk 133→63KB, JetBrains Mono 264→87KB. This is a build-time asset operation; the TTFs in `lib/app/assets/fonts/` are the subset versions. If the copy ever needs glyphs outside Latin-1, re-subset with a wider charset.

### Drop Font Awesome

Only the GitHub and LinkedIn brand marks were used (both Brands family). `font_awesome_flutter` additionally bundled its Solid (~0.4MB) and Regular (~0.08MB) icon fonts with zero used glyphs, and icon tree-shaking did not drop them. The package is removed; the two marks are vendored as single-path SVGs in `lib/app/assets/icons/` and rendered with `flutter_svg`. A shared `SocialIcon` widget (`lib/app/widgets/social_icon.dart`) renders an `Object` icon as either a Material `IconData` or a `String` SVG asset path (see `BrandIcons`), so `SocialButton` and the contact cards keep their existing `icon` API. A global `ThemeData.fontFamily` (Inter) is set so CanvasKit does not fall back to fetching Roboto for default-styled text.

### Trade-offs

* **HTML splash with the brand logo vs a plain spinner** — chose a spinner. Referencing the logo from static HTML means hard-coding a hashed asset path that changes per build; a CSS spinner is build-stable and the Flutter `LoadingPage` (which does show the animated logo) takes over within a few hundred ms anyway.
* **`--wasm` vs staying on CanvasKit JS** — chose `--wasm`. The automatic JS fallback removes the browser-support risk, and the WasmGC path is faster to parse/execute. If a rendering regression ever appears, dropping the one flag reverts it.
* **Self-host vs keep `google_fonts` with `allowRuntimeFetching = false` + bundled assets** — chose full self-host via standard `pubspec` `fonts:`. It removes a dependency entirely and is the most predictable (no reliance on `google_fonts`' asset-name matching).

## Tasks

* [x] Add the instant splash + `flutter-first-frame` removal to `web/index.html`.
* [x] Vendor the three TTFs into `lib/app/assets/fonts/` and declare them in `pubspec.yaml`.
* [x] Remove `google_fonts`; rewrite `AppTheme` with `_textTheme` helper + `fontFamily`.
* [x] Update `flutter_test_config.dart` + `app_theme_test.dart` comments.
* [x] Add `--wasm` to the deploy build step.
* [x] Subset the three bundled fonts to Latin.
* [x] Remove `font_awesome_flutter`; vendor GitHub/LinkedIn SVGs + `flutter_svg`; add `SocialIcon` + `BrandIcons`.
* [x] Set a global `ThemeData.fontFamily` so CanvasKit doesn't fetch Roboto.
* [x] Update docs (README, CLAUDE.md, amend 0003, roadmap).

## Verification

* [x] `flutter analyze` — zero issues.
* [x] `flutter test` — all 29 tests pass.
* [x] `flutter build web --release --wasm` — succeeds; built `index.html` contains the splash and `assets/.../fonts/` contains the three subset TTFs.
* [x] Measured (headless Chrome, release wasm build, gzip-served = like GitHub Pages, cold cache, median of 3):
  * Total transfer **2.57MB → 1.27MB** (−51%) after subsetting + dropping Font Awesome.
  * First frame on simulated broadband (12 Mbps / 40ms RTT) **3.05s → 2.25s**; on an unthrottled connection **~1.26s**.
  * HTML splash paints at ~130ms, so there is no blank white frame regardless of engine download time.
  * Remaining heaviest asset is `main.dart.wasm` (~0.84MB transfer, app + skwasm). A ~0.06MB Roboto woff2 is still fetched once by CanvasKit's fallback path (cached after first visit); not worth chasing.
* [ ] Manual: confirm text renders in the correct families (display = Space Grotesk, body = Inter, labels = JetBrains Mono) and the GitHub/LinkedIn marks render correctly in both light and dark.
* [ ] CI: `.github/workflows/deploy.yml` builds green on `master` and the deployed site loads.
