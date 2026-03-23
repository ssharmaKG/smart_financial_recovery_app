import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import 'package:smart_financial_recovery_app/features/signup/presentation/viewmodels/signup_viewmodel.dart';
import 'package:smart_financial_recovery_app/widgets/widgets.dart';
import '../../../core/design_system/design_system.dart';

class PasswordRules extends StatelessWidget {
  final SignupViewModel vm;

  const PasswordRules({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DSSpacing.md),
      decoration: BoxDecoration(
        color: DSColors.surfaceSecondary,
        borderRadius: DSRadius.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.passwordMustInclude,
            style: DSTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: DSColors.textPrimary,
            ),
          ),
          const SizedBox(height: DSSpacing.sm),
          RuleRow(label: AppStrings.passwordMinLength, met: vm.hasMinLength),
          RuleRow(label: AppStrings.passwordNumber, met: vm.hasNumber),
          RuleRow(
            label: AppStrings.passwordSpecialChar,
            met: vm.hasSpecialChar,
          ),
        ],
      ),
    );
  }
}
