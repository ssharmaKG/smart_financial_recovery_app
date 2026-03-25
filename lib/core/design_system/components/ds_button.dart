import 'package:flutter/material.dart';
import '../tokens/ds_colors.dart';
import '../tokens/ds_radius.dart';

enum DSButtonType { primary, secondary, ghost }

class DSButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final DSButtonType type;
  final bool isDisabled;

  const DSButton({
    super.key,
    required this.label,
    required this.type,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Color textColor;
    BorderSide border = BorderSide.none;

    switch (type) {
      case DSButtonType.primary:
        backgroundColor = isDisabled
            ? DSColors.brandPrimary40
            : DSColors.brandPrimary;

        textColor = isDisabled
            ? DSColors.textInverse.withValues(alpha: .7)
            : DSColors.textInverse;
        break;

      case DSButtonType.secondary:
        backgroundColor = Colors.transparent;

        textColor = isDisabled ? DSColors.textDisabled : DSColors.brandPrimary;

        border = BorderSide(
          color: isDisabled ? DSColors.textDisabled : DSColors.brandPrimary,
        );
        break;

      case DSButtonType.ghost:
        backgroundColor = Colors.transparent;

        textColor = isDisabled ? DSColors.textDisabled : DSColors.brandPrimary;
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: DSRadius.md,
            side: border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
