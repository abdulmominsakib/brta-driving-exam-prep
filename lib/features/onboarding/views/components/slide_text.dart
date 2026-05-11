import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/onboarding_slide.dart';

class SlideText extends StatelessWidget {
  const SlideText({super.key, required this.slide});
  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Chip label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: slide.iconColor.withAlpha(25),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: slide.iconColor.withAlpha(80)),
          ),
          child: Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: slide.iconColor,
              fontSize: 13,
              fontFamily: 'SolaimanLipi',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Title
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.h1.copyWith(
            fontSize: 30,
            fontFamily: 'SolaimanLipi',
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),

        // Description
        Text(
          slide.description,
          textAlign: TextAlign.center,
          style: theme.textTheme.p.copyWith(
            color: theme.colorScheme.mutedForeground,
            fontSize: 15,
            fontFamily: 'SolaimanLipi',
            height: 1.65,
          ),
        ),

        if (slide.sourceUrl != null) ...[
          const SizedBox(height: 8),
          InkWell(
            onTap: () => launchUrl(Uri.parse(slide.sourceUrl!)),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.link_rounded,
                    size: 16,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
