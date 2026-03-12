import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/design_system/tokens/ds_colors.dart';

class DSShadows {
  static const sm = BoxShadow(
    color: DSColors.shadowSm,
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const md = BoxShadow(
    color: DSColors.shadowMd,
    blurRadius: 6,
    offset: Offset(0, 4),
  );

  static const lg = BoxShadow(
    color: DSColors.shadowLg,
    blurRadius: 15,
    offset: Offset(0, 10),
  );
}
