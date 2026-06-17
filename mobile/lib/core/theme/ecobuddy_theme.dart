import 'package:flutter/material.dart';

import 'ecobuddy_colors.dart';

class EcoBuddyTheme {
  const EcoBuddyTheme._();

  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: EcoBuddyColors.primary,
      onPrimary: EcoBuddyColors.onPrimary,
      secondary: EcoBuddyColors.secondary,
      onSecondary: EcoBuddyColors.onSecondary,
      error: EcoBuddyColors.error,
      onError: EcoBuddyColors.onPrimary,
      surface: EcoBuddyColors.surface,
      onSurface: EcoBuddyColors.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: EcoBuddyColors.surface,
      colorScheme: colorScheme,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w700,
          color: EcoBuddyColors.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          height: 28 / 20,
          fontWeight: FontWeight.w700,
          color: EcoBuddyColors.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          color: EcoBuddyColors.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          color: EcoBuddyColors.onSurfaceVariant,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w700,
          color: EcoBuddyColors.onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w600,
          color: EcoBuddyColors.outline,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: EcoBuddyColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: EcoBuddyColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      ),
    );
  }
}
