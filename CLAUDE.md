# My Portfolio — Claude Code Guide

You are assisting in a **Flutter Web portfolio** project called **my_portfolio**.
This is Guilherme Passos' personal portfolio website — a single-page application hosted on **GitHub Pages** (`guilhermeeng99.github.io`) showcasing projects, skills, experience, and contact information with a polished, responsive, dark-themed design.

Generate **high-quality, performant, and maintainable** code that follows the conventions established in this codebase.

---

## Project Overview

| Aspect | Detail |
|---|---|
| **Platform** | Flutter Web only (GitHub Pages) |
| **SDK** | Dart ^3.10.8 |
| **State Management** | `flutter_bloc` (used for dependency initialization) |
| **DI** | `MultiRepositoryProvider` via `AppDependencies` widget |
| **Routing** | `go_router` (declarative, path-based — 2 routes) |
| **Firebase** | `firebase_core`, `firebase_analytics`, `firebase_remote_config` |
| **Remote Config** | Located in `lib/core/remote_config/` — dynamic URLs for stores, awards, resume |
| **Code Generation** | `slang` (i18n) |
| **Linting** | `very_good_analysis` ^10.2.0 (strict) |
| **Fonts** | `google_fonts` — SpaceGrotesk (headings), Inter (body), JetBrainsMono (labels) |
| **i18n** | `slang` / `slang_flutter` — JSON-based, type-safe, English only |
| **Theme** | Dark-only Material 3, "Midnight Ocean" palette, custom `AppColors` / `AppTheme` |
| **Monorepo** | `melos` for script management |

---

## Architecture

### Pattern — Clean Architecture (Feature-First)

```
lib/
├── app/                          # App-level setup
│   ├── app_widget.dart           # MaterialApp.router + Analytics + Theme
│   ├── assets/
│   │   ├── i18n/                 # Translation JSON files
│   │   └── images/               # Profile photo, project images
│   ├── providers/                # Top-level DI (RemoteConfig providers)
│   ├── routes/                   # GoRouter config + AppRoutes
│   ├── theme/                    # AppColors, AppTheme
│   └── widgets/                  # Shared reusable widgets
├── core/                         # Shared across all features
│   ├── constants/                # AppConstants (URLs, social links)
│   ├── remote_config/            # Shared Remote Config infrastructure
│   │   ├── domain/               # TypeEnum, repository contract, use cases
│   │   └── infra/                # Firebase implementation
│   └── utils/                    # Firebase options, URL launcher helper
├── features/
│   ├── loading/
│   │   └── presentation/         # Splash / loading page
│   └── portfolio/
│       ├── domain/
│       │   └── entities/         # ProjectData, SkillCategory, ResumeData
│       └── presentation/
│           ├── pages/            # HomePage
│           └── widgets/          # Section widgets (hero/about/projects/resume/skills/contact) + section-specific subwidgets
└── gen/                          # Auto-generated (slang strings, asset refs)
    ├── assets.gen.dart
    └── i18n/
        ├── strings.g.dart
        └── strings_en.g.dart
```

### Data Flow

```
UI (Page/Section/Widget) → UseCase → Repository (abstract) → Service (Firebase)
```

- Domain entities (`ProjectData`, `SkillCategory`, `ResumeData`) are plain Dart classes with no external dependencies.
- The `remote_config` module follows a clean layered architecture: `domain/` (contracts + use cases) → `infra/` (Firebase implementation).
- `AppDependencies` widget uses `MultiRepositoryProvider` to inject use cases across the widget tree.

---

## Routing — GoRouter

Only **2 routes** exist:

| Path | Page | Purpose |
|---|---|---|
| `/` | `LoadingPage` | Splash screen: init Firebase, precache images, min 1800ms delay |
| `/home` | `HomePage` | Main portfolio (single-page with scrollable sections) |

- Route paths are **static constants** in `AppRoutes`.
- `HomePage` transition uses `CustomTransitionPage` with `FadeTransition` (400ms).
- Internal navigation within `HomePage` is done via **scroll-to-section** using `GlobalKey`s and `ScrollController`, not route changes.

---

## Remote Config

The `lib/core/remote_config/` module encapsulates all Firebase Remote Config logic:

- **`TypeEnum`** — Defines all remote config keys (store URLs, award links, resume PDF).
- **`RemoteConfigInitializeUseCase`** — Initializes Firebase Remote Config with default values.
- **`GetRemoteValueUseCase`** — Retrieves values with type-safe accessors (`callString`, `callInt`, `callDouble`, `callBool`, `callIntList`).
- **`RemoteConfigRepository`** (abstract) → **`RemoteConfigRepositoryImpl`** (implementation).
- **`RemoteConfigService`** (abstract) → **`FirebaseRemoteConfigServiceImpl`** (Firebase SDK).

Remote config values drive dynamic content like Play Store/App Store links, award URLs, and resume PDF link.

---

## Firebase Integration

| Service | Usage |
|---|---|
| **Analytics** | `FirebaseAnalytics` + `FirebaseAnalyticsObserver` on `GoRouter` |
| **Remote Config** | Dynamic URLs for projects, stores, awards, resume |

- Firebase is initialised in `main.dart` with `DefaultFirebaseOptions.currentPlatform`.
- Remote Config is initialised during the loading screen (`LoadingPage`).

---

## Theme — "Midnight Ocean"

### Colour Palette (`AppColors`)

| Token | Hex | Usage |
|---|---|---|
| `background` | `#0A1628` | Main background |
| `surface` | `#0F1F35` | Cards, elevated surfaces |
| `primary` | `#6C63FF` | Primary actions, accents |
| `secondary` | `#00D9FF` | Secondary highlights |
| `accent` | `#06B6D4` | Subtle accent |

- **Gradients**: `primaryGradient` (purple → cyan), `cardGradient`, `heroGradient`.
- **Never** use raw `Color(0x...)` in widgets — always use `AppColors`.

### Typography

| Role | Font | Style |
|---|---|---|
| Display / Headlines | SpaceGrotesk | Bold / SemiBold |
| Body text | Inter | Regular, line-height 1.6–1.7 |
| Labels / Monospace | JetBrainsMono | For emphasis and badges |

- Text styles are defined in `AppTheme` — never inline `TextStyle` in widgets.

---

## Shared Widgets (`lib/app/widgets/`)

| Widget | Purpose |
|---|---|
| `GlassCard` | Glassmorphism container with gradient border, hover glow shadow |
| `NavBar` | Responsive top navigation — desktop links vs mobile hamburger menu |
| `ResponsiveLayout` | Provides breakpoint queries (`isMobile`, `isTablet`, `isDesktop`) + max content width |
| `ScrollFadeIn` | Fade + slide-up animation triggered on scroll visibility |
| `SectionTitle` | Section heading with gradient shader + subtitle |
| `SocialButton` | Icon button with hover effect, launches URL, shows tooltip |
| `TechChip` | Badge chip with semi-transparent background and border |

---

## Portfolio Sections (`lib/features/portfolio/presentation/widgets/`)

Sections live directly under `widgets/`. Small sections are single files (`about_section.dart`, `contact_section.dart`); larger sections have their own folder with a `widgets/` subfolder for section-specific children (e.g., `projects_section/projects_section.dart` + `projects_section/widgets/project_content.dart`).

The `HomePage` is a `CustomScrollView` with these sections in order:

1. **HeroSection** — Name, title, description, CTA buttons ("Explore Projects", "Get In Touch")
2. **AboutSection** — Bio paragraphs + stat cards (12M+ downloads, 7+ years, 10+ products, 14 team size)
3. **ProjectsSection** — Featured projects (6) + secondary projects (6), data from `ProjectData` entities with Remote Config URLs
4. **ResumeSection** — Professional experience (Blu Studios, VX Case, Tecall) + education
5. **SkillsSection** — 3 categories: Core Engineering, Architecture Backend, DevOps & Production
6. **ContactSection** — Email, GitHub, LinkedIn cards + footer

---

## Internationalisation (i18n) — Slang

- Config: `slang.yaml` — base locale `en`, input from `lib/app/assets/i18n/`, output to `lib/gen/i18n/`.
- Source file: `lib/app/assets/i18n/en.i18n.json` (structured by section: `app`, `nav`, `hero`, `about`, `projects`, `resume`, `skills`, `contact`).
- Access translations via the global `t` object (e.g., `t.hero.name`, `t.about.title`).
- Initialise with `LocaleSettings.useDeviceLocaleSync()` in `main.dart`.
- After editing JSON files, regenerate with `dart run slang`.

---

## Build & Deploy

### Commands (via Melos)

| Script | Command |
|---|---|
| **Regenerate i18n** | `dart run slang` |
| **Generate asset folders** | `dart run my_portfolio:assets_linux` |
| **Release + Deploy** | `flutter build web --release && call deploy_web.bat` |

### Deploy Flow (`deploy_web.bat`)

1. `flutter build web --release` — Builds optimised web output to `build/web/`.
2. Initialises git in `build/web/`, commits, and force-pushes to the `gh-pages` branch.
3. Hosted at **`guilhermeeng99.github.io`**.

CI (`.github/workflows/deploy.yml`) mirrors this: `flutter pub get` → `dart run slang` → `flutter analyze` → `flutter build web --release` → publish to `gh-pages`.

---

## Design Principles

- **DRY** — Extract shared logic into `core/utils` or shared widgets in `app/widgets/`.
- **KISS** — Favour simplicity. Don't add abstractions unless they reduce complexity.
- **Composition over inheritance** — Prefer composing small widgets.
- **Responsiveness first** — Every section must render well on mobile, tablet, and desktop. Use `ResponsiveLayout` for breakpoint decisions.
- **Performance** — Precache heavy assets (images) during loading screen. Use `const` constructors wherever possible.

---

## Coding Conventions

| Rule | Detail |
|---|---|
| **Naming** | `snake_case` files, `PascalCase` classes, `camelCase` members |
| **Imports** | Use package imports (`package:my_portfolio/...`), not relative |
| **`const`** | Apply `const` constructors and `const` values wherever possible |
| **Private fields** | Prefix with `_`; expose only what's needed |
| **File length** | Keep files under 200 lines; split if larger |
| **Widget decomposition** | Extract widgets when they exceed ~50 lines or are reused |
| **Sections** | Each portfolio section lives under `presentation/widgets/` — as a flat file for simple sections, or a subfolder with its own `widgets/` for sections with nested pieces |
| **Comments** | Only where the *why* isn't obvious; avoid restating the code |
| **Lint rules** | Follow `very_good_analysis`; never add `// ignore` without justification |
| **Animations** | Use `ScrollFadeIn` for scroll-triggered animations; prefer `AnimationController` + `CurvedAnimation` for custom effects |
| **URL launching** | Use the `urlLaunch` helper from `core/utils/url_launch.dart` |

---

## Checklists

### When Adding a New Section

1. Create a new section widget under `lib/features/portfolio/presentation/widgets/` — as a flat file (`<name>_section.dart`) if simple, or as a subfolder (`<name>_section/<name>_section.dart` + `<name>_section/widgets/`) if the section has its own nested pieces.
2. Add any required entity in `lib/features/portfolio/domain/entities/`.
3. Add all user-facing strings to `lib/app/assets/i18n/en.i18n.json` under a new key and run `dart run slang`.
4. If the section needs Remote Config values, add the new key to `TypeEnum` in `lib/core/remote_config/`.
5. Register the section in `HomePage`'s `CustomScrollView` children, wrapped in `ScrollFadeIn`.
6. Add a nav entry in `NavBar` with the corresponding `GlobalKey` for scroll-to navigation.
7. Ensure responsive layout using `ResponsiveLayout` breakpoints.

### When Adding a New Project

1. Add the project data in the `ProjectData` entity list within the projects section.
2. Add the project image to `lib/app/assets/images/projects/` and re-run asset generation if needed.
3. If the project has dynamic URLs (store links, awards), add Remote Config keys in `TypeEnum` with defaults.
4. Add all display strings to the i18n JSON and regenerate.

### Post-Implementation Checklist

After every code change (new features, bug fixes, refactors), **always**:

1. Run `dart run slang` if any i18n JSON file was modified.
2. Run `flutter analyze` and verify **zero** errors, warnings, **and** info-level issues.
3. Fix every reported issue — this project uses `very_good_analysis`.
4. Never add `// ignore` without clear justification in a comment.
5. Treat info-level lint hints the same as warnings — they must be resolved.

> Once the `/ship-check` command lands (Stage 3 of the harness rollout), run it to automate the above.

---

## Spec Workflow

Non-trivial changes (new sections, new infrastructure, cross-cutting refactors) start in `docs/specs/` as a numbered single-file spec before code is written.

- Location: `docs/specs/NNNN-slug.md` (zero-padded number, monotonic, kebab-case slug).
- Template and numbering rules live in `docs/specs/README.md`.
- Fixed sections: `## Context`, `## Requirements`, `## Design`, `## Tasks`, `## Verification`.
- Once `/spec` is available (Stage 2 of the harness rollout), use it to scaffold new specs. Until then, copy the template from `docs/specs/README.md` manually.
- Trivial changes (typo fixes, dependency bumps, one-line bug fixes) skip the spec.

## Quality Gate

Before claiming any task complete, the Post-Implementation Checklist above must pass. Once `/ship-check` is available (Stage 3 of the harness rollout), that command codifies the gate — a green `/ship-check` predicts a green CI deploy.

## Plan Mode

For any feature with a spec, fill the `## Design` section **in plan mode** before writing code. Plan mode outputs land in the spec file rather than in a scratch plan file, so the design thinking is preserved with the feature and not lost between sessions.
