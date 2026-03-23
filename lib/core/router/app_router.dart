import 'package:go_router/go_router.dart';
import 'package:smart_financial_recovery_app/features/Login/presentation/views/login_view.dart';
import 'package:smart_financial_recovery_app/features/signup/presentation/views/signup_view.dart';

abstract final class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      name: AppRoutes.signup,
      builder: (context, state) => const SignupView(),
    ),
  ],
);
