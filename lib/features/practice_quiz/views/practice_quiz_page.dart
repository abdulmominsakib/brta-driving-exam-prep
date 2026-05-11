import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/quiz_model.dart';
import '../../../core/services/sound_service.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/practice_quiz_provider.dart';
import '../providers/question_repository_provider.dart';
import 'components/feedback_bottom_sheet.dart';
import 'components/loading_road.dart';
import 'components/practice_quiz_result_view.dart';
import 'components/practice_quiz_tutorial_helper.dart';
import 'components/practice_quiz_view.dart';

class PracticeQuizPage extends ConsumerStatefulWidget {
  final String? dataPath;
  final bool isPractice;
  final int? questionLimit;
  final int? passThreshold;
  final int? levelIndex; // To track which level is being attempted

  const PracticeQuizPage({
    super.key,
    this.dataPath,
    this.isPractice = false,
    this.questionLimit,
    this.passThreshold,
    this.levelIndex,
  });

  @override
  ConsumerState<PracticeQuizPage> createState() => _PracticeQuizPageState();
}

class _PracticeQuizPageState extends ConsumerState<PracticeQuizPage> {
  final GlobalKey _progressKey = GlobalKey();
  final GlobalKey _questionKey = GlobalKey();
  final GlobalKey _firstOptionKey = GlobalKey();
  final GlobalKey _checkButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadSampleData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasShownTutorial =
        prefs.getBool('has_shown_quiz_tutorial') ?? false;

    if (!hasShownTutorial) {
      if (mounted) {
        PracticeQuizTutorialHelper.showTutorial(
          context: context,
          progressKey: _progressKey,
          questionKey: _questionKey,
          firstOptionKey: _firstOptionKey,
          checkButtonKey: _checkButtonKey,
          onFinish: () async {
            await prefs.setBool('has_shown_quiz_tutorial', true);
          },
        );
      }
    }
  }

  Future<void> _loadSampleData() async {
    try {
      List<Question> allQuestions = [];

      final String path =
          widget.dataPath ?? 'assets/data/questions/categorized/basics.json';

      final repository = ref.read(questionRepositoryProvider);
      allQuestions = await repository.getQuestionsBySourcePath(path);

      if (allQuestions.isEmpty) {
        debugPrint('No questions found in database for path: $path');
      }

      // Deduplicate questions based on question text
      final uniqueQuestions = <String, Question>{};
      for (final question in allQuestions) {
        final key = question.questionText.trim();
        if (!uniqueQuestions.containsKey(key)) {
          uniqueQuestions[key] = question;
        }
      }
      allQuestions = uniqueQuestions.values.toList();

      int initialIndex = 0;
      int initialScore = 0;
      bool shouldShuffle = true;

      // Handle Practice Mode Persistence
      if (widget.isPractice) {
        shouldShuffle = false; // Disable shuffle for practice

        if (widget.dataPath != null) {
          final prefs = await SharedPreferences.getInstance();
          initialIndex =
              prefs.getInt('practice_progress_${widget.dataPath}') ?? 0;
          initialScore = prefs.getInt('practice_score_${widget.dataPath}') ?? 0;

          // Save as last played
          await prefs.setString('last_played_practice_path', widget.dataPath!);

          // Setup listener to save progress
          ref.listenManual(practiceQuizNotifierProvider, (
            previous,
            next,
          ) async {
            if (next.isCompleted) {
              await prefs.remove('practice_progress_${widget.dataPath}');
              await prefs.remove('practice_score_${widget.dataPath}');
            } else if (previous?.currentQuestionIndex !=
                next.currentQuestionIndex) {
              await prefs.setInt(
                'practice_progress_${widget.dataPath}',
                next.currentQuestionIndex,
              );
              await prefs.setInt(
                'practice_score_${widget.dataPath}',
                next.score,
              );
            }
          });
        }
      }

      if (shouldShuffle) {
        allQuestions.shuffle();
      }

      // Limit (only for non-practice or if specifically requested)
      if (widget.questionLimit != null &&
          widget.questionLimit! < allQuestions.length) {
        allQuestions = allQuestions.take(widget.questionLimit!).toList();
      }

      ref
          .read(practiceQuizNotifierProvider.notifier)
          .loadQuestions(
            allQuestions,
            shouldShuffle: shouldShuffle,
            initialIndex: initialIndex,
            initialScore: initialScore,
          );
    } catch (e) {
      debugPrint('Error loading quiz data: $e');
    }
  }

  void _showFeedback(bool isCorrect, String correctAnswer) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => FeedbackBottomSheet(
        isCorrect: isCorrect,
        correctAnswer: correctAnswer,
        onContinue: () {
          Navigator.pop(context); // Close bottom sheet
          ref.read(practiceQuizNotifierProvider.notifier).nextQuestion();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(practiceQuizNotifierProvider);
    final currentQuestion = quizState.currentQuestion;

    final settingsAsync = ref.watch(settingsProvider);
    final isSoundEnabled = settingsAsync.value?.isSoundEnabled ?? true;
    final isHapticEnabled = settingsAsync.value?.isHapticEnabled ?? true;

    // Listen for answer check to show feedback
    ref.listen(practiceQuizNotifierProvider, (previous, next) {
      if (!next.isAnswered) return; // Only react when answered
      if (previous != null && previous.isAnswered) return; // Already handled

      if (next.isCorrect) {
        if (isSoundEnabled) SoundService.playSuccess();
        if (isHapticEnabled) HapticFeedback.mediumImpact();
      } else {
        if (isSoundEnabled) SoundService.playError();
        if (isHapticEnabled) HapticFeedback.heavyImpact();
      }

      final correctOption = next.currentQuestion?.options.firstWhere(
        (o) => o.isCorrect,
        orElse: () => Option(text: 'Unknown', isCorrect: true),
      );

      _showFeedback(next.isCorrect, correctOption?.text ?? '');
    });

    if (currentQuestion == null) {
      return const Scaffold(body: Center(child: LoadingRoad()));
    }

    if (quizState.isCompleted) {
      return PracticeQuizResultView(
        quizState: quizState,
        isPractice: widget.isPractice,
        passThreshold: widget.passThreshold,
        levelIndex: widget.levelIndex,
        dataPath: widget.dataPath,
      );
    }

    return PracticeQuizView(
      progressKey: _progressKey,
      questionKey: _questionKey,
      firstOptionKey: _firstOptionKey,
      checkButtonKey: _checkButtonKey,
      isPractice: widget.isPractice,
      passThreshold: widget.passThreshold,
    );
  }
}
