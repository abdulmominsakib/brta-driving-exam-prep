import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:math';
import 'package:hugeicons/hugeicons.dart';

import 'components/practice_path_painter.dart';
import 'components/practice_node.dart';
import '../models/practice_item.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/practice_progress_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/practice_tutorial_helper.dart';

class PracticePage extends ConsumerStatefulWidget {
  const PracticePage({super.key});

  @override
  ConsumerState<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends ConsumerState<PracticePage> {
  final GlobalKey _firstNodeKey = GlobalKey();
  final GlobalKey _lastNodeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasShownTutorial =
        prefs.getBool('has_shown_practice_tutorial') ?? false;

    if (!hasShownTutorial) {
      if (mounted) {
        PracticeTutorialHelper.showTutorial(
          context: context,
          firstNodeKey: _firstNodeKey,
          lastNodeKey: _lastNodeKey,
          onFinish: () async {
            await prefs.setBool('has_shown_practice_tutorial', true);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final practiceState = ref.watch(practiceProgressProvider);
    final theme = ShadTheme.of(context);

    // Determine the status bar brightness based on the theme
    // If background is light (Brightness.light) -> Status bar icons should be dark (Brightness.dark)
    // If background is dark (Brightness.dark) -> Status bar icons should be light (Brightness.light)
    final SystemUiOverlayStyle overlayStyle =
        theme.brightness == Brightness.light
        ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent)
        : SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const int levelCount = 6;
              const double nodeSize = 80;
              const double verticalSpacing = 60;
              const double itemHeight = nodeSize + verticalSpacing;

              // Calculate total height needed. Add some bottom padding.
              final totalHeight = levelCount * itemHeight + 100;

              // Generate positions
              final List<Offset> points = [];
              final double centerX = constraints.maxWidth / 2;
              final double amplitude = constraints.maxWidth * 0.25;

              // Use same sinusoidal pattern as Home
              for (int i = 0; i < levelCount; i++) {
                final double y = i * itemHeight + 50;
                final double x = centerX + sin(i * pi / 2) * amplitude;
                points.add(Offset(x, y));
              }

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top - 10,
                ),
                child: SizedBox(
                  height: totalHeight,
                  child: Stack(
                    children: [
                      // Path Layer
                      CustomPaint(
                        size: Size(constraints.maxWidth, totalHeight),
                        painter: PathPainter(
                          points: points,
                          color: theme.brightness == Brightness.dark
                              ? const Color(0xFF374151) // Dark mode road
                              : const Color(0xFFE5E7EB), // Light mode road
                        ),
                      ),
                      // Nodes Layer
                      ...List.generate(levelCount, (index) {
                        final point = points[index];

                        // Define Practice Nodes
                        // UNLOCK ALL: All items are enabled by default.
                        final practiceItems = [
                          PracticeItem(
                            title: 'বেসিকস',
                            dataPath:
                                'assets/data/questions/categorized/basics.json',
                            isEnabled: true,
                            passThreshold: 5,
                            icon: HugeIcons.strokeRoundedBook01,
                            color: Colors.blue,
                          ),
                          PracticeItem(
                            title: 'মেকানিজম',
                            dataPath:
                                'assets/data/questions/categorized/mechanisms.json',
                            isEnabled: true,
                            passThreshold: 5,
                            icon: HugeIcons.strokeRoundedSettings01,
                            color: Colors.blueGrey,
                          ),
                          PracticeItem(
                            title: 'রোড সাইন',
                            dataPath:
                                'assets/data/questions/categorized/road_signs.json',
                            isEnabled: true,
                            passThreshold: 5,
                            icon: HugeIcons.strokeRoundedAlert01,
                            color: Colors.orange,
                          ),
                          PracticeItem(
                            title: 'ট্রাফিক আইন',
                            dataPath:
                                'assets/data/questions/categorized/traffic_rules.json',
                            isEnabled: true,
                            passThreshold: 5,
                            icon: HugeIcons.strokeRoundedGrid,
                            color: Colors.purple,
                          ),
                          PracticeItem(
                            title: 'জরিমানা',
                            dataPath:
                                'assets/data/questions/categorized/penalties.json',
                            isEnabled: true,
                            passThreshold: 5,
                            icon: HugeIcons.strokeRoundedHelpCircle,
                            color: Colors.red,
                          ),
                          PracticeItem(
                            title: 'মডেল টেস্ট',
                            dataPath: 'mock_test',
                            isEnabled: true,
                            questionLimit: 20,
                            passThreshold: 13,
                            icon: HugeIcons.strokeRoundedTaskDaily01,
                            color: Colors.teal,
                          ),
                        ];

                        final item = practiceItems[index];

                        // Check completion status from provider
                        // unlockedIndex is now in practiceState.unlockedIndex
                        bool isCompleted = index < practiceState.unlockedIndex;
                        bool hasCompletedOnce = practiceState.completedSections
                            .contains(item.dataPath);

                        bool isActive = index == practiceState.unlockedIndex;
                        bool isLocked = index > practiceState.unlockedIndex;

                        return Positioned(
                          left: point.dx - 50, // (nodeSize + 20) / 2
                          top:
                              point.dy -
                              6, // Adjusted for the 6px top padding in PracticeNode
                          child: PracticeNode(
                            key: index == 0
                                ? _firstNodeKey
                                : index == levelCount - 1
                                ? _lastNodeKey
                                : null,
                            item: item,
                            levelIndex: index,
                            isCompleted: isCompleted,
                            isActive: isActive,
                            isLocked: isLocked,
                            hasCompletedOnce: hasCompletedOnce,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
