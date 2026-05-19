import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

void main() {
  group('AppColorsExtension presets', () {
    test('midnightOcean and arcticLight expose distinct background colors',
        () {
      expect(
        AppColorsExtension.midnightOcean.background,
        isNot(equals(AppColorsExtension.arcticLight.background)),
      );
    });

    test('both presets expose all token getters', () {
      // A passing compile is half the point — this test guards against a
      // future refactor that drops a token from one preset.
      const dark = AppColorsExtension.midnightOcean;
      const light = AppColorsExtension.arcticLight;

      for (final preset in [dark, light]) {
        expect(preset.background, isA<Color>());
        expect(preset.surface, isA<Color>());
        expect(preset.surfaceLight, isA<Color>());
        expect(preset.cardBorder, isA<Color>());
        expect(preset.textPrimary, isA<Color>());
        expect(preset.textSecondary, isA<Color>());
        expect(preset.textMuted, isA<Color>());
        expect(preset.primary, isA<Color>());
        expect(preset.secondary, isA<Color>());
        expect(preset.accent, isA<Color>());
        expect(preset.success, isA<Color>());
        expect(preset.divider, isA<Color>());
        expect(preset.primaryGradient, isA<LinearGradient>());
        expect(preset.heroGradient, isA<LinearGradient>());
        expect(preset.cardGradient, isA<LinearGradient>());
        expect(preset.awardGradient, isA<LinearGradient>());
        expect(preset.awardForeground, isA<Color>());
        expect(preset.awardShadow, isA<Color>());
        expect(preset.navShadow, isA<Color>());
      }
    });

    test('award tokens are shared across both presets', () {
      const dark = AppColorsExtension.midnightOcean;
      const light = AppColorsExtension.arcticLight;

      expect(dark.awardGradient, light.awardGradient);
      expect(dark.awardForeground, light.awardForeground);
      expect(dark.awardShadow, light.awardShadow);
    });

    test('navShadow differs between dark and light presets', () {
      expect(
        AppColorsExtension.midnightOcean.navShadow,
        isNot(equals(AppColorsExtension.arcticLight.navShadow)),
      );
    });
  });

  group('copyWith', () {
    test('replaces only the supplied field', () {
      const original = AppColorsExtension.midnightOcean;
      final replaced = original.copyWith(primary: const Color(0xFF112233));

      expect(replaced.primary, const Color(0xFF112233));
      expect(replaced.background, original.background);
      expect(replaced.secondary, original.secondary);
      expect(replaced.cardGradient, original.cardGradient);
    });
  });

  group('lerp', () {
    test('returns this when other is null', () {
      const colors = AppColorsExtension.midnightOcean;
      expect(colors.lerp(null, 0.5), same(colors));
    });

    test('at t=0 returns the start preset, at t=1 returns the end', () {
      const dark = AppColorsExtension.midnightOcean;
      const light = AppColorsExtension.arcticLight;

      final atZero = dark.lerp(light, 0);
      final atOne = dark.lerp(light, 1);

      expect(atZero.background, dark.background);
      expect(atOne.background, light.background);
    });

    test('interpolates background colors at midpoint', () {
      const dark = AppColorsExtension.midnightOcean;
      const light = AppColorsExtension.arcticLight;

      final midpoint = dark.lerp(light, 0.5);
      final expected = Color.lerp(dark.background, light.background, 0.5);

      expect(midpoint.background, expected);
    });
  });
}
