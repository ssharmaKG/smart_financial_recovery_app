import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_financial_recovery_app/core/design_system/components/ds_button.dart';
import 'package:smart_financial_recovery_app/core/design_system/components/ds_card.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_colors.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_grid.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_radius.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_sizes.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_spacing.dart';
import 'package:smart_financial_recovery_app/core/design_system/tokens/ds_typography.dart';
import 'package:smart_financial_recovery_app/core/form/engine/form_controller.dart';
import 'package:smart_financial_recovery_app/core/form/models/field_type.dart';
import 'package:smart_financial_recovery_app/core/form/models/form_field_config.dart';
import 'package:smart_financial_recovery_app/core/form/validator/validation_mode.dart';
import 'package:smart_financial_recovery_app/core/form/view/form_view.dart';
import 'package:smart_financial_recovery_app/core/router/app_router.dart';
import 'package:smart_financial_recovery_app/core/utils/app_images.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import 'package:smart_financial_recovery_app/widgets/password_rules_view.dart';
import '../viewmodels/signup_viewmodel.dart';
import 'package:smart_financial_recovery_app/widgets/widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formController = FormController();

  // Form fields config
  final List<FormFieldConfig> fields = [
    FormFieldConfig(
      key: "fullName",
      type: FieldType.name,
      label: AppStrings.fullNameLabel,
    ),
    FormFieldConfig(
      key: "email",
      type: FieldType.email,
      label: AppStrings.emailLabel,
    ),
    FormFieldConfig(
      key: "password",
      type: FieldType.password,
      label: AppStrings.passwordLabel,
      validationMode: ValidationMode.onChange,
    ),
    FormFieldConfig(
      key: "confirmPassword",
      type: FieldType.password,
      label: AppStrings.confirmPasswordLabel,
    ),
  ];

  void _onSignUp(SignupViewModel vm) {
    final isValid = formController.validateAll(fields);

    if (!isValid) return;

    final data = formController.values;

    vm.signUp(
      fullName: data["fullName"] ?? "",
      email: data["email"] ?? "",
      password: data["password"] ?? "",
      confirmPassword: data["confirmPassword"] ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, vm, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(AppStrings.accountCreated),
                backgroundColor: DSColors.success,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: DSRadius.md),
              ),
            );
          }
        });

        return Scaffold(
          backgroundColor: DSColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: DSGrid.mobileMargin,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: DSGrid.maxWidth),
                child: Column(
                  children: [
                    const SizedBox(height: DSSpacing.xl + DSSpacing.md),

                    // ── Logo ─────────────────────────
                    const AppLogo(),
                    const SizedBox(height: DSSpacing.lg),

                    // ── Heading ──────────────────────
                    Text(
                      AppStrings.createYourAccount,
                      style: DSTypography.h1.copyWith(
                        fontSize: 26,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: DSSpacing.xs),
                    Text(
                      AppStrings.signupSubtitle,
                      textAlign: TextAlign.center,
                      style: DSTypography.body.copyWith(
                        color: DSColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // ── Signup Card ──────────────────
                    DSCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormView(fields: fields, controller: formController),

                          // Scoped rebuild ONLY for password rules
                          ListenableBuilder(
                            listenable: formController,
                            builder: (_, __) {
                              final password =
                                  formController.values["password"] ?? "";

                              if (password.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                children: [
                                  const SizedBox(height: DSSpacing.xs),
                                  PasswordRulesView(password: password),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: DSSpacing.md),

                          // Terms Checkbox
                          TermsCheckbox(
                            agreed: vm.agreedToTerms,
                            onToggle: vm.toggleAgreement,
                          ),

                          // Error banner
                          if (vm.errorMessage != null) ...[
                            const SizedBox(height: DSSpacing.sm),
                            ErrorBanner(message: vm.errorMessage!),
                          ],

                          const SizedBox(height: DSSpacing.md),

                          // Create Account button
                          DSButton(
                            label: vm.isLoading ? '' : AppStrings.createAccount,
                            type: DSButtonType.primary,
                            onPressed: vm.isLoading
                                ? null
                                : () => _onSignUp(vm),
                            isDisabled: vm.isLoading,
                          ),

                          const SizedBox(height: DSSpacing.lg),
                          const OrDivider(),
                          const SizedBox(height: DSSpacing.md),

                          // Google
                          SocialButton(
                            label: AppStrings.continueWithGoogle,
                            icon: SizedBox(
                              width: DSSizes.iconMd,
                              height: DSSizes.iconMd,
                              child: Image.asset(
                                AppImages.googleIcon,
                                fit: BoxFit.contain,
                              ),
                            ),
                            onPressed: vm.isLoading
                                ? null
                                : vm.signUpWithGoogle,
                          ),

                          const SizedBox(height: DSSpacing.sm),

                          // Apple
                          SocialButton(
                            label: AppStrings.continueWithApple,
                            icon: const Icon(
                              Icons.apple,
                              size: DSSizes.iconMd,
                              color: DSColors.textPrimary,
                            ),
                            onPressed: vm.isLoading ? null : vm.signUpWithApple,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // ── Sign In Link ─────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.alreadyHaveAccount,
                          style: DSTypography.body.copyWith(
                            color: DSColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: DSSpacing.xs),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.login),
                          child: Text(
                            AppStrings.signIn,
                            style: DSTypography.body.copyWith(
                              color: DSColors.brandPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: DSSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
