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
    final colorScheme = ShadTheme.of(context).colorScheme;
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;

    Color backgroundColor = colorScheme.card;
    Color borderColor = colorScheme.border;
    Color shadowColor = isDark ? Colors.black.withValues(alpha: 0.3) : Colors.grey.shade300;
    Color textColor = colorScheme.foreground;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = isDark ? const Color(0xFF1E3A00) : const Color(0xFFD7FFB8); // Adaptive Light Green
        borderColor = const Color(0xFF58CC02); // Green
        shadowColor = const Color(0xFF58A700);
        textColor = isDark ? const Color(0xFF76E11B) : const Color(0xFF58A700);
      } else if (isWrong && isSelected) {
        backgroundColor = isDark ? const Color(0xFF3F0000) : const Color(0xFFFFDFE0); // Adaptive Light Red
        borderColor = const Color(0xFFFF4B4B); // Red
        shadowColor = const Color(0xFFEA2B2B);
        textColor = isDark ? const Color(0xFFFF8585) : const Color(0xFFEA2B2B);
      } else {
        // Disabled/Unselected state
        backgroundColor = colorScheme.card.withValues(alpha: 0.5);
        borderColor = colorScheme.border;
        shadowColor = Colors.transparent;
        textColor = colorScheme.mutedForeground;
      }
    } else if (isSelected) {
      backgroundColor = isDark ? const Color(0xFF003355) : const Color(0xFFE5F6FF); // Adaptive Light Blue
      borderColor = const Color(0xFF1CB0F6); // Blue
      shadowColor = const Color(0xFF1899D6);
      textColor = isDark ? const Color(0xFF62D1FF) : const Color(0xFF1899D6);
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
              child: Text(
                text,
                style: ShadTheme.of(context).textTheme.large.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (isAnswered) ...[
              if (isCorrect)
                const Icon(Icons.check_circle, color: Color(0xFF58CC02), size: 24)
              else if (isWrong && isSelected)
                const Icon(Icons.cancel, color: Color(0xFFFF4B4B), size: 24),
            ],
          ],
        ),
      ),
    );
  }
}
