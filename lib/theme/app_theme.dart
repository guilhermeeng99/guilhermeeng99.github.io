import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.spaceGrotesk(
              fontSize: 72,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -2,
              height: 1.1,
            ),
            displayMedium: GoogleFonts.spaceGrotesk(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -1.5,
              height: 1.2,
            ),
            displaySmall: GoogleFonts.spaceGrotesk(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              letterSpacing: -1,
            ),
            headlineMedium: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            headlineSmall: GoogleFonts.spaceGrotesk(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            titleLarge: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            titleMedium: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            labelMedium: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
    );
  }
}
