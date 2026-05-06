# 0004 — Loading + Bootstrap Flow

**Status:** shipped (retroactive — documents existing code as of 2026-05-06)
**Date:** 2026-05-06

## Context

The portfolio's first frame is the `LoadingPage`. Behind that splash, three things must complete before the user lands on `/home`:

1. **Firebase init** — required so `FirebaseAnalytics`, `FirebaseRemoteConfig`, etc. can be referenced inside `AppDependencies` without throwing.
2. **Remote Config init** — fetches dynamic URLs that the `ProjectsSection` and résumé download need; without this, we render with `TypeEnum` defaults.
3. **Image precache** — the profile photo (and downstream, the project images) load eagerly so the hero/projects sections don't pop in.

Without orchestration, an empty white frame shows until everything resolves; with orchestration, the user sees a polished animated logo for a guaranteed minimum 1.8s. This spec pins the timing, the parallelism, and the failure-tolerant shape of that bootstrap so a future change (adding another async warmup, rewriting the splash, persisting auth) doesn't accidentally break the perceived-load contract.

## Requirements

* `main.dart` shall: bind Flutter, sync the device locale to slang, initialise Firebase (with logged-not-thrown failure), and run the app inside `AppDependencies(TranslationProvider(child: AppWidget()))`.
* `LoadingPage` shall render an animated logo + linear progress indicator over `context.appColors.background`, displayed for **at least** 1800ms even if init completes faster.
* The two async warmups (`RemoteConfigInitializeUseCase.call()` and profile image precache) shall run in **parallel** via `Future.wait`.
* Init failures shall **not block navigation** — a failed Remote Config or precache logs and the page still proceeds to `/home`.
* After init + min-display elapse, the splash shall fade out over 500ms (`AnimatedOpacity`), then `context.go('/home')` triggers the `FadeTransition` route transition (400ms) defined in `app_router.dart`.
* Navigation shall be guarded by `mounted` checks at every async boundary so a fast user closing the tab doesn't trigger `setState` after dispose.

## Design

### `main.dart` ([lib/main.dart](../../lib/main.dart))

```dart
WidgetsFlutterBinding.ensureInitialized();
LocaleSettings.useDeviceLocaleSync();           // slang locale bootstrap
try {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
} on Exception catch (e) {
  Logger().e('Firebase initialization failed', error: e);
}
runApp(
  AppDependencies(child: TranslationProvider(child: const AppWidget())),
);
```

The locale call is **before** Firebase so `TranslationProvider` has a valid locale available even if Firebase init throws. `Firebase.initializeApp` is wrapped in `try/on Exception` so the app boots in degraded mode (no analytics, no remote config) rather than showing a blank screen.

`AppDependencies` ([lib/app/providers/remote_config_providers.dart](../../lib/app/providers/remote_config_providers.dart)) wraps `MultiRepositoryProvider` providing:

* `RemoteConfigInitializeUseCase` (no construction args — this is a `const` use case).
* `RemoteConstants` (built from `GetRemoteValueUseCase(RemoteConfigRepositoryImpl(FirebaseRemoteConfigServiceImpl()))`).

These providers are factories — the actual Firebase calls happen lazily when sections read them.

### `LoadingPage._preload()` ([lib/features/loading/presentation/pages/loading_page.dart](../../lib/features/loading/presentation/pages/loading_page.dart))

```
preload:
  start stopwatch
  await endOfFrame                              # let MaterialApp render the splash first
  if !mounted: return
  Future.wait([
    initializeRemoteConfig(),                   # tolerates failure (logs)
    precacheImages(),                           # tolerates failure (onError no-op)
  ])  inside try/on Exception
  if elapsed < 1800ms: delay(1800 - elapsed)
  if !mounted: return
  setState(_fadeOut = true)
  delay(500ms)                                  # AnimatedOpacity transition
  if !mounted: return
  context.go('/home')
```

The `endOfFrame` await is what guarantees the user sees the splash at least once — without it, a fast Firebase init could `context.go` before the first paint. The min-display gate is enforced after `Future.wait` so a slow init doesn't double the splash duration; it only pads when we're faster than 1.8s.

### Splash visuals

`LoadingPage` is a `Stack`-free `Scaffold` with `AnimatedOpacity(opacity: _fadeOut ? 0.0 : 1.0)` wrapping a centred `Column` of:

1. `_AnimatedLogo` — `AnimationController(800ms)` driving `Transform.scale(0.5 → 1.0, easeOutBack)` and `Opacity(0 → 1, easeOut)`. Forward-starts after a 200ms delay.
2. `_LoadingIndicator` — `LinearProgressIndicator` (3px, primary on surfaceLight) wrapped in an `Opacity` driven by an `AnimationController(1200ms)` with an `Interval(0.3, 1.0, easeOut)` curve. Forward-starts after a 600ms delay.

The staggered start delays (200ms logo, 600ms indicator) produce the "logo lands first, then progress bar fades in" feel without orchestrating a single controller.

### Route transition

`app_router.dart`'s `/home` `pageBuilder` returns a `CustomTransitionPage` with a `FadeTransition` (400ms). Combined with the splash's 500ms `AnimatedOpacity` fade-out, total perceived crossfade is ~900ms — long enough to read as intentional, short enough not to feel sluggish.

### Trade-offs considered and rejected

* **Skip min-display when init is fast** — rejected: a sub-second flicker between loading screen and content reads as "broken page" on slow connections where the user expects feedback. The 1.8s floor is a UX choice.
* **Sequential init** (Firebase → RemoteConfig → precache) — rejected: precache only depends on the `BuildContext` for `precacheImage`, not on Firebase. Parallelising shaves ~200–400ms typical.
* **Throwing on Firebase init failure and showing an error screen** — rejected: a portfolio that *can't* render because analytics is down would be worse than the degraded mode. We log and proceed.
* **Persisting "skip splash next time"** — rejected: the splash also doubles as the brand impression; skipping it on repeat visits hides the loading bar that real warmups still need.

## Tasks

Retrospective. The work is shipped; this list is a completeness check against as-built code.

* [x] `main.dart` order: ensureInitialized → useDeviceLocaleSync → Firebase init (try/log) → runApp.
* [x] `runApp` wraps the tree in `AppDependencies(TranslationProvider(child: AppWidget()))`.
* [x] `AppDependencies` provides `RemoteConfigInitializeUseCase` + `RemoteConstants` via `MultiRepositoryProvider`.
* [x] `LoadingPage._preload` awaits `endOfFrame`, runs `Future.wait` of init + precache inside try/on Exception.
* [x] Min-display gate enforces ≥1800ms via `Stopwatch` + `Future.delayed`.
* [x] `mounted` checks at every async boundary (3 occurrences).
* [x] Splash fade-out is 500ms via `AnimatedOpacity`; route transition is 400ms `FadeTransition`.
* [x] `_AnimatedLogo` uses 800ms `easeOutBack` scale + `easeOut` opacity, 200ms forward delay.
* [x] `_LoadingIndicator` uses 1200ms `Interval(0.3, 1.0, easeOut)`, 600ms forward delay.

## Verification

* [ ] Tests: `LoadingPage` is not unit-tested today — exercising it requires a Firebase test harness and faked `RemoteConfigInitializeUseCase`. Tracked as a follow-up; manual checks below cover the contract.
* [ ] Manual: hard-reload `/` in Chrome — splash visible, fades out, `/home` arrives. Total time ≥1.8s.
* [ ] Manual: throttle network to "Slow 3G" in DevTools, hard-reload — splash visible for the duration of init, no white flash.
* [ ] Manual: simulate Remote Config failure (block `firebaseremoteconfig.googleapis.com` in DevTools network) — splash still proceeds; Projects section renders with `TypeEnum` defaults.
* [ ] Manual: rapidly navigate away from `/` (close tab) before splash completes — no `setState() called after dispose()` errors in the console.
* [ ] CI: `.github/workflows/deploy.yml` builds `flutter build web --release` green on `master`.
