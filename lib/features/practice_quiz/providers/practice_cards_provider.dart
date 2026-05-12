import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/quiz_model.dart';

class PracticeCardsState {
  final List<Question> questions;
  final int currentIndex;
  final bool isFlipped;
  final Set<int> knownIndices;
  final Set<int> unknownIndices;
  final bool isCompleted;

  const PracticeCardsState({
    required this.questions,
    required this.currentIndex,
    required this.isFlipped,
    required this.knownIndices,
    required this.unknownIndices,
    required this.isCompleted,
  });

  Question? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length
      ? questions[currentIndex]
      : null;

  PracticeCardsState copyWith({
    List<Question>? questions,
    int? currentIndex,
    bool? isFlipped,
    Set<int>? knownIndices,
    Set<int>? unknownIndices,
    bool? isCompleted,
  }) {
    return PracticeCardsState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      knownIndices: knownIndices ?? this.knownIndices,
      unknownIndices: unknownIndices ?? this.unknownIndices,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class PracticeCardsNotifier extends Notifier<PracticeCardsState> {
  @override
  PracticeCardsState build() {
    return const PracticeCardsState(
      questions: [],
      currentIndex: 0,
      isFlipped: false,
      knownIndices: {},
      unknownIndices: {},
      isCompleted: false,
    );
  }

  void loadQuestions(List<Question> questions, {int initialIndex = 0}) {
    state = PracticeCardsState(
      questions: questions,
      currentIndex: initialIndex.clamp(0, questions.length - 1),
      isFlipped: false,
      knownIndices: {},
      unknownIndices: {},
      isCompleted: false,
    );
  }

  void flipCard() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void markAsKnown() {
    final currentSet = Set<int>.from(state.knownIndices)
      ..add(state.currentIndex);
    state = state.copyWith(knownIndices: currentSet, isFlipped: false);
    _nextCard();
  }

  void markAsUnknown() {
    final currentSet = Set<int>.from(state.unknownIndices)
      ..add(state.currentIndex);
    state = state.copyWith(unknownIndices: currentSet, isFlipped: false);
    _nextCard();
  }

  void _nextCard() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      state = state.copyWith(isCompleted: true);
    }
  }

  void reset() {
    state = state.copyWith(
      currentIndex: 0,
      isFlipped: false,
      knownIndices: {},
      unknownIndices: {},
      isCompleted: false,
    );
  }
}

final practiceCardsNotifierProvider =
    NotifierProvider<PracticeCardsNotifier, PracticeCardsState>(
      () => PracticeCardsNotifier(),
    );
