import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/login_user.dart';
import '../../domain/repositories/login_repository.dart';
import '../models/login_user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  LoginRepositoryImpl() {
    _init();
  }

  Future<void> _init() async {
    await _googleSignIn.initialize(
      serverClientId:
          '286619280602-cg5a9r7vhueiksoeuptk17l147dtitko.apps.googleusercontent.com;', //'286619280602-2jhotjddmusosls0e41o0dot03ncfcio.apps.googleusercontent.com',
    );
  }

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
    try {
      final account = await _googleSignIn.authenticate();

      return LoginUserModel(
        id: account.id,
        email: account.email,
        displayName: account.displayName,
      );
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
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
