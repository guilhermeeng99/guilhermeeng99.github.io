import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    // The theme getters call GoogleFonts.* which schedules async font
    // fetches. In bare `test()` blocks an unhandled async error from a
    // failed fetch fails the test; `testWidgets` runs inside FakeAsync
    // so those errors are handled. Hence the testWidgets-everywhere shape.

    testWidgets('darkTheme registers AppColorsExtension(midnightOcean)',
        (tester) async {
      final theme = AppTheme.darkTheme;
      final colors = theme.extension<AppColorsExtension>();

      expect(colors, isNotNull);
      expect(colors!.background, AppColorsExtension.midnightOcean.background);
      expect(theme.scaffoldBackgroundColor, colors.background);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    testWidgets('lightTheme registers AppColorsExtension(arcticLight)',
        (tester) async {
      final theme = AppTheme.lightTheme;
      final colors = theme.extension<AppColorsExtension>();

      expect(colors, isNotNull);
      expect(colors!.background, AppColorsExtension.arcticLight.background);
      expect(theme.scaffoldBackgroundColor, colors.background);
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    testWidgets('both themes expose the typography roles widgets rely on',
        (tester) async {
      for (final theme in [AppTheme.darkTheme, AppTheme.lightTheme]) {
        final text = theme.textTheme;
        expect(text.displayLarge, isNotNull);
        expect(text.displayMedium, isNotNull);
        expect(text.displaySmall, isNotNull);
        expect(text.headlineMedium, isNotNull);
        expect(text.headlineSmall, isNotNull);
        expect(text.titleLarge, isNotNull);
        expect(text.titleMedium, isNotNull);
        expect(text.bodyLarge, isNotNull);
        expect(text.bodyMedium, isNotNull);
        expect(text.labelLarge, isNotNull);
        expect(text.labelMedium, isNotNull);
      }
    });

    testWidgets('context.appColors returns the dark preset under darkTheme',
        (tester) async {
      late AppColorsExtension resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Builder(
            builder: (context) {
              resolved = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved.background, AppColorsExtension.midnightOcean.background);
    });

    testWidgets('context.appColors returns the light preset under lightTheme',
        (tester) async {
      late AppColorsExtension resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (context) {
              resolved = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved.background, AppColorsExtension.arcticLight.background);
    });
  });
}
