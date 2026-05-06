# Test Harness

Shared test infrastructure for `my_portfolio`. Mirrors the convention from the Financo codebase.

## Files

| File                                     | Purpose                                                                                          |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `mocks.dart`                             | Centralized `mocktail` mocks (`MockRemoteConfigRepository`, `MockRemoteConfigService`) + `registerFallbacks()` |
| `helpers.dart`                           | `pumpMaterialApp(tester, child: ...)`, `buildFakeRemoteConstants(...)`. Re-exports `mocks.dart`. |
| `factories/`                             | One file per entity. Each exposes static builders so tests never hardcode entities.              |

## Conventions

* Import `helpers.dart` (it re-exports mocks) — your test file should rarely need to reach into `mocks.dart` directly.
* If you find yourself declaring a mock or building an entity inline in a test, **promote it into the harness**.
* Call `registerFallbacks()` once in your test file's `setUpAll` if you use `any()` matchers against `RemoteConfigEnum`.
* Use `pumpMaterialApp` for any widget test — it wires `MaterialApp`, `TranslationProvider` (slang), and the optional `RemoteConstants` repository provider in one call.

## Layering

| Test target  | Mock at boundary  | Helper to use                                    |
| ------------ | ----------------- | ------------------------------------------------ |
| Use case     | Repository        | `MockRemoteConfigRepository` + factories         |
| Repository   | Service           | `MockRemoteConfigService`                        |
| Cubit        | Use case          | Plain `Mock` against the use case class          |
| Widget       | Repository / VM   | `pumpMaterialApp` + `buildFakeRemoteConstants`   |
