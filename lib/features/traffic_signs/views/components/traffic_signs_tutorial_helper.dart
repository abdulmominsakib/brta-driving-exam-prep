import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TrafficSignsTutorialHelper {
  static List<TargetFocus> createTargets({
    required GlobalKey filterKey,
    required GlobalKey firstSignKey,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context);
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "filter",
        keyTarget: filterKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "ক্যাটাগরি ফিল্টার",
                description:
                    "এখান থেকে আপনি বিভিন্ন ধরণের রোড সাইন (যেমন: বাধ্যতামূলক, সতর্কতামূলক) আলাদাভাবে দেখতে পারবেন।",
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
        identify: "signs",
        keyTarget: firstSignKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "বিস্তারিত তথ্য",
                description: "যেকোনো সাইনের উপর ক্লিক করলে সেটির বিস্তারিত অর্থ এবং নিয়মাবলী জানতে পারবেন।",
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
    required GlobalKey filterKey,
    required GlobalKey firstSignKey,
    VoidCallback? onFinish,
  }) {
    TutorialCoachMark(
      targets: createTargets(
        filterKey: filterKey,
        firstSignKey: firstSignKey,
        context: context,
      ),
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
