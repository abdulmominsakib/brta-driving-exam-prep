import 'package:flutter/material.dart';

class GuideStep {
  final String title;
  final dynamic icon; // Can be IconData or List<List<dynamic>> for HugeIcons
  final Color color;
  final String content;
  final bool isDecision;
  final String? loopBackText;

  GuideStep({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
    this.isDecision = false,
    this.loopBackText,
  });
}
