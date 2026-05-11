import 'package:flutter/material.dart';

class PracticeItem {
  final String title;
  final String dataPath;
  final bool isEnabled;
  final int? questionLimit;
  final int? passThreshold;
  final dynamic icon;
  final Color? color;

  PracticeItem({
    required this.title,
    required this.dataPath,
    required this.isEnabled,
    this.questionLimit,
    this.passThreshold,
    this.icon,
    this.color,
  });
}
