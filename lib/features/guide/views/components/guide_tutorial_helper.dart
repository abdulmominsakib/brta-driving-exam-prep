import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GuideTutorialHelper {
  static List<TargetFocus> createTargets({
    required GlobalKey firstGuideKey,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context);
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "guides",
        keyTarget: firstGuideKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "প্রক্রিয়া ও নির্দেশিকা",
                description:
                    "এখানে লাইসেন্স থেকে শুরু করে গাড়ি মালিকানা পরিবর্তনের সকল প্রক্রিয়া ধাপে ধাপে দেওয়া আছে।",
                theme: theme,
                controller: controller,
                isLast: false,
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "details",
        keyTarget: firstGuideKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "বিস্তারিত পড়ুন",
                description:
                    "যেকোনো একটি গাইডের উপর ক্লিক করলে আপনি সেটির বিস্তারিত নিয়মাবলী এবং প্রয়োজনীয় তথ্যাদি জানতে পারবেন।",
                theme: theme,
                controller: controller,
                isLast: true,
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }

  static Widget _buildTutorialContent({
    required String title,
    required String description,
    required ShadThemeData theme,
    required TutorialCoachMarkController controller,
    required bool isLast,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.h3.copyWith(color: Colors.white)),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.p.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton(
                onPressed: () {
                  if (isLast) {
                    controller.skip();
                  } else {
                    controller.next();
                  }
                },
                backgroundColor: const Color(0xFF58CC02),
                child: Text(
                  isLast ? "শেষ করুন" : "পরবর্তী",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void showTutorial({
    required BuildContext context,
    required GlobalKey firstGuideKey,
    VoidCallback? onFinish,
  }) {
    TutorialCoachMark(
      targets: createTargets(firstGuideKey: firstGuideKey, context: context),
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      onFinish: onFinish,
      onSkip: () {
        if (onFinish != null) onFinish();
        return true;
      },
      textSkip: "বাদ দিন",
      paddingFocus: 10,
    ).show(context: context);
  }
}
