import 'package:flutter/material.dart';
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
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: DSColors.surfacePrimary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
