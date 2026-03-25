import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import '../../../core/design_system/design_system.dart';

class TermsCheckbox extends StatelessWidget {
  final bool agreed;
  final VoidCallback onToggle;

  const TermsCheckbox({
    super.key,
    required this.agreed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: DSSizes.iconMd,
          height: DSSizes.iconMd,
          child: Checkbox(
            value: agreed,
            onChanged: (_) => onToggle(),
            activeColor: DSColors.brandPrimary,
            shape: RoundedRectangleBorder(borderRadius: DSRadius.sm),
            side: const BorderSide(color: DSColors.textDisabled),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: DSSpacing.sm),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DSTypography.caption.copyWith(
                color: DSColors.textSecondary,
              ),
              children: [
                const TextSpan(text: AppStrings.agreeTo),
                TextSpan(
                  text: AppStrings.termsOfService,
                  style: DSTypography.caption.copyWith(
                    color: DSColors.brandPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: AppStrings.and),
                TextSpan(
                  text: AppStrings.privacyPolicy,
                  style: DSTypography.caption.copyWith(
                    color: DSColors.brandPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: AppStrings.dot),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
