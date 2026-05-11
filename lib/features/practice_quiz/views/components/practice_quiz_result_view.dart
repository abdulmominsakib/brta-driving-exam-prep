import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/providers/rate_app_provider.dart';
import '../../../../core/services/sound_service.dart';
import '../../../practice/providers/practice_progress_provider.dart';
import '../../../settings/providers/settings_provider.dart';
import '../../providers/practice_quiz_provider.dart';

class PracticeQuizResultView extends ConsumerStatefulWidget {
  final PracticeQuizState quizState;
  final bool isPractice;
  final int? passThreshold;
  final int? levelIndex;
  final String? dataPath;

  const PracticeQuizResultView({
    super.key,
    required this.quizState,
    required this.isPractice,
    this.passThreshold,
    this.levelIndex,
    this.dataPath,
  });

  @override
  ConsumerState<PracticeQuizResultView> createState() =>
      _PracticeQuizResultViewState();
}

class _PracticeQuizResultViewState
    extends ConsumerState<PracticeQuizResultView> {
  bool _hasPlayedSuccessParams = false;

  @override
  void initState() {
    super.initState();
    _handleSuccessEffects();
  }

  void _handleSuccessEffects() {
    final correctAnswers = widget.quizState.score ~/ 10;
    final bool? isPassed = widget.passThreshold != null
        ? correctAnswers >= widget.passThreshold!
        : null;

    if (isPassed == true && !_hasPlayedSuccessParams) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final settings = ref.read(settingsProvider).value;
          final isSoundEnabled = settings?.isSoundEnabled ?? true;

          setState(() => _hasPlayedSuccessParams = true);
          if (isSoundEnabled) SoundService.playBirdChirp();
          Confetti.launch(
            context,
            options: const ConfettiOptions(
              particleCount: 100,
              spread: 70,
              y: 0.6,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final int correctAnswers = widget.quizState.score ~/ 10;
    final bool? isPassed = widget.passThreshold != null
        ? correctAnswers >= widget.passThreshold!
        : null;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isPractice) ...[
                HugeIcon(
                  icon: HugeIcons.strokeRoundedBookOpen01,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'অনুশীলন সম্পন্ন!', // Practice Completed!
                  style: theme.textTheme.h2.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else if (isPassed != null) ...[
                HugeIcon(
                  icon: isPassed
                      ? HugeIcons.strokeRoundedTick02
                      : HugeIcons.strokeRoundedCancel01,
                  size: 80,
                  color: isPassed
                      ? const Color(0xFF58CC02)
                      : const Color(0xFFFF4B4B),
                ),
                const SizedBox(height: 24),
                Text(
                  isPassed
                      ? 'অসাধারণ!'
                      : 'আবার চেষ্টা করুন!', // Awesome! / Try Again!
                  style: theme.textTheme.h2.copyWith(
                    color: isPassed
                        ? const Color(0xFF58CC02)
                        : const Color(0xFFFF4B4B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else ...[
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedCoupon01,
                  size: 80,
                  color: Colors.amber,
                ),
                const SizedBox(height: 24),
                Text(
                  'কুইজ সম্পন্ন!', // Quiz Completed!
                  style: theme.textTheme.h2.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.colorScheme.border),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.isPractice
                          ? 'মোট সম্পন্ন'
                          : 'স্কোর', // Total Completed / Score
                      style: theme.textTheme.large.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$correctAnswers / ${widget.quizState.questions.length}',
                      style: theme.textTheme.h3.copyWith(
                        color: const Color(0xFF58CC02),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.passThreshold != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'পাস করতে প্রয়োজন: ${widget.passThreshold}', // Required to pass
                        style: theme.textTheme.p.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: () async {
                  if (isPassed == true) {
                    if (widget.levelIndex != null) {
                      ref
                          .read(practiceProgressProvider.notifier)
                          .unlockNextLevel(widget.levelIndex!);
                    }
                    if (widget.dataPath != null) {
                      ref
                          .read(practiceProgressProvider.notifier)
                          .markSectionCompleted(widget.dataPath!);
                    }
                    await ref.read(rateAppProvider.notifier).requestReview();
                  }
                  if (context.mounted) {
                    context.pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.primary.withValues(alpha: 0.7),
                        width: 4.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'চালিয়ে যান', // Continue
                      style: theme.textTheme.large.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
