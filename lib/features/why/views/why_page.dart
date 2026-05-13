import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/responsive.dart';
import '../../settings/views/components/app_version.dart';
import 'components/app_purpose_section.dart';
import 'components/developer_info_section.dart';
import 'components/future_plans_section.dart';
import 'components/road_safety_stats_section.dart';
import 'components/sound_effects_section.dart';

class WhyPage extends StatelessWidget {
  const WhyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'কেন?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ShadTheme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context)),
          child: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPurposeSection(),
            SizedBox(height: 24),
            RoadSafetyStatsSection(),
            SizedBox(height: 24),
            SoundEffectsSection(),
            SizedBox(height: 24),
            FuturePlansSection(),
            SizedBox(height: 24),
            DeveloperInfoSection(),
            SizedBox(height: 32),
            // WhyFooter(),
            AppVersion(),
            SizedBox(height: 32),
          ],
        ),
      ),
        ),
      ),
    );
  }
}
