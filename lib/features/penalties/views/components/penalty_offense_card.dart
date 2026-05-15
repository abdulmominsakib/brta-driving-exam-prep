import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../models/penalty_offense.dart';

class PenaltyOffenseCard extends StatelessWidget {
  final PenaltyOffense offense;

  const PenaltyOffenseCard({super.key, required this.offense});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      radius: const BorderRadius.all(Radius.circular(18)),
      padding: const EdgeInsets.all(16),
      backgroundColor: theme.colorScheme.card,
      border: ShadBorder.all(color: theme.colorScheme.border),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offense.offense,
            style: theme.textTheme.large.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _MetaPill(
                label: 'সর্বোচ্চ জরিমানা',
                value: offense.maxFine,
                color: const Color(0xFFF97316),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  offense.punishment,
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MetaPill({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.small.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
