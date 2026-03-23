import 'package:flutter/foundation.dart';
import '../../domain/usecases/signup_usecases.dart';

enum SignupStatus { idle, loading, success, failure }

class SignupViewModel extends ChangeNotifier {
  final SignUpWithEmailUseCase _signUpWithEmail;
  final SignUpWithGoogleUseCase _signUpWithGoogle;
  final SignUpWithAppleUseCase _signUpWithApple;

  SignupViewModel({
    required SignUpWithEmailUseCase signUpWithEmail,
    required SignUpWithGoogleUseCase signUpWithGoogle,
    required SignUpWithAppleUseCase signUpWithApple,
  }) : _signUpWithEmail = signUpWithEmail,
       _signUpWithGoogle = signUpWithGoogle,
       _signUpWithApple = signUpWithApple;

  // ── State ──────────────────────────────────────────────────────────────────

  SignupStatus _status = SignupStatus.idle;
  SignupStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool _agreedToTerms = false;
  bool get agreedToTerms => _agreedToTerms;

  // ── Password touched — controls visibility of rules box ───────────────────
  bool _passwordTouched = false;
  bool get passwordTouched => _passwordTouched;

  // ── Password rule checks ───────────────────────────────────────────────────
  String _password = '';
  bool get hasMinLength => _password.length >= 8;
  bool get hasNumber => _password.contains(RegExp(r'[0-9]'));
  bool get hasSpecialChar =>
      _password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  bool get isLoading => _status == SignupStatus.loading;
  bool get isSuccess => _status == SignupStatus.success;

  // ── Actions ────────────────────────────────────────────────────────────────

  void onPasswordChanged(String value) {
    _password = value;
    _passwordTouched = true;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void toggleAgreement() {
    _agreedToTerms = !_agreedToTerms;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      _status = SignupStatus.idle;
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (!_agreedToTerms) {
      _setError('Please agree to the Terms of Service and Privacy Policy.');
      return;
    }
    if (password != confirmPassword) {
      _setError('Passwords do not match.');
      return;
    }
    _setLoading();
    try {
      await _signUpWithEmail(
        fullName: fullName,
        email: email,
        password: password,
      );
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> signUpWithGoogle() async {
    _setLoading();
    try {
      await _signUpWithGoogle();
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> signUpWithApple() async {
    _setLoading();
    try {
      await _signUpWithApple();
      _setSuccess();
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  void _setLoading() {
    _status = SignupStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = SignupStatus.success;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = SignupStatus.failure;
    _errorMessage = message;
    notifyListeners();
  }
}
