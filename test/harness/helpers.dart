import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/app_theme.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

export 'mocks.dart';

/// Pumps `child` inside a fully wired-up `MaterialApp` so widget tests have
/// access to theme, slang translations, and (optionally) a `RemoteConstants`
/// repository provider.
///
/// Example:
/// ```dart
/// await pumpMaterialApp(tester, child: const ContactSection());
/// expect(find.text(t.contact.title), findsOneWidget);
/// ```
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

/// Builds a `RemoteConstants` backed by the in-memory fake repository, so
/// section widgets that consume it via `context.read<RemoteConstants>()` get
/// deterministic URLs in tests.
RemoteConstants buildFakeRemoteConstants({
  Map<RemoteConfigEnum, Object>? overrides,
}) {
  final repo = _FakeRemoteConfigRepository(overrides ?? const {});
  return RemoteConstants(GetRemoteValueUseCase(repo));
}

class _MaybeRemoteConstants extends StatelessWidget {
  const _MaybeRemoteConstants({required this.child, this.remoteConstants});

  final Widget child;
  final RemoteConstants? remoteConstants;

  @override
  Widget build(BuildContext context) {
    if (remoteConstants == null) return child;
    return RepositoryProvider<RemoteConstants>.value(
      value: remoteConstants!,
      child: child,
    );
  }
}

/// Returns `enumValue.defaultValue` unless an override is supplied, mirroring
/// `RemoteConfigRepositoryImpl` semantics without touching Firebase.
class _FakeRemoteConfigRepository implements RemoteConfigRepository {
  _FakeRemoteConfigRepository(this._overrides);

  final Map<RemoteConfigEnum, Object> _overrides;

  @override
  T getValue<T>(RemoteConfigEnum enumValue) {
    final value = _overrides[enumValue] ?? enumValue.defaultValue;
    return value as T;
  }
}
