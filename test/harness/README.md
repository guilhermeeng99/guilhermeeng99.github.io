# Test Harness

Shared test infrastructure for `my_portfolio`. Mirrors the convention from the Financo codebase.

## Files

| File                                     | Purpose                                                                                          |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `mocks.dart`                             | Centralized `mocktail` mock declarations + `registerFallbacks()`. Currently empty — the app has no service/repository boundaries to mock since Firebase/Remote Config were removed ([spec 0006](../../docs/specs/0006-remove-firebase-remote-config.md)). |
| `helpers.dart`                           | `pumpMaterialApp(tester, child: ...)`. Re-exports `mocks.dart`.                                  |
| `factories/`                             | One file per entity. Each exposes static builders so tests never hardcode entities.              |

## Conventions

* Import `helpers.dart` (it re-exports mocks) — your test file should rarely need to reach into `mocks.dart` directly.
* If you find yourself declaring a mock or building an entity inline in a test, **promote it into the harness**.
* When a new mock boundary appears, declare it in `mocks.dart` and call `registerFallbacks()` once in your test file's `setUpAll` if you use `any()` matchers against a non-primitive type.
* Use `pumpMaterialApp` for any widget test — it wires `MaterialApp` and `TranslationProvider` (slang) in one call.

## Layering

| Test target  | Mock at boundary  | Helper to use                                    |
| ------------ | ----------------- | ------------------------------------------------ |
| Use case     | Repository        | `Mock` against the repository class + factories  |
| Repository   | Service           | `Mock` against the service class                 |
| Cubit        | Use case          | Plain `Mock` against the use case class          |
| Widget       | Repository / VM   | `pumpMaterialApp`                                |
