import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hugeicons/hugeicons.dart';

import 'components/flow_step_card.dart';
import '../models/license_step.dart';

class LicenseGuidePage extends StatefulWidget {
  const LicenseGuidePage({super.key});

  @override
  State<LicenseGuidePage> createState() => _LicenseGuidePageState();
}

class _LicenseGuidePageState extends State<LicenseGuidePage> {
  final Set<String> _expandedIds = {};

  void _toggleExpansion(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final SystemUiOverlayStyle overlayStyle =
        theme.brightness == Brightness.light
        ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent)
        : SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          );

    final List<LicenseStep> preparationSteps = [
      LicenseStep(
        title: 'পূর্বশর্ত',
        icon: HugeIcons.strokeRoundedTaskDaily01,
        color: Colors.blue,
        content:
            '''ড্রাইভিং লাইসেন্সের পূর্বশর্ত হলো লার্নার বা শিক্ষানবিশ ড্রাইভিং লাইসেন্স।
• আবেদনকারীর ন্যূনতম শিক্ষাগত যোগ্যতা ৮ম শ্রেণী পাশ।
• অপেশাদার এর জন্য ন্যূনতম ১৮ বছর এবং পেশাদারদের জন্য ২১ বছর।
• মানসিক ও শারীরিকভাবে সুস্থ থাকতে হবে।''',
      ),
      LicenseStep(
        title: 'প্রয়োজনীয় ডকুমেন্ট',
        icon: HugeIcons.strokeRoundedFiles01,
        color: Colors.orange,
        content: '''অনলাইনে আবেদনের জন্য প্রয়োজনীয় ডকুমেন্টসমূহ:
• আবেদনকারীর ছবি (সর্বোচ্চ ১৫০ কে.বি);
• মেডিকেল সার্টিফিকেট (সর্বোচ্চ ৬০০কে.বি);
• জাতীয় পরিচয়পত্রের (NID) স্ক্যান কপি;
• শিক্ষাগত যোগ্যতার সনদের স্ক্যান কপি;
• ইউটিলিটি বিলের কপি (ঠিকানা ভিন্ন হলে)।''',
      ),
    ];

    final List<LicenseStep> flowSteps = [
      LicenseStep(
        title: 'শুরু ও অনলাইন আবেদন',
        icon: HugeIcons.strokeRoundedLicense,
        color: Colors.purple,
        content:
            '''অনলাইনে ড্রাইভিং লাইসেন্সের আবেদন দাখিল ও লার্নার লাইসেন্স সংগ্রহ:
• বিআরটিএ সার্ভিস পোর্টালে এনআইডি ব্যবহার করে অ্যাকাউন্ট তৈরি।
• অনলাইন আবেদন ও পুনঃপরীক্ষার তারিখ গ্রহণ।
• লার্নার ড্রাইভিং লাইসেন্স অনলাইন থেকে প্রিন্ট করা।''',
      ),
      LicenseStep(
        title: 'বায়োমেট্রিক যাচাইকরণ',
        isDecision: true,
        loopBackText: 'তথ্য অমিল হলে পুনরায় যাচাই',
        icon: HugeIcons.strokeRoundedFingerPrint,
        color: Colors.red,
        content: '''পরীক্ষার্থী যাচাইকরণ ও বায়োমেট্রিক গ্রহণ:
• ফিঙ্গারপ্রিন্টের মাধ্যমে আবেদনকারীর পরিচয় যাচাই।
• বায়োমেট্রিক তথ্য সংগ্রহ (ছবি, চোখের স্ক্যান)।
• তথ্য সঠিক না হলে পুনরায় যাচাইকরণ প্রক্রিয়ায় যেতে হবে।''',
      ),
      LicenseStep(
        title: 'তিন স্তরের পরীক্ষা',
        icon: HugeIcons.strokeRoundedBookOpen01,
        color: Colors.indigo,
        content: '''নির্ধারিত দিনে পরীক্ষা কেন্দ্রে উপস্থিতি:
• লিখিত পরীক্ষা।
• মৌখিক পরীক্ষা (ভাইভা)।
• ব্যবহারিক পরীক্ষা (ফিল্ড টেস্ট)।''',
      ),
      LicenseStep(
        title: 'পরীক্ষার ফলাফল',
        isDecision: true,
        loopBackText: 'অকৃতকার্য হলে পুনঃপরীক্ষা',
        icon: HugeIcons.strokeRoundedCheckList,
        color: Colors.teal,
        content: '''অনলাইনে পরীক্ষার ফলাফল প্রকাশ:
• সর্বোচ্চ ১ কর্মদিবসের মধ্যে ফলাফল জানানো হবে।
• উত্তীর্ণ প্রার্থীরা পরবর্তী ধাপে ফি প্রদান করতে পারবেন।
• অকৃতকার্য প্রার্থীদের পুনরায় পরীক্ষা দিতে হবে।''',
      ),
      LicenseStep(
        title: 'ফি ও ডকুমেন্ট দাখিল',
        isDecision: true,
        loopBackText: 'বাতিল হলে পুনরায় দাখিল',
        icon: HugeIcons.strokeRoundedMoney03,
        color: Colors.green,
        content: '''অনলাইনে নির্ধারিত ফি ও কাগজ দাখিল:
• স্মার্ট কার্ডের জন্য নির্ধারিত ফি প্রদান।
• পাস/ফেল সিলসহ লার্নার লাইসেন্স ও অন্যান্য প্রয়োজনীয় ডকুমেন্ট আপলোড।
• পেশাদারদের জন্য ডোপ টেস্ট রিপোর্ট বাধ্যতামূলক।''',
      ),
      LicenseStep(
        title: 'কর্তৃপক্ষের অনুমোদন',
        icon: HugeIcons.strokeRoundedChampion,
        color: Colors.blueGrey,
        content: '''বিআরটিএ কর্তৃপক্ষের চূড়ান্ত যাচাই:
• লাইসেন্সিং অথরিটি কর্তৃক আপনার সকল তথ্য যাচাই করা হবে।
• সবকিছু সঠিক পাওয়া সাপেক্ষে লাইসেন্স অনুমোদিত হবে।''',
      ),
      LicenseStep(
        title: 'লাইসেন্স প্রিন্ট',
        icon: HugeIcons.strokeRoundedPrinter,
        color: Colors.cyan,
        content: '''স্মার্ট কার্ড ও ই-পেপার প্রিন্টিং:
• অনুমোদনের পর ই-পেপার লাইসেন্স আপলোড হবে যা প্রিন্ট করে ব্যবহার করা যাবে।
• মূল স্মার্ট কার্ড প্রিন্টিং কার্যক্রম শুরু হবে।''',
      ),
      LicenseStep(
        title: 'বিতরণ ও প্রদান',
        icon: HugeIcons.strokeRoundedCards01,
        color: Colors.pink,
        content: '''ডাকযোগে স্মার্ট কার্ড প্রাপ্তি:
• প্রিন্টিং শেষ হলে আপনার দাখিলকৃত ঠিকানায় ডাকযোগে কার্ডটি পাঠানো হবে।
• পোস্ট অফিস বা কুরিয়ার সার্ভিসের মাধ্যমে এটি আপনার হাতে পৌঁছাবে।''',
      ),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              collapsedHeight: 70,
              floating: false,
              pinned: true,
              centerTitle: true,
              backgroundColor: theme.colorScheme.background,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'লাইসেন্স গাইড',
                  style: theme.textTheme.h4.copyWith(
                    color: theme.colorScheme.foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                        theme.colorScheme.background,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        top: -10,
                        child: Hero(
                          tag: 'guide-license_guide-image',
                          child: Opacity(
                            opacity: 0.1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/guides/license_guide.webp',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      context,
                      'প্রাথমিক প্রস্তুতি',
                      Icons.checklist_rounded,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final step = preparationSteps[index];
                  final id = 'prep-$index';
                  return FlowStepCard(
                    step: step,
                    isLast: index == preparationSteps.length - 1,
                    isExpanded: _expandedIds.contains(id),
                    onTap: () => _toggleExpansion(id),
                  );
                }, childCount: preparationSteps.length),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      context,
                      'ইস্যু ও নবায়ন প্রসেস ম্যাপ',
                      Icons.map_rounded,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final step = flowSteps[index];
                  final id = 'flow-$index';
                  return FlowStepCard(
                    step: step,
                    isLast: index == flowSteps.length - 1,
                    isExpanded: _expandedIds.contains(id),
                    onTap: () => _toggleExpansion(id),
                  );
                }, childCount: flowSteps.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
