import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/responsive.dart';

class BasePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget>? children;

  const BasePage({super.key, required this.navigationShell, this.children});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  bool _reverse = false;

  @override
  void didUpdateWidget(covariant BasePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _reverse =
        widget.navigationShell.currentIndex <
        oldWidget.navigationShell.currentIndex;
  }

  void _onDestinationSelected(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final index = widget.navigationShell.currentIndex;

    final body = widget.children != null
        ? PageTransitionSwitcher(
            reverse: _reverse,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: widget.children![index],
          )
        : widget.navigationShell;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            _SideNavigationRail(
              selectedIndex: index,
              onDestinationSelected: _onDestinationSelected,
            ),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ShadTheme.of(context).colorScheme.border,
              width: 2,
            ),
          ),
        ),
        child: NavigationBar(
          elevation: 0,
          selectedIndex: index,
          onDestinationSelected: _onDestinationSelected,
          backgroundColor: ShadTheme.of(context).colorScheme.background,
          indicatorColor: Colors.transparent,
          destinations: _navDestinations(context),
        ),
      ),
    );
  }
}

List<NavigationDestination> _navDestinations(BuildContext context) {
  final muted = ShadTheme.of(context).colorScheme.mutedForeground;
  return [
    NavigationDestination(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedBookOpen01, color: muted),
      selectedIcon: const HugeIcon(
        icon: HugeIcons.strokeRoundedBookOpen01,
        color: Color(0xFF58CC02),
      ),
      label: 'প্র্যাকটিস',
    ),
    NavigationDestination(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedAlert01, color: muted),
      selectedIcon: const HugeIcon(
        icon: HugeIcons.strokeRoundedAlert01,
        color: Color(0xFF58CC02),
      ),
      label: 'চিহ্ন',
    ),
    NavigationDestination(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedDashboardCircle, color: muted),
      selectedIcon: const HugeIcon(
        icon: HugeIcons.strokeRoundedDashboardCircle,
        color: Color(0xFF58CC02),
      ),
      label: 'পরীক্ষা',
    ),
    NavigationDestination(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedNotebook, color: muted),
      selectedIcon: const HugeIcon(
        icon: HugeIcons.strokeRoundedNotebook,
        color: Color(0xFF58CC02),
      ),
      label: 'প্রক্রিয়া',
    ),
    NavigationDestination(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedSettings01, color: muted),
      selectedIcon: const HugeIcon(
        icon: HugeIcons.strokeRoundedSettings01,
        color: Color(0xFF58CC02),
      ),
      label: 'সেটিংস',
    ),
  ];
}

class _SideNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _SideNavigationRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final borderColor = theme.colorScheme.border;

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: Border(right: BorderSide(color: borderColor, width: 1)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF58CC02).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedCar01,
                  color: Color(0xFF58CC02),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BRTA',
                    style: theme.textTheme.large.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF58CC02),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ড্রাইভিং',
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          _NavItem(
            icon: HugeIcons.strokeRoundedBookOpen01,
            label: 'প্র্যাকটিস',
            isSelected: selectedIndex == 0,
            onTap: () => onDestinationSelected(0),
          ),
          _NavItem(
            icon: HugeIcons.strokeRoundedAlert01,
            label: 'চিহ্ন',
            isSelected: selectedIndex == 1,
            onTap: () => onDestinationSelected(1),
          ),
          _NavItem(
            icon: HugeIcons.strokeRoundedDashboardCircle,
            label: 'পরীক্ষা',
            isSelected: selectedIndex == 2,
            onTap: () => onDestinationSelected(2),
          ),
          _NavItem(
            icon: HugeIcons.strokeRoundedNotebook,
            label: 'প্রক্রিয়া',
            isSelected: selectedIndex == 3,
            onTap: () => onDestinationSelected(3),
          ),
          _NavItem(
            icon: HugeIcons.strokeRoundedSettings01,
            label: 'সেটিংস',
            isSelected: selectedIndex == 4,
            onTap: () => onDestinationSelected(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final color =
        isSelected
            ? const Color(0xFF58CC02)
            : theme.colorScheme.mutedForeground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? const Color(0xFF58CC02).withValues(alpha: 0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                HugeIcon(icon: icon, color: color, size: 22),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: theme.textTheme.p.copyWith(
                    color: color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
