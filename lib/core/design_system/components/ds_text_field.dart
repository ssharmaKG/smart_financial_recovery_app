import 'package:flutter/material.dart';
import '../tokens/ds_colors.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_radius.dart';

enum DSTextFieldType { primary, amount, password, search }

enum DSTextFieldStyle { outlined, filled }

class DSTextField extends StatefulWidget {
  final String hint;
  final String? label;
  final String? errorText;
  final bool disabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final DSTextFieldType type;
  final DSTextFieldStyle style;
  final FormFieldValidator<String>? validator;

  const DSTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.errorText,
    this.disabled = false,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.onChanged,
    this.type = DSTextFieldType.primary,
    this.style = DSTextFieldStyle.outlined,
    this.validator,
  });

  @override
  State<DSTextField> createState() => _DSTextFieldState();
}

class _DSTextFieldState extends State<DSTextField> {
  bool _obscureText = true;

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case DSTextFieldType.amount:
        return TextInputType.number;
      case DSTextFieldType.search:
        return TextInputType.text;
      case DSTextFieldType.password:
        return TextInputType.text;
      default:
        return widget.keyboardType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.type == DSTextFieldType.password;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DSSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Label ──────────────────────────────────────────────────────────
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: DSColors.textSecondary,
              ),
            ),
            const SizedBox(height: DSSpacing.xs),
          ],

          SizedBox(
            height: 48,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: _getKeyboardType(),
              onChanged: widget.onChanged,
              enabled: !widget.disabled,
              obscureText: isPassword ? _obscureText : false,
              validator: widget.validator,
              style: const TextStyle(fontSize: 16, color: DSColors.textPrimary),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: DSColors.textDisabled,
                  fontSize: 16,
                ),
                // Hide inline error — shown manually below
                errorText: null,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                prefixIcon: widget.prefix,

                // Password toggle — auto shown for password type only
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: DSColors.textDisabled,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      )
                    : null,

                filled: true,
                fillColor: widget.style == DSTextFieldStyle.filled
                    ? DSColors.surfaceSecondary
                    : widget.disabled
                    ? DSColors.surfaceSecondary
                    : DSColors.surfacePrimary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: DSSpacing.md,
                  vertical: DSSpacing.sm,
                ),

                // Enabled Border
                enabledBorder: widget.style == DSTextFieldStyle.filled
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      )
                    : OutlineInputBorder(
                        borderRadius: DSRadius.md,
                        borderSide: const BorderSide(
                          color: DSColors.surfaceSecondary,
                        ),
                      ),

                // Focused Border
                focusedBorder: widget.style == DSTextFieldStyle.filled
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
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

                // Focused Error Border
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: DSRadius.md,
                  borderSide: const BorderSide(
                    color: DSColors.error,
                    width: 1.5,
                  ),
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

          // ── Error text ──────────────────────────
          if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
            const SizedBox(height: DSSpacing.xs),
            Text(
              widget.errorText!,
              style: const TextStyle(color: DSColors.error, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
