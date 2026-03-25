import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/core/form/engine/form_controller.dart';
import 'package:smart_financial_recovery_app/core/form/models/form_field_config.dart';
import 'package:smart_financial_recovery_app/core/form/view/form_field_factory.dart';

class FormView extends StatelessWidget {
  final List<FormFieldConfig> fields;
  final FormController controller;

  const FormView({
    super.key,
    required this.fields,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Column(
          children: fields
              .map((f) => FormFieldFactory.build(f, controller))
              .toList(),
        );
      },
    );
  }
}