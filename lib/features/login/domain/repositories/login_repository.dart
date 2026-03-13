import '../entities/login_user.dart';

abstract class LoginRepository {
  Future<LoginUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<LoginUser> signInWithGoogle();

  Future<LoginUser> signInWithApple();

  Future<LoginUser> signInWithBiometrics();

  Future<void> forgotPassword(String email);
}
