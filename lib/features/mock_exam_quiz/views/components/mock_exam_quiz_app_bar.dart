import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockExamQuizAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double progress;
  final bool isPractice;
  final GlobalKey progressKey;

  const MockExamQuizAppBar({
    super.key,
    required this.progress,
    required this.isPractice,
    required this.progressKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedCancel01,
          color: Colors.grey,
        ),
        onPressed: () => context.pop(),
      ),
      title: ShadProgress(
        key: progressKey,
        value: progress,
        minHeight: 16,
        backgroundColor: Colors.grey.shade200,
        valueColor: const AlwaysStoppedAnimation(Color(0xFF58CC02)),
      ),
      actions: [
        if (!isPractice)
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'পরীক্ষা',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
