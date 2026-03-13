import 'package:flutter/foundation.dart';
import '../../domain/entities/login_user.dart';
import '../../domain/usecases/login_usecases.dart';

enum LoginStatus { idle, loading, success, failure }

class LoginViewModel extends ChangeNotifier {
  final SignInWithEmailUseCase _signInWithEmail;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final SignInWithAppleUseCase _signInWithApple;
  final SignInWithBiometricsUseCase _signInWithBiometrics;
  final ForgotPasswordUseCase _forgotPassword;

  LoginViewModel({
    required SignInWithEmailUseCase signInWithEmail,
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignInWithAppleUseCase signInWithApple,
    required SignInWithBiometricsUseCase signInWithBiometrics,
    required ForgotPasswordUseCase forgotPassword,
  }) : _signInWithEmail = signInWithEmail,
       _signInWithGoogle = signInWithGoogle,
       _signInWithApple = signInWithApple,
       _signInWithBiometrics = signInWithBiometrics,
       _forgotPassword = forgotPassword;

  // ── State ──────────────────────────────────────────────────────────────────

  LoginStatus _status = LoginStatus.idle;
  LoginStatus get status => _status;

  LoginUser? _loginenticatedUser;
  LoginUser? get loginenticatedUser => _loginenticatedUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _forgotPasswordSent = false;
  bool get forgotPasswordSent => _forgotPasswordSent;

  bool get isLoading => _status == LoginStatus.loading;
  bool get isSuccess => _status == LoginStatus.success;

  // ── Actions ────────────────────────────────────────────────────────────────

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      _status = LoginStatus.idle;
      notifyListeners();
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    _setLoading();
    try {
      _loginenticatedUser = await _signInWithEmail(
        email: email,
        password: password,
      );
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading();
    try {
      _loginenticatedUser = await _signInWithGoogle();
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> signInWithApple() async {
    _setLoading();
    try {
      _loginenticatedUser = await _signInWithApple();
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> signInWithBiometrics() async {
    _setLoading();
    try {
      _loginenticatedUser = await _signInWithBiometrics();
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> sendForgotPassword(String email) async {
    _setLoading();
    try {
      await _forgotPassword(email);
      _forgotPasswordSent = true;
      _status = LoginStatus.idle;
      notifyListeners();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _setLoading() {
    _status = LoginStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = LoginStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = LoginStatus.failure;
    _errorMessage = message;
    notifyListeners();
  }
}
