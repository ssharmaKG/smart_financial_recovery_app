import 'package:flutter/material.dart';
import '../tokens/ds_colors.dart';

class DSTypography {
  static const display = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: DSColors.textPrimary,
  );

  static const h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: DSColors.textPrimary,
  );

  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: DSColors.textPrimary,
  );

  static const body = TextStyle(fontSize: 16, color: DSColors.textPrimary);

  static const caption = TextStyle(fontSize: 12, color: DSColors.textSecondary);
}
