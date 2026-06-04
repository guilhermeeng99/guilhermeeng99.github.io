# 0006 — Remove Firebase + Remote Config, Speed Up Loading

**Status:** shipped
**Date:** 2026-06-04

## Context

The portfolio shipped with Firebase (`firebase_core`, `firebase_analytics`, `firebase_remote_config`) to serve outbound URLs (store links, award articles, the résumé PDF, demo URLs) through Remote Config, per [0002](0002-remote-config.md). In practice none of this earns its cost:

* The URLs are stable. They change on the order of "once a year," and when they do, a code change + the existing auto-deploy pipeline ships the update in minutes. Remote Config bought nothing here.
* `firebase_analytics` was wired as a `FirebaseAnalyticsObserver` static field on `AppWidget` but **never attached** to the router. It was dead code collecting no events.
* Firebase + Remote Config add real cost to a cold load: `Firebase.initializeApp` is awaited before `runApp` (blocks first paint), and `RemoteConfigInitializeUseCase` runs a network fetch inside the loading gate.

On top of that, the loading splash enforced a **1800ms** minimum display ([0004](0004-loading-bootstrap.md)) that sat on top of the Firebase cold-start, making the site feel slow.

This spec records the decision to delete the entire Firebase/Remote Config stack, replace the dynamic URLs with plain compile-time constants, and shorten the splash floor to 700ms.

## Requirements

* All outbound URLs previously sourced from `TypeEnum` shall become `static const` fields on `AppConstants` ([lib/core/constants/app_constants.dart](../../lib/core/constants/app_constants.dart)).
* `ProjectsSectionData.projects()` / `.otherProjects()` shall read URLs directly from `AppConstants` and take no `RemoteConstants` argument.
* The résumé download button shall read `AppConstants.resumeUrl` directly.
* The entire `lib/core/remote_config/` module, `lib/app/providers/remote_config_providers.dart` (`AppDependencies`), and `lib/core/utils/firebase_options.dart` shall be deleted.
* `firebase_core`, `firebase_analytics`, `firebase_remote_config` shall be removed from `pubspec.yaml`.
* `main.dart` shall no longer initialise Firebase; it binds Flutter, syncs the slang locale, and runs `TranslationProvider(child: AppWidget())` directly.
* `AppWidget` shall no longer reference `FirebaseAnalytics` / `FirebaseAnalyticsObserver`.
* `LoadingPage` shall drop Remote Config init from `_preload` (image precache only) and lower the min-display floor to **700ms**.
* `flutter analyze` zero issues and `flutter test` all green after the change.

## Design

### URL constants

`AppConstants` gains a block of `static const String` URLs (résumé, store pages, award articles, per-project links) carrying the exact values that were `TypeEnum` defaults. A comment notes these used to be Remote Config so the history is not lost.

### Data flow change

The old flow was `Section → context.read<RemoteConstants>() → ProjectsSectionData.projects(remote) → remote.xUrl`. It becomes `Section → ProjectsSectionData.projects() → AppConstants.xUrl`. The `RemoteConstants` widget-tree provider disappears, so `projects_section.dart` and `resume_download_button.dart` drop their `flutter_bloc` `context.read` calls.

### Bootstrap simplification

`main.dart` loses the Firebase try/catch and the `AppDependencies` wrapper. `LoadingPage._preload` no longer runs `Future.wait([initRemoteConfig, precache])` — it just `await _precacheImages()`. The min-display gate stays (it prevents the sub-second flicker that reads as "broken"), but the floor drops from 1800ms to 700ms.

### Test harness

`mocks.dart` loses the Remote Config mocks (no boundaries left to mock; file kept as a placeholder). `helpers.dart` loses the `RemoteConstants` provider param, `buildFakeRemoteConstants`, and the fake repository. The `remote_config` test tree and `remote_config_enum_factory.dart` are deleted.

### Trade-offs

* **Keep a thin Remote Config layer for future tuning** — rejected. It was never used to tune anything; YAGNI. If runtime config is ever needed, [0002](0002-remote-config.md) documents how it was built and can be revived.
* **Keep analytics, wire it properly** — rejected for now. The observer was dead; re-adding analytics is a separate, deliberate decision (tracked in the roadmap), not a side effect of this cleanup.
* **Delete the splash floor entirely** — rejected. A sub-second flicker on fast connections reads as a broken page. 700ms keeps the brand impression and the "logo lands, bar fades in" animation legible while feeling fast.

## Tasks

* [x] Move all `TypeEnum` URLs to `AppConstants` constants.
* [x] Rewrite `ProjectsSectionData` factories to use constants, no `RemoteConstants` param.
* [x] Drop `context.read<RemoteConstants>()` from `projects_section.dart` and `resume_download_button.dart`.
* [x] Strip Firebase from `main.dart` and `AppWidget`.
* [x] Drop Remote Config from `LoadingPage._preload`; lower floor to 700ms.
* [x] Delete `lib/core/remote_config/`, `remote_config_providers.dart`, `firebase_options.dart`.
* [x] Remove the three `firebase_*` deps from `pubspec.yaml`.
* [x] Update the test harness; delete Remote Config tests + factory.
* [x] Update docs: README, CLAUDE.md, roadmap, harness README, supersede 0002, amend 0004.

## Verification

* [x] `flutter analyze` — zero issues.
* [x] `flutter test` — all 29 tests pass.
* [ ] Manual: hard-reload `/` in Chrome — splash visible ~700ms, fades out, `/home` arrives; project links + résumé download open correct URLs.
* [ ] CI: `.github/workflows/deploy.yml` builds `flutter build web --release` green on `master`.
