import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/update/update_page.dart';
import 'core/services/sound_service.dart';
import 'features/practice_quiz/data/repositories/question_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Sound Service (preloads audio into memory)
  await SoundService.init();

  // Seed questions into Sembast if needed
  final questionRepo = QuestionRepository();
  await questionRepo.seedQuestionsIfNeeded();

  runApp(UpdatePage(child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);

    return ShadApp.router(
      title: 'BRTA Driving Prep',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeModeAsync.value ?? ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
