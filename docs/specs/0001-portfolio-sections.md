# 0001 — Portfolio Sections System

**Status:** shipped (retroactive — documents existing code as of 2026-04-15)
**Date:** 2026-04-15

## Context

The portfolio site is a single-page Flutter Web app. Instead of multi-page routing, the main `HomePage` composes six stacked content sections — Hero, About, Projects, Resume, Skills, Contact — inside one vertically scrolling view. Navigation between sections is scroll-based: clicking a nav entry smoothly animates to a section, not a route change.

This shape is not obvious from the routing layer (only two `go_router` routes exist: `/` → `LoadingPage`, `/home` → `HomePage`). The real structure lives in how sections register keys with the page, how the `NavBar` resolves those keys back to scroll offsets, and which shared widgets each section reuses. This spec documents that system as-built so future changes (adding a section, reordering, extracting a second page) have a single reference.

It also exists as the **calibration artifact for the spec workflow** — the first spec written in this repo, deliberately targeting known territory so the template's shape is legible before being used on unknown territory.

## Requirements

- The `HomePage` shall present exactly six scrollable sections in a fixed order: Hero → About → Projects → Resume → Skills → Contact.
- Each section shall be reachable by scroll-to-section animation from the `NavBar`, with smooth transitions (~600ms) and an 80px offset below the fixed top nav.
- Each section shall fade + slide in on first visibility via [`ScrollFadeIn`](lib/app/widgets/scroll_fade_in.dart).
- Each section shall render legibly at mobile (<600px), tablet (600–1024px), and desktop (≥1024px) breakpoints using [`ResponsiveLayout`](lib/app/widgets/responsive_layout.dart).
- All user-facing strings shall be sourced from `slang`-generated i18n (accessed via the global `t` object), not inline literals.
- The Projects section shall read dynamic URLs (store links, award links, resume PDF) from Firebase Remote Config via `TypeEnum` keys.
- No section shall depend on another section's internal state; inter-section actions (e.g., Hero CTAs scrolling to Projects/Contact) go through `HomePage`'s `_scrollToSection(int index)` callback.
- Project image assets shall be precached during `HomePage.initState` to avoid flicker when the Projects section enters the viewport.

## Design

### Page composition

[`HomePage`](lib/features/portfolio/presentation/pages/home_page.dart) is a `StatefulWidget` owning:
- `ScrollController _scrollController`
- `List<GlobalKey> _sectionKeys` — 6 keys generated in `initState`, indexed 0..5 in the section order above.

Layout is a `Stack` with two children:
1. A `CustomScrollView` containing six `SliverToBoxAdapter` slivers, each wrapping a section in `ScrollFadeIn` and assigning `_sectionKeys[i]` to the section widget itself.
2. A `Positioned(top: 0)` `NavBar` receiving the `_scrollController` and the `_scrollToSection` callback.

### Scroll-to-section mechanism

`_scrollToSection(int index)` ([`home_page.dart:54`](lib/features/portfolio/presentation/pages/home_page.dart:54)):
- Index `0` animates to offset `0` (Hero = top).
- Indices `1..5` resolve the `GlobalKey`'s `RenderBox`, compute its global `Offset` relative to `HomePage`'s own `RenderObject`, and animate `_scrollController.offset + offset.dy - 80` to compensate for the 80px nav bar.
- Curve `Curves.easeInOutCubic`, duration `600ms`.

Hero section CTAs reuse the same mechanism via props: `onExploreProjects: () => _scrollToSection(2)` and `onContact: () => _scrollToSection(5)`.

### NavBar integration

[`NavBar`](lib/app/widgets/nav_bar/nav_bar.dart) receives:
- `ScrollController scrollController` — for rendering scroll-position-aware visuals.
- `void Function(int index) onSectionTap` — the scroll callback.

NavBar renders 4 tappable entries (About/Projects/Experience/Skills, indices 1..4); the logo taps index 0, and the mobile menu's Contact CTA uses `kNavContactIndex = 5` (defined in [`mobile_menu_button.dart`](lib/app/widgets/nav_bar/widgets/mobile_menu_button.dart)). Hero is not a nav target because tapping the logo covers it.

### Section files

All sections live under [`lib/features/portfolio/presentation/widgets/`](lib/features/portfolio/presentation/widgets/). Two conventions coexist intentionally:

| Section | Class | File | Shape |
|---|---|---|---|
| Hero | `HeroSection` | `hero_section/hero_section.dart` | Subfolder — has own `widgets/` (`hero_section_content.dart`) |
| About | `AboutSection` | `about_section.dart` | Flat file |
| Projects | `ProjectsSection` | `projects_section/projects_section.dart` | Subfolder — has own `widgets/` (`project_content.dart`, `project_image.dart`) |
| Resume | `ResumeSection` | `resume_section/resume_section.dart` | Subfolder — has own `widgets/` (`resume_download_button.dart`, `resume_education.dart`, `resume_experience.dart`) |
| Skills | `SkillsSection` | `skills_section/skills_section.dart` | Subfolder (no subwidgets yet) |
| Contact | `ContactSection` | `contact_section.dart` | Flat file |

**Rule:** a flat file is fine until the section grows nested pieces worth naming; at that point promote to a subfolder with `widgets/`. No premature foldering.

### Shared widget usage across sections

| Widget | Used by |
|---|---|
| [`ResponsiveLayout`](lib/app/widgets/responsive_layout.dart) | All 6 sections |
| [`SectionTitle`](lib/app/widgets/section_title.dart) | About, Projects, Resume, Skills |
| [`GlassCard`](lib/app/widgets/glass_card.dart) | About (stat cards), Skills (category cards) |
| [`ScrollFadeIn`](lib/app/widgets/scroll_fade_in.dart) | Applied **by `HomePage`**, not by sections themselves |
| [`TechChip`](lib/app/widgets/tech_chip.dart) | Projects (tech stack badges), Skills (skill badges) |
| [`SocialButton`](lib/app/widgets/social_button.dart) | Contact |

Hero and Contact are the two sections that don't use `SectionTitle` — Hero has its own layout (name + role + description + CTAs), Contact uses a different heading treatment.

### Domain entities

[`lib/features/portfolio/domain/entities/`](lib/features/portfolio/domain/entities/):

- [`project_data.dart`](lib/features/portfolio/domain/entities/project_data.dart) — `ProjectsSectionData`, enum `ProjectCompany`, class `ProjectAward`. Static factories `ProjectsSectionData.projects(RemoteConstants)` (6 featured) and `.otherProjects(RemoteConstants)` (7 secondary).
- [`resume_data.dart`](lib/features/portfolio/domain/entities/resume_data.dart) — `ResumeSectionData` (static list `resumes`), `EducationData` (static list `educations`).
- [`skill_category.dart`](lib/features/portfolio/domain/entities/skill_category.dart) — `SkillsSectionCategory` (static list `categories`).

All entities are plain Dart classes, no external dependencies. Instantiation via static factories keeps the sections' `build` methods free of data assembly.

### Remote Config wiring

The Projects section reads `RemoteConstants` from the widget tree ([`projects_section.dart:27`](lib/features/portfolio/presentation/widgets/projects_section/projects_section.dart:27)) and passes it to `ProjectsSectionData.projects(remote)`. Keys accessed (via `TypeEnum`) include the project store URLs (`magicSortUrl`, `rabitUrl`, `cupsUrl`, `farmUrl`, `capyUrl`, `dropAndMergeUrl`, `neverHaveIEverXUrl`, `boozeUrl`, `vdxUrl`, `flutterBaseUrl`, `financoUrl`), the resume PDF (`resumeUrl`), and award URLs (`googlePlayIndieGamesAccelerator2024Url`, `googlePlayIndieGamesFund2023Url`, `harvestArticleUrl`, `googlePlayBestOf2021Url`).

No other section reads Remote Config directly.

### Responsive breakpoints

From [`responsive_layout.dart`](lib/app/widgets/responsive_layout.dart):
- Mobile: `width < 600`
- Tablet: `600 ≤ width < 1024`
- Desktop: `width ≥ 1024`
- Max content width: `1100px` (applied when width ≥ 1200)
- Section vertical padding: `60px` (mobile) / `100px` (else)

### Image precaching

`HomePage._precacheProjectImages()` waits one frame (`WidgetsBinding.instance.endOfFrame`) then precaches every image under `Assets.lib.app.assets.images.projects.values` via `precacheImage`. Errors are swallowed because a missing project image shouldn't crash the page.

## Tasks

This section is retrospective — the work is already shipped. Listed as a completeness check against the as-built code.

- [x] Six sections implemented under `presentation/widgets/` with the flat-vs-subfolder convention.
- [x] `HomePage` owns `_sectionKeys` and `_scrollToSection`; sections receive keys from parent.
- [x] `ScrollFadeIn` wraps each section in `HomePage`, not in the section itself.
- [x] `NavBar` receives `onSectionTap` callback; logo = index 0, entries = 1..4, contact shortcut = 5.
- [x] All sections use `ResponsiveLayout` for breakpoint decisions.
- [x] All user-facing strings routed through `slang` (`t.hero.*`, `t.about.*`, etc.).
- [x] Projects section reads Remote Config URLs via `RemoteConstants` and `TypeEnum`.
- [x] Project images precached in `HomePage.initState`.
- [x] `dart run slang` producing strings.g.dart committed; `flutter analyze` zero issues (enforced by CI).

## Verification

- [x] CI: `.github/workflows/deploy.yml` runs `flutter analyze` + `flutter build web --release` green on `master`.
- [ ] Manual: render `/home` at 360px (mobile), 800px (tablet), 1440px (desktop) — every section is legible and no layout overflows.
- [ ] Manual: tap each NavBar entry — page smoothly scrolls to the correct section with ~80px breathing room under the nav.
- [ ] Manual: tap Hero "Explore Projects" CTA — scrolls to Projects. Tap "Get In Touch" — scrolls to Contact.
- [ ] Manual: open DevTools Network tab on `/home` first load — project thumbnails load without a visible pop-in when the Projects section enters the viewport (precache working).
- [ ] Manual: confirm every i18n key resolves — no raw `t.foo.bar` strings visible in the rendered DOM.
- [ ] Manual: confirm Remote Config URLs launch correctly — click one project's store link, one award link, and the resume download.

_Manual verification boxes remain unchecked in this retroactive spec because the checks were not formally run when the code shipped; they represent the gate any **future** change to this system must pass._
