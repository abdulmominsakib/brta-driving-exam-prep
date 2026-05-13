import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:math';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/responsive.dart';
import 'components/practice_path_painter.dart';
import 'components/practice_node.dart';
import '../models/practice_item.dart';

import '../providers/practice_progress_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/practice_tutorial_helper.dart';

final List<PracticeItem> practiceItems = [
  PracticeItem(
    title: 'বেসিকস',
    dataPath: 'assets/data/questions/categorized/basics.json',
    isEnabled: true,
    passThreshold: 5,
    icon: HugeIcons.strokeRoundedBook01,
    color: Colors.blue,
  ),
  PracticeItem(
    title: 'মেকানিজম',
    dataPath: 'assets/data/questions/categorized/mechanisms.json',
    isEnabled: true,
    passThreshold: 5,
    icon: HugeIcons.strokeRoundedSettings01,
    color: Colors.blueGrey,
  ),
  PracticeItem(
    title: 'রোড সাইন',
    dataPath: 'assets/data/questions/categorized/road_signs.json',
    isEnabled: true,
    passThreshold: 5,
    icon: HugeIcons.strokeRoundedAlert01,
    color: Colors.orange,
  ),
  PracticeItem(
    title: 'ট্রাফিক আইন',
    dataPath: 'assets/data/questions/categorized/traffic_rules.json',
    isEnabled: true,
    passThreshold: 5,
    icon: HugeIcons.strokeRoundedGrid,
    color: Colors.purple,
  ),
  PracticeItem(
    title: 'জরিমানা',
    dataPath: 'assets/data/questions/categorized/penalties.json',
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

  void _onPracticeTap(PracticeItem item, int levelIndex) {
    if (item.dataPath == 'mock_test') {
      context.go('/mock-exam');
    } else {
      context.push(
        '/practice-quiz',
        extra: {
          'dataPath': item.dataPath,
          'isPractice': true,
          'questionLimit': item.questionLimit,
          'passThreshold': item.passThreshold,
          'levelIndex': levelIndex,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final practiceState = ref.watch(practiceProgressProvider);
    final theme = ShadTheme.of(context);

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
          child: Responsive.isDesktop(context)
              ? _buildDesktopLayout(context, theme, practiceState)
              : _buildMobileLayout(context, theme, practiceState),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ShadThemeData theme,
    PracticeState practiceState,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'প্র্যাকটিস',
                style: theme.textTheme.h2.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'প্রতিটি বিষয় ভালোভাবে অনুশীলন করুন',
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.1,
                ),
                itemCount: practiceItems.length,
                itemBuilder: (context, index) {
                  final item = practiceItems[index];
                  final isCompleted = index < practiceState.unlockedIndex;
                  final hasCompletedOnce =
                      practiceState.completedSections.contains(item.dataPath);
                  final isActive = index == practiceState.unlockedIndex;
                  final isLocked = index > practiceState.unlockedIndex;

                  return _DesktopPracticeCard(
                    item: item,
                    isCompleted: isCompleted,
                    isActive: isActive,
                    isLocked: isLocked,
                    hasCompletedOnce: hasCompletedOnce,
                    onTap: () => _onPracticeTap(item, index),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ShadThemeData theme,
    PracticeState practiceState,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const int levelCount = 6;
        const double nodeSize = 80;
        const double verticalSpacing = 60;
        const double itemHeight = nodeSize + verticalSpacing;
        final totalHeight = levelCount * itemHeight + 100;

        final List<Offset> points = [];
        final double centerX = constraints.maxWidth / 2;
        final double amplitude = constraints.maxWidth * 0.25;

        for (int i = 0; i < levelCount; i++) {
          final double y = i * itemHeight + 50;
          final double x = centerX + sin(i * pi / 2) * amplitude;
          points.add(Offset(x, y));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(
            top: max(0.0, MediaQuery.of(context).padding.top - 10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: totalHeight,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, totalHeight),
                      painter: PathPainter(
                        points: points,
                        color: theme.brightness == Brightness.dark
                            ? const Color(0xFF374151)
                            : const Color(0xFFE5E7EB),
                      ),
                    ),
                    ...List.generate(levelCount, (index) {
                      final point = points[index];
                      final item = practiceItems[index];
                      final isCompleted = index < practiceState.unlockedIndex;
                      final hasCompletedOnce =
                          practiceState.completedSections
                              .contains(item.dataPath);
                      final isActive = index == practiceState.unlockedIndex;
                      final isLocked = index > practiceState.unlockedIndex;

                      return Positioned(
                        left: point.dx - 50,
                        top: point.dy - 6,
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
            ],
          ),
        );
      },
    );
  }
}

class _DesktopPracticeCard extends StatelessWidget {
  final PracticeItem item;
  final bool isCompleted;
  final bool isActive;
  final bool isLocked;
  final bool hasCompletedOnce;
  final VoidCallback onTap;

  const _DesktopPracticeCard({
    required this.item,
    required this.isCompleted,
    required this.isActive,
    required this.isLocked,
    required this.hasCompletedOnce,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final baseColor = item.color ?? const Color(0xFF58CC02);

    final color = isLocked
        ? const Color(0xFFE5E7EB)
        : isCompleted
        ? const Color(0xFFFFC800)
        : baseColor;

    final bgColor =
        isLocked
            ? theme.colorScheme.background
            : color.withValues(alpha: 0.08);

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isLocked
                ? theme.colorScheme.border
                : color.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(
                    icon: isLocked
                        ? HugeIcons.strokeRoundedLock
                        : item.icon ?? HugeIcons.strokeRoundedPlay,
                    color: isLocked
                        ? const Color(0xFFAFB2B7)
                        : isCompleted
                        ? const Color(0xFFFFC800)
                        : isActive
                        ? baseColor
                        : baseColor,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.title,
                    style: theme.textTheme.large.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isLocked
                          ? const Color(0xFFAFB2B7)
                          : theme.colorScheme.foreground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isLocked
                        ? 'লকড'
                        : isCompleted
                        ? 'সম্পন্ন'
                        : isActive
                        ? 'শুরু করুন'
                        : 'অনুশীলন',
                    style: theme.textTheme.small.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (hasCompletedOnce && !isLocked)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF58CC02),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedTick02,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
