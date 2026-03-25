import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/design_system/components/ds_text_field.dart';
import 'package:smart_financial_recovery_app/core/form/engine/form_controller.dart';
import 'package:smart_financial_recovery_app/core/form/models/field_type.dart';
import 'package:smart_financial_recovery_app/core/form/models/form_field_config.dart';

class FormFieldFactory {
  static Widget build(
    FormFieldConfig config,
    FormController controller,
  ) {
    return _textField(config, controller);
  }

  static Widget _textField(
    FormFieldConfig config,
    FormController controller,
  ) {
    return DSTextField(
      label: config.label,
      hint: config.label,
      controller: controller.getTextController(config.key),
      type: _mapType(config.type),
      errorText: controller.getVisibleError(config.key),
      onChanged: (value) {
        controller.setValue(config, value);
      },
    );
  }

  static DSTextFieldType _mapType(FieldType type) {
    switch (type) {
      case FieldType.amount:
      case FieldType.percentage:
        return DSTextFieldType.amount;
      case FieldType.password:
        return DSTextFieldType.password;
      default:
        return DSTextFieldType.primary;
    }
  }
}