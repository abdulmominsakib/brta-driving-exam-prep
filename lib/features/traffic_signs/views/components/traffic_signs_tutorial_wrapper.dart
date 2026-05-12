import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'traffic_signs_tutorial_helper.dart';

class TrafficSignsTutorialWrapper extends StatefulWidget {
  const TrafficSignsTutorialWrapper({super.key, required this.builder});

  final Widget Function(
    BuildContext context,
    GlobalKey filterKey,
    GlobalKey firstSignKey,
  )
  builder;

  @override
  State<TrafficSignsTutorialWrapper> createState() =>
      _TrafficSignsTutorialWrapperState();
}

class _TrafficSignsTutorialWrapperState
    extends State<TrafficSignsTutorialWrapper> {
  final GlobalKey _filterKey = GlobalKey();
  final GlobalKey _firstSignKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _checkAndShowTutorial();
  }

  Future<void> _checkAndShowTutorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasShownTutorial =
          prefs.getBool('hasShownTrafficSignsTutorial') ?? false;

      if (!hasShownTutorial) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            TrafficSignsTutorialHelper.showTutorial(
              context: context,
              filterKey: _filterKey,
              firstSignKey: _firstSignKey,
              onFinish: () {
                prefs.setBool('hasShownTrafficSignsTutorial', true);
              },
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Error showing tutorial: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _filterKey, _firstSignKey);
  }
}
