# 0001 — Portfolio Sections System

**Status:** shipped (retroactive — documents existing code as of 2026-05-06)
**Date:** 2026-05-06

## Context

The portfolio site is a single-page Flutter Web app. Instead of multi-page routing, the main `HomePage` composes six stacked content sections — Hero, About, Projects, Resume, Skills, Contact — inside one vertically scrolling view. Navigation between sections is scroll-based: clicking a nav entry smoothly animates to a section, not a route change.

This shape is not obvious from the routing layer (only two `go_router` routes exist: `/` → `LoadingPage`, `/home` → `HomePage`). The real structure lives in how sections register keys with the page, how the `NavBar` resolves those keys back to scroll offsets, and which shared widgets each section reuses. This spec documents that system as-built so future changes (adding a section, reordering, extracting a second page) have a single reference.

It also exists as the **calibration artifact for the spec workflow** — the first spec written in this repo, deliberately targeting known territory so the template's shape is legible before being used on unknown territory.

## Requirements

* The `HomePage` shall present exactly six scrollable sections in a fixed order: Hero → About → Projects → Resume → Skills → Contact.
* Each section shall be reachable via scroll-to-section animation from the `NavBar`, with smooth transitions (~600ms) and an 80px offset below the fixed top nav.
* Each section shall fade + slide in on first visibility via `ScrollFadeIn` (offset 30px, duration 600ms, threshold 0.15 except Hero which uses 0).
* Each section shall render legibly at mobile (<600px), tablet (600–1024px), and desktop (≥1024px) breakpoints using `ResponsiveLayout`.
* All user-facing strings shall be sourced from `slang`-generated i18n (accessed via the global `t` object), not inline literals.
* The Projects section is the only section that reads dynamic URLs from Firebase Remote Config (via `RemoteConstants` and `TypeEnum`).
* No section shall depend on another section's internal state; inter-section actions (e.g. Hero CTAs) go through `HomePage`'s `_scrollToSection(int index)` callback.
* Project image assets shall be precached during `HomePage.initState` to avoid pop-in when the Projects section enters the viewport.
* The `MobileMenuButton` exposes the four nav entries plus a Contact entry (index `kNavContactIndex = 5`) so mobile users can reach Contact without scrolling.

## Design

### Page composition

`HomePage` ([lib/features/portfolio/presentation/pages/home_page.dart](../../lib/features/portfolio/presentation/pages/home_page.dart)) is a `StatefulWidget` owning:

* `ScrollController _scrollController`
* `List<GlobalKey> _sectionKeys` — 6 keys generated in `initState`, indexed 0..5 in section order.

Layout is a `Stack`:

1. A `CustomScrollView` containing six `SliverToBoxAdapter` slivers, each wrapping a section in `ScrollFadeIn` and assigning `_sectionKeys[i]` to the section widget itself.
2. A `Positioned(top: 0)` `NavBar` receiving the `_scrollController` and the `_scrollToSection` callback.

### Scroll-to-section mechanism

`_scrollToSection(int index)`:

* Index `0` animates to offset `0` (Hero = top).
* Indices `1..5` resolve the `GlobalKey`'s `RenderBox`, compute its global `Offset` relative to `HomePage`'s own `RenderObject`, and animate `_scrollController.offset + offset.dy - 80` (compensating for the 80px nav).
* Curve `Curves.easeInOutCubic`, duration `600ms`.

Hero CTAs reuse the same callback: `onExploreProjects: () => _scrollToSection(2)`, `onContact: () => _scrollToSection(5)`.

### NavBar integration

`NavBar` ([lib/app/widgets/nav_bar/nav_bar.dart](../../lib/app/widgets/nav_bar/nav_bar.dart)) receives:

* `ScrollController scrollController` — for any scroll-position-aware visuals.
* `void Function(int index) onSectionTap` — the scroll callback.

Desktop renders four `NavItem`s (About/Projects/Experience/Skills, indices 1..4), a `ThemeToggleButton`, and a `NavCta` for Contact (index `kNavContactIndex = 5`). Mobile renders the `ThemeToggleButton` plus a `MobileMenuButton` whose popup exposes the same five entries. The logo (`LogoButton`) always taps index `0`.

### Section files

All sections live under [lib/features/portfolio/presentation/widgets/](../../lib/features/portfolio/presentation/widgets/). Two conventions coexist intentionally:

| Section  | Class             | File                                                | Shape    |
| -------- | ----------------- | --------------------------------------------------- | -------- |
| Hero     | `HeroSection`     | `hero_section/hero_section.dart`                    | Subfolder |
| About    | `AboutSection`    | `about_section.dart`                                | Flat     |
| Projects | `ProjectsSection` | `projects_section/projects_section.dart`            | Subfolder |
| Resume   | `ResumeSection`   | `resume_section/resume_section.dart`                | Subfolder |
| Skills   | `SkillsSection`   | `skills_section/skills_section.dart`                | Subfolder |
| Contact  | `ContactSection`  | `contact_section.dart`                              | Flat     |

**Rule:** start flat. Promote to a subfolder with its own `widgets/` only when the section grows nested pieces worth naming.

### Shared widget usage across sections

| Widget              | Used by                                          |
| ------------------- | ------------------------------------------------ |
| `ResponsiveLayout`  | All 6 sections                                    |
| `SectionTitle`      | About, Projects, Resume, Skills                  |
| `GlassCard`         | About (stat cards), Skills (category cards)      |
| `ScrollFadeIn`      | Applied **by `HomePage`**, not by sections themselves |
| `TechChip`          | Projects (tech stack), Skills (skill badges)     |
| `SocialButton`      | Contact                                          |

Hero and Contact don't use `SectionTitle` — Hero has its own layout, Contact uses a different heading treatment.

### Domain entities

[lib/features/portfolio/domain/entities/](../../lib/features/portfolio/domain/entities/):

* `project_data.dart` — `ProjectsSectionData`, `ProjectCompany`, `ProjectAward`. Static factories `ProjectsSectionData.projects(remote)` and `.otherProjects(remote)` build the lists from i18n + Remote Config.
* `resume_data.dart` — `ResumeSectionData` (`resumes` static list), `EducationData` (`educations` static list).
* `skill_category.dart` — `SkillsSectionCategory` (`categories` static list).

All entities are plain Dart (no Firebase, no Flutter). Static factories keep `build` methods free of data assembly.

### Image precaching

`HomePage._precacheProjectImages()` waits one frame (`WidgetsBinding.instance.endOfFrame`) then precaches every image under `Assets.lib.app.assets.images.projects.values`. Errors are swallowed (`onError: (_, _) {}`) — a missing image shouldn't crash the page.

### Trade-offs considered and rejected

* **Multi-route navigation** (`/about`, `/projects`, etc.) — rejected: a portfolio is a marketing surface; one continuous scroll converts better than a route-tabbed UX, and SEO concerns are dominated by the static-rendered hero + meta tags.
* **`Visibility` based fade-in** instead of `ScrollFadeIn`'s custom `RenderProxyBox` — rejected: the custom render object reads `RenderAbstractViewport.maybeOf` to compute a real visibility ratio (not just "in viewport"), which is what `threshold` requires.
* **Sections owning their own `ScrollFadeIn` wrapper** — rejected: keeping the wrapper in `HomePage` makes per-section ordering and disabling (Hero uses `visibleThreshold: 0`) trivial without each section knowing about animation.

## Tasks

Retrospective. The work is shipped; this list is a completeness check against as-built code.

* [x] Six sections implemented under `presentation/widgets/` with the flat-vs-subfolder convention.
* [x] `HomePage` owns `_sectionKeys` and `_scrollToSection`; sections receive keys from parent.
* [x] `ScrollFadeIn` wraps each section in `HomePage`, not in the section itself.
* [x] `NavBar` receives `onSectionTap` callback; logo = index 0, nav entries = 1..4, contact shortcut = 5.
* [x] `MobileMenuButton` exposes 5 popup entries (4 nav + Contact).
* [x] All sections use `ResponsiveLayout` for breakpoint decisions.
* [x] All user-facing strings routed through `slang` (`t.hero.*`, `t.about.*`, etc.).
* [x] Projects section reads Remote Config URLs via `RemoteConstants` and `TypeEnum`.
* [x] Project images precached in `HomePage.initState`.
* [x] `dart run slang` output committed; `flutter analyze` zero issues (enforced by CI).

## Verification

* [x] CI: `.github/workflows/deploy.yml` runs `flutter analyze` + `flutter build web --release` green on `master`.
* [x] Tests: [`test/app/widgets/scroll_fade_in_test.dart`](../../test/app/widgets/scroll_fade_in_test.dart), [`test/app/widgets/nav_bar/mobile_menu_button_test.dart`](../../test/app/widgets/nav_bar/mobile_menu_button_test.dart), [`test/app/widgets/section_title_test.dart`](../../test/app/widgets/section_title_test.dart), [`test/app/widgets/glass_card_test.dart`](../../test/app/widgets/glass_card_test.dart) cover the shared widgets behind this system.
* [ ] Manual: render `/home` at 360px (mobile), 800px (tablet), 1440px (desktop) — every section legible, no overflows.
* [ ] Manual: tap each `NavBar` entry — page smoothly scrolls to the correct section with ~80px breathing room under the nav.
* [ ] Manual: tap Hero "Explore Projects" → scrolls to Projects. Tap "Get In Touch" → scrolls to Contact.
* [ ] Manual: open DevTools Network tab on `/home` first load — project thumbnails arrive before Projects section enters the viewport (precache working).
* [ ] Manual: confirm no raw `t.foo.bar` strings visible in the DOM.
* [ ] Manual: confirm Remote Config URLs launch correctly — click one project's store link, one award link, and the resume download.

_Manual verification boxes remain unchecked because they were not formally run when the code shipped; they represent the gate any **future** change to this system must pass._
