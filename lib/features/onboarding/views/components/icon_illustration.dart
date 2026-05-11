import 'package:flutter/material.dart';
import '../../models/onboarding_slide.dart';

class IconIllustration extends StatefulWidget {
  const IconIllustration({super.key, required this.slide});
  final OnboardingSlide slide;

  @override
  State<IconIllustration> createState() => _IconIllustrationState();
}

class _IconIllustrationState extends State<IconIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.93, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.slide.iconColor;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulse
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withAlpha(15),
              ),
            ),
          ),
          // Middle pulse
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withAlpha(30), width: 1.5),
              ),
            ),
          ),
          // Inner icon container
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withAlpha(25),
                border: Border.all(color: color.withAlpha(80), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: color.withAlpha(40),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(widget.slide.icon, size: 84, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
