import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'why_section_card.dart';

class AppPurposeSection extends StatelessWidget {
  const AppPurposeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return WhySectionCard(
      title: 'অ্যাপের উদ্দেশ্য',
      icon: HugeIcons.strokeRoundedTarget02,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'এই অ্যাপটির মূল উদ্দেশ্য হলো সাধারণ মানুষকে রাস্তা-ঘাট, ট্রাফিক নিয়ম এবং গাড়ি চালনা সংক্রান্ত গুরুত্বপূর্ণ তথ্য সম্পর্কে সচেতন করা।',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: 12),
          Text(
            'বিশেষভাবে, BRTA ড্রাইভিং লাইসেন্স পরীক্ষায় যে প্রশ্নগুলো সাধারণত আসে, সেগুলো সম্পর্কে ধারণা দেওয়া এবং ব্যবহারকারীদের নিজের জ্ঞান ঝালাই করে নেওয়ার সুযোগ করে দেওয়া এই অ্যাপের অন্যতম লক্ষ্য।',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF58CC02).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF58CC02).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedIdea01,
                  color: Color(0xFF58CC02),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'সঠিক জ্ঞানই পারে দুর্ঘটনা কমাতে এবং একজন দায়িত্বশীল চালক তৈরি করতে।',
                    style: ShadTheme.of(
                      context,
                    ).textTheme.p.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
