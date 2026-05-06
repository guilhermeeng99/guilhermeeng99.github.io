# 0002 — Remote Config Module

**Status:** shipped (retroactive — documents existing code as of 2026-05-06)
**Date:** 2026-05-06

## Context

Several portfolio entries — store links, award articles, the résumé PDF, the GitHub Pages-hosted demo URLs — change independently of code releases. Hardcoding them would force a redeploy for every URL change and would couple project data to the deploy schedule. Firebase Remote Config solves the rotation problem, but its SDK is a global singleton with stringly-typed keys, no defaults, and silent failures — none of which we want leaking into UI code.

This spec documents the layered module that wraps Remote Config behind a domain-first interface: `TypeEnum` is the single source of truth for key + default-value pairs, `GetRemoteValueUseCase` exposes typed accessors with a fail-safe fallback to the enum's default, and `RemoteConstants` re-surfaces named getters so sections never reach into the use case directly.

## Requirements

* Every Remote Config key shall live in `TypeEnum` ([lib/core/remote_config/domain/entities/type_enum.dart](../../lib/core/remote_config/domain/entities/type_enum.dart)) with a sane default value baked in.
* Reading a value must never throw to the UI. If the underlying repository or service fails for any reason, the use case shall return the enum's `defaultValue`.
* Sections shall consume `RemoteConstants` (named getters), never `GetRemoteValueUseCase` directly.
* The Firebase SDK is reachable only from `infra/services/firebase_remote_config_service.dart`. Domain code must not import `package:firebase_remote_config/...`.
* `RemoteConfigInitializeUseCase.call()` shall (a) push every `TypeEnum` default to Firebase, (b) configure fetch timeouts, (c) call `fetchAndActivate`, and (d) swallow init errors — the app must boot even if Remote Config is unreachable.
* Adding a new key shall require touching exactly two files: `TypeEnum` (entry + default) and `RemoteConstants` (getter).

## Design

### Layering

```
domain/
  entities/
    remote_config_enum.dart        # interface: { key, defaultValue }
    type_enum.dart                 # enum implementing RemoteConfigEnum, all keys + defaults
  repositories/
    remote_config_repository.dart  # abstract interface { T getValue<T>(RemoteConfigEnum) }
  usecases/
    get_remote_value_usecase.dart  # call<T>, callString, callInt, callDouble, callBool, callIntList
    remote_config_initialize.dart  # one-shot init pushing defaults + fetchAndActivate
infra/
  services/
    remote_config_service.dart           # interface mirroring repository
    firebase_remote_config_service.dart  # Firebase SDK adapter
  repositories/
    remote_config_repository_impl.dart   # delegates to service
```

The barrel [lib/core/remote_config/remote_config.dart](../../lib/core/remote_config/remote_config.dart) re-exports the public surface so consumers import a single path.

### Type-safe accessors and the fail-safe wrapper

`GetRemoteValueUseCase.call<T>(enumValue, defaultValue: ...)` is the generic core: it tries `repository.getValue<T>(enumValue)` and on **any** thrown error returns the supplied default. The typed siblings (`callString`, `callInt`, `callDouble`, `callBool`) cast `enumValue.defaultValue` to the right type so callers don't have to repeat the default at every call site.

`callIntList` is special-cased: Firebase Remote Config doesn't natively support list values, so the wire format is a comma-separated string (`"1, 2, 3"` or `"[1, 2, 3]"`). The use case strips brackets, splits on commas, parses each entry, and falls back to the enum default on the first parse failure.

### Initialization

`RemoteConfigInitializeUseCase.call()`:

1. Builds `defaultParameters` as `{ enum.key: enum.defaultValue }` from `TypeEnum.values`.
2. Sets fetch settings: `fetchTimeout: 1 minute`, `minimumFetchInterval: 1 hour`.
3. Calls `setDefaults(defaultParameters)` so reads have a value even before fetch completes.
4. Calls `fetchAndActivate()` inside a `try`/`on Object` so a network outage at boot doesn't block the loading screen — failures log via `dart:developer` and the app proceeds with defaults.

This is invoked from `LoadingPage._initializeRemoteConfig()` while the splash is animating, in parallel with image precache.

### `RemoteConstants` accessor surface

[lib/core/constants/app_constants.dart](../../lib/core/constants/app_constants.dart) exposes one getter per key (`resumeUrl`, `magicSortUrl`, `googlePlayBestOf2021Url`, …). This is the only API sections call. The widget tree provides it via `MultiRepositoryProvider` in `AppDependencies` ([lib/app/providers/remote_config_providers.dart](../../lib/app/providers/remote_config_providers.dart)).

### `FirebaseRemoteConfigServiceImpl` source-checked default

The service ([lib/core/remote_config/infra/services/firebase_remote_config_service.dart](../../lib/core/remote_config/infra/services/firebase_remote_config_service.dart)) inspects `RemoteValue.source` — if it's `ValueSource.valueStatic` (no default registered, no remote value) it returns the enum default directly instead of letting Firebase return an empty string / zero. This catches the case where a new `TypeEnum` entry hasn't been pushed via `setDefaults` yet (e.g. dev environment, first boot before init completes).

### Trade-offs considered and rejected

* **Generated bindings (`build_runner`)** for `RemoteConstants` getters — rejected: 21 keys, manual mapping is half the boilerplate of a build pipeline and avoids adding `build_runner` to the dev loop.
* **Streams of remote values** for live updates without restart — rejected: portfolio URLs change on the order of months; a one-shot fetch on boot is the right cadence.
* **Throwing on missing keys** — rejected: a missing key in production means a redeploy is required to surface the failure. Falling back to the enum default at every layer keeps the page rendering even with a misconfigured project.

## Tasks

Retrospective. The work is shipped; this list is a completeness check against as-built code.

* [x] `TypeEnum` holds every key + default; no Firebase imports in domain.
* [x] `GetRemoteValueUseCase.call` wraps repository calls with try/return-default.
* [x] Typed accessors (`callString`, `callInt`, `callDouble`, `callBool`, `callIntList`) implemented.
* [x] `callIntList` parses comma-separated payload, strips brackets, falls back to default on parse failure.
* [x] `RemoteConfigRepositoryImpl` delegates one-line to the service; no logic.
* [x] `FirebaseRemoteConfigServiceImpl` returns enum default when `RemoteValue.source == ValueSource.valueStatic`.
* [x] `RemoteConfigInitializeUseCase` swallows init errors via `try/on Object`.
* [x] `RemoteConstants` exposes one getter per key.
* [x] `AppDependencies` provides `RemoteConfigInitializeUseCase` and `RemoteConstants` via `MultiRepositoryProvider`.
* [x] `LoadingPage` invokes `RemoteConfigInitializeUseCase` in parallel with image precache.

## Verification

* [x] Tests: [`test/core/remote_config/domain/usecases/get_remote_value_usecase_test.dart`](../../test/core/remote_config/domain/usecases/get_remote_value_usecase_test.dart) covers typed accessors + fail-safe path.
* [x] Tests: [`test/core/remote_config/infra/repositories/remote_config_repository_impl_test.dart`](../../test/core/remote_config/infra/repositories/remote_config_repository_impl_test.dart) covers service delegation.
* [x] Tests: [`test/core/constants/remote_constants_test.dart`](../../test/core/constants/remote_constants_test.dart) covers each `RemoteConstants` getter wiring to its `TypeEnum` key.
* [ ] Manual: temporarily break the network in DevTools, hard-reload `/` — `LoadingPage` still proceeds to `/home` after ~1.8s and Projects section renders with default URLs.
* [ ] Manual: change `resume_url` in the Firebase Remote Config console, hard-reload — résumé download button picks up the new URL within one minute (fetch interval).
