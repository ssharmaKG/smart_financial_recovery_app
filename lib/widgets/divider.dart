import 'package:flutter/material.dart';
import '../../../core/design_system/design_system.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: DSColors.surfaceSecondary, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DSSpacing.md),
          child: Text(
            'OR',
            style: DSTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: DSColors.surfaceSecondary, thickness: 1),
        ),
      ],
    );
  }
}
