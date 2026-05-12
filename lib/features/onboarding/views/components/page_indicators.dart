import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PageIndicators extends StatelessWidget {
  const PageIndicators({
    super.key,
    required this.count,
    required this.current,
    required this.activeColor,
  });
  final int count;
  final int current;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : ShadTheme.of(context).colorScheme.border,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
