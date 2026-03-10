import 'package:flutter/material.dart';

class DSColors {
  // Brand
  static const brandPrimary = Color(0xFF01014B);
  static const brandSecondary = Color(0xFF1E1E6A);

  // Semantic
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Surface
  static const background = Color(0xFFF8FAFC);
  static const surfacePrimary = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFF1F5F9);

  // Text
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF475569);
  static const textDisabled = Color(0xFF94A3B8);
  static const textInverse = Color(0xFFFFFFFF);

  //Alpha variants
  static Color brandPrimary40 = brandPrimary.withValues(alpha: 0.4);
}
