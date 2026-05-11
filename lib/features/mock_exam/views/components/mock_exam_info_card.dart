import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hugeicons/hugeicons.dart';

class MockExamInfoCard extends StatelessWidget {
  const MockExamInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ShadTheme.of(context).colorScheme.border),
        boxShadow: [
          BoxShadow(
            color: ShadTheme.of(
              context,
            ).colorScheme.foreground.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem(
            context,
            label: 'মোট প্রশ্ন',
            value: '২০টি',
            icon: HugeIcons.strokeRoundedIdea01,
            color: Colors.orange,
          ),
          Container(
            height: 40,
            width: 1,
            color: ShadTheme.of(context).colorScheme.border,
          ),
          _buildInfoItem(
            context,
            label: 'পাস মার্ক',
            value: '১৫',
            icon: HugeIcons.strokeRoundedCheckList,
            color: const Color(0xFF58CC02),
          ),
          Container(
            height: 40,
            width: 1,
            color: ShadTheme.of(context).colorScheme.border,
          ),
          _buildInfoItem(
            context,
            label: 'সময়',
            value: 'সীমা নেই',
            icon: HugeIcons.strokeRoundedClock01,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String label,
    required String value,
    required dynamic icon,
    required Color color,
  }) {
    return Column(
      children: [
        HugeIcon(icon: icon, size: 28, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: ShadTheme.of(
            context,
          ).textTheme.large.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: ShadTheme.of(context).textTheme.muted.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
