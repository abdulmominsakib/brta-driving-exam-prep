import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../practice/providers/practice_progress_provider.dart'
    show practiceProgressProvider;
import '../../providers/practice_cards_provider.dart';
import 'practice_action_button.dart';

class PracticeCardsCompletionView extends ConsumerWidget {
  final PracticeCardsState state;
  final int? levelIndex;
  final String? dataPath;

  const PracticeCardsCompletionView({
    super.key,
    required this.state,
    this.levelIndex,
    this.dataPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedBookOpen01,
                color: theme.colorScheme.primary,
                size: 100,
              ),
              const SizedBox(height: 32),
              Text(
                'অনুশীলন সম্পন্ন!', // Practice Completed!
                style: theme.textTheme.h1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'আপনি এই সেকশনের ${state.questions.length}টি কার্ড সফলভাবে অনুশীলন করেছেন।',
                style: theme.textTheme.large.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontFamily: kFontFamily,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              PracticeActionButton(
                label: 'চালিয়ে যান', // Continue
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: theme.colorScheme.primary,
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.7),
                onTap: () {
                  if (levelIndex != null) {
                    ref
                        .read(practiceProgressProvider.notifier)
                        .unlockNextLevel(levelIndex!);
                  }
                  if (dataPath != null) {
                    ref
                        .read(practiceProgressProvider.notifier)
                        .markSectionCompleted(dataPath!);
                  }
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
