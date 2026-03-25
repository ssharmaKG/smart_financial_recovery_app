import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_financial_recovery_app/features/signup/data/models/signup_user_model.dart';
import 'package:smart_financial_recovery_app/features/signup/domain/entities/signup_user.dart';
import 'package:smart_financial_recovery_app/features/signup/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<void> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    //replace with real API/Firebase call
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  @override
  Future<SignupUser> signUpWithGoogle() async {
    try {
      final account = await _googleSignIn.authenticate();

      return SignupUserModel(
        id: account.id,
        email: account.email,
        fullName: account.displayName ?? 'Google User',
      );
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  @override
  Future<void> signUpWithApple() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
