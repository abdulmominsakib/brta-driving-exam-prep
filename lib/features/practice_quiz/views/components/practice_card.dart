import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/models/quiz_model.dart';
import '../../../../core/theme/app_theme.dart';

class PracticeCard extends StatefulWidget {
  final Question question;
  final bool isFlipped;
  final VoidCallback onTap;
  const PracticeCard({
    super.key,
    required this.question,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  State<PracticeCard> createState() => _PracticeCardState();
}

class _PracticeCardState extends State<PracticeCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    if (widget.isFlipped) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(PracticeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isFront = angle < pi / 2;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012) // Perspective
              ..rotateY(angle),
            alignment: Alignment.center,
            child: isFront
                ? RepaintBoundary(
                    child: _CardFront(question: widget.question),
                  )
                : Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: RepaintBoundary(
                      child: _CardBack(question: widget.question),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final Question question;
  const _CardFront({required this.question});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: theme.colorScheme.border, width: 2),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.border.withValues(alpha: 0.5),
            offset: const Offset(0, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (question.questionImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:
                        question.questionImage!.toLowerCase().endsWith('.svg')
                        ? SvgPicture.asset(
                            question.questionImage!,
                            height: 180,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            question.questionImage!,
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                  ),
                  const SizedBox(height: 32),
                ],
                Text(
                  question.questionText,
                  style: theme.textTheme.h3.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    fontFamily: kFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedTap03,
                      color: theme.colorScheme.mutedForeground,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'উওর দেখতে ট্যাপ করুন', // Tap to see answer
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontFamily: kFontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'প্রশ্ন', // Question
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  final Question question;
  const _CardBack({required this.question});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final correctOption = question.options.firstWhere((o) => o.isCorrect);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            offset: const Offset(0, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedTick02,
                    color: theme.colorScheme.primary,
                    size: 64,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'সঠিক উত্তর:', // Correct Answer:
                    style: theme.textTheme.large.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: kFontFamily,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.primary.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (correctOption.optionImage != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: correctOption.optionImage!
                                    .toLowerCase()
                                    .endsWith('.svg')
                                ? SvgPicture.asset(
                                    correctOption.optionImage!,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    correctOption.optionImage!,
                                    height: 80,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Text(
                          correctOption.text,
                          style: theme.textTheme.h4.copyWith(
                            color: theme.colorScheme.foreground,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontFamily: kFontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'উত্তর', // Answer
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
