import 'package:flutter/material.dart';
import 'package:smart_financial_recovery_app/design_system/components/ds_text_field.dart';
import 'design_system/theme/ds_theme.dart';
import 'design_system/components/ds_button.dart';
import 'design_system/layout/ds_grid.dart';
import 'design_system/tokens/ds_spacing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DSTheme.lightTheme,
      home: DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final TextEditingController generalController = TextEditingController();
  final TextEditingController errorController = TextEditingController();
  final TextEditingController otherController = TextEditingController();
  String? amountError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: DSGrid.maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(DSGrid.mobileMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// PRIMARY BUTTON
                DSButton(
                  label: "Primary Action",
                  type: DSButtonType.primary,
                  onPressed: () {
                    debugPrint("Primary pressed");
                  },
                  isDisabled: false,
                ),

                const SizedBox(height: DSSpacing.md),

                /// PRIMARY BUTTON
                DSButton(
                  label: "Primary Disabled",
                  type: DSButtonType.primary,
                  onPressed: null,
                  isDisabled: true,
                ),

                const SizedBox(height: DSSpacing.md),

                /// SECONDARY BUTTON
                DSButton(
                  label: "Secondary Action",
                  type: DSButtonType.secondary,
                  onPressed: () {
                    debugPrint("Secondary pressed");
                  },
                  isDisabled: false,
                ),

                const SizedBox(height: DSSpacing.md),

                /// SECONDARY BUTTON
                DSButton(
                  label: "Secondary Disabled",
                  type: DSButtonType.secondary,
                  onPressed: null,
                  isDisabled: true,
                ),

                const SizedBox(height: DSSpacing.md),

                /// GHOST BUTTON
                DSButton(
                  label: "Ghost Action",
                  type: DSButtonType.ghost,
                  onPressed: () {
                    debugPrint("Ghost pressed");
                  },
                  isDisabled: false,
                ),

                const SizedBox(height: DSSpacing.md),

                /// DISABLED PRIMARY
                const DSButton(
                  label: "Ghost Disabled",
                  type: DSButtonType.ghost,
                  onPressed: null,
                  isDisabled: true,
                ),

                DSTextField(
                  hint: "0.00",
                  label: "General TF",
                  controller: generalController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    print("Amount entered: $value");
                  },
                  prefix: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("\$"),
                  ),
                ),

                DSTextField(
                  errorText: amountError,
                  hint: "0.00",
                  label: "Error TF",
                  controller: errorController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    debugPrint("Amount entered: $value");

                    final parsed = double.tryParse(value);

                    setState(() {
                      if (value.isEmpty) {
                        amountError = null;
                      } else if (parsed == null || parsed > 1000) {
                        amountError = "Invalid amount";
                      } else {
                        amountError = null;
                      }
                    });
                  },
                  prefix: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("\$"),
                  ),
                ),

                DSTextField(
                  disabled: true,
                  hint: "0.00",
                  label: "Disabled TF",
                  controller: generalController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    print("Amount entered: $value");
                  },
                  suffix: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("\$"),
                  ),
                ),

                DSTextField(
                  style: DSTextFieldStyle.filled,
                  disabled: false,
                  hint: "0.00",
                  label: "Form TF",
                  type: DSTextFieldType.amount,
                  controller: otherController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    print("Amount entered: $value");
                  },
                  suffix: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("\$"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
