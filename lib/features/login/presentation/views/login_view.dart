import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_financial_recovery_app/core/utils/app_images.dart';
import '../../../../../core/design_system/design_system.dart';
import '../viewmodels/login_viewmodel.dart';
import 'package:smart_financial_recovery_app/widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSignIn(LoginViewModel vm) {
    if (_formKey.currentState?.validate() ?? false) {
      vm.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  void _showForgotPasswordSheet(LoginViewModel vm) {
    final emailController = TextEditingController(text: _emailController.text);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ForgotPasswordSheet(
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
          if (vm.isSuccess && vm.loginenticatedUser != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Welcome back, ${vm.loginenticatedUser!.displayName ?? vm.loginenticatedUser!.email}!',
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

                    // ── Logo ───────────────────────────────────────
                    const AppLogo(),
                    const SizedBox(height: DSSpacing.lg),

                    // ── Heading ────────────────────────────────────
                    Text(
                      'Welcome Back',
                      style: DSTypography.h1.copyWith(
                        fontSize: 26,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: DSSpacing.xs),
                    Text(
                      'Sign in to manage your financial recovery plan.',
                      textAlign: TextAlign.center,
                      style: DSTypography.body.copyWith(
                        color: DSColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // ── Login Card ─────────────────────────────────
                    DSCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email
                            DSTextField(
                              label: 'Email Address',
                              hint: 'name@example.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) => vm.clearError(),
                              errorText: null,
                            ),

                            DSTextField(
                              label: 'Password',
                              hint: 'Enter your password',
                              suffix: Image.asset(
                                AppImages.eye,
                                width: 16,
                                height: 16,
                              ),
                              controller: _passwordController,
                              type: DSTextFieldType.password,
                              keyboardType: TextInputType.visiblePassword,
                              onChanged: (_) => vm.clearError(),
                              errorText: null,
                            ),

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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
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
                              label: vm.isLoading ? '' : 'Sign In',
                              type: DSButtonType.primary,
                              onPressed: vm.isLoading
                                  ? null
                                  : () => _onSignIn(vm),
                              isDisabled: vm.isLoading,
                            ),

                            const SizedBox(height: DSSpacing.lg),
                            const OrDivider(),
                            const SizedBox(height: DSSpacing.md),

                            // Biometric
                            BiometricButton(
                              onPressed: vm.isLoading
                                  ? null
                                  : vm.signInWithBiometrics,
                            ),

                            const SizedBox(height: DSSpacing.sm),
                            Text(
                              'Use biometric authentication for faster and secure access.',
                              textAlign: TextAlign.center,
                              style: DSTypography.caption.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: DSSpacing.md),

                    // ── Social ─────────────────────────────────────
                    SocialButton(
                      label: 'Continue with Google',
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          AppImages.googleIcon,
                          fit: BoxFit.contain,
                        ),
                      ),
                      onPressed: vm.isLoading ? null : vm.signInWithGoogle,
                    ),
                    const SizedBox(height: DSSpacing.sm),
                    SocialButton(
                      label: 'Continue with Apple',
                      icon: const Icon(
                        Icons.apple,
                        size: 20,
                        color: DSColors.textPrimary,
                      ),
                      onPressed: vm.isLoading ? null : vm.signInWithApple,
                    ),

                    const SizedBox(height: DSSpacing.xl),

                    // ── Register ───────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: DSTypography.body.copyWith(
                            color: DSColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: DSSpacing.xs),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Create Account',
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

// ── Forgot Password Sheet ──────────────────────────────────────────────────

class _ForgotPasswordSheet extends StatelessWidget {
  final TextEditingController emailController;
  final void Function(String email) onSend;

  const _ForgotPasswordSheet({
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
          Text('Reset Password', style: DSTypography.h2),
          const SizedBox(height: DSSpacing.sm),
          Text(
            "Enter your email and we'll send you a reset link.",
            style: DSTypography.body.copyWith(
              color: DSColors.textSecondary,
              height: 1.5,
            ),
          ),
          DSTextField(
            label: 'Email Address',
            hint: 'name@example.com',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: DSSpacing.sm),
          DSButton(
            label: 'Send Reset Link',
            type: DSButtonType.primary,
            onPressed: () => onSend(emailController.text.trim()),
          ),
        ],
      ),
    );
  }
}
