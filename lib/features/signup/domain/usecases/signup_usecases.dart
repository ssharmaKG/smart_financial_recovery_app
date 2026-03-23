import 'package:smart_financial_recovery_app/features/signup/domain/repositories/signup_repository.dart';

class SignUpWithEmailUseCase {
  final SignupRepository _repository;

  const SignUpWithEmailUseCase(this._repository);

  Future<void> call({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return _repository.signUpWithEmail(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}

class SignUpWithGoogleUseCase {
  final SignupRepository _repository;

  const SignUpWithGoogleUseCase(this._repository);

  Future<void> call() async => _repository.signUpWithGoogle();
}

class SignUpWithAppleUseCase {
  final SignupRepository _repository;

  const SignUpWithAppleUseCase(this._repository);

  Future<void> call() async => _repository.signUpWithApple();
}
