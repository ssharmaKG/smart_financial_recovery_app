import 'package:flutter/material.dart';
import '../../../core/design_system/design_system.dart';

class ErrorBanner extends StatelessWidget {
  final String message;
  const ErrorBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.md,
        vertical: DSSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: DSColors.error.withValues(alpha: 0.08),
        borderRadius: DSRadius.md,
        border: Border.all(color: DSColors.error.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: DSColors.error,
          ),
          const SizedBox(width: DSSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: DSTypography.caption.copyWith(color: DSColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
