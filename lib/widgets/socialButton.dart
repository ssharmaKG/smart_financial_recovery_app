import 'package:flutter/material.dart';
import '../../../core/design_system/design_system.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.textPrimary,
          side: const BorderSide(color: DSColors.surfaceSecondary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: DSRadius.md),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: DSSpacing.sm),
            Text(
              label,
              style: DSTypography.body.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
