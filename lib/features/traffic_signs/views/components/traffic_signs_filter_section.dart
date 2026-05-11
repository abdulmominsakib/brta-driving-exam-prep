import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../data/models/traffic_sign.dart';
import '../../providers/traffic_signs_provider.dart';
import 'category_filter_chip.dart';

class TrafficSignsFilterSection extends ConsumerWidget {
  const TrafficSignsFilterSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  final List<SignCategory> categories;
  final String? selectedCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            AllFilterChip(
              isSelected: selectedCategory == null,
              onTap: () {
                ref.read(selectedCategoryProvider.notifier).select(null);
              },
            ),
            const SizedBox(width: 10),
            ...categories.map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CategoryFilterChip(
                  category: category,
                  isSelected: selectedCategory == category.id,
                  onTap: () {
                    ref.read(selectedCategoryProvider.notifier).select(
                          selectedCategory == category.id ? null : category.id,
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
