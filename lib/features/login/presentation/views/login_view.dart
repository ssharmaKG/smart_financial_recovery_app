import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_financial_recovery_app/core/form/engine/form_controller.dart';
import 'package:smart_financial_recovery_app/core/form/models/field_type.dart';
import 'package:smart_financial_recovery_app/core/form/models/form_field_config.dart';
import 'package:smart_financial_recovery_app/core/form/view/form_view.dart';
import 'package:smart_financial_recovery_app/core/router/app_router.dart';
import 'package:smart_financial_recovery_app/core/utils/app_images.dart';
import 'package:smart_financial_recovery_app/core/utils/app_strings.dart';
import '../../../../../core/design_system/design_system.dart';
import '../viewmodels/login_viewmodel.dart';
import 'package:smart_financial_recovery_app/widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formController = FormController();

  final List<FormFieldConfig> fields = [
    FormFieldConfig(
      key: "email",
      type: FieldType.email,
      label: AppStrings.emailLabel,
    ),
    FormFieldConfig(
      key: "password",
      type: FieldType.password,
      label: AppStrings.passwordLabel,
    ),
  ];

  void _onSignIn(LoginViewModel vm) {
    final isValid = formController.validateAll(fields);
    if (!isValid) return;
    final data = formController.values;
    vm.signIn(email: data["email"] ?? "", password: data["password"] ?? "");
  }

  void _showForgotPasswordSheet(LoginViewModel vm) {
    final email = formController.values["email"] ?? "";
    final emailController = TextEditingController(text: email);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ForgotPasswordSheet(
        emailController: emailController,
        onSend: (email) {
          Navigator.pop(context);
          vm.sendForgotPassword(email);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, vm, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isSuccess && vm.authenticatedUser != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${AppStrings.welcomeBack}, ${vm.authenticatedUser!.displayName ?? vm.authenticatedUser!.email}!',
                ),
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

                    const AppLogo(),
                    const SizedBox(height: DSSpacing.lg),

                    Text(
                      AppStrings.welcomeBack,
                      style: DSTypography.h1.copyWith(
                        fontSize: 26,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: DSSpacing.xs),
                    Text(
                      AppStrings.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: DSTypography.body.copyWith(
                        color: DSColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    DSCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormView(fields: fields, controller: formController),

                          const SizedBox(height: DSSpacing.sm),

                          // Error banner
                          if (vm.errorMessage != null) ...[
                            const SizedBox(height: DSSpacing.sm),
                            ErrorBanner(message: vm.errorMessage!),
                          ],

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => _showForgotPasswordSheet(vm),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                AppStrings.forgotPassword,
                                style: DSTypography.caption.copyWith(
                                  color: DSColors.brandPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: DSSpacing.sm),

                          // Sign In
                          DSButton(
                            label: vm.isLoading ? '' : AppStrings.signIn,
                            type: DSButtonType.primary,
                            onPressed: vm.isLoading
                                ? null
                                : () => _onSignIn(vm),
                            isDisabled: vm.isLoading,
                          ),

                          const SizedBox(height: DSSpacing.lg),
                          const OrDivider(),
                          const SizedBox(height: DSSpacing.md),

                          BiometricButton(
                            onPressed: vm.isLoading
                                ? null
                                : vm.signInWithBiometrics,
                          ),

                          const SizedBox(height: DSSpacing.sm),
                          Text(
                            AppStrings.biometricDesc,
                            textAlign: TextAlign.center,
                            style: DSTypography.caption.copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: DSSpacing.md),

                    // Social
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
                      onPressed: vm.isLoading ? null : vm.signInWithGoogle,
                    ),

                    const SizedBox(height: DSSpacing.sm),

                    SocialButton(
                      label: AppStrings.continueWithApple,
                      icon: const Icon(
                        Icons.apple,
                        size: DSSizes.iconMd,
                        color: DSColors.textPrimary,
                      ),
                      onPressed: vm.isLoading ? null : vm.signInWithApple,
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.noAccount,
                          style: DSTypography.body.copyWith(
                            color: DSColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: DSSpacing.xs),
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.signup);
                          },
                          child: Text(
                            AppStrings.createAccount,
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
