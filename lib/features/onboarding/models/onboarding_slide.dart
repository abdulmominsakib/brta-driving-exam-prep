import 'package:flutter/material.dart';

class OnboardingSlide {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color gradientStart;
  final Color gradientEnd;
  final String? sourceUrl;
  final bool useHeroImage;

  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.gradientStart,
    required this.gradientEnd,
    this.sourceUrl,
    this.useHeroImage = false,
  });
}

final List<OnboardingSlide> onboardingSlides = [
  const OnboardingSlide(
    title: 'ড্রাইভিং শিক্ষা',
    subtitle: 'সড়ক সম্পর্কে জেনে লাইসেন্স নিন',
    description:
        'BRTA-র সকল প্রশ্নব্যাংক থেকে প্রস্তুতি নিন। ভালো ড্রাইভার হওয়ার যাত্রা শুরু হোক আজ থেকেই।',
    icon: Icons.directions_car_rounded,
    iconColor: Color(0xFF16A34A),
    gradientStart: Color(0xFF064E3B),
    gradientEnd: Color(0xFF065F46),
    useHeroImage: true,
  ),
  const OnboardingSlide(
    title: 'প্র্যাকটিস মোড',
    subtitle: 'বিষয়ভিত্তিক প্রশ্ন অনুশীলন',
    description:
        'বেসিক, মেকানিজম, রোড সাইন, ট্রাফিক আইন ও জরিমানা — সব বিষয়ে আলাদাভাবে অনুশীলন করুন এবং দুর্বলতা খুঁজে বের করুন।',
    icon: Icons.quiz_rounded,
    iconColor: Color(0xFFF59E0B),
    gradientStart: Color(0xFF78350F),
    gradientEnd: Color(0xFF92400E),
  ),
  const OnboardingSlide(
    title: 'মডেল টেস্ট',
    subtitle: 'আসল পরীক্ষার মতো অনুভব করুন',
    description:
        'নির্ধারিত সময়ে ৩০টি প্রশ্ন সমাধান করুন এবং আপনার পাস/ফেইল যাচাই করুন। পরীক্ষার হলে ঢোকার আগেই আত্মবিশ্বাসী হন।',
    icon: Icons.timer_rounded,
    iconColor: Color(0xFF7C3AED),
    gradientStart: Color(0xFF2E1065),
    gradientEnd: Color(0xFF3B0764),
  ),
  const OnboardingSlide(
    title: 'ট্রাফিক চিহ্ন',
    subtitle: 'প্রতিটি সাইন চিনুন ও বুঝুন',
    description:
        'রাস্তার সব ট্রাফিক চিহ্নের বিস্তারিত ব্যাখ্যা ও ছবি সহ শিখুন। নিরাপদ ড্রাইভিং-এর জন্য এটি অপরিহার্য।',
    icon: Icons.traffic_rounded,
    iconColor: Color(0xFFDC2626),
    gradientStart: Color(0xFF7F1D1D),
    gradientEnd: Color(0xFF991B1B),
  ),
  const OnboardingSlide(
    title: 'সড়ক সচেতনতা',
    subtitle: 'ঘণ্টায় ২ জন +',
    description:
        'বাংলাদেশে গড়ে প্রতিদিন ৬৬ জন মানুষ সড়ক দুর্ঘটনায় মারা যান। এর অন্যতম প্রধান কারণ ট্রাফিক আইন সম্পর্কে অজ্ঞতা।',
    icon: Icons.warning_amber_rounded,
    iconColor: Color(0xFFDC2626),
    gradientStart: Color(0xFF7F1D1D),
    gradientEnd: Color(0xFF991B1B),
    sourceUrl:
        'https://www.thedailystar.net/news/bangladesh/accidents-fires/news/66-die-injuries-roads-day-4014991',
  ),
];
