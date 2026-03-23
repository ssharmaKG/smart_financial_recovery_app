import 'package:flutter/material.dart';
import 'tokens/ds_colors.dart';

class DSTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: DSColors.background,
    primaryColor: DSColors.brandPrimary,
    colorScheme: const ColorScheme.light(
      primary: DSColors.brandPrimary,
      secondary: DSColors.brandSecondary,
      error: DSColors.error,
    ),
  );
}
