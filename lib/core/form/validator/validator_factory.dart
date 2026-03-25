import 'package:smart_financial_recovery_app/core/form/models/field_type.dart';
import 'package:smart_financial_recovery_app/core/form/validator/form_field_validator.dart';

class ValidatorFactory {
  static List<FieldValidator> getValidators(
    FieldType type,
    bool required,
  ) {
    final validators = <FieldValidator>[];

    if (required) validators.add(RequiredValidator());

    switch (type) {
      case FieldType.email:
        validators.add(EmailValidator());
        break;
      case FieldType.password:
        validators.add(PasswordValidator());
        break;
      case FieldType.amount:
        validators.add(AmountValidator());
        break;
      case FieldType.percentage:
        validators.add(PercentageValidator());
        break;
      case FieldType.date:
        validators.add(DateValidator());
        break;
      default:
        break;
    }

    return validators;
  }
}