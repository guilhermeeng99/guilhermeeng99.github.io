import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme {
    const colors = AppColorsExtension.midnightOcean;

    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
      ),
      extensions: const [colors],
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.spaceGrotesk(
              fontSize: 72,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: -2,
              height: 1.1,
            ),
            displayMedium: GoogleFonts.spaceGrotesk(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: -1.5,
              height: 1.2,
            ),
            displaySmall: GoogleFonts.spaceGrotesk(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
              letterSpacing: -1,
            ),
            headlineMedium: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            headlineSmall: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            titleMedium: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.textSecondary,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
              height: 1.7,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
              height: 1.6,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
            labelMedium: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colors.secondary,
            ),
          ),
    );
  }

  static ThemeData get lightTheme {
    const colors = AppColorsExtension.arcticLight;

    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
      ),
      extensions: const [colors],
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.spaceGrotesk(
              fontSize: 72,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: -2,
              height: 1.1,
            ),
            displayMedium: GoogleFonts.spaceGrotesk(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: -1.5,
              height: 1.2,
            ),
            displaySmall: GoogleFonts.spaceGrotesk(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
              letterSpacing: -1,
            ),
            headlineMedium: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            headlineSmall: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
            titleMedium: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.textSecondary,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
              height: 1.7,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
              height: 1.6,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
            labelMedium: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colors.secondary,
            ),
          ),
    );
  }
}
