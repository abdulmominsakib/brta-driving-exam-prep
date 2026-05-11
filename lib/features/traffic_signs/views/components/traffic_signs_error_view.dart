import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TrafficSignsErrorView extends StatelessWidget {
  const TrafficSignsErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.mutedForeground,
          ),
          const SizedBox(height: 16),
          Text(
            'ডেটা লোড করতে সমস্যা হয়েছে',
            style: theme.textTheme.p.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
