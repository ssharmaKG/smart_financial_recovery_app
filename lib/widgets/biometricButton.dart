import 'package:flutter/material.dart';
import '../../../core/design_system/design_system.dart';

class BiometricButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BiometricButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.brandPrimary,
          side: const BorderSide(color: DSColors.surfaceSecondary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: DSRadius.md),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fingerprint,
              size: 20,
              color: DSColors.brandPrimary,
            ),
            const SizedBox(width: DSSpacing.sm),
            Text(
              'Sign in with Face ID / Fingerprint',
              style: DSTypography.body.copyWith(
                color: DSColors.brandPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
