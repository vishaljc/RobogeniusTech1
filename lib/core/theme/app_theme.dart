// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Dark palette ─────────────────────────────────────────────────────────────

class AppColors {
  // Primary palette (dark)
  static const Color background    = Color(0xFF050A18);
  static const Color surface       = Color(0xFF0D1528);
  static const Color surfaceLight  = Color(0xFF121E38);
  static const Color card          = Color(0xFF0F1A30);

  // Accent (shared)
  static const Color neonBlue   = Color(0xFF00D4FF);
  static const Color neonPurple = Color(0xFF7B2FFF);
  static const Color neonCyan   = Color(0xFF00FFD1);
  static const Color neonPink   = Color(0xFFFF2D87);

  // Gradient stops (shared)
  static const Color gradientStart = Color(0xFF0066FF);
  static const Color gradientMid   = Color(0xFF7B2FFF);
  static const Color gradientEnd   = Color(0xFF00D4FF);

  // Dark text
  static const Color textPrimary   = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8A9CC8);
  static const Color textMuted     = Color(0xFF4A5980);

  // Dark borders
  static const Color border     = Color(0xFF1E2D4E);
  static const Color borderGlow = Color(0xFF00D4FF);

  // Shared gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientMid, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF0066FF), Color(0xFF7B2FFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF000D1F), Color(0xFF050A18), Color(0xFF0A0520)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0F1A30), Color(0xFF0A1020)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─── Light palette ────────────────────────────────────────────────────────────

class AppColorsLight {
  // Pure white base — no blue tint so nothing reads as gray
  static const Color background   = Color(0xFFFFFFFF);
  static const Color surface      = Color(0xFFFFFFFF);
  // Very subtle warm-white for alternating sections
  static const Color surfaceLight = Color(0xFFF7F9FF);
  static const Color card         = Color(0xFFFFFFFF);

  static const Color textPrimary   = Color(0xFF0A1128);
  static const Color textSecondary = Color(0xFF3D4F7C);
  static const Color textMuted     = Color(0xFF8A9CC8);

  // Softer border — barely visible on white, not gray
  static const Color border     = Color(0xFFE4EAF8);
  static const Color borderGlow = Color(0xFF0066FF);

  // Accents — vivid enough to pop on white
  static const Color neonBlue   = Color(0xFF0055DD);
  static const Color neonPurple = Color(0xFF6B1FFF);
  static const Color neonCyan   = Color(0xFF00B89C);
}

// ─── Dynamic color helper ─────────────────────────────────────────────────────

class DynamicColors {
  final bool isDark;
  const DynamicColors(this.isDark);

  Color get background    => isDark ? AppColors.background    : AppColorsLight.background;
  Color get surface       => isDark ? AppColors.surface       : AppColorsLight.surface;
  Color get surfaceLight  => isDark ? AppColors.surfaceLight  : AppColorsLight.surfaceLight;
  Color get card          => isDark ? AppColors.card          : AppColorsLight.card;
  Color get textPrimary   => isDark ? AppColors.textPrimary   : AppColorsLight.textPrimary;
  Color get textSecondary => isDark ? AppColors.textSecondary : AppColorsLight.textSecondary;
  Color get textMuted     => isDark ? AppColors.textMuted     : AppColorsLight.textMuted;
  Color get border        => isDark ? AppColors.border        : AppColorsLight.border;
  Color get neonBlue      => isDark ? AppColors.neonBlue      : AppColorsLight.neonBlue;
  Color get neonPurple    => isDark ? AppColors.neonPurple    : AppColorsLight.neonPurple;
  Color get neonCyan      => isDark ? AppColors.neonCyan      : AppColorsLight.neonCyan;

  LinearGradient get sectionGradient => isDark
      ? const LinearGradient(
      colors: [Color(0xFF050A18), Color(0xFF080E1E)],
      begin: Alignment.topCenter, end: Alignment.bottomCenter)
      : const LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFFF7F9FF)],
      begin: Alignment.topCenter, end: Alignment.bottomCenter);

  LinearGradient get heroGradient => isDark
      ? const LinearGradient(
      colors: [Color(0xFF000D1F), Color(0xFF050A18), Color(0xFF0A051A)],
      begin: Alignment.topCenter, end: Alignment.bottomCenter)
      : const LinearGradient(
    // All stops stay in the same white-blue family so there's no
    // jarring seam where the hero meets the stats section below.
      colors: [Color(0xFFECF1FF), Color(0xFFF7F9FF), Color(0xFFFFFFFF)],
      begin: Alignment.topCenter, end: Alignment.bottomCenter);

  LinearGradient cardGradient(Color accent) => isDark
      ? LinearGradient(
      colors: [accent.withOpacity(0.12), accent.withOpacity(0.06)],
      begin: Alignment.topLeft, end: Alignment.bottomRight)
      : LinearGradient(
      colors: [accent.withOpacity(0.07), accent.withOpacity(0.03)],
      begin: Alignment.topLeft, end: Alignment.bottomRight);
}

// ─── ThemeData builders ───────────────────────────────────────────────────────

class AppTheme {
  static ThemeData get darkTheme  => _build(Brightness.dark);
  static ThemeData get lightTheme => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg      = isDark ? AppColors.background    : AppColorsLight.background;
    final surface = isDark ? AppColors.surface       : AppColorsLight.surface;
    final primary = isDark ? AppColors.textPrimary   : AppColorsLight.textPrimary;
    final secondary = isDark ? AppColors.textSecondary : AppColorsLight.textSecondary;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? AppColors.background : Colors.white,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.gradientStart,
        secondary: AppColors.neonPurple,
        surface: surface,
        background: bg,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: primary,
        onBackground: primary,
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(TextTheme(
        displayLarge:  TextStyle(color: primary, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: primary, fontWeight: FontWeight.w700),
        displaySmall:  TextStyle(color: primary, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(color: primary, fontWeight: FontWeight.w700),
        headlineMedium:TextStyle(color: primary, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(color: primary, fontWeight: FontWeight.w600),
        titleLarge:    TextStyle(color: primary, fontWeight: FontWeight.w600),
        titleMedium:   TextStyle(color: primary),
        titleSmall:    TextStyle(color: secondary),
        bodyLarge:     TextStyle(color: secondary),
        bodyMedium:    TextStyle(color: secondary),
        bodySmall:     TextStyle(color: secondary),
      )),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}