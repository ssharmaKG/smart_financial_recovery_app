//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_financial_recovery_app/core/design_system/ds_theme.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/usecases/login_usecases.dart';
import 'features/login/presentation/viewmodels/login_viewmodel.dart';
import 'features/login/presentation/views/login_view.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency injection via Provider
    final LoginRepository = LoginRepositoryImpl();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            signInWithEmail: SignInWithEmailUseCase(LoginRepository),
            signInWithGoogle: SignInWithGoogleUseCase(LoginRepository),
            signInWithApple: SignInWithAppleUseCase(LoginRepository),
            signInWithBiometrics: SignInWithBiometricsUseCase(LoginRepository),
            forgotPassword: ForgotPasswordUseCase(LoginRepository),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Finance Recovery',
        debugShowCheckedModeBanner: false,
        theme: DSTheme.lightTheme,
        home: const LoginView(),
      ),
    );
  }
}
