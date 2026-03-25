abstract class SignupRepository {
  Future<void> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> signUpWithGoogle();

  Future<void> signUpWithApple();
}
