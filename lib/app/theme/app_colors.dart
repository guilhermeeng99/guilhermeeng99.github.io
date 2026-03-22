import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.surfaceLight,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.success,
    required this.divider,
    required this.primaryGradient,
    required this.heroGradient,
    required this.cardGradient,
  });

  final Color background;
  final Color surface;
  final Color surfaceLight;
  final Color cardBorder;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color success;
  final Color divider;
  final LinearGradient primaryGradient;
  final LinearGradient heroGradient;
  final LinearGradient cardGradient;

  static const midnightOcean = AppColorsExtension(
    background: Color(0xFF0A1628),
    surface: Color(0xFF0F1F35),
    surfaceLight: Color(0xFF162A45),
    cardBorder: Color(0xFF1E3A5F),
    textPrimary: Color(0xFFE8F1FA),
    textSecondary: Color(0xFF8BADC4),
    textMuted: Color(0xFF5A7E99),
    primary: Color(0xFF6C63FF),
    secondary: Color(0xFF00D9FF),
    accent: Color(0xFF06B6D4),
    success: Color(0xFF34D399),
    divider: Color(0xFF1A3050),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF6C63FF), Color(0xFF00D9FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    heroGradient: LinearGradient(
      colors: [Color(0xFF0A1628), Color(0xFF0D2240), Color(0xFF0A1628)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    cardGradient: LinearGradient(
      colors: [Color(0xFF0F1F35), Color(0xFF0B1829)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? surface,
    Color? surfaceLight,
    Color? cardBorder,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? success,
    Color? divider,
    LinearGradient? primaryGradient,
    LinearGradient? heroGradient,
    LinearGradient? cardGradient,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceLight: surfaceLight ?? this.surfaceLight,
      cardBorder: cardBorder ?? this.cardBorder,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      success: success ?? this.success,
      divider: divider ?? this.divider,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  AppColorsExtension lerp(covariant AppColorsExtension? other, double t) {
    if (other == null) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceLight: Color.lerp(surfaceLight, other.surfaceLight, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      primaryGradient: LinearGradient.lerp(
        primaryGradient,
        other.primaryGradient,
        t,
      )!,
      heroGradient: LinearGradient.lerp(heroGradient, other.heroGradient, t)!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
