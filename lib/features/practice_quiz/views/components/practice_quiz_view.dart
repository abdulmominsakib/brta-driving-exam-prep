import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/services/sound_service.dart';
import '../../../settings/providers/settings_provider.dart';
import '../../providers/practice_quiz_provider.dart';

import 'quiz_option_card.dart';

class PracticeQuizView extends ConsumerWidget {
  final GlobalKey progressKey;
  final GlobalKey questionKey;
  final GlobalKey firstOptionKey;
  final GlobalKey checkButtonKey;
  final bool isPractice;
  final int? passThreshold;

  const PracticeQuizView({
    super.key,
    required this.progressKey,
    required this.questionKey,
    required this.firstOptionKey,
    required this.checkButtonKey,
    required this.isPractice,
    this.passThreshold,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(practiceQuizNotifierProvider);
    final quizNotifier = ref.read(practiceQuizNotifierProvider.notifier);
    final theme = ShadTheme.of(context);
    final settings = ref.watch(settingsProvider).value;
    final isSoundEnabled = settings?.isSoundEnabled ?? true;
    final isHapticEnabled = settings?.isHapticEnabled ?? true;

    final currentQuestion = quizState.currentQuestion!;
    final totalQuestions = quizState.questions.length;
    final currentQuestionNum = quizState.currentQuestionIndex + 1;
    final remainingQuestions = totalQuestions - currentQuestionNum;
    final progress = totalQuestions > 0
        ? currentQuestionNum / totalQuestions
        : 0.0;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 56,
        leading: IconButton(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedCancel01,
            color: theme.colorScheme.mutedForeground,
          ),
          onPressed: () => context.pop(),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ShadProgress(
            key: progressKey,
            value: progress,
            minHeight: 12,
            backgroundColor: theme.colorScheme.border,
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
          ),
        ),
        actions: [
          if (isPractice)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F6FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF1CB0F6).withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedBookOpen01,
                    color: Color(0xFF1CB0F6),
                    size: 16,
                  ),
                ],
              ),
            )
          else if (passThreshold == null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedFavourite,
                    color: Color(0xFFFF4B4B),
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${quizState.lives}',
                    style: theme.textTheme.large.copyWith(
                      color: const Color(0xFFFF4B4B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.border),
                    ),
                    child: Text(
                      'প্রশ্ন $currentQuestionNum / $totalQuestions',
                      style: theme.textTheme.small.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.mutedForeground,
                      ),
                    ),
                  ),
                  if (remainingQuestions > 0)
                    Row(
                      children: [
                        Text(
                          'বাকি আছে: $remainingQuestionsটি',
                          style: theme.textTheme.small.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.mutedForeground,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF58CC02,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${(progress * 100).toInt()}%',
                            style: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF58CC02),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.card,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.border,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colorScheme.border),
                      ),
                      child: Text(
                        'প্রশ্ন',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      key: questionKey,
                      currentQuestion.questionText,
                      style: theme.textTheme.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: theme.colorScheme.foreground,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    if (currentQuestion.questionImage != null) ...[
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child:
                            currentQuestion.questionImage!
                                .toLowerCase()
                                .endsWith('.svg')
                            ? SvgPicture.asset(
                                currentQuestion.questionImage!,
                                height: 140,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                currentQuestion.questionImage!,
                                height: 140,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox.shrink(),
                              ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final isSelected = quizState.selectedOption == index;
                    return QuizOptionCard(
                      key: index == 0 ? firstOptionKey : null,
                      text: option.text,
                      image: option.optionImage,
                      isSelected: isSelected,
                      isAnswered: quizState.isAnswered,
                      isCorrect: option.isCorrect,
                      isWrong: !option.isCorrect,
                      onTap: () {
                        if (isSoundEnabled) SoundService.playClick();
                        if (isHapticEnabled) HapticFeedback.selectionClick();
                        quizNotifier.selectOption(index);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                key: checkButtonKey,
                onTap: () {
                  if (quizState.selectedOption != null &&
                      !quizState.isAnswered) {
                    quizNotifier.checkAnswer();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        (quizState.selectedOption != null &&
                            !quizState.isAnswered)
                        ? theme.colorScheme.primary
                        : theme.colorScheme.border,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      bottom: BorderSide(
                        color:
                            (quizState.selectedOption != null &&
                                !quizState.isAnswered)
                            ? theme.colorScheme.primary
                            : theme.colorScheme.mutedForeground.withValues(
                                alpha: 0.2,
                              ),
                        width: 4.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'চেক করুন',
                      style: theme.textTheme.large.copyWith(
                        color:
                            (quizState.selectedOption != null &&
                                !quizState.isAnswered)
                            ? Colors.white
                            : theme.colorScheme.mutedForeground,
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
