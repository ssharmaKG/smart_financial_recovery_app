import 'package:smart_financial_recovery_app/core/form/models/field_type.dart';

enum ValidationMode { onSubmit, onChange }

class FormFieldConfig {
  final String key;
  final FieldType type;
  final String label;
  final bool required;
  final ValidationMode validationMode;

  FormFieldConfig({
    required this.key,
    required this.type,
    required this.label,
    this.required = true,
    this.validationMode = ValidationMode.onSubmit,
  });
}