import '../entities/login_user.dart';
import '../repositories/login_repository.dart';

class SignInWithEmailUseCase {
  final LoginRepository _repository;

  const SignInWithEmailUseCase(this._repository);

  Future<LoginUser> call({
    required String email,
    required String password,
  }) async {
    return _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

class SignInWithGoogleUseCase {
  final LoginRepository _repository;

  const SignInWithGoogleUseCase(this._repository);

  Future<LoginUser> call() async => _repository.signInWithGoogle();
}

class SignInWithAppleUseCase {
  final LoginRepository _repository;

  const SignInWithAppleUseCase(this._repository);

  Future<LoginUser> call() async => _repository.signInWithApple();
}

class SignInWithBiometricsUseCase {
  final LoginRepository _repository;

  const SignInWithBiometricsUseCase(this._repository);

  Future<LoginUser> call() async => _repository.signInWithBiometrics();
}

class ForgotPasswordUseCase {
  final LoginRepository _repository;

  const ForgotPasswordUseCase(this._repository);

  Future<void> call(String email) async => _repository.forgotPassword(email);
}
