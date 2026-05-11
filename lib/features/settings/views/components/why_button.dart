import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WhyButton extends StatelessWidget {
  const WhyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/why'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ShadTheme.of(context).colorScheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ShadTheme.of(context).colorScheme.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedInformationSquare,
                size: 24,
                color: Color(0xFF58CC02),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'কেন এই অ্যাপ?',
                    style: TextStyle(
                      color: ShadTheme.of(context).colorScheme.foreground,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'আপনার ড্রাইভিং লাইসেন্স পাওয়ার গাইড',
                    style: TextStyle(
                      color: ShadTheme.of(context).colorScheme.mutedForeground,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              size: 20,
              color: ShadTheme.of(context).colorScheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}
