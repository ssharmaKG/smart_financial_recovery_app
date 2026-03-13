import 'package:flutter/material.dart';
import '../tokens/ds_colors.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_radius.dart';

enum DSTextFieldType { primary, amount, password, search }

enum DSTextFieldStyle { outlined, filled }

class DSTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final String? errorText;
  final bool disabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final DSTextFieldType type;
  final DSTextFieldStyle style;

  const DSTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.errorText,
    this.disabled = false,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.type = DSTextFieldType.primary,
    this.style = DSTextFieldStyle.outlined,
  });

  TextInputType _getKeyboardType() {
    switch (type) {
      case DSTextFieldType.amount:
        return TextInputType.number;

      case DSTextFieldType.search:
        return TextInputType.text;

      case DSTextFieldType.password:
        return TextInputType.text;

      default:
        return keyboardType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DSSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: DSColors.textSecondary,
              ),
            ),
            const SizedBox(height: DSSpacing.xs),
          ],

          SizedBox(
            height: errorText != null && errorText!.isNotEmpty ? 64 : 44,
            child: TextField(
              controller: controller,
              keyboardType: _getKeyboardType(),
              onChanged: onChanged,
              enabled: !disabled,
              obscureText: type == DSTextFieldType.password,
              style: const TextStyle(fontSize: 16, color: DSColors.textPrimary),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: DSColors.textDisabled),
                errorText: errorText,
                prefixIcon: prefix,
                suffixIcon: suffix,
                filled: true,
                fillColor: style == DSTextFieldStyle.filled
                    ? DSColors.surfaceSecondary
                    : disabled
                    ? DSColors.surfaceSecondary
                    : DSColors.surfacePrimary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: DSSpacing.md,
                ),

                // Default Border
                enabledBorder: style == DSTextFieldStyle.filled
                    ? OutlineInputBorder(
                        borderRadius: DSRadius.xxl,
                        borderSide: BorderSide.none,
                      )
                    : OutlineInputBorder(
                        borderRadius: DSRadius.md,
                        borderSide: const BorderSide(
                          color: DSColors.surfaceSecondary,
                        ),
                      ),

                // Focused Border
                focusedBorder: style == DSTextFieldStyle.filled
                    ? OutlineInputBorder(
                        borderRadius: DSRadius.xxl,
                        borderSide: BorderSide.none,
                      )
                    : OutlineInputBorder(
                        borderRadius: DSRadius.md,
                        borderSide: const BorderSide(
                          color: DSColors.brandPrimary,
                          width: 1.5,
                        ),
                      ),

                // Error Border
                errorBorder: OutlineInputBorder(
                  borderRadius: DSRadius.md,
                  borderSide: const BorderSide(color: DSColors.error),
                ),

                // Disabled Border
                disabledBorder: OutlineInputBorder(
                  borderRadius: DSRadius.md,
                  borderSide: const BorderSide(
                    color: DSColors.surfaceSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
