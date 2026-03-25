import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/form/models/form_field_config.dart';
import 'package:smart_financial_recovery_app/core/form/validator/form_field_validator.dart';
import 'package:smart_financial_recovery_app/core/form/validator/validation_mode.dart';
import 'package:smart_financial_recovery_app/core/form/validator/validation_runner.dart';
import 'package:smart_financial_recovery_app/core/form/validator/validator_factory.dart';

class FormController extends ChangeNotifier {
  final Map<String, String?> _values = {};
  final Map<String, String?> _errors = {};
  final Map<String, String?> _visibleErrors = {};
  final Map<String, TextEditingController> _controllers = {};

  // Controllers
  TextEditingController getTextController(String key) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController();
    }
    return _controllers[key]!;
  }

  // Value update
  void setValue(FormFieldConfig config, String? value) {
    _values[config.key] = value;

    final context = ValidationContext(_values);

    final validators = ValidatorFactory.getValidators(
      config.type,
      config.required,
    );

    final error = ValidatorRunner.run(validators, value, context);

    _errors[config.key] = error;

    if (config.validationMode == ValidationMode.onChange) {
      _visibleErrors[config.key] = error;
    }

    notifyListeners();
  }

  // Visible error
  String? getVisibleError(String key) {
    return _visibleErrors[key];
  }

  // Submit validation
  bool validateAll(List<FormFieldConfig> fields) {
    bool isValid = true;

    final context = ValidationContext(_values);

    for (final field in fields) {
      final validators = ValidatorFactory.getValidators(
        field.type,
        field.required,
      );

      final error = ValidatorRunner.run(
        validators,
        _values[field.key],
        context,
      );

      _errors[field.key] = error;
      _visibleErrors[field.key] = error;

      if (error != null) isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Map<String, String?> get values => _values;
}
