import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_colors.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_radius.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_spacing.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_typography.dart';
import 'package:smart_financial_recovery_app/core/form/engine/password_rules_engine.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import 'package:smart_financial_recovery_app/widgets/RuleRow.dart';

class PasswordRulesView extends StatelessWidget {
  final String password;

  const PasswordRulesView({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final hasMinLength = PasswordRulesEngine.hasMinLength(password);
    final hasNumber = PasswordRulesEngine.hasNumber(password);
    final hasSpecialChar = PasswordRulesEngine.hasSpecialChar(password);

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
          RuleRow(label: AppStrings.passwordMinLength, met: hasMinLength),
          RuleRow(label: AppStrings.passwordNumber, met: hasNumber),
          RuleRow(label: AppStrings.passwordSpecialChar, met: hasSpecialChar),
        ],
      ),
    );
  }
}
