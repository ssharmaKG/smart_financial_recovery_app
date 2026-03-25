import 'package:smart_financial_recovery_app/core/form/engine/password_rules_engine.dart';

class ValidationContext {
  final Map<String, dynamic> values;

  ValidationContext(this.values);

  T? get<T>(String key) {
    return values[key] as T?;
  }
}

abstract class FieldValidator {
  String? validate(String? value, ValidationContext context);
}

class RequiredValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }
}

class EmailValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.isEmpty) return null;

    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(value)) return "Invalid email";

    return null;
  }
}

class PasswordValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.isEmpty) return null;

    if (!PasswordRulesEngine.hasMinLength(value)) {
      return "Minimum 8 characters required";
    }

    if (!PasswordRulesEngine.hasNumber(value)) {
      return "Must include a number";
    }

    if (!PasswordRulesEngine.hasSpecialChar(value)) {
      return "Must include a special character";
    }

    return null;
  }
}

class ConfirmPasswordValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    final password = context.get<String>("password");

    if (value == null || value.isEmpty) return null;

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }
}

class AmountValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.isEmpty) return null;

    if (double.tryParse(value) == null) {
      return "Enter valid amount";
    }

    return null;
  }
}

class PercentageValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.isEmpty) return null;

    final val = double.tryParse(value);

    if (val == null || val < 0 || val > 100) {
      return "Enter valid %";
    }

    return null;
  }
}

class DateValidator implements FieldValidator {
  @override
  String? validate(String? value, ValidationContext context) {
    if (value == null || value.isEmpty) return null;

    try {
      DateTime.parse(value);
    } catch (_) {
      return "Invalid date";
    }

    return null;
  }
}
