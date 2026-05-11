import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/quiz_model.dart';

class PracticeQuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int? selectedOption;
  final bool isAnswered;
  final bool isCorrect;
  final int score;
  final int lives;
  final bool isCompleted;

  const PracticeQuizState({
    required this.questions,
    required this.currentQuestionIndex,
    this.selectedOption,
    required this.isAnswered,
    required this.isCorrect,
    required this.score,
    required this.lives,
    required this.isCompleted,
  });

  Question? get currentQuestion =>
      questions.isNotEmpty && currentQuestionIndex < questions.length
      ? questions[currentQuestionIndex]
      : null;

  PracticeQuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? selectedOption,
    bool? isAnswered,
    bool? isCorrect,
    int? score,
    int? lives,
    bool? isCompleted,
  }) {
    return PracticeQuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOption:
          selectedOption, // Nullable handling logic remains same as intent
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class PracticeQuizNotifier extends Notifier<PracticeQuizState> {
  @override
  PracticeQuizState build() {
    return const PracticeQuizState(
      questions: [],
      currentQuestionIndex: 0,
      selectedOption: null,
      isAnswered: false,
      isCorrect: false,
      score: 0,
      lives: 3,
      isCompleted: false,
    );
  }

  void loadQuestions(
    List<Question> questions, {
    bool shouldShuffle = true,
    int initialIndex = 0,
    int initialScore = 0,
  }) {
    List<Question> finalQuestions;

    if (shouldShuffle) {
      // Shuffle options for each question
      finalQuestions = questions.map((q) {
        final shuffledOptions = List<Option>.from(q.options)..shuffle();
        return Question(
          questionText: q.questionText,
          questionImage: q.questionImage,
          options: shuffledOptions,
        );
      }).toList()..shuffle(); // Shuffle questions
    } else {
      // Don't shuffle questions, but still shuffle options?
      // User said "don't randomize practice questions", implying order matters or just static sequence.
      // Usually options are shuffled in quizzes regardless.
      finalQuestions = questions.map((q) {
        final shuffledOptions = List<Option>.from(q.options)..shuffle();
        return Question(
          questionText: q.questionText,
          questionImage: q.questionImage,
          options: shuffledOptions,
        );
      }).toList();
      // No shuffle for questions list
    }

    state =
        const PracticeQuizState(
          questions: [],
          currentQuestionIndex: 0,
          selectedOption: null,
          isAnswered: false,
          isCorrect: false,
          score: 0,
          lives: 3,
          isCompleted: false,
        ).copyWith(
          questions: finalQuestions,
          currentQuestionIndex: initialIndex.clamp(
            0,
            finalQuestions.length - 1,
          ),
          score: initialScore,
        );
  }

  void selectOption(int index) {
    if (state.isAnswered || state.isCompleted) return;
    state = state.copyWith(selectedOption: index);
  }

  void checkAnswer() {
    if (state.selectedOption == null || state.isAnswered || state.isCompleted) {
      return;
    }

    final question = state.currentQuestion;
    if (question == null) return;

    final selectedOptionIndex = state.selectedOption!;
    // Assuming options have an 'isCorrect' field, but looking at model, it does.
    // However, the model has List<Option>.
    if (selectedOptionIndex >= question.options.length) return;

    final isCorrect = question.options[selectedOptionIndex].isCorrect;

    state = state.copyWith(
      isAnswered: true,
      isCorrect: isCorrect,
      score: isCorrect ? state.score + 10 : state.score,
      lives: isCorrect ? state.lives : state.lives - 1,
    );

    if (state.lives == 0) {
      // Handle Game Over if needed, for now just let it be or mark completed?
      // Usually we should stop you if you lose all hearts.
      // For now we will check lives in UI.
    }
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedOption: null,
        isAnswered: false,
        isCorrect: false,
      );
    } else {
      state = state.copyWith(isCompleted: true);
    }
  }
}

final practiceQuizNotifierProvider =
    NotifierProvider<PracticeQuizNotifier, PracticeQuizState>(
      () => PracticeQuizNotifier(),
    );
