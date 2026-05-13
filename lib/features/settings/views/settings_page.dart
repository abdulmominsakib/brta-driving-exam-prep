import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../core/utils/responsive.dart';
import 'components/theme_selector.dart';
import 'components/sound_toggles.dart';
import 'components/share_section.dart';
import 'components/why_button.dart';
import 'components/app_version.dart';
import 'components/rate_app_section.dart';
import 'components/feedback_section.dart';
import 'components/github_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: ShadTheme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        title: const Text(
          'সেটিংস',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context)),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const WhyButton(),
              const SizedBox(height: 24),
              const ThemeSelector(),
              const SizedBox(height: 16),
              const SoundToggles(),
              const SizedBox(height: 16),
              const GithubSection(),
              const SizedBox(height: 16),
              const ShareSection(),
              const SizedBox(height: 16),
              if (!kIsWeb) ...[const RateAppSection(), const SizedBox(height: 16)],
              const FeedbackSection(),

              const SizedBox(height: 40),
              const AppVersion(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
