import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

abstract final class AppTheme {
  // Self-hosted families declared in pubspec.yaml (no runtime font fetch).
  static const String _display = 'SpaceGrotesk';
  static const String _body = 'Inter';
  static const String _mono = 'JetBrainsMono';

  static ThemeData get darkTheme {
    const colors = AppColorsExtension.midnightOcean;

    // fontFamily: _body makes Inter the global default so CanvasKit never
    // falls back to fetching Roboto from fonts.gstatic.com for unstyled text
    // (tooltips, etc.) — keeping the app fully self-hosted (no font network).
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: _body,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
      ),
      extensions: const [colors],
      textTheme: _textTheme(ThemeData.dark().textTheme, colors),
    );
  }

  static ThemeData get lightTheme {
    const colors = AppColorsExtension.arcticLight;

    return ThemeData(
      brightness: Brightness.light,
      fontFamily: _body,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
      ),
      extensions: const [colors],
      textTheme: _textTheme(ThemeData.light().textTheme, colors),
    );
  }

  /// Both presets share the same type scale; only the color tokens differ, so
  /// the role styles live here once and are applied over the mode's base theme.
  static TextTheme _textTheme(TextTheme base, AppColorsExtension colors) {
    return base.apply(fontFamily: _body).copyWith(
      displayLarge: TextStyle(
        fontFamily: _display,
        fontSize: 72,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -2,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontFamily: _display,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
        letterSpacing: -1.5,
        height: 1.2,
      ),
      displaySmall: TextStyle(
        fontFamily: _display,
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
        letterSpacing: -1,
      ),
      headlineMedium: TextStyle(
        fontFamily: _display,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: _display,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: _body,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: _body,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colors.textSecondary,
      ),
      bodyLarge: TextStyle(
        fontFamily: _body,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        height: 1.7,
      ),
      bodyMedium: TextStyle(
        fontFamily: _body,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        height: 1.6,
      ),
      labelLarge: TextStyle(
        fontFamily: _body,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: _mono,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: colors.secondary,
      ),
    );
  }
}
