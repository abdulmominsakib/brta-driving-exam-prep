import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizOptionCard extends StatelessWidget {
  final String text;
  final String? image;
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.text,
    this.image,
    required this.isSelected,
    required this.isAnswered,
    this.isCorrect = false,
    this.isWrong = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey.shade300;
    Color shadowColor = Colors.grey.shade400;
    Color textColor = Colors.black87;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = const Color(0xFFDDF4FF); // Light Blueish/Green
        borderColor = const Color(0xFF58CC02); // Green
        shadowColor = const Color(0xFF58A700);
        textColor = const Color(0xFF58CC02);
      } else if (isWrong && isSelected) {
        backgroundColor = const Color(0xFFFFDFE0); // Light Red
        borderColor = const Color(0xFFFF4B4B); // Red
        shadowColor = const Color(0xFFEA2B2B);
        textColor = const Color(0xFFFF4B4B);
      } else {
        // Disabled/Unselected state
        borderColor = Colors.grey.shade200;
        shadowColor = Colors.transparent;
        textColor = Colors.grey.shade400;
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFFE5F6FF); // Light Blue
      borderColor = const Color(0xFF1CB0F6); // Blue
      shadowColor = const Color(0xFF1899D6);
      textColor = const Color(0xFF1CB0F6);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            if (image != null) ...[
              if (image!.toLowerCase().endsWith('.svg'))
                SvgPicture.asset(image!, height: 48, width: 48)
              else
                Image.asset(
                  image!,
                  height: 48,
                  width: 48,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 48,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Row(
                children: [
                  ShadBadge(
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      'উত্তরঃ',
                      style: ShadTheme.of(context).textTheme.small.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: ShadTheme.of(context).textTheme.large.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
