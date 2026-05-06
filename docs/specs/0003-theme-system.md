# 0003 — Theme System (Light + Dark)

**Status:** shipped (retroactive — documents existing code as of 2026-05-06)
**Date:** 2026-05-06

## Context

The portfolio originally shipped dark-only ("Midnight Ocean" palette). Light mode was added later (commit `b6ff247 [ADD] White mode`) without a redesign — the same token surface, two presets, a `ThemeCubit` driving `ThemeMode` from the nav bar's `ThemeToggleButton`. Documenting this prevents the "is this a dark-only project?" question from coming up again, and pins the contract so a future tweak (a third preset, system-following mode, persistence) has a baseline to evolve.

The unique-to-this-codebase choice is that `AppColorsExtension` is a `ThemeExtension` (not a `static const Map` or a singleton service), so colors flow through `ThemeData.extensions` and `Theme.of(context).extension<AppColorsExtension>()`. A `BuildContext` extension (`context.appColors`) hides that lookup so callers stay terse.

## Requirements

* The app shall support both light and dark themes, switchable at runtime.
* Both themes shall expose the same token surface — a widget that reads `context.appColors.<token>` shall compile-fail at zero call sites when switching themes.
* Theme state shall be a Cubit — `ThemeCubit` ([lib/app/theme/theme_cubit.dart](../../lib/app/theme/theme_cubit.dart)) — so `BlocBuilder` rebuilds `MaterialApp.router` on toggle.
* Initial mode is `ThemeMode.dark`. (No persistence today; a refresh resets to dark.)
* The toggle UI lives in the nav bar (`ThemeToggleButton` in both desktop and mobile branches).
* Color tokens shall be defined as a `ThemeExtension<AppColorsExtension>` so `lerp` interpolates correctly during theme animations and `copyWith` is available for one-off overrides.
* Widgets shall **never** use raw `Color(0x...)` literals (with the documented exception of pure shadow constants in widgets where the shadow color isn't part of the palette).
* Typography is centralised in `AppTheme.lightTheme` / `darkTheme` ([lib/app/theme/app_theme.dart](../../lib/app/theme/app_theme.dart)); widgets use `Theme.of(context).textTheme.<role>` and never inline `TextStyle`.

## Design

### Tokens — `AppColorsExtension`

[lib/app/theme/app_colors.dart](../../lib/app/theme/app_colors.dart) defines `AppColorsExtension extends ThemeExtension<AppColorsExtension>` with 11 `Color` tokens (`background`, `surface`, `surfaceLight`, `cardBorder`, `textPrimary`, `textSecondary`, `textMuted`, `primary`, `secondary`, `accent`, `success`, `divider`) and 3 `LinearGradient`s (`primaryGradient`, `heroGradient`, `cardGradient`).

Two presets are defined as `static const`:

| Preset           | Mode  | Background | Primary    | Secondary  |
| ---------------- | ----- | ---------- | ---------- | ---------- |
| `midnightOcean`  | dark  | `#0A1628`  | `#6C63FF`  | `#00D9FF`  |
| `arcticLight`    | light | `#F5F7FA`  | `#5A52E0`  | `#0097B2`  |

`copyWith` and `lerp` are implemented manually (no codegen) because `ThemeExtension` requires both. `lerp` uses `Color.lerp` and `LinearGradient.lerp` per field; if `other` is null it returns `this` unchanged.

### Access pattern — `BuildContext` extension

```dart
extension AppColorsContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
```

The non-null assertion is intentional: every theme registers the extension (`extensions: const [colors]`), so a missing extension is a programmer error worth crashing on. Tests must use `pumpMaterialApp` (which wires both themes) to avoid this trap.

### Theme assembly — `AppTheme`

[lib/app/theme/app_theme.dart](../../lib/app/theme/app_theme.dart) exposes `AppTheme.lightTheme` / `AppTheme.darkTheme` getters. Each:

1. Picks the matching `AppColorsExtension` preset.
2. Starts from `ThemeData.dark()` / `ThemeData.light()` and `copyWith`s:
   * `scaffoldBackgroundColor: colors.background`
   * `colorScheme: ColorScheme.dark|light(primary: colors.primary, secondary: colors.secondary, surface: colors.surface)`
   * `extensions: const [colors]`
   * `textTheme: GoogleFonts.interTextTheme(...).copyWith(...)` — explicit `TextStyle` for every role we use (`displayLarge/M/S`, `headlineMedium/Small`, `titleLarge/Medium`, `bodyLarge/Medium`, `labelLarge/Medium`).

Typography roles by font:

| Role                   | Font           | Notes                                      |
| ---------------------- | -------------- | ------------------------------------------ |
| `displayLarge/M/S`     | SpaceGrotesk   | Bold/SemiBold, tight letter-spacing        |
| `headlineMedium/Small` | SpaceGrotesk   | SemiBold                                   |
| `titleLarge/Medium`    | Inter          | SemiBold/Medium                            |
| `bodyLarge/Medium`     | Inter          | Regular, line-height 1.6–1.7               |
| `labelLarge`           | Inter          | Medium                                     |
| `labelMedium`          | JetBrainsMono  | Mono accent for tags/badges (`secondary`)  |

### Toggle wiring

`AppWidget` ([lib/app/app_widget.dart](../../lib/app/app_widget.dart)) wraps the router in `BlocProvider(create: (_) => ThemeCubit())` and a `BlocBuilder<ThemeCubit, ThemeMode>` whose builder returns `MaterialApp.router(theme: light, darkTheme: dark, themeMode: state, …)`. `ThemeToggleButton` ([lib/app/widgets/nav_bar/widgets/theme_toggle_button.dart](../../lib/app/widgets/nav_bar/widgets/theme_toggle_button.dart)) reads `context.watch<ThemeCubit>().isDark` for its icon and calls `context.read<ThemeCubit>().toggleTheme()` on tap, with a 300ms `RotationTransition` + `FadeTransition` between sun/moon icons.

### Trade-offs considered and rejected

* **System-following mode (`ThemeMode.system`)** — rejected: portfolio is a curated marketing surface; explicit user choice beats OS guessing. Easy to add later if requested.
* **`SharedPreferences` persistence** — rejected: not worth a Web-only persistence layer for a portfolio that the same person rarely re-opens. Trivial follow-up if needed.
* **`Color(0x...)` exception list maintained as lint config** — rejected: enforce by review; the only exception today is `_kNavShadow` in `nav_bar.dart` (a black shadow, palette-independent).
* **Three palettes (high-contrast)** — rejected: nothing today demands it; the `ThemeExtension` shape supports adding a third preset without API changes.

## Tasks

Retrospective. The work is shipped; this list is a completeness check against as-built code.

* [x] `AppColorsExtension extends ThemeExtension<AppColorsExtension>` with 11 colors + 3 gradients.
* [x] Two presets: `midnightOcean` (dark), `arcticLight` (light), each `static const`.
* [x] `copyWith` and `lerp` implemented for all fields.
* [x] `AppColorsContext` extension on `BuildContext` exposes `context.appColors`.
* [x] `AppTheme.lightTheme` / `darkTheme` register the matching preset via `extensions: const [colors]`.
* [x] All text roles defined with explicit fonts and weights.
* [x] `ThemeCubit` with `ThemeMode.dark` initial state and `toggleTheme()` flipping to/from light.
* [x] `AppWidget` provides `ThemeCubit` and rebuilds `MaterialApp.router` on state change.
* [x] `ThemeToggleButton` rendered in both desktop and mobile branches of `NavBar`.

## Verification

* [x] Tests: [`test/app/theme/theme_cubit_test.dart`](../../test/app/theme/theme_cubit_test.dart) covers initial state + toggle transitions.
* [x] Tests: [`test/app/theme/app_colors_test.dart`](../../test/app/theme/app_colors_test.dart) covers `copyWith` field preservation, `lerp` interpolation, and the two presets exposing distinct values.
* [x] Tests: [`test/app/theme/app_theme_test.dart`](../../test/app/theme/app_theme_test.dart) covers both themes registering `AppColorsExtension` and exposing the expected `textTheme` roles.
* [ ] Manual: tap `ThemeToggleButton` on `/home` — colors flip across all six sections without flicker; icon rotates between sun/moon.
* [ ] Manual: navigate to a different section, toggle theme — section retains scroll position; `ScrollFadeIn` does not re-trigger.
* [ ] Manual: with theme set to light, screen-reader contrast on text-secondary against background passes WCAG AA (informal check; no automated audit gating yet).
