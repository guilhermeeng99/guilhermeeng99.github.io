# my_portfolio — Project Conventions

Guilherme Passos' personal portfolio — a single-page **Flutter Web** app deployed to **GitHub Pages** at `guilhermeeng99.github.io`. Showcases projects, skills, experience, and contact in a polished, responsive, themeable layout.

---

## Architecture

**Clean Architecture** with feature-first organization. Flutter Web only.

```
lib/
├── app/         # App shell: routing, theme, DI, shared widgets, assets
├── core/        # Shared cross-feature: constants, remote_config, utils
├── features/    # Feature modules (loading, portfolio)
└── gen/         # Generated code (slang i18n, asset references)
```

Each feature follows:

* `domain/` — entities, repository interfaces, use cases
* `infra/` — service implementations (Firebase SDK adapters)
* `presentation/` — pages, widgets, cubits

Data flow:

```
UI (Page → Section → Widget) → UseCase → Repository (abstract) → Service (Firebase)
```

Domain entities are plain Dart classes (no Firebase, no Flutter material imports). Static factories on entities (e.g. `ProjectsSectionData.projects(remote)`) keep section `build` methods free of data assembly.

---

## Code Style

* Functions: 5–25 lines. Split if longer.
* Files: keep under ~200 lines; split widgets when they exceed ~50 lines or are reused.
* One responsibility per function/widget (SRP).
* Prefer small, composable widgets over large ones.

### Naming

* `snake_case` files, `PascalCase` classes, `camelCase` members.
* Names must be specific and intention-revealing.
* Private fields prefix with `_`; expose only what's needed.
* Avoid generic names like `data`, `manager`, `handler`.

### Control Flow

* Prefer early returns over nested conditionals.
* Maximum 2 levels of indentation.

---

## Comments

* Write **WHY**, not WHAT.
* Preserve important context and decisions; do not strip meaningful comments during refactors.
* Public APIs (use cases, repository contracts) document:

  * intent
  * parameters
  * usage example

---

## Key Technologies

| Aspect             | Detail                                                                              |
| ------------------ | ----------------------------------------------------------------------------------- |
| **Platform**       | Flutter Web only (Dart `^3.10.8`)                                                   |
| **State**          | `flutter_bloc` — `ThemeCubit` for light/dark toggle; `MultiRepositoryProvider` for DI |
| **DI**             | `AppDependencies` widget at root (`lib/app/providers/remote_config_providers.dart`) |
| **Routing**        | `go_router` — declarative, 2 routes (`/` loading, `/home` portfolio)                |
| **Firebase**       | `firebase_core`, `firebase_analytics`, `firebase_remote_config`                     |
| **Remote Config**  | `lib/core/remote_config/` — domain/infra split, `TypeEnum` keys, `RemoteConstants` accessor |
| **i18n**           | `slang` / `slang_flutter` — JSON-based, type-safe, English only                     |
| **Theme**          | Light + Dark Material 3, `AppColorsExtension` (`midnightOcean` / `arcticLight`)     |
| **Fonts**          | `google_fonts` — SpaceGrotesk (display), Inter (body), JetBrainsMono (labels)       |
| **Linting**        | `very_good_analysis` ^10.2.0 (strict)                                               |
| **Monorepo runner**| `melos` — `slang`, `build:web` scripts                                              |
| **Logging**        | `logger`                                                                            |

---

## Commands

```bash
flutter pub get                    # Install dependencies
dart run slang                     # Regenerate i18n (after editing en.i18n.json)
flutter analyze                    # Static analysis (must be zero issues)
flutter test                       # Run all tests
flutter run -d chrome              # Run web app locally
flutter build web --release        # Production build → build/web/
melos run build:web                # Same, via melos
```

Deployment is **automated** via `.github/workflows/deploy.yml` on push to `master`: `flutter pub get` → `dart run slang` → `flutter analyze` → `flutter build web --release` → publish `build/web/` to the `gh-pages` branch.

---

## Post-Change Checklist

After every code change (features, fixes, refactors):

1. Run `dart run slang` if any `*.i18n.json` was modified.
2. Run `flutter analyze` → **zero** errors, warnings, **and** info-level issues.
3. Run `flutter test` → all tests must pass.
4. For UI changes, render in Chrome at mobile (<600px), tablet (600–1024px), and desktop (≥1024px) breakpoints.
5. Never add `// ignore` without a justification comment naming the lint and the reason.

> Once `/ship-check` lands (Stage 3 of the harness rollout), it codifies steps 1–3.

---

## Spec-Driven Development

Non-trivial changes start as a spec at `docs/specs/NNNN-<slug>.md` **before code is written**.

### When to write a spec

* New portfolio sections.
* New cross-cutting infrastructure (Firebase service, theme overhaul, routing changes).
* Refactors that touch more than ~3 files or cross feature boundaries.
* Anything you'd want to explain twice.

Skip for: typo fixes, dependency bumps, one-line bug fixes, adding a project entry through the existing `ProjectData` flow.

### Workflow

1. Scaffold a new spec with `/spec <slug>` (or copy the template from `docs/specs/README.md`).
2. Fill `## Context` and `## Requirements` (observable, testable statements).
3. Enter **plan mode** to fill `## Design` — design thinking lands in the spec, not a throwaway plan.
4. Derive `## Tasks` from `## Design`; work through them one commit at a time.
5. Tick `## Verification` before marking the spec `shipped`.
6. If the approach materially changes during implementation, update the spec rather than letting it drift.

### Spec structure (fixed)

* `## Context` — why this change, what's missing or wrong.
* `## Requirements` — observable, testable statements. No implementation details.
* `## Design` — files touched, shared widgets reused, data flow, theme/i18n/Remote Config keys, trade-offs.
* `## Tasks` — ordered checklist, each item a coherent commit.
* `## Verification` — manual + CI checks that prove it works end-to-end.

See `docs/specs/README.md` for the canonical template and naming rules.

---

## Testing Rules

* Every new use case must have tests.
* Every bug fix must include a regression test.
* One test file per source file; mirror the `lib/` tree under `test/`.
* Tests follow F.I.R.S.T:

  * Fast
  * Independent
  * Repeatable
  * Self-validating
  * Timely

### Test layers

* **Use cases** → unit tests with mocked repositories.
* **Repositories** → unit tests with mocked services.
* **Cubits** → `bloc_test` with mocked dependencies.
* **Widgets** → widget tests via `pumpMaterialApp` helper, asserting layout / interactions / `slang` keys resolve.

### Mocking rules

* Use `mocktail` (no codegen).
* Mock at boundaries:

  * repositories for use cases
  * services for repositories
  * use cases for cubits
* Never hardcode entities in tests — use factories from `test/harness/factories/`.

---

## Harness Engineering

Test infrastructure lives in `test/harness/`:

* `mocks.dart` — centralized mock declarations (mocktail).
* `helpers.dart` — shared setup: `pumpMaterialApp`, theme wrapper, fake `RemoteConstants` builder.
* `factories/` — test data factories per entity (one file per entity).

Importing the harness should be the first move in any new test file — if you're declaring a mock or building a fake entity inline, promote it into the harness.

---

## Dependencies

* Depend on abstractions, not implementations.
* Inject dependencies via constructor (use cases, repositories) or `MultiRepositoryProvider` (widget tree).
* External libraries (Firebase, url_launcher) must be wrapped behind a project-owned interface in `core/` or `infra/`.

---

## Code Conventions

* Use package imports (`package:my_portfolio/...`) — never relative.
* Apply `const` constructors and `const` values wherever possible.
* Use cases are single-method classes with `call()`. Typed variants like `callString`, `callInt` are allowed when generic dispatch isn't enough — see `GetRemoteValueUseCase`.
* Repository methods that read external state should be designed to fail safely — the use case wraps with try/return-default (see `GetRemoteValueUseCase.call`).

### UI & Formatting

* Every user-facing string via slang (`t.section.key`) — never hardcode.
* Never use raw `Color(0x...)` in widgets — use `context.appColors.<token>` (extension on `BuildContext` defined in `app_colors.dart`).
* Never inline `TextStyle` — use `Theme.of(context).textTheme.<role>`.
* Use the `urlLaunch` helper from `core/utils/url_launch.dart` for external links.

---

## State Management

* **Cubit** for simple state (e.g. `ThemeCubit` toggling `ThemeMode.dark` ↔ `ThemeMode.light`).
* **Bloc** reserved for genuinely event-driven flows — none today.
* **Repository providers** for read-only dependencies surfaced to the widget tree (`RemoteConstants`, `RemoteConfigInitializeUseCase`).

### Rules

* UI must not contain business logic.
* Cubits/Blocs orchestrate, UseCases execute logic.
* State must be immutable.
* Global cubits live as long as the widget tree (`BlocProvider` near the root).

---

## Performance

* Avoid unnecessary rebuilds (use `const`, split widgets, `BlocSelector` over `BlocBuilder` when partial state suffices).
* Precache heavy assets during the loading screen (`HomePage._precacheProjectImages` follows this pattern).
* Prefer granular widgets over large rebuild scopes.
* Lists must use lazy builders (`ListView.builder`, `SliverList.builder`).
* Keep section widgets idempotent — they're wrapped in `ScrollFadeIn` and rebuild on visibility changes.

---

## Theme — Material 3, Light + Dark

The theme is **not dark-only**. `ThemeCubit` (created in `AppWidget`) toggles `ThemeMode` and `MaterialApp.router` reads `theme: AppTheme.lightTheme` and `darkTheme: AppTheme.darkTheme`.

Color tokens live in `AppColorsExtension` (a `ThemeExtension`), with two presets:

| Preset           | Mode  | Background  | Primary    | Secondary  |
| ---------------- | ----- | ----------- | ---------- | ---------- |
| `midnightOcean`  | dark  | `#0A1628`   | `#6C63FF`  | `#00D9FF`  |
| `arcticLight`    | light | `#F5F7FA`   | `#5A52E0`  | `#0097B2`  |

Access via `context.appColors.<token>` (extension on `BuildContext` defined in `app_colors.dart`). Both presets share the same token surface (`background`, `surface`, `surfaceLight`, `cardBorder`, `textPrimary`, `textSecondary`, `textMuted`, `primary`, `secondary`, `accent`, `success`, `divider`) plus three `LinearGradient`s (`primaryGradient`, `heroGradient`, `cardGradient`).

### Typography (defined in `AppTheme`)

| Role                  | Font           | Notes                                   |
| --------------------- | -------------- | --------------------------------------- |
| `displayLarge/M/S`    | SpaceGrotesk   | Bold/SemiBold, tight letter-spacing     |
| `headlineMedium/Small`| SpaceGrotesk   | SemiBold                                |
| `titleLarge/Medium`   | Inter          | SemiBold/Medium                         |
| `bodyLarge/Medium`    | Inter          | Regular, line-height 1.6–1.7            |
| `labelLarge`          | Inter          | Medium                                  |
| `labelMedium`         | JetBrainsMono  | Mono accent for tags/badges (`secondary`)|

---

## Routing — go_router

| Path     | Page          | Purpose                                                              |
| -------- | ------------- | -------------------------------------------------------------------- |
| `/`      | `LoadingPage` | Splash: init Firebase Remote Config, precache assets, min ~1800ms    |
| `/home`  | `HomePage`    | Portfolio (single-page, scroll-to-section navigation)                |

* Route paths are static constants in `AppRoutes` (`lib/app/routes/app_router.dart`).
* `HomePage` transition: `CustomTransitionPage` + `FadeTransition` (400ms).
* **Internal navigation within HomePage is scroll-based**, not route-based — driven by `_sectionKeys` (`List<GlobalKey>`) and `_scrollToSection(int index)`.

---

## Portfolio Sections (`lib/features/portfolio/presentation/widgets/`)

`HomePage` is a `Stack` of:
1. `CustomScrollView` with 6 `SliverToBoxAdapter`s, each wrapping a section in `ScrollFadeIn` and assigning `_sectionKeys[i]`.
2. A pinned `NavBar` (`Positioned(top: 0)`) receiving the `ScrollController` + `onSectionTap` callback.

Section order (indices 0..5):

1. **HeroSection** — Name, role, description, CTA buttons (Explore Projects → idx 2, Get In Touch → idx 5).
2. **AboutSection** — Bio + stat cards.
3. **ProjectsSection** — Featured + secondary projects. **Only section that reads Remote Config** (via `RemoteConstants` from the widget tree).
4. **ResumeSection** — Experience + education + résumé download.
5. **SkillsSection** — Skill categories with `TechChip` badges.
6. **ContactSection** — Email, GitHub, LinkedIn, footer.

### File-shape convention

| Shape       | When                                                        | Example                                  |
| ----------- | ----------------------------------------------------------- | ---------------------------------------- |
| Flat file   | Section has no nested subwidgets worth naming              | `about_section.dart`, `contact_section.dart` |
| Subfolder   | Section owns nested pieces — promote to `<name>_section/` with own `widgets/` | `projects_section/`, `resume_section/`, `hero_section/`, `skills_section/` |

**Rule:** start flat; promote to a subfolder when nested pieces appear. No premature foldering.

### Shared widgets used across sections

| Widget              | Used by                                                |
| ------------------- | ------------------------------------------------------ |
| `ResponsiveLayout`  | All 6 sections (breakpoints + max content width)       |
| `ScrollFadeIn`      | Applied **by `HomePage`**, not by sections themselves  |
| `SectionTitle`      | About, Projects, Resume, Skills                        |
| `GlassCard`         | About (stats), Skills (categories)                     |
| `TechChip`          | Projects (tech stack), Skills (skill badges)           |
| `SocialButton`      | Contact                                                |
| `NavBar`            | `HomePage` only                                        |

---

## Remote Config (`lib/core/remote_config/`)

Layered:

* `domain/entities/type_enum.dart` — every remote key + its default value (single source of truth).
* `domain/entities/remote_config_enum.dart` — interface so other enums can extend the system.
* `domain/repositories/remote_config_repository.dart` — abstract contract.
* `domain/usecases/get_remote_value_usecase.dart` — typed accessors (`callString`, `callInt`, `callDouble`, `callBool`, `callIntList`); falls back to `enumValue.defaultValue` on any error.
* `domain/usecases/remote_config_initialize.dart` — one-shot init (called from `LoadingPage`).
* `infra/services/firebase_remote_config_service.dart` — Firebase SDK adapter.
* `infra/repositories/remote_config_repository_impl.dart` — concrete repository.

`RemoteConstants` (`lib/core/constants/app_constants.dart`) exposes named getters per remote key — sections consume this, not the use case directly.

### Adding a remote key

1. Add the entry to `TypeEnum` with a sane default URL/value.
2. Add a getter on `RemoteConstants`.
3. (If exposed in i18n copy) update `en.i18n.json` and re-run `dart run slang`.

---

## Firebase

| Service                  | Usage                                                                       |
| ------------------------ | --------------------------------------------------------------------------- |
| `firebase_core`          | Initialised in `main.dart` with `DefaultFirebaseOptions.currentPlatform`    |
| `firebase_analytics`     | `FirebaseAnalyticsObserver` attached to `GoRouter` (page-view tracking)     |
| `firebase_remote_config` | Initialised in `LoadingPage` via `RemoteConfigInitializeUseCase`            |

No Firestore, Auth, Storage, or Functions in this project.

---

## i18n — Slang

* Config: `slang.yaml` (base locale `en`, input `lib/app/assets/i18n/`, output `lib/gen/i18n/`).
* Source: `lib/app/assets/i18n/en.i18n.json`, structured by section (`app`, `nav`, `hero`, `about`, `projects`, `resume`, `skills`, `contact`).
* Access: global `t` object (e.g. `t.hero.name`, `t.about.title`).
* Bootstrapping: `LocaleSettings.useDeviceLocaleSync()` in `main.dart`.
* Regenerate after every JSON edit: `dart run slang`.

---

## Checklists

### Adding a new section

1. Create the section under `lib/features/portfolio/presentation/widgets/` — flat file if simple, subfolder with `widgets/` if it owns nested pieces.
2. Add any needed entity in `lib/features/portfolio/domain/entities/`.
3. Add all user-facing strings to `lib/app/assets/i18n/en.i18n.json` and run `dart run slang`.
4. If the section needs Remote Config values, add the key to `TypeEnum` and a getter on `RemoteConstants`.
5. Register the section in `HomePage`'s `CustomScrollView`, wrapped in `ScrollFadeIn`, with a fresh `GlobalKey` index.
6. Add a nav entry in `NavBar` and (if mobile) in `MobileMenuButton`.
7. Use `ResponsiveLayout` for breakpoint decisions.
8. Write a widget test using `test/harness/helpers.dart::pumpMaterialApp`.

### Adding a new project

1. Add the project to `ProjectsSectionData.projects(...)` or `.otherProjects(...)`.
2. Drop the image in `lib/app/assets/images/projects/` (asset generation auto-picks it up).
3. If the project has a dynamic URL, add a `TypeEnum` entry + `RemoteConstants` getter.
4. Add display strings to `en.i18n.json` and regenerate.

---

## Plan Mode

For any feature with a spec, fill the `## Design` section **in plan mode** before writing code. Plan mode outputs land in the spec file rather than in a scratch plan file, so the design thinking is preserved with the feature and not lost between sessions.

---

## Quality Gate

Before claiming any task complete, the **Post-Change Checklist** above must pass. Once `/ship-check` is available (Stage 3 of the harness rollout), that command codifies the gate — a green `/ship-check` predicts a green CI deploy.
