import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackSection extends StatelessWidget {
  const FeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Column(
        children: [
          const SizedBox(height: 16),
          // App Logo Placeholder
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'মতামত জানান',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'অ্যাপটি সম্পর্কে আপনার মতামত জানান এবং আমাদের উন্নয়ন করতে সাহায্য করুন।',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://forms.gle/zQBTMLaKyMVjxcyx5');
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
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade700, // Darker Blue for 3D effect
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'মতামত দিন',
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
