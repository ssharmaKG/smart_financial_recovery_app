import '../../domain/entities/login_user.dart';
import '../../domain/repositories/login_repository.dart';
import '../models/login_user_model.dart';

/// Mock implementation — replace with real API/Firebase calls
class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<LoginUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate validation — replace with real Login
    if (password == 'wrong') {
      throw Exception('Invalid email or password. Please try again.');
    }

    return LoginUserModel(
      id: 'user_001',
      email: email,
      displayName: 'Jane Doe',
    );
  }

  @override
  Future<LoginUser> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return const LoginUserModel(
      id: 'google_user_001',
      email: 'user@gmail.com',
      displayName: 'Google User',
    );
  }

  @override
  Future<LoginUser> signInWithApple() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return const LoginUserModel(
      id: 'apple_user_001',
      email: 'user@icloud.com',
      displayName: 'Apple User',
    );
  }

  @override
  Future<LoginUser> signInWithBiometrics() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const LoginUserModel(
      id: 'bio_user_001',
      email: 'user@example.com',
      displayName: 'Biometric User',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Simulate sending reset email
  }
}
