import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/utils/app_images.dart';
import '../../../core/design_system/design_system.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: DSColors.brandPrimary,
        borderRadius: DSRadius.lg,
        boxShadow: [
          BoxShadow(
            color: DSColors.brandPrimary.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.asset(
        AppImages.shieldRepresentation,
        width: 24, // ← control icon size inside container
        height: 24,
      ),
    );
  }
}
