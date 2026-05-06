# 0005 — Test Harness

**Status:** shipped (retroactive — documents existing code as of 2026-05-06)
**Date:** 2026-05-06

## Context

Until now this repo had no `test/` directory at all. Adding tests piecemeal usually produces inconsistent fixtures: one test file declares an inline `MockFoo`, the next imports a fixture from a sibling test, and within a few weeks "where do mocks live" becomes a per-author judgment call.

Borrowing the convention from the Financo codebase, the rule is: **shared test setup lives in `test/harness/`, period**. Every test file imports from there. If you find yourself declaring a mock or building an entity inline, promote it.

This spec pins the harness shape, naming, and layering rules so the test surface scales without bikeshedding. It also defines the `pumpMaterialApp` and `buildFakeRemoteConstants` helpers — the two cross-cutting utilities every widget/use-case test reaches for first.

## Requirements

* All shared test infrastructure shall live in `test/harness/`.
* `test/harness/mocks.dart` shall hold every `mocktail` mock declaration plus a `registerFallbacks()` for `mocktail` matchers that need fallback values.
* `test/harness/helpers.dart` shall expose `pumpMaterialApp(tester, child: ...)` and `buildFakeRemoteConstants(...)`. It shall **re-export** `mocks.dart` so test files import a single path.
* `test/harness/factories/` shall hold one file per entity. Each file exposes static builders so tests never hardcode entity instances.
* Test files shall mirror the `lib/` tree — `lib/foo/bar.dart` → `test/foo/bar_test.dart`.
* Mocking happens at boundaries: repositories for use cases, services for repositories, use cases for cubits, repositories or use cases for widgets.
* `pumpMaterialApp` shall wire (a) `MaterialApp` with both real themes, (b) `TranslationProvider` so slang `t.*` resolves, and (c) optionally a `RepositoryProvider<RemoteConstants>` when the caller passes one.
* `buildFakeRemoteConstants` shall return a real `RemoteConstants` backed by an in-memory repository whose `getValue<T>` returns `enumValue.defaultValue` unless an override is supplied.

## Design

### Directory layout

```
test/
├── harness/
│   ├── README.md                    # consumer-facing usage notes
│   ├── mocks.dart                   # MockRemoteConfigRepository, MockRemoteConfigService, registerFallbacks
│   ├── helpers.dart                 # pumpMaterialApp, buildFakeRemoteConstants; re-exports mocks
│   └── factories/
│       └── remote_config_enum_factory.dart   # TestRemoteEnum + RemoteConfigEnumFactory.string/integer/...
├── app/
│   ├── theme/                       # mirrors lib/app/theme/
│   └── widgets/                     # mirrors lib/app/widgets/
└── core/
    ├── constants/                   # mirrors lib/core/constants/
    └── remote_config/
        ├── domain/usecases/
        └── infra/repositories/
```

### `mocks.dart`

```dart
class MockRemoteConfigRepository extends Mock implements RemoteConfigRepository {}
class MockRemoteConfigService extends Mock implements RemoteConfigService {}
class FakeRemoteConfigEnum extends Fake implements RemoteConfigEnum {}

void registerFallbacks() {
  registerFallbackValue(FakeRemoteConfigEnum());
}
```

Tests that use `any<RemoteConfigEnum>()` matchers must call `setUpAll(registerFallbacks)`.

### `helpers.dart` — `pumpMaterialApp`

```dart
Future<void> pumpMaterialApp(
  WidgetTester tester, {
  required Widget child,
  ThemeMode themeMode = ThemeMode.dark,
  RemoteConstants? remoteConstants,
  Size surfaceSize = const Size(1440, 900),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    TranslationProvider(
      child: _MaybeRemoteConstants(
        remoteConstants: remoteConstants,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
}
```

* `setSurfaceSize` is reset on tear-down so the next test starts from the framework default.
* `_MaybeRemoteConstants` is a tiny private widget that wraps with `RepositoryProvider<RemoteConstants>.value(...)` only when the caller supplies one (sections that don't read `RemoteConstants` shouldn't be forced to provide a fake).
* `themeMode` defaults to dark — that's the production default, so most tests should use it.

### `helpers.dart` — `buildFakeRemoteConstants`

```dart
RemoteConstants buildFakeRemoteConstants({
  Map<RemoteConfigEnum, Object>? overrides,
}) {
  final repo = _FakeRemoteConfigRepository(overrides ?? const {});
  return RemoteConstants(GetRemoteValueUseCase(repo));
}
```

Backed by a private `_FakeRemoteConfigRepository` that returns `_overrides[enumValue] ?? enumValue.defaultValue`. This deliberately uses the **real** `GetRemoteValueUseCase` so the fail-safe wrapping is exercised end-to-end — only the underlying source of values is faked.

### `factories/remote_config_enum_factory.dart`

`TestRemoteEnum` is a non-`enum` class implementing `RemoteConfigEnum`. It exists so use-case tests can construct ad-hoc keys with whatever default value type they need (`String`, `int`, `bool`, `List<int>`) without inventing production `TypeEnum` entries.

`RemoteConfigEnumFactory.string()`, `.integer()`, `.boolean()`, `.integerList()` return pre-configured `TestRemoteEnum`s with sensible defaults the test can override.

### Layering rules

| Test target  | Mock at boundary | Helper                                          |
| ------------ | ---------------- | ----------------------------------------------- |
| Use case     | Repository       | `MockRemoteConfigRepository` + factories        |
| Repository   | Service          | `MockRemoteConfigService`                       |
| Cubit        | Use case         | Plain `Mock` against the use case class         |
| Widget       | Repository / VM  | `pumpMaterialApp` + `buildFakeRemoteConstants`  |

Never mock multiple layers at once — a test that mocks both the repository and the service for a use-case test is testing the wiring of the mock library, not the code.

### Trade-offs considered and rejected

* **`mockito` (codegen) instead of `mocktail`** — rejected: codegen drag, and `mocktail` is the project-default elsewhere (Financo, internal Flutter ecosystem). No null-safety advantage with codegen on Dart 3.
* **A single `pumpApp` that always provides `RemoteConstants`** — rejected: forces every widget test to invent fake URLs even when the widget under test never reads them. The `_MaybeRemoteConstants` wrapper is six lines and removes the requirement.
* **Fixture JSON files in `test/fixtures/`** — rejected: factories give you typed entities, autocompletion, refactor-safety, and named overrides. JSON fixtures buy nothing here.
* **Re-exporting `mocks.dart` from `helpers.dart`** vs separate imports — chose to re-export so `import 'helpers.dart'` is the only line a test file needs. Trade-off: a slightly larger surface available to every test, accepted because the harness is small and won't grow unbounded.

## Tasks

Retrospective. The work is shipped; this list is a completeness check against as-built code.

* [x] `test/harness/mocks.dart` declares `MockRemoteConfigRepository`, `MockRemoteConfigService`, `FakeRemoteConfigEnum`, `registerFallbacks()`.
* [x] `test/harness/helpers.dart` exposes `pumpMaterialApp` and `buildFakeRemoteConstants`; re-exports `mocks.dart`.
* [x] `test/harness/factories/remote_config_enum_factory.dart` exposes `TestRemoteEnum` + `RemoteConfigEnumFactory.string|integer|boolean|integerList`.
* [x] `test/harness/README.md` documents file purpose, layering rules, and the "promote to harness" rule.
* [x] First wave of tests imports the harness and follows the layering rules — `get_remote_value_usecase_test`, `theme_cubit_test`, `tech_chip_test`.

## Verification

* [x] Tests: [`test/harness/helpers_test.dart`](../../test/harness/helpers_test.dart) self-tests `pumpMaterialApp` (TranslationProvider wired, optional `RemoteConstants` provider) and `buildFakeRemoteConstants` (returns defaults; overrides applied).
* [x] `flutter analyze` reports zero issues across `test/`.
* [x] `flutter test` runs every file in `test/` (excluding `harness/`), all green.
* [ ] Manual review: a new test file added in this repo by a contributor with no prior context can be authored end-to-end by reading only `test/harness/README.md` and one existing example.
