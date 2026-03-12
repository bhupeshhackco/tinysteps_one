import 'package:flutter/material.dart';

// ─── Brand colours ───────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const primary = Color(0xFF00BFA5); // Teal from image
  static const primaryLight = Color(0xFFE0F2F1);
  static const secondary = Color(0xFFFF8C69);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const danger = Color(0xFFE53935);

  static const bgLight = Color(0xFFF0F7F6); // Soft teal-ish white
  static const bgWhite = Color(0xFFFFFFFF);
  static const bgDark = Color(0xFF1A1A2E);

  static const textDark = Color(0xFF1B2C29); // Dark slate for better contrast
  static const textMuted = Color(0xFF758585);
  static const white = Color(0xFFFFFFFF);
  static const border = Color(0xFFE0E6E5);
}

// ─── Text styles ─────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  static const heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  static const heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
  );

  static const bodyMuted = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static const labelBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );
}

// ─── Spacing / radius ────────────────────────────────────────────────────────
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 20;
  static const double full = 999;
}
