import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadSafetyStatsSection extends StatelessWidget {
  const RoadSafetyStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    const accentColor = Color(0xFFDC2626); // Red for urgency

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accentColor.withAlpha(50), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withAlpha(10),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedUserWarning01,
                  color: accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'সড়ক সচেতনতা',
                style: theme.textTheme.h4.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'বাংলাদেশে গড়ে প্রতিদিন ৬৬ জন মানুষ সড়ক দুর্ঘটনায় মারা যান। অর্থাৎ প্রতি ঘণ্টায় গড়ে ২ জনের বেশি মানুষ প্রাণ হারান।',
            style: theme.textTheme.p,
          ),
          const SizedBox(height: 12),
          Text(
            'এর অন্যতম প্রধান কারণ ট্রাফিক আইন সম্পর্কে অজ্ঞতা। সঠিক নিয়ম শিখে এবং তা মেনে চলে আমরা এই মৃত্যুর মিছিল কমাতে পারি।',
            style: theme.textTheme.p,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => launchUrl(
              Uri.parse(
                'https://www.thedailystar.net/news/bangladesh/accidents-fires/news/66-die-injuries-roads-day-4014991',
              ),
            ),
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
                  const SizedBox(width: 6),
                  Text(
                    'তথ্যসূত্র',
                    style: theme.textTheme.p.copyWith(
                      color: theme.colorScheme.mutedForeground,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
