import 'package:flutter/material.dart';

import '../../../../core/models/quiz_model.dart';
import 'quiz_option_card.dart';

class MockExamOptionsView extends StatelessWidget {
  final List<Option> options;
  final int? selectedOption;
  final bool isAnswered;
  final Function(int) onSelect;
  final GlobalKey? firstOptionKey;

  const MockExamOptionsView({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.isAnswered,
    required this.onSelect,
    this.firstOptionKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedOption == index;
        return QuizOptionCard(
          key: index == 0 ? firstOptionKey : null,
          text: option.text,
          image: option.optionImage,
          isSelected: isSelected,
          isAnswered: isAnswered,
          isCorrect: option.isCorrect,
          isWrong: !option.isCorrect,
          onTap: () => onSelect(index),
        );
      },
    );
  }
}
