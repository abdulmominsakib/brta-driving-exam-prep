import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/traffic_sign.dart';
import '../../providers/traffic_signs_provider.dart';
import 'traffic_signs_filter_section.dart';
import 'traffic_signs_grid.dart';

class TrafficSignsContent extends ConsumerWidget {
  const TrafficSignsContent({
    super.key,
    required this.signsData,
    required this.filterKey,
    required this.firstSignKey,
  });

  final SignsData signsData;
  final GlobalKey filterKey;
  final GlobalKey firstSignKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Column(
      children: [
        SizedBox(
          key: filterKey,
          child: TrafficSignsFilterSection(
            categories: signsData.categories.values.toList(),
            selectedCategory: selectedCategory,
          ),
        ),
        Expanded(
          child: TrafficSignsGrid(
            signsData: signsData,
            selectedCategory: selectedCategory,
            firstSignKey: firstSignKey,
          ),
        ),
      ],
    );
  }
}
