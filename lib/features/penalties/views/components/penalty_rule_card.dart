import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../models/penalty_rule.dart';

class PenaltyRuleCard extends StatelessWidget {
  final PenaltyRule rule;

  const PenaltyRuleCard({super.key, required this.rule});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      radius: const BorderRadius.all(Radius.circular(20)),
      padding: const EdgeInsets.all(16),
      backgroundColor: theme.colorScheme.card,
      border: ShadBorder.all(
        color: theme.colorScheme.border.withValues(alpha: 0.6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(rule.icon, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.title,
                  style: theme.textTheme.large.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rule.description,
                  style: theme.textTheme.muted.copyWith(height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
