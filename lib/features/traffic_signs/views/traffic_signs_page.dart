import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../providers/traffic_signs_provider.dart';
import 'components/traffic_signs_content.dart';
import 'components/traffic_signs_error_view.dart';
import 'components/traffic_signs_tutorial_wrapper.dart';

class TrafficSignsPage extends ConsumerWidget {
  const TrafficSignsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final signsDataAsync = ref.watch(signsDataProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'রোড সাইন',
          style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: TrafficSignsTutorialWrapper(
        builder: (context, filterKey, firstSignKey) {
          return signsDataAsync.when(
            data: (signsData) => TrafficSignsContent(
              signsData: signsData,
              filterKey: filterKey,
              firstSignKey: firstSignKey,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => const TrafficSignsErrorView(),
          );
        },
      ),
    );
  }
}
