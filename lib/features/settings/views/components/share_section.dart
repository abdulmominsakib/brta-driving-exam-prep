import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:share_plus/share_plus.dart';

class ShareSection extends StatelessWidget {
  const ShareSection({super.key});

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
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedCar04, // App logo placeholder
                size: 40,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'বন্ধুদের আমন্ত্রণ জানান',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'ড্রাইভিং শিক্ষা অ্যাপটি আপনার বন্ধুদের সাথে শেয়ার করুন এবং একসাথে শিখুন!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              SharePlus.instance.share(
                ShareParams(
                  text:
                      'ড্রাইভিং শিক্ষা অ্যাপটি ব্যবহার করে দেখুন! ডাউনলোড করুন: https://play.google.com/store/apps/details?id=pro.momin.driving_shikkha',
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF58CC02),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF58A700,
                    ), // Darker Green for 3D effect
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'অ্যাপ শেয়ার করুন',
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
