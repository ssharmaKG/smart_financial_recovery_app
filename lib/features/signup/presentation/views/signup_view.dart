import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_financial_recovery_app/core/router/app_router.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import '../../../../../core/design_system/design_system.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/validators.dart';
import '../viewmodels/signup_viewmodel.dart';
import 'package:smart_financial_recovery_app/widgets/widgets.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUp(SignupViewModel vm) {
    if (_formKey.currentState?.validate() ?? false) {
      vm.signUp(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
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

                    // ── Logo ───────────────────────────────────────
                    const AppLogo(),
                    const SizedBox(height: DSSpacing.lg),

                    // ── Heading ────────────────────────────────────
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

                    // ── Signup Card ────────────────────────────────
                    DSCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Full Name
                            DSTextField(
                              label: AppStrings.fullNameLabel,
                              hint: AppStrings.fullNameHint,
                              controller: _fullNameController,
                              keyboardType: TextInputType.name,
                              onChanged: (_) => vm.clearError(),
                              validator: Validators.validateFullName,
                            ),

                            // Email
                            DSTextField(
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailHint,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) => vm.clearError(),
                              validator: Validators.validateEmail,
                            ),

                            // Password
                            DSTextField(
                              label: AppStrings.passwordLabel,
                              hint: AppStrings.passwordHint,
                              controller: _passwordController,
                              type: DSTextFieldType.password,
                              onChanged: (val) {
                                vm.onPasswordChanged(val);
                                vm.clearError();
                              },
                              validator: Validators.validatePassword,
                            ),

                            // Password rules — shown when typing
                            if (vm.passwordTouched) ...[
                              const SizedBox(height: DSSpacing.xs),
                              PasswordRules(vm: vm),
                            ],

                            // Confirm Password
                            DSTextField(
                              label: AppStrings.confirmPasswordLabel,
                              hint: AppStrings.confirmPasswordHint,
                              controller: _confirmPasswordController,
                              type: DSTextFieldType.password,
                              onChanged: (_) => vm.clearError(),
                              validator: (val) =>
                                  Validators.validateConfirmPassword(
                                    val,
                                    _passwordController.text,
                                  ),
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
                              label: vm.isLoading
                                  ? ''
                                  : AppStrings.createAccount,
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
                              onPressed: vm.isLoading
                                  ? null
                                  : vm.signUpWithApple,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // ── Sign In Link ───────────────────────────────
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
