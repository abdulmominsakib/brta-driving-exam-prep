import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/sound_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/practice_cards_provider.dart';
import '../providers/question_repository_provider.dart';
import 'components/loading_road.dart';
import 'components/practice_action_button.dart';
import 'components/practice_cards_completion_view.dart';
import 'components/practice_cards_tutorial_helper.dart';
import 'components/swipeable_card_stack.dart';

class PracticeCardsPage extends ConsumerStatefulWidget {
  final String? dataPath;
  final int? levelIndex;

  const PracticeCardsPage({super.key, this.dataPath, this.levelIndex});

  @override
  ConsumerState<PracticeCardsPage> createState() => _PracticeCardsPageState();
}

class _PracticeCardsPageState extends ConsumerState<PracticeCardsPage> {
  final GlobalKey _tutorialCenterKey = GlobalKey();
  final GlobalKey _knownButtonKey = GlobalKey();
  final GlobalKey _unknownButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final path =
        widget.dataPath ?? 'assets/data/questions/categorized/basics.json';
    final repository = ref.read(questionRepositoryProvider);
    final questions = await repository.getQuestionsBySourcePath(path);

    // Randomize for cards
    questions.shuffle();

    ref.read(practiceCardsNotifierProvider.notifier).loadQuestions(questions);

    _checkAndShowTutorial();
  }

  Future<void> _checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasShownCardTutorial =
        prefs.getBool('has_shown_practice_cards_tutorial_card') ?? false;

    if (!hasShownCardTutorial) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            PracticeCardsTutorialHelper.showCardTutorial(
              context: context,
              cardKey: _tutorialCenterKey,
              onFinish: () async {
                await prefs.setBool(
                  'has_shown_practice_cards_tutorial_card',
                  true,
                );
              },
            );
          }
        });
      }
    }
  }

  Future<void> _checkAndShowButtonsTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasShownButtonsTutorial =
        prefs.getBool('has_shown_practice_cards_tutorial_buttons') ?? false;

    if (!hasShownButtonsTutorial) {
      if (mounted) {
        PracticeCardsTutorialHelper.showButtonsTutorial(
          context: context,
          knownButtonKey: _knownButtonKey,
          unknownButtonKey: _unknownButtonKey,
          onFinish: () async {
            await prefs.setBool(
              'has_shown_practice_cards_tutorial_buttons',
              true,
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(practiceCardsNotifierProvider);
    final notifier = ref.read(practiceCardsNotifierProvider.notifier);
    final theme = ShadTheme.of(context);

    final settingsAsync = ref.watch(settingsProvider);
    final isSoundEnabled = settingsAsync.value?.isSoundEnabled ?? true;
    final isHapticEnabled = settingsAsync.value?.isHapticEnabled ?? true;

    if (state.questions.isEmpty) {
      return const Scaffold(body: Center(child: LoadingRoad()));
    }

    if (state.isCompleted) {
      return PracticeCardsCompletionView(
        state: state,
        levelIndex: widget.levelIndex,
        dataPath: widget.dataPath,
      );
    }

    final currentQuestion = state.currentQuestion;
    final progress = (state.currentIndex + 1) / state.questions.length;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedCancel01,
            color: theme.colorScheme.mutedForeground,
          ),
          onPressed: () => context.pop(),
        ),
        title: ShadProgress(
          value: progress,
          minHeight: 12,
          backgroundColor: theme.colorScheme.border,
          valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${state.currentIndex + 1}/${state.questions.length}',
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          state.isFlipped ? 24 : 14,
          24,
          state.isFlipped ? 16 : 14,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SwipeableCardStack(
                  cardKey: _tutorialCenterKey,
                  currentQuestion: currentQuestion!,
                  isFlipped: state.isFlipped,
                  nextQuestion1: state.currentIndex + 1 < state.questions.length
                      ? state.questions[state.currentIndex + 1]
                      : null,
                  nextQuestion2: state.currentIndex + 2 < state.questions.length
                      ? state.questions[state.currentIndex + 2]
                      : null,
                  onTap: () {
                    if (isSoundEnabled) SoundService.playClick();
                    if (isHapticEnabled) HapticFeedback.lightImpact();
                    notifier.flipCard();
                    if (!state.isFlipped) {
                      Future.delayed(const Duration(milliseconds: 400), () {
                        _checkAndShowButtonsTutorial();
                      });
                    }
                  },
                  onSwipeRight: () {
                    if (isSoundEnabled) SoundService.playSuccess();
                    if (isHapticEnabled) HapticFeedback.mediumImpact();
                    notifier.markAsKnown();
                  },
                  onSwipeLeft: () {
                    if (isSoundEnabled) SoundService.playLoading();
                    if (isHapticEnabled) HapticFeedback.mediumImpact();
                    notifier.markAsUnknown();
                  },
                ),
              ),
            ),
            if (state.isFlipped) ...[
              const SizedBox(height: 24),
              AnimatedSlide(
                offset: state.isFlipped ? Offset.zero : const Offset(0, 0.15),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: state.isFlipped ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    children: [
                      Expanded(
                        child: PracticeActionButton(
                          key: _unknownButtonKey,
                          label: 'জানি না', // Don't know
                          icon: HugeIcons.strokeRoundedAlertCircle,
                          color: const Color(0xFFFF4B4B),
                          shadowColor: const Color(0xFFEA2B2B),
                          onTap: () {
                            if (isSoundEnabled) SoundService.playLoading();
                            if (isHapticEnabled) HapticFeedback.mediumImpact();
                            notifier.markAsUnknown();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PracticeActionButton(
                          key: _knownButtonKey,
                          label: 'জানি', // Know
                          icon: HugeIcons.strokeRoundedTick02,
                          color: theme.colorScheme.primary,
                          shadowColor: theme.colorScheme.primary.withValues(
                            alpha: 0.7,
                          ),
                          onTap: () {
                            if (isSoundEnabled) SoundService.playSuccess();
                            if (isHapticEnabled) HapticFeedback.mediumImpact();
                            notifier.markAsKnown();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ] else ...[
              const SizedBox(height: 32),
              Text(
                'উওর দেখতে কার্ডে ট্যাপ করুন', // Tap card to see answer
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontFamily: kFontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
