import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFF0B0B0F);
  static const Color surface = Color(0xFF131320);
  static const Color surfaceLight = Color(0xFF1C1C2E);
  static const Color cardBorder = Color(0xFF2A2A3E);
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF9999B0);
  static const Color textMuted = Color(0xFF66667A);
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00D9FF);
  static const Color accent = Color(0xFF7C3AED);
  static const Color success = Color(0xFF22C55E);
  static const Color divider = Color(0xFF1E1E30);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0B0B0F), Color(0xFF0F0F2D), Color(0xFF0B0B0F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF131320), Color(0xFF0F0F1A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
