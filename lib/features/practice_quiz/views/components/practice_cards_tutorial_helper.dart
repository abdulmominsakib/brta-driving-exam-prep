import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PracticeCardsTutorialHelper {
  static TargetFocus _createCardTarget({
    required GlobalKey cardKey,
    required ShadThemeData theme,
  }) {
    return TargetFocus(
      identify: "card",
      keyTarget: cardKey,
      shape: ShapeLightFocus.Circle,
      paddingFocus: 5,

      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return _buildTutorialContent(
              title: "অনুশীলন কার্ড",
              description: "এই কার্ডে ট্যাপ করে সঠিক উত্তরটি দেখে নিন।",
              theme: theme,
              controller: controller,
              isLast: true,
            );
          },
        ),
      ],
    );
  }

  static List<TargetFocus> _createButtonTargets({
    required GlobalKey knownButtonKey,
    required GlobalKey unknownButtonKey,
    required ShadThemeData theme,
  }) {
    return [
      TargetFocus(
        identify: "known",
        keyTarget: knownButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "আমি জানি",
                description:
                    "যদি আপনি উত্তরটি আগে থেকেই জানেন তবে এখানে ক্লিক করুন।",
                theme: theme,
                controller: controller,
                isLast: false,
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "unknown",
        keyTarget: unknownButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                title: "আমি জানি না",
                description:
                    "উত্তরটি যদি অজানা হয় তবে এখানে ক্লিক করুন। এটি আপনার দুর্বলতাগুলো বুঝতে সাহায্য করবে।",
                theme: theme,
                controller: controller,
                isLast: true,
              );
            },
          ),
        ],
      ),
    ];
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

  static void showCardTutorial({
    required BuildContext context,
    required GlobalKey cardKey,
    VoidCallback? onFinish,
  }) {
    final theme = ShadTheme.of(context);
    TutorialCoachMark(
      targets: [_createCardTarget(cardKey: cardKey, theme: theme)],
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

  static void showButtonsTutorial({
    required BuildContext context,
    required GlobalKey knownButtonKey,
    required GlobalKey unknownButtonKey,
    VoidCallback? onFinish,
  }) {
    final theme = ShadTheme.of(context);
    TutorialCoachMark(
      targets: _createButtonTargets(
        knownButtonKey: knownButtonKey,
        unknownButtonKey: unknownButtonKey,
        theme: theme,
      ),
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      onFinish: onFinish,
      onSkip: () {
        if (onFinish != null) onFinish();
        return true;
      },
      alignSkip: Alignment.topRight,
      textSkip: "বাদ দিন",
      paddingFocus: 10,
    ).show(context: context);
  }
}
