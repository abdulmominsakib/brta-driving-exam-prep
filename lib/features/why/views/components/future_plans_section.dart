import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'why_section_card.dart';

class FuturePlansSection extends StatelessWidget {
  const FuturePlansSection({super.key});

  @override
  Widget build(BuildContext context) {
    return WhySectionCard(
      title: 'ভবিষ্যৎ পরিকল্পনা',
      icon: HugeIcons.strokeRoundedRocket01,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ইনশাআল্লাহ, ভবিষ্যতে এই অ্যাপে আরও নতুন ও উপকারী ফিচার যুক্ত করার পরিকল্পনা রয়েছে, যেমন:',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: 12),
          _buildBulletPoint('আরও সমৃদ্ধ গাইড'),
          _buildBulletPoint('বাস্তব জীবনের ট্রাফিক পরিস্থিতি ভিত্তিক গাইড'),
          _buildBulletPoint('শেখাকে আরও সহজ ও ইন্টার্যাকটিভ করার ফিচার'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withValues(alpha: .3)),
            ),
            child: Row(
              children: [
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedInformationCircle,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'এই অ্যাপে কোনো বিজ্ঞাপন যুক্ত করার কোনো ইচ্ছা আমার নেই। অ্যাপটি সম্পূর্ণভাবে জ্ঞান ও উপকারের উদ্দেশ্যে তৈরি।',
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: CircleAvatar(radius: 3, backgroundColor: Color(0xFF58CC02)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
