import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FeedbackBottomSheet extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final VoidCallback onContinue;

  const FeedbackBottomSheet({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isCorrect
        ? const Color(0xFFD7FFB8) // Light Green
        : const Color(0xFFFFDFE0); // Light Red

    final primaryColor = isCorrect
        ? const Color(0xFF58CC02) // Green
        : const Color(0xFFFF4B4B); // Red

    final shadowColor = isCorrect
        ? const Color(0xFF58A700) // Darker Green
        : const Color(0xFFEA2B2B); // Darker Red

    final title = isCorrect ? 'চমৎকার!' : 'ভুল উত্তর';
    final icon = isCorrect
        ? HugeIcons.strokeRoundedCheckmarkCircle01
        : HugeIcons.strokeRoundedAlertCircle;

    return PopScope(
      canPop: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: HugeIcon(icon: icon, color: primaryColor, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: ShadTheme.of(context).textTheme.h4.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (!isCorrect) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'সঠিক উত্তর:',
                    style: ShadTheme.of(context).textTheme.large.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor, width: 1),
                    ),
                    child: Text(
                      correctAnswer,
                      style: ShadTheme.of(context).textTheme.p.copyWith(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            // 3D Continue Button
            GestureDetector(
              onTap: onContinue,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    bottom: BorderSide(
                      color: shadowColor,
                      width: 4.0, // Thickness of 3D effect
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
    );
  }
}
