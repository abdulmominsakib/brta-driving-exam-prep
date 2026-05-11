import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../models/license_step.dart';

class FlowStepCard extends StatelessWidget {
  final LicenseStep step;
  final bool isLast;
  final bool isExpanded;
  final VoidCallback onTap;

  const FlowStepCard({
    super.key,
    required this.step,
    required this.isLast,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Timeline Line & Icon
        SizedBox(
          width: 50,
          child: Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: step.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: step.color.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [step.color, step.color.withValues(alpha: 0.8)],
                  ),
                ),
                child: Center(
                  child: HugeIcon(
                    icon: step.icon,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height:
                      100, // Large enough to be clipped or handled by parent scroll
                  constraints: const BoxConstraints(minHeight: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        step.color.withValues(alpha: 0.5),
                        theme.colorScheme.border,
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right: Content Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isExpanded
                      ? step.color.withValues(alpha: 0.05)
                      : theme.colorScheme.card,
                  border: Border.all(
                    color: isExpanded
                        ? step.color.withValues(alpha: 0.2)
                        : theme.colorScheme.border,
                    width: isExpanded ? 2 : 1,
                  ),
                  boxShadow: [
                    if (isExpanded)
                      BoxShadow(
                        color: step.color.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    else
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            step.title,
                            style: theme.textTheme.large.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isExpanded
                                  ? step.color
                                  : theme.colorScheme.foreground,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: isExpanded ? 0.5 : 0,
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowDown01,
                            size: 16,
                            color: isExpanded
                                ? step.color
                                : theme.colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AnimatedCrossFade(
                      firstChild: Text(
                        step.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.muted.copyWith(height: 1.5),
                      ),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.content,
                            style: theme.textTheme.muted.copyWith(height: 1.5),
                          ),
                          if (step.loopBackText != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.red.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const HugeIcon(
                                    icon: HugeIcons.strokeRoundedAlert01,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      step.loopBackText!,
                                      style: theme.textTheme.small.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                    if (!isExpanded) ...[
                      const SizedBox(height: 8),
                      Text(
                        'আরও দেখুন',
                        style: theme.textTheme.small.copyWith(
                          color: step.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
