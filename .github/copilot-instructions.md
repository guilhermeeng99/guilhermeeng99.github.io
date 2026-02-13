# Web site - AI Developer Instructions

Improve the following Flutter widget code for better performance, and maintainability. Focus on optimizing to mobile platforms while ensuring the code remains clean and well-structured. Avoid unnecessary rebuilds, optimize layout calculations, and enhance state management where applicable.

Dont add any comments in the code.

Always use UIControl.width, UIControl.height or UIControl.mqSize instead of MediaQuery directly.

Always ensure that the visual output remains unchanged after your improvements.

Always return before and after metrics including performance metrics such as frame build time, memory usage, and CPU load, as well as code quality metrics like lines of code, cyclomatic complexity, and maintainability index.

Additionally, indicate the real performance gain percentage after optimization (e.g., “was 50%, now 70%”).

Use an icon in each indication of improvement made to ease identification and use a table format for the metrics.

Don't remove super.key from public constructors of widgets.

Everything must be in English.

# Magic Sort - AI Developer Instructions

Magic Sort is a match-3 puzzle game built with Flutter and Dart. This guide helps AI agents understand the codebase architecture and accelerate development.

---

## ⚙️ Global Development Rules

- ✅ **Always verify `context.mounted` before calling `setState` or performing UI updates inside Futures, async methods, or delayed callbacks.**

  ```dart
  Future<void> loadData(BuildContext context) async {
    final data = await fetchData();
    if (!context.mounted) return;
    setState(() => _data = data);
  }
  ```

- ✅ **Prioritize performance for mobile** (Android and iOS):

  - Avoid unnecessary rebuilds and re-renders.
  - Use `const` constructors where possible.
  - Minimize widget tree depth.
  - Use `ListView.builder` or `GridView.builder` for long lists.
  - Avoid heavy computations in the build method — move logic to controllers or isolates.
  - Cache images, fonts, and audio assets.
  - Use lightweight animations and avoid unnecessary Rive rebuilds.
  - Dispose controllers and streams properly.

---

## Project Overview

**Name**: Guilherme Passos (Project: `gp`)
**Type**: Flutter web site
**Architecture**: Clean architecture
**Key Platforms**: Web, Android, iOS, Windows, macOS
**Min SDK**: Dart 3.1.4+, Flutter 3.22.1+

---

## Architecture Layers

### 1. Monorepo Structure

**Main App**: `lib/` - Core game application
**Service Packages**: `packages/services/` - Shared business logic (database, ads, analytics, IAP, audio, notifications, etc.)
**Local Packages**: `packages/` - Game-specific utilities (game_creator, ms_level_creator, core, ui components)

**Example package boundaries**:

- `packages/core/` - Riverpod providers, error handling, use cases
- `packages/services/database/` - Firestore + Hive (local cache) integration
- `packages/services/user/` - User data models and repositories
- `packages/services/remote_config/` - A/B testing values and feature flags

---

### 2. Screen Folder Structure Pattern

Each major screen follows **clean architecture** with three parts:

```
lib/screens/[feature]/
├── domain/
│   └── entities/              # Data models
├── infra/ (or data/)
│   └── local_data/            # Local database/cache logic
├── presentation/
│   ├── [feature]_bindings.dart    # GetX dependency injection
│   ├── [feature]_bloc.dart        # Business logic (if complex)
│   ├── [feature]_controller.dart  # GetX controller
│   └── [feature]_page.dart        # UI widget tree
└── [feature].dart                 # Library entry point (export all)
```

**Example**:
`lib/screens/home/main_home/main_home.dart` - Barrel export with `library main_home;` and `part` declarations.

---

### 3. State Management

**Framework**: Riverpod (hooks_riverpod) + GetX for navigation
**Data Flow**:

1. Use `Riverpod` providers for reactive state in `packages/`
2. Use `GetX` controllers (Binding + Controller) for screen-level state
3. Store global Riverpod container: `pc = ProviderContainer()` in `core/core.dart`

**Pattern:**

```dart
// In bindings
Bind.put<Type>(instance);

// In code
Get.find<Type>();
```

---

### 4. Level System

**Level Definition**: `packages/ms_level_creator/` creates level objects via `Level` class
**Generated Levels**: `lib/levels/generated_levels/`
**Static Levels**: `lib/levels/` and `lib/levels_b/`
**Level Loading**: `lib/screens/game/main_game/levels/all_levels.dart`

**Key**:

- Use `LazyLevel(() => level_N)` for lazy initialization (**performance critical**).
- Levels are date-mapped:

  ```dart
  DateTime.utc(2025, 10, 03): [LazyLevel(...), ...]
  ```

---

### 5. Meta Game System

**Location**: `lib/screens/core/meta_game/`
**Pattern**: Event-driven mini-games/features stacked on the main game

**Examples**: Battle Pass, Magic League, Treasure Hunts, Daily Rewards, Dungeon Quest, Space Rush

**Registration**:

```dart
Get.put<MetaGameController>(
  MetaGameController(
    metaGames: [
      MG_Archery(...),
      MG_BattlePass(...),
    ],
  ),
  permanent: true,
);
```

---

## Critical Developer Workflows

### Build & Run Commands

```bash
flutter pub get
flutter run -v
dart run wsp:localizations
dart run wsp:localizations export
dart run wsp:localizations import
fluttergen
dart run wsp:webp
dart analyze
dart format lib/
dart fix --apply
```

---

## Testing & Debugging

- Enable performance overlay:
  `AppDebugSettings.withPerformance.value = true`
- Configure A/B testing values in `app_debug_settings.dart`
- Lock orientation: `SystemChrome.setPreferredOrientations`
- Crash reporting via Firebase Crashlytics

---

## Dependency Injection Flow

1. **Early app init** (`main.dart` → `AppBindings.initializeBeforeApp()`):

   - Firebase, translations, crash/error handlers

2. **Loading screen** (`AppBindings.initializeOnLoading()`):

   - Analytics, SDKs, local database, meta-games, remote config

3. **After first frame** (`AppBindings.initializeAfterApp()`):

   - Audio system, IAP registration, analytics open event

---

## Code Patterns & Conventions

### Imports Organization

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wsp/app/...';
```

### Library Entry Points

```dart
library quit_level;
part 'presentation/quit_level_bloc.dart';
part 'presentation/quit_level_controller.dart';
part 'presentation/quit_level_pop_up.dart';
part 'quit_level_bindings.dart';
```

### Global Functions/Exports

- Use `Get.find<T>()` for dependency access.
- Comments **must be in English** only.
- Always **check `context.mounted`** before updating UI after async tasks.

---

## Performance Considerations

1. Use **lazy initialization** for levels (`LazyLevel`).
2. Pre-cache images (`LoadingScreen.cacheLoading()`).
3. Use WebP assets (`dart run wsp:webp`).
4. Use `const` constructors for static widgets.
5. Avoid logic in `build()` methods.
6. Dispose streams, controllers, and listeners properly.
7. Use lightweight widgets and efficient state updates.
8. Always prefer **mobile-first optimizations** (minimize jank and memory overhead).
9. **Extract repeated const values to top-level constants** (e.g., `LinearGradient`, `BoxDecoration`, `TextStyle`, `EdgeInsets`, `BorderRadius`) to avoid runtime allocations and enable compile-time optimization.

### Const Extraction Rules (Performance Critical)

When the same `const` object is used **3+ times** in a file, extract it to a **top-level private constant**:

```dart
// ✅ GOOD - Top-level const (zero runtime allocation)
const _kTextGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFFBF2D5), Color(0xFFEFD5B3)],
);

// Then use: linearGradient: _kTextGradient,

// ❌ BAD - Inline const (still allocates object reference per use)
linearGradient: const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFFBF2D5), Color(0xFFEFD5B3)],
),
```

**Common candidates for extraction:**
- `LinearGradient` / `RadialGradient`
- `BoxDecoration`
- `TextStyle`
- `EdgeInsets` / `EdgeInsetsDirectional`
- `BorderRadius`
- `BoxShadow` lists
- `Duration`
- Repeated `Color` values

---

## Integration Points

- **Firebase**: Analytics, Crashlytics, Remote Config
- **Platform SDK** (`wildlife_platform`): Analytics, user identification
- **Social**: Facebook tracking, `share_plus`
- **Notifications**: Local + Push
- **Device Info**: `device_info_plus`, `device_region`

---
