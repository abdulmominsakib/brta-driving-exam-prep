import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/theme_provider.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);

    return ShadCard(
      title: const Text(
        'অ্যাপ থিম',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ThemeOption(
                  label: 'লাইট',
                  icon: HugeIcons.strokeRoundedSun03,
                  isSelected: themeModeAsync.value == ThemeMode.light,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.light),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ThemeOption(
                  label: 'ডার্ক',
                  icon: HugeIcons.strokeRoundedMoon02,
                  isSelected: themeModeAsync.value == ThemeMode.dark,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.dark),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ThemeOption(
                  label: 'সিস্টেম',
                  icon: HugeIcons.strokeRoundedSmartPhone01,
                  isSelected:
                      themeModeAsync.value == ThemeMode.system ||
                      themeModeAsync.value == null,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setThemeMode(ThemeMode.system),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final dynamic icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    // Resume/Share button colors
    final selectedColor = const Color(0xFF58CC02);
    final selectedShadowColor = const Color(0xFF58A700);

    // Unselected colors (neutral 3D look)
    final unselectedColor = theme.brightness == Brightness.dark
        ? const Color(0xFF1E293B) // Dark slate for dark mode
        : Colors.white;
    final unselectedShadowColor = theme.brightness == Brightness.dark
        ? const Color(0xFF0F172A) // Darker slate
        : const Color(0xFFE2E8F0); // Light grey

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isSelected ? selectedShadowColor : unselectedShadowColor,
              offset: const Offset(0, 4),
            ),
          ],
          border: isSelected
              ? null
              : Border.all(
                  color: theme.brightness == Brightness.dark
                      ? Colors.transparent
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
        ),
        child: Column(
          children: [
            HugeIcon(
              icon: icon,
              size: 24,
              color: isSelected ? Colors.white : theme.colorScheme.foreground,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : theme.colorScheme.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
