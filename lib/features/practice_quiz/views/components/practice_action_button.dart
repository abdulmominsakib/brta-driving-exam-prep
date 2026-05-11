import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/theme/app_theme.dart';

class PracticeActionButton extends StatelessWidget {
  final String label;
  final dynamic icon;
  final Color color;
  final Color shadowColor;
  final VoidCallback onTap;
  final double height;

  const PracticeActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.shadowColor,
    required this.onTap,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border(bottom: BorderSide(color: shadowColor, width: 4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon is IconData)
              Icon(icon, color: Colors.white, size: 20)
            else
              HugeIcon(icon: icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.large.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
