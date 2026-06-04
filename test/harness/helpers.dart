import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/app_theme.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

export 'mocks.dart';

/// Pumps `child` inside a fully wired-up `MaterialApp` so widget tests have
/// access to theme and slang translations.
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
  Size surfaceSize = const Size(1440, 900),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home: Scaffold(body: child),
      ),
    ),
  );
}
