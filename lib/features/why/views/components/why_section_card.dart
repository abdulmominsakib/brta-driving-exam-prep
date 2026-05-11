import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WhySectionCard extends StatelessWidget {
  final String title;
  final dynamic icon;
  final Widget content;

  const WhySectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: ShadTheme.of(context).colorScheme.border,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ShadTheme.of(
              context,
            ).colorScheme.foreground.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: HugeIcon(
                  icon: icon,
                  color: const Color(0xFF58CC02),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}
