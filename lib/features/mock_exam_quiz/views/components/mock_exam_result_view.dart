import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockExamResultView extends StatelessWidget {
  final bool isPassed;
  final int correctAnswers;
  final int totalQuestions;
  final int? passThreshold;
  final VoidCallback onContinue;

  const MockExamResultView({
    super.key,
    required this.isPassed,
    required this.correctAnswers,
    required this.totalQuestions,
    this.passThreshold,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HugeIcon(
                icon: isPassed
                    ? HugeIcons.strokeRoundedTick02
                    : HugeIcons.strokeRoundedCancel01,
                size: 80,
                color: isPassed ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
              ),
              const SizedBox(height: 24),
              Text(
                isPassed ? 'অসাধারণ!' : 'আবার চেষ্টা করুন!',
                style: ShadTheme.of(context).textTheme.h2.copyWith(
                      color: isPassed
                          ? const Color(0xFF58CC02)
                          : const Color(0xFFFF4B4B),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Text(
                      'স্কোর',
                      style: ShadTheme.of(context).textTheme.large.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$correctAnswers / $totalQuestions',
                      style: ShadTheme.of(context).textTheme.h3.copyWith(
                            color: const Color(0xFF58CC02),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (passThreshold != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'পাস করতে প্রয়োজন: $passThreshold',
                        style: ShadTheme.of(context)
                            .textTheme
                            .p
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 48),
              GestureDetector(
                onTap: onContinue,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0xFF58A700),
                        width: 4.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'চালিয়ে যান',
                      style: ShadTheme.of(context).textTheme.large.copyWith(
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
