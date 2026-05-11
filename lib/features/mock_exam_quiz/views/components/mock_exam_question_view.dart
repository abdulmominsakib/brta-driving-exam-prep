import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/models/quiz_model.dart';

class MockExamQuestionView extends StatelessWidget {
  final Question question;
  final int currentIndex;
  final int totalQuestions;
  final GlobalKey questionKey;

  const MockExamQuestionView({
    super.key,
    required this.question,
    required this.currentIndex,
    required this.totalQuestions,
    required this.questionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'প্রশ্ন (${currentIndex + 1} / $totalQuestions)',
              style: ShadTheme.of(context).textTheme.large.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          question.questionText,
          key: questionKey,
          style: ShadTheme.of(
            context,
          ).textTheme.h2.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        if (question.questionImage != null) ...[
          const SizedBox(height: 16),
          Center(
            child: question.questionImage!.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(question.questionImage!, height: 120)
                : Image.asset(
                    question.questionImage!,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
          ),
        ],
      ],
    );
  }
}
