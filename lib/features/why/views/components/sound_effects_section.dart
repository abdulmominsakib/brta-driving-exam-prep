import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'why_section_card.dart';

class SoundEffectsSection extends StatelessWidget {
  const SoundEffectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return WhySectionCard(
      title: 'সাউন্ড ইফেক্ট সম্পর্কে',
      icon: HugeIcons.strokeRoundedMusicNote01,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'এই অ্যাপে ব্যবহৃত সকল সাউন্ড ইফেক্ট সম্পূর্ণ হালাল। এই সাউন্ড ইফেক্ট সম্পর্কে আরও বিস্তারিত জানতে পারেন আপনি নিচের লিংকে ক্লিক করেন।',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final url = Uri.parse(
                'https://github.com/abdulmominsakib/halal-sound-effects',
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ShadTheme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ShadTheme.of(context).colorScheme.border,
                ),
              ),
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedGithub,
                    color: ShadTheme.of(context).colorScheme.foreground,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'halal-sound-effects',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedLink01,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'এই রিপোজিটরিটি ইসলামী মূল্যবোধ বজায় রেখে তৈরি করা হয়েছে, যাতে ব্যবহারকারীরা নিশ্চিন্তে যেকোনো এ্যাপে ব্যবহার করতে পারেন।',
            style: ShadTheme.of(context).textTheme.muted.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
