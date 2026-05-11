import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';

import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    return Scaffold(
      body: widget.children != null
          ? PageTransitionSwitcher(
              reverse: _reverse,
              transitionBuilder:
                  (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child,
                    );
                  },
              child: widget.children![widget.navigationShell.currentIndex],
            )
          : widget.navigationShell,
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
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: _onDestinationSelected,
          backgroundColor: ShadTheme.of(context).colorScheme.background,
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedBookOpen01,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
              selectedIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedBookOpen01,
                color: Color(0xFF58CC02),
              ),
              label: 'প্র্যাকটিস',
            ),
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedAlert01,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
              selectedIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedAlert01,
                color: Color(0xFF58CC02),
              ),
              label: 'চিহ্ন',
            ),
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedDashboardCircle,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
              selectedIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedDashboardCircle,
                color: Color(0xFF58CC02),
              ),
              label: 'পরীক্ষা',
            ),

            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedNotebook,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
              selectedIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedNotebook,
                color: Color(0xFF58CC02),
              ),
              label: 'প্রক্রিয়া',
            ),
            NavigationDestination(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSettings01,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
              selectedIcon: HugeIcon(
                icon: HugeIcons.strokeRoundedSettings01,
                color: Color(0xFF58CC02),
              ),
              label: 'সেটিংস',
            ),
          ],
        ),
      ),
    );
  }
}
