import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubSection extends StatelessWidget {
  const GithubSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ShadCard(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedGithub,
                size: 40,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'সোর্স কোড (GitHub)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'এই অ্যাপটি একটি ওপেন-সোর্স প্রজেক্ট। আপনি গিটহাবে সোর্স কোড দেখতে এবং কন্ট্রিবিউট করতে পারেন।',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse(
                'https://github.com/abdulmominsakib/brta-driving-exam-prep',
              );
              if (!await launchUrl(url)) {
                if (context.mounted) {
                  ShadToaster.of(context).show(
                    const ShadToast.destructive(
                      title: Text('লিংকটি খোলা সম্ভব হয়নি'),
                    ),
                  );
                }
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF24292E), // GitHub Dark Gray
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF000000), // Black for 3D effect
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'GitHub এ দেখুন',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // Extra space for the shadow
        ],
      ),
    );
  }
}
