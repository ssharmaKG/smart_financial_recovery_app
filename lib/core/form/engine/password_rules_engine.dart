class PasswordRulesEngine {
  static bool hasMinLength(String password) => password.length >= 8;

  static bool hasNumber(String password) =>
      password.contains(RegExp(r'[0-9]'));

  static bool hasSpecialChar(String password) =>
      password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  static bool isValid(String password) {
    return hasMinLength(password) &&
        hasNumber(password) &&
        hasSpecialChar(password);
  }
}