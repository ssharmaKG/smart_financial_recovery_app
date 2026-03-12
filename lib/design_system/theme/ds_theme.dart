import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/design_system/tokens/ds_radius.dart';
import '../tokens/ds_colors.dart';

class DSTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: DSColors.background,
    primaryColor: DSColors.brandPrimary,
    colorScheme: const ColorScheme.light(
      primary: DSColors.brandPrimary,
      secondary: DSColors.brandSecondary,
      error: DSColors.error,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DSColors.surfacePrimary,
      border: OutlineInputBorder(borderRadius: DSRadius.md),
    ),
  );
}
