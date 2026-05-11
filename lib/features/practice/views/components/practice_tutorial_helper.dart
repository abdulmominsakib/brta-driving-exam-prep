import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PracticeTutorialHelper {
  static List<TargetFocus> createTargets({
    required GlobalKey firstNodeKey,
    required GlobalKey lastNodeKey,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context);
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "intro",
        keyTarget: firstNodeKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "প্র্যাকটিস মোডে স্বাগতম!",
                description:
                    "এটি আপনার পরীক্ষার প্রস্তুতির পথ। এখানে আপনি বিভিন্ন বিষয়ের উপর প্র্যাকটিস করতে পারবেন।",
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
        identify: "sections",
        keyTarget: firstNodeKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "সেকশন শুরু করুন",
                description:
                    "প্রতিটি গোল চিহ্ন একটি করে সেকশন। 'বেসিকস' থেকে শুরু করুন এবং পরবর্তী ধাপগুলো আনলক করুন।",
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
        identify: "mock_test",
        keyTarget: lastNodeKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "মডেল টেস্ট",
                description:
                    "সবগুলো সেকশন শেষ করলে আপনি মডেল টেস্ট দিতে পারবেন। এটি আপনাকে আসল পরীক্ষার জন্য তৈরি করবে।",
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
    required GlobalKey firstNodeKey,
    required GlobalKey lastNodeKey,
    VoidCallback? onFinish,
  }) {
    TutorialCoachMark(
      targets: createTargets(
        firstNodeKey: firstNodeKey,
        lastNodeKey: lastNodeKey,
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
