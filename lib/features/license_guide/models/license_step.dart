import 'package:flutter/material.dart';

class LicenseStep {
  final String title;
  final List<List<dynamic>> icon;
  final Color color;
  final String content;
  final bool isDecision;
  final String? loopBackText;

  LicenseStep({
    required this.title,
    required this.icon,
    required this.color,
    required this.content,
    this.isDecision = false,
    this.loopBackText,
  });
}
