import 'package:flutter/material.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_radius.dart';
import '../tokens/ds_shadows.dart';
import '../tokens/ds_colors.dart';

class DSCard extends StatelessWidget {
  final Widget child;

  const DSCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DSSpacing.md),
      decoration: BoxDecoration(
        color: DSColors.surfacePrimary,
        borderRadius: DSRadius.lg,
        boxShadow: [DSShadows.md],
      ),
      child: child,
    );
  }
}
