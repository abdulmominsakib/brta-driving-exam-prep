import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/settings_provider.dart';

class SoundToggles extends ConsumerWidget {
  const SoundToggles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final theme = ShadTheme.of(context);

    return settingsAsync.when(
      data: (settings) => ShadCard(
        title: const Text(
          'শব্দ ও ভাইব্রেশন',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedMusicNote01,
                  size: 24,
                  color: theme.colorScheme.foreground,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'শব্দ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      _SoundInfoSection(),
                    ],
                  ),
                ),
                ShadSwitch(
                  width: 60,
                  height: 30,
                  value: settings.isSoundEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setSoundEnabled(value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedSmartPhone01,
                  size: 24,
                  color: theme.colorScheme.foreground,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'ভাইব্রেশন',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                ShadSwitch(
                  width: 60,
                  height: 30,
                  value: settings.isHapticEnabled,
                  onChanged: (value) => ref
                      .read(settingsProvider.notifier)
                      .setHapticEnabled(value),
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () =>
          const ShadCard(child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => ShadCard(child: Text('Error: $err')),
    );
  }
}

class _SoundInfoSection extends StatelessWidget {
  const _SoundInfoSection();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => ShadDialog(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            removeBorderRadiusWhenTiny: false,
            radius: BorderRadius.circular(16),
            title: const Text('সাউন্ড ইফেক্ট তথ্য'),
            description: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'এই অ্যাপে ব্যবহৃত সকল সাউন্ড ইফেক্ট সম্পূর্ণ হালাল। এই সাউন্ড ইফেক্ট সম্পর্কে আরও বিস্তারিত জানতে পারেন আপনি নিচের লিংকে ক্লিক করেন।',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                      'https://github.com/abdulmominsakib/halal-sound-effects',
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: const Text(
                    'https://github.com/abdulmominsakib/halal-sound-effects',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            actions: [
              ShadButton(
                onPressed: () => Navigator.of(context).pop(),
                foregroundColor: Colors.white,
                child: const Text('ঠিক আছে'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.info),
    );
  }
}
