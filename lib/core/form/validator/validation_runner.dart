import 'package:smart_financial_recovery_app/core/form/validator/form_field_validator.dart';

class ValidatorRunner {
  static String? run(
    List<FieldValidator> validators,
    String? value,
    ValidationContext context,
  ) {
    for (final v in validators) {
      final error = v.validate(value, context);
      if (error != null) return error;
    }
    return null;
  }
}
