import 'dart:ui';
import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  PathPainter({required this.points, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    // 1. Draw the Road (Wide Path)
    final roadPaint = Paint()
      ..color =
          color // Use passed color
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          20 // Widen to look like a road
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Offset Y by +40 to match center of the node (node is 80x80)
    final centerPoints = points.map((p) => Offset(p.dx, p.dy + 40)).toList();

    path.moveTo(centerPoints[0].dx, centerPoints[0].dy);

    for (int i = 0; i < centerPoints.length - 1; i++) {
      final p1 = centerPoints[i];
      final p2 = centerPoints[i + 1];

      final controlPoint1 = Offset(p1.dx, p1.dy + (p2.dy - p1.dy) / 2);
      final controlPoint2 = Offset(p2.dx, p1.dy + (p2.dy - p1.dy) / 2);

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        p2.dx,
        p2.dy,
      );
    }

    // Draw the main road
    canvas.drawPath(path, roadPaint);

    // 2. Draw the Divider (Dashed Line)
    final dividerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double dashLength = 10.0;
        final double gapLength = 10.0;

        // Extract a segment for the dash
        final Path extractPath = pathMetric.extractPath(
          distance,
          distance + dashLength,
        );

        canvas.drawPath(extractPath, dividerPaint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.color != color;
  }
}
