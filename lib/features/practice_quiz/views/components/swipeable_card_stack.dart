import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/models/quiz_model.dart';
import '../../../../core/theme/app_theme.dart';
import 'practice_card.dart';

class SwipeableCardStack extends StatefulWidget {
  final Question currentQuestion;
  final bool isFlipped;
  final Question? nextQuestion1;
  final Question? nextQuestion2;
  final VoidCallback onTap;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;
  final GlobalKey? cardKey;

  const SwipeableCardStack({
    super.key,
    required this.currentQuestion,
    required this.isFlipped,
    this.nextQuestion1,
    this.nextQuestion2,
    required this.onTap,
    required this.onSwipeRight,
    required this.onSwipeLeft,
    this.cardKey,
  });

  @override
  State<SwipeableCardStack> createState() => _SwipeableCardStackState();
}

class _SwipeableCardStackState extends State<SwipeableCardStack>
    with SingleTickerProviderStateMixin {
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  late AnimationController _animController;
  late VoidCallback _animListener;
  Animation<Offset>? _offsetAnimation;

  static const double _threshold = 120.0;
  static const double _maxRotation = 0.25;

  bool get _useGestures => !kIsWeb;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this);
    _animListener = () {
      if (mounted) setState(() {});
    };
    _animController.addListener(_animListener);
  }

  @override
  void didUpdateWidget(covariant SwipeableCardStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.currentQuestion, widget.currentQuestion)) {
      _resetCardPosition();
    }
  }

  @override
  void dispose() {
    _animController.removeListener(_animListener);
    _animController.dispose();
    super.dispose();
  }

  double get _offsetX =>
      _isDragging ? _dragOffset.dx : (_offsetAnimation?.value.dx ?? 0);

  double get _offsetY =>
      _isDragging ? _dragOffset.dy * 0.3 : (_offsetAnimation?.value.dy ?? 0);

  double get _rotation {
    final dx = _offsetX;
    return ((dx / _threshold).clamp(-1.0, 1.0)) * _maxRotation;
  }

  double get _progress => (_offsetX.abs() / _threshold).clamp(0.0, 1.0);
  bool get _isRight => _offsetX > 0;

  void _onDragStart(DragStartDetails _) {
    if (_animController.isAnimating) return;
    _animController.stop();
    _animController.value = 0;
    setState(() {
      _isDragging = true;
      _dragOffset = Offset.zero;
      _offsetAnimation = null;
    });
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (!_isDragging) return;
    setState(() => _dragOffset += d.delta);
  }

  void _onDragEnd(DragEndDetails _) {
    if (!_isDragging) return;
    _isDragging = false;
    final x = _dragOffset.dx;

    _animController
      ..stop()
      ..value = 0;

    if (x.abs() >= _threshold) {
      final direction = x.sign;
      _offsetAnimation =
          Tween<Offset>(
            begin: Offset(x, _dragOffset.dy),
            end: Offset(direction * 600, _dragOffset.dy * 2 + 100),
          ).animate(
            CurvedAnimation(parent: _animController, curve: Curves.easeInCubic),
          );
      _animController.duration = const Duration(milliseconds: 300);
      _animController.forward().then((_) {
        if (!mounted) return;
        if (direction > 0) {
          widget.onSwipeRight();
        } else {
          widget.onSwipeLeft();
        }
      });
    } else {
      _offsetAnimation =
          Tween<Offset>(
            begin: Offset(x, _dragOffset.dy),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
          );
      _animController.duration = const Duration(milliseconds: 400);
      _animController.forward().then((_) {
        if (mounted) {
          setState(() {
            _offsetAnimation = null;
            _dragOffset = Offset.zero;
          });
        }
      });
    }
  }

  void _resetCardPosition() {
    _animController
      ..stop()
      ..value = 0;
    if (!mounted) return;
    setState(() {
      _isDragging = false;
      _dragOffset = Offset.zero;
      _offsetAnimation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      onHorizontalDragStart: _useGestures ? _onDragStart : null,
      onHorizontalDragUpdate: _useGestures ? _onDragUpdate : null,
      onHorizontalDragEnd: _useGestures ? _onDragEnd : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (widget.nextQuestion2 != null)
                Positioned(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: _BackCard(
                    question: widget.nextQuestion2!,
                    scale: 0.84,
                    translateX: -10,
                    translateY: 14,
                    rotation: -0.06,
                    theme: theme,
                  ),
                ),
              if (widget.nextQuestion1 != null)
                Positioned(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: _BackCard(
                    question: widget.nextQuestion1!,
                    scale: 0.92,
                    translateX: 10,
                    translateY: 7,
                    rotation: 0.035,
                    theme: theme,
                  ),
                ),
              Transform(
                transform: Matrix4.identity()
                  ..translateByDouble(_offsetX, _offsetY, 0, 1)
                  ..rotateZ(_rotation),
                alignment: Alignment.center,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      PracticeCard(
                        question: widget.currentQuestion,
                        isFlipped: widget.isFlipped,
                        onTap: widget.onTap,
                      ),
                      if (widget.cardKey != null)
                        Center(
                          child: IgnorePointer(
                            child: SizedBox(
                              key: widget.cardKey,
                              width: 72,
                              height: 72,
                            ),
                          ),
                        ),
                      if (_progress > 0)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: AnimatedOpacity(
                              opacity: _progress,
                              duration: Duration.zero,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: (_isRight ? Colors.green : Colors.red)
                                      .withValues(alpha: 0.15 * _progress),
                                  border: Border.all(
                                    color:
                                        (_isRight ? Colors.green : Colors.red)
                                            .withValues(alpha: 0.4 * _progress),
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_progress > 0.35)
                        Positioned(
                          top: 32,
                          right: _isRight ? 28 : null,
                          left: _isRight ? null : 28,
                          child: IgnorePointer(
                            child: Transform.rotate(
                              angle: _isRight ? 0.12 : -0.12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: (_isRight ? Colors.green : Colors.red)
                                      .withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          (_isRight ? Colors.green : Colors.red)
                                              .withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isRight
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _isRight ? 'জানি' : 'জানি না',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final Question question;
  final double scale;
  final double translateX;
  final double translateY;
  final double rotation;
  final ShadThemeData theme;

  const _BackCard({
    required this.question,
    required this.scale,
    required this.translateX,
    required this.translateY,
    required this.rotation,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translateByDouble(translateX, translateY, 0, 1)
        ..rotateZ(rotation)
        ..scaleByDouble(scale, scale, scale, 1),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: theme.colorScheme.border.withValues(alpha: 0.6),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              question.questionText,
              style: theme.textTheme.h4.copyWith(
                color: theme.colorScheme.mutedForeground.withValues(
                  alpha: 0.25,
                ),
                fontFamily: kFontFamily,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
