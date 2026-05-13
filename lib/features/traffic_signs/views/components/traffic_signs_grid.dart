import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/traffic_sign.dart';
import 'sign_card.dart';
import 'sign_detail_bottom_sheet.dart';

class TrafficSignsGrid extends StatelessWidget {
  const TrafficSignsGrid({
    super.key,
    required this.signsData,
    required this.selectedCategory,
    this.firstSignKey,
  });

  final SignsData signsData;
  final String? selectedCategory;
  final GlobalKey? firstSignKey;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final filteredSigns = selectedCategory == null
        ? signsData.signs
        : signsData.getSignsByCategory(selectedCategory!);

    if (filteredSigns.isEmpty) {
      return _EmptySignsView(theme: theme);
    }

    final crossAxisCount = _gridColumns(context);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: filteredSigns.length,
      itemBuilder: (context, index) {
        final sign = filteredSigns[index];
        final category = signsData.getCategory(sign.category);

        return SignCard(
          key: index == 0 ? firstSignKey : null,
          sign: sign,
          category: category,
          onTap: () {
            if (category != null) {
              if (Responsive.isDesktop(context)) {
                showSignDetailDialog(context: context, sign: sign, category: category);
              } else {
                showSignDetailBottomSheet(
                  context: context,
                  sign: sign,
                  category: category,
                );
              }
            }
          },
        );
      },
    );
  }

  int _gridColumns(BuildContext context) {
    if (Responsive.isDesktop(context)) return 6;
    if (Responsive.isTablet(context)) return 4;
    if (MediaQuery.of(context).size.width > 600) return 3;
    return 2;
  }
}

class _EmptySignsView extends StatelessWidget {
  const _EmptySignsView({required this.theme});
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_outlined,
              size: 40,
              color: theme.colorScheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'কোনো সাইন পাওয়া যায়নি',
            style: theme.textTheme.p.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
