import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import '../../../core/design_system/design_system.dart';

class ForgotPasswordSheet extends StatelessWidget {
  final TextEditingController emailController;
  final void Function(String email) onSend;

  const ForgotPasswordSheet({
    super.key,
    required this.emailController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(DSSpacing.md),
      padding: EdgeInsets.only(
        left: DSSpacing.lg,
        right: DSSpacing.lg,
        top: DSSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + DSSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: DSColors.surfacePrimary,
        borderRadius: DSRadius.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.resetPassword, style: DSTypography.h2),
          const SizedBox(height: DSSpacing.sm),
          Text(
            AppStrings.resetPasswordDesc,
            style: DSTypography.body.copyWith(
              color: DSColors.textSecondary,
              height: 1.5,
            ),
          ),
          DSTextField(
            label: AppStrings.emailHint,
            hint: AppStrings.emailHint,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: DSSpacing.sm),
          DSButton(
            label: AppStrings.sendResetLink,
            type: DSButtonType.primary,
            onPressed: () => onSend(emailController.text.trim()),
          ),
        ],
      ),
    );
  }
}
