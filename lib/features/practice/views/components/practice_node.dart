import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../models/practice_item.dart';

class PracticeNode extends StatefulWidget {
  final PracticeItem item;
  final bool isCompleted;
  final bool isActive;
  final bool isLocked;
  final int levelIndex;
  final bool hasCompletedOnce;

  const PracticeNode({
    super.key,
    required this.item,
    this.isCompleted = false,
    this.isActive = false,
    this.isLocked = true,
    this.levelIndex = 0,
    this.hasCompletedOnce = false,
  });

  @override
  State<PracticeNode> createState() => _PracticeNodeState();
}

class _PracticeNodeState extends State<PracticeNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    if (widget.isActive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(PracticeNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Styles for Practice Mode
    final baseColor = widget.item.color ?? const Color(0xFF58CC02);

    final color = widget.isLocked
        ? const Color(0xFFE5E7EB) // Grey
        : widget.isCompleted
        ? const Color(0xFFFFC800) // Gold
        : baseColor;

    final shadowColor = widget.isLocked
        ? const Color(0xFFAFB2B7) // Grey Shadow
        : widget.isCompleted
        ? const Color(0xFFE5B000) // Gold Shadow
        : Color.alphaBlend(
            Colors.black.withValues(alpha: 0.3),
            baseColor,
          ); // Darker shade of baseColor

    final iconColor = (widget.isCompleted || widget.isActive)
        ? Colors.white
        : const Color(0xFFAFB2B7);

    final dynamic iconData = widget.isLocked
        ? HugeIcons.strokeRoundedLock
        : widget.item.icon ?? HugeIcons.strokeRoundedPlay;

    const double size = 80;

    return GestureDetector(
      onTap: () {
        if (!widget.isLocked) {
          if (widget.item.dataPath == 'mock_test') {
            context.go('/mock-exam');
          } else {
            context.push(
              '/practice-quiz',
              extra: {
                'dataPath': widget.item.dataPath,
                'isPractice': true,
                'questionLimit': widget.item.questionLimit,
                'passThreshold': widget.item.passThreshold,
                'levelIndex': widget.levelIndex,
              },
            );
          }
        }
      },
      child: Column(
        children: [
          // The 3D Circle
          SizedBox(
            height: size + 20, // Extra space for shadow and ring
            width: size + 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated Dotted Ring
                if (widget.isActive)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(size + 20, size + 20),
                        painter: _DottedRingPainter(
                          color: baseColor,
                          animationValue: _controller.value,
                        ),
                      );
                    },
                  ),
                // Shadow Layer (Bottom)
                Positioned(
                  top: 14, // Adjusted for centering in larger SizedBox
                  left: 10,
                  right: 10,
                  child: Container(
                    height: size,
                    decoration: BoxDecoration(
                      color: shadowColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Foreground Layer (Top)
                Positioned(
                  top: 6, // Adjusted for centering
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: iconData,
                        color: iconColor,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                // Checkmark for completed once
                if (widget.hasCompletedOnce && !widget.isLocked)
                  Positioned(
                    right: 10,
                    bottom: 14,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF58CC02),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const HugeIcon(
                        icon: HugeIcons.strokeRoundedTick02,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            constraints: const BoxConstraints(maxWidth: 120),
            child: Text(
              widget.item.title,
              style: ShadTheme.of(context).textTheme.large.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: widget.item.isEnabled
                    ? const Color(0xFF58CC02)
                    : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedRingPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _DottedRingPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 2; // Slightly inside the container

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Subtle glow/shadow for the segments
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    const int segmentCount = 12;
    for (int i = 0; i < segmentCount; i++) {
      final double angle =
          (i * 2 * math.pi / segmentCount) + (animationValue * 2 * math.pi);
      final double x = center.dx + radius * math.cos(angle);
      final double y = center.dy + radius * math.sin(angle);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + math.pi / 2); // Rotate to be tangent to the circle

      // Draw shadow/glow (rectangle)
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: 8, height: 4),
          const Radius.circular(2),
        ),
        shadowPaint,
      );

      // Draw rectangle
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: 6, height: 3),
          const Radius.circular(1),
        ),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _DottedRingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
