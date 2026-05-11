class QuizDocument {
  final String documentTitle;
  final List<Question> questions;

  QuizDocument({required this.documentTitle, required this.questions});

  factory QuizDocument.fromJson(Map<String, dynamic> json) {
    return QuizDocument(
      documentTitle: json['document_title'] ?? json['category'] ?? '',
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_title': documentTitle,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}

class Question {
  final String questionText;
  final String? questionImage; // Added: Image for the question itself
  final List<Option> options;

  Question({
    required this.questionText,
    this.questionImage,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question_text'] ?? json['question'] ?? '',
      questionImage: json['question_image'], // Can be null
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_text': questionText,
      'question_image': questionImage,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class Option {
  final String text;
  final String? optionImage; // Added: Image for the option (if applicable)
  final bool isCorrect;

  Option({required this.text, this.optionImage, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['text'] ?? '',
      optionImage: json['option_image'], // Can be null
      isCorrect: json['is_correct'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'option_image': optionImage, 'is_correct': isCorrect};
  }
}
