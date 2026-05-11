import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/quiz_model.dart';
import '../../../core/services/sound_service.dart';
import '../../practice/providers/practice_progress_provider.dart';
import '../../practice_quiz/providers/question_repository_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../data/models/mock_exam_result.dart';
import '../providers/mock_exam_quiz_provider.dart';
import '../providers/mock_exam_repository_provider.dart';
import 'components/feedback_bottom_sheet.dart';
import 'components/mock_exam_check_button.dart';
import 'components/mock_exam_options_view.dart';
import 'components/mock_exam_question_view.dart';
import 'components/mock_exam_quiz_app_bar.dart';
import 'components/mock_exam_quiz_tutorial_helper.dart';
import 'components/mock_exam_result_view.dart';

class MockExamQuizPage extends ConsumerStatefulWidget {
  final String? dataPath;
  final bool isPractice;
  final int? questionLimit;
  final int? passThreshold;
  final int? levelIndex;

  const MockExamQuizPage({
    super.key,
    this.dataPath,
    this.isPractice = false,
    this.questionLimit,
    this.passThreshold,
    this.levelIndex,
  });

  @override
  ConsumerState<MockExamQuizPage> createState() => _MockExamQuizPageState();
}

class _MockExamQuizPageState extends ConsumerState<MockExamQuizPage> {
  bool _hasPlayedSuccessParams = false;

  // Tutorial keys
  final GlobalKey _progressKey = GlobalKey();
  final GlobalKey _questionKey = GlobalKey();
  final GlobalKey _firstOptionKey = GlobalKey();
  final GlobalKey _checkButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    try {
      List<Question> allQuestions = [];

      final repository = ref.read(questionRepositoryProvider);

      if (widget.dataPath == 'mock_test') {
        allQuestions = await repository.getAllQuestions();
      } else {
        final String path =
            widget.dataPath ?? 'assets/data/questions/categorized/basics.json';
        allQuestions = await repository.getQuestionsBySourcePath(path);
      }

      // Deduplicate questions based on normalized question text
      final uniqueQuestions = <String, Question>{};
      for (final question in allQuestions) {
        final key = question.questionText.trim();
        if (!uniqueQuestions.containsKey(key)) {
          uniqueQuestions[key] = question;
        }
      }
      allQuestions = uniqueQuestions.values.toList();

      allQuestions.shuffle();

      if (widget.questionLimit != null &&
          widget.questionLimit! < allQuestions.length) {
        allQuestions = allQuestions.take(widget.questionLimit!).toList();
      }

      ref
          .read(mockExamQuizNotifierProvider.notifier)
          .loadQuestions(allQuestions);

      _checkAndShowTutorial();
    } catch (e) {
      debugPrint('Error loading quiz data: $e');
    }
  }

  Future<void> _checkAndShowTutorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasShownTutorial =
          prefs.getBool('hasShownMockExamQuizTutorial') ?? false;

      if (!hasShownTutorial) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            MockExamQuizTutorialHelper.showTutorial(
              context: context,
              progressKey: _progressKey,
              questionKey: _questionKey,
              firstOptionKey: _firstOptionKey,
              checkButtonKey: _checkButtonKey,
              onFinish: () {
                prefs.setBool('hasShownMockExamQuizTutorial', true);
              },
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Error showing tutorial: $e');
    }
  }

  Future<void> _saveCurrentResult(
    int score,
    int totalQuestions,
    bool isPassed,
  ) async {
    if (!widget.isPractice) {
      final result = MockExamResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        score: score,
        totalQuestions: totalQuestions,
        timestamp: DateTime.now(),
        isPassed: isPassed,
      );
      await ref.read(mockExamRepositoryProvider).saveResult(result);
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
          Navigator.pop(context);
          ref.read(mockExamQuizNotifierProvider.notifier).nextQuestion();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(mockExamQuizNotifierProvider);
    final quizNotifier = ref.read(mockExamQuizNotifierProvider.notifier);

    ref.listen(mockExamQuizNotifierProvider, (previous, next) {
      if (!next.isAnswered) return;
      if (previous != null && previous.isAnswered) return;

      final settingsAsync = ref.read(settingsProvider);
      final isSoundEnabled = settingsAsync.value?.isSoundEnabled ?? true;
      final isHapticEnabled = settingsAsync.value?.isHapticEnabled ?? true;

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

    if (quizState.isCompleted) {
      final int correctAnswers = quizState.score ~/ 10;
      final bool isPassed = widget.passThreshold != null
          ? correctAnswers >= widget.passThreshold!
          : correctAnswers >= (quizState.questions.length * 0.6).ceil();

      if (!_hasPlayedSuccessParams) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_hasPlayedSuccessParams) {
            _saveCurrentResult(
              correctAnswers,
              quizState.questions.length,
              isPassed,
            );
            setState(() {
              _hasPlayedSuccessParams = true;
            });

            final settingsAsync = ref.read(settingsProvider);
            final isSoundEnabled = settingsAsync.value?.isSoundEnabled ?? true;

            if (isPassed && isSoundEnabled) SoundService.playBirdChirp();
            if (isPassed) {
              Confetti.launch(
                context,
                options: const ConfettiOptions(
                  particleCount: 100,
                  spread: 70,
                  y: 0.6,
                ),
              );
            }
          }
        });
      }

      return MockExamResultView(
        isPassed: isPassed,
        correctAnswers: correctAnswers,
        totalQuestions: quizState.questions.length,
        passThreshold: widget.passThreshold,
        onContinue: () {
          if (isPassed == true && widget.levelIndex != null) {
            ref
                .read(practiceProgressProvider.notifier)
                .unlockNextLevel(widget.levelIndex!);
          }
          context.pop();
        },
      );
    }

    if (quizState.currentQuestion == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final totalQuestions = quizState.questions.length;
    final progress = totalQuestions > 0
        ? (quizState.currentQuestionIndex + 1) / totalQuestions
        : 0.0;

    final settingsAsync = ref.watch(settingsProvider);
    final isSoundEnabled = settingsAsync.value?.isSoundEnabled ?? true;
    final isHapticEnabled = settingsAsync.value?.isHapticEnabled ?? true;

    return Scaffold(
      appBar: MockExamQuizAppBar(
        progress: progress,
        isPractice: widget.isPractice,
        progressKey: _progressKey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MockExamQuestionView(
                question: quizState.currentQuestion!,
                currentIndex: quizState.currentQuestionIndex,
                totalQuestions: totalQuestions,
                questionKey: _questionKey,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: MockExamOptionsView(
                  options: quizState.currentQuestion!.options,
                  selectedOption: quizState.selectedOption,
                  isAnswered: quizState.isAnswered,
                  firstOptionKey: _firstOptionKey,
                  onSelect: (index) {
                    if (isSoundEnabled) SoundService.playClick();
                    if (isHapticEnabled) HapticFeedback.selectionClick();
                    quizNotifier.selectOption(index);
                  },
                ),
              ),
              const SizedBox(height: 16),
              MockExamCheckButton(
                buttonKey: _checkButtonKey,
                isEnabled:
                    quizState.selectedOption != null && !quizState.isAnswered,
                onTap: () => quizNotifier.checkAnswer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
