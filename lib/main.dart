import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/design_system/design_system.dart';
import 'core/router/app_router.dart';
import 'features/Login/data/repositories/login_repository_impl.dart';
import 'features/Login/domain/usecases/login_usecases.dart';
import 'features/Login/presentation/viewmodels/login_viewmodel.dart';
import 'features/signup/data/repositories/signup_repository_impl.dart';
import 'features/signup/domain/usecases/signup_usecases.dart';
import 'features/signup/presentation/viewmodels/signup_viewmodel.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepository = LoginRepositoryImpl();
    final signupRepository = SignupRepositoryImpl();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            signInWithEmail: SignInWithEmailUseCase(loginRepository),
            signInWithGoogle: SignInWithGoogleUseCase(loginRepository),
            signInWithApple: SignInWithAppleUseCase(loginRepository),
            signInWithBiometrics: SignInWithBiometricsUseCase(loginRepository),
            forgotPassword: ForgotPasswordUseCase(loginRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupViewModel(
            signUpWithEmail: SignUpWithEmailUseCase(signupRepository),
            signUpWithGoogle: SignUpWithGoogleUseCase(signupRepository),
            signUpWithApple: SignUpWithAppleUseCase(signupRepository),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Finance Recovery',
        debugShowCheckedModeBanner: false,
        theme: DSTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
