import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoadingRoad extends StatefulWidget {
  const LoadingRoad({super.key});

  @override
  State<LoadingRoad> createState() => _LoadingRoadState();
}

class _LoadingRoadState extends State<LoadingRoad>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Moving Road
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(200, 300),
                    painter: RoadPainter(
                      animationValue: _controller.value,
                      isDark:
                          ShadTheme.of(context).brightness == Brightness.dark,
                    ),
                  );
                },
              ),

              // Car Icon
              Container(
                decoration: BoxDecoration(
                  color: ShadTheme.of(context).colorScheme.card,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCar01,
                  color: Color(0xFF58CC02),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'প্রশ্ন লোড হচ্ছে...',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
        ),
      ],
    );
  }
}

class RoadPainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  RoadPainter({required this.animationValue, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    // Draw Road Background
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF1E293B) : Colors.grey.shade200
      ..style = PaintingStyle.fill;

    final roadRect = Rect.fromCenter(
      center: Offset(centerX, size.height / 2),
      width: 120,
      height: size.height,
    );

    // transform for perspective effect (optional, keep simple for now)
    canvas.drawRRect(
      RRect.fromRectAndRadius(roadRect, const Radius.circular(0)),
      roadPaint,
    );

    // Draw Border Lines
    final borderPaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : Colors.grey.shade400
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(centerX - 50, 0),
      Offset(centerX - 50, size.height),
      borderPaint,
    );

    canvas.drawLine(
      Offset(centerX + 50, 0),
      Offset(centerX + 50, size.height),
      borderPaint,
    );

    // Draw Moving Divider Lines
    final dividerPaint = Paint()
      ..color = isDark ? const Color(0xFF64748B) : Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final double dashHeight = 30;
    final double gapHeight = 20;
    final double totalDash = dashHeight + gapHeight;

    // Calculate offset based on animation
    final double dy = animationValue * totalDash;

    for (double i = -totalDash; i < size.height + totalDash; i += totalDash) {
      canvas.drawLine(
        Offset(centerX, i + dy),
        Offset(centerX, i + dy + dashHeight),
        dividerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant RoadPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
