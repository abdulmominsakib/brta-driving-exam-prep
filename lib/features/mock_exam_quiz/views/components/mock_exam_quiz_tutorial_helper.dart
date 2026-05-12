import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockExamQuizTutorialHelper {
  static List<TargetFocus> createTargets({
    required GlobalKey progressKey,
    required GlobalKey questionKey,
    required GlobalKey firstOptionKey,
    required GlobalKey checkButtonKey,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context);
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "progress",
        keyTarget: progressKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "পরীক্ষার প্রগ্রেস",
                description:
                    "এখানে আপনার পরীক্ষার অগ্রগতি এবং কতগুলো প্রশ্ন বাকি আছে তা দেখতে পাবেন।",
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
        identify: "question",
        keyTarget: questionKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "প্রশ্ন",
                description:
                    "প্রশ্নটি মনোযোগ দিয়ে পড়ুন। এটি আসল পরীক্ষার প্রশ্নের মতোই।",
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
        identify: "options",
        keyTarget: firstOptionKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "সঠিক উত্তর নির্বাচন",
                description: "আপনার কাছে যেটি সঠিক মনে হয় সেটি সিলেক্ট করুন।",
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
        identify: "check",
        keyTarget: checkButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "চেক করুন",
                description:
                    "উত্তর সিলেক্ট করার পর এখানে ক্লিক করে যাচাই করুন।",
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
    required GlobalKey progressKey,
    required GlobalKey questionKey,
    required GlobalKey firstOptionKey,
    required GlobalKey checkButtonKey,
    VoidCallback? onFinish,
  }) {
    TutorialCoachMark(
      targets: createTargets(
        progressKey: progressKey,
        questionKey: questionKey,
        firstOptionKey: firstOptionKey,
        checkButtonKey: checkButtonKey,
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
