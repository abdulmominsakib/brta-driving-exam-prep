import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MockExamTutorialHelper {
  static List<TargetFocus> createTargets({
    required GlobalKey welcomeKey,
    required GlobalKey infoTipKey,
    required GlobalKey startButtonKey,
    required GlobalKey? historyKey,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context);
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "welcome",
        keyTarget: welcomeKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "মডেল টেস্টে স্বাগতম!",
                description:
                    "এখানে আপনি আসল পরীক্ষার মতো করে মডেল টেস্ট দিতে পারবেন।",
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
        identify: "info_tip",
        keyTarget: infoTipKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "গুরুত্বপূর্ণ তথ্য",
                description:
                    "পরীক্ষায় লিখিত প্রশ্ন থাকবে, তাই সঠিক উত্তরটি ভালো ভাবে খেয়াল করবেন।",
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
        identify: "start_button",
        keyTarget: startButtonKey,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "পরীক্ষা শুরু করুন",
                description:
                    "সব প্রস্তুতি শেষ হলে এখান থেকে পরীক্ষা শুরু করুন।",
                theme: theme,
                controller: controller,
                isLast: historyKey == null,
              );
            },
          ),
        ],
      ),
    );

    if (historyKey != null) {
      targets.add(
        TargetFocus(
          identify: "history",
          keyTarget: historyKey,
          alignSkip: Alignment.topRight,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return _buildTutorialContent(
                  title: "পূর্ববর্তী ফলাফল",
                  description:
                      "আপনার আগের সব পরীক্ষার রেজাল্ট এখানে দেখতে পাবেন।",
                  theme: theme,
                  controller: controller,
                  isLast: true,
                );
              },
            ),
          ],
        ),
      );
    }

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
    required GlobalKey welcomeKey,
    required GlobalKey infoTipKey,
    required GlobalKey startButtonKey,
    GlobalKey? historyKey,
    VoidCallback? onFinish,
  }) {
    TutorialCoachMark(
      targets: createTargets(
        welcomeKey: welcomeKey,
        infoTipKey: infoTipKey,
        startButtonKey: startButtonKey,
        historyKey: historyKey,
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
