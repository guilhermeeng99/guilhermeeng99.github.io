# Guilherme Passos - Portfolio

Personal portfolio built with Flutter Web. Deployed to GitHub Pages at [guilhermeeng99.github.io](https://guilhermeeng99.github.io).

Showcases my work as a Flutter Engineer and Mobile Entrepreneur. Products I have built and maintained have reached **12M+ downloads worldwide**.

## What it does

* **Hero**: name, role, description, CTAs that scroll to Projects or Contact.
* **About**: bio + stat cards (downloads, years experience, products shipped, max team size).
* **Projects**: featured + secondary projects, dynamic store URLs sourced from Firebase Remote Config.
* **Resume**: professional experience, education, and résumé download.
* **Skills**: skill categories rendered as tech-chip badges.
* **Contact**: email, GitHub, LinkedIn, footer.
* **Theming**: Material 3 light and dark presets (`midnightOcean` / `arcticLight`), toggled at runtime.
* **Responsive**: mobile (<600px), tablet (600 to 1024px), and desktop (>=1024px) breakpoints via `ResponsiveLayout`.
* **i18n**: every user-facing string sourced from `slang`-generated translations (English).

## Architecture

[Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) with feature-first organization. Flutter Web only.

```
lib/
├── app/          # App shell: routing, theme, DI, shared widgets, assets
├── core/         # Shared cross-feature: constants, remote_config, utils
├── features/     # Feature modules (loading, portfolio)
└── gen/          # Generated code (slang i18n, asset references)

docs/
└── specs/        # ADR-style design specs (NNNN-slug.md)

test/
└── harness/      # Centralized mocks, factories, helpers
```

Each feature follows:

* `domain/`: entities, repository interfaces, use cases
* `infra/`: service implementations (Firebase SDK adapters)
* `presentation/`: pages, widgets, cubits

Data flow: UI (Page → Section → Widget) → UseCase → Repository (abstract) → Service (Firebase).

## Tech stack

| Concern             | Tool                                                                |
|---------------------|---------------------------------------------------------------------|
| State management    | `flutter_bloc` (`ThemeCubit` toggles light/dark; repository providers for read-only deps) |
| Routing             | `go_router` (2 routes: `/` loading, `/home` portfolio)              |
| Firebase            | `firebase_core`, `firebase_analytics`, `firebase_remote_config`     |
| Remote Config       | Custom layer in `lib/core/remote_config/` with `TypeEnum` keys      |
| i18n                | `slang` / `slang_flutter` (JSON-based, type-safe, English only)     |
| Theme               | Material 3 with `AppColorsExtension` (`ThemeExtension`)             |
| Fonts               | `google_fonts` (SpaceGrotesk, Inter, JetBrainsMono)                 |
| Linting             | `very_good_analysis` ^10.2.0 (strict)                               |
| Monorepo runner     | `melos` (`slang`, `build:web` scripts)                              |
| Testing             | `flutter_test`, `bloc_test`, `mocktail`                             |

## Running locally

Prerequisites: Flutter SDK >=3.10.8, Dart >=3.10.8.

```bash
# 1. Install deps
flutter pub get

# 2. Generate i18n (after editing en.i18n.json)
dart run slang

# 3. Run the web app
flutter run -d chrome
```

## Testing

```bash
flutter analyze                    # Must be zero issues
flutter test                       # All tests must pass
```

Tests follow F.I.R.S.T principles. All shared test infrastructure lives in `test/harness/` (mocks, helpers, factories). Mock at boundaries: repositories for use cases, services for repositories, use cases for cubits, repositories or use cases for widgets. See [test/harness/README.md](test/harness/README.md) and [docs/specs/0005-test-harness.md](docs/specs/0005-test-harness.md).

## Post-change checklist

After every code change:

1. `dart run slang` if any i18n JSON changed
2. `flutter analyze` (zero errors, warnings, info-level issues)
3. `flutter test` (all tests pass)
4. For UI changes: render in Chrome at mobile / tablet / desktop breakpoints
5. Never add `// ignore` without a justification comment naming the lint and the reason

## Deploy

GitHub Actions automates the release on every push to `master` ([`.github/workflows/deploy.yml`](.github/workflows/deploy.yml)):

1. `flutter pub get`
2. `dart run slang`
3. `flutter analyze`
4. `flutter test`
5. **Auto-bump `pubspec.yaml` version** based on the last commit message:
   * default: patch bump (`1.2.0` to `1.2.1`)
   * `feat(scope):` prefix: minor bump (`1.2.0` to `1.3.0`)
   * `BREAKING CHANGE` or `feat!:` / `fix!:`: major bump (`1.2.0` to `2.0.0`)
   * build number always set to `$GITHUB_RUN_NUMBER`
6. `flutter build web --release --build-number=$GITHUB_RUN_NUMBER`
7. Publish `build/web/` to the `gh-pages` branch
8. Commit the bumped version back to `master` (`chore(release): vX.Y.Z [skip ci]`)
9. Tag the commit `vX.Y.Z`
10. Create a GitHub Release with auto-generated notes

Pull requests against `master` run analyze + test + build but skip the bump, deploy, and release steps.

Live URL: [guilhermeeng99.github.io](https://guilhermeeng99.github.io).

## Conventions and specs

* Project conventions: [CLAUDE.md](CLAUDE.md) (architecture, code style, state management, theme, routing, sections, Remote Config, i18n, testing, performance, plan mode, quality gate).
* Design specs: [docs/specs/](docs/specs/) (ADR-style: Context, Requirements, Design, Tasks, Verification). Template and naming rules in [docs/specs/README.md](docs/specs/README.md).
* Active and planned work: [docs/roadmap.md](docs/roadmap.md).

## Links

* [LinkedIn](https://linkedin.com/in/guigapassos/)
* [GitHub](https://github.com/guilhermeeng99)
* [Email](mailto:guilhermeeng99@gmail.com)
