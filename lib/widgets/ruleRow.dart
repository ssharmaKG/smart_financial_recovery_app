import 'package:flutter/material.dart';
import '../../../core/design_system/design_system.dart';

class RuleRow extends StatelessWidget {
  final String label;
  final bool met;

  const RuleRow({super.key, required this.label, required this.met});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DSSpacing.xs),
      child: Row(
        children: [
          Icon(
            Icons.check,
            size: DSSizes.iconxSm,
            color: met ? DSColors.success : DSColors.textDisabled,
          ),
          const SizedBox(width: DSSpacing.xs),
          Text(
            label,
            style: DSTypography.caption.copyWith(
              color: met ? DSColors.success : DSColors.textDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
