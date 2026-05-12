import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/base/views/base_page.dart';
import '../../features/guide/views/guide_detail_pages.dart';
import '../../features/guide/views/guide_list_page.dart';
import '../../features/license_guide/views/license_guide_page.dart';
import '../../features/mock_exam/views/mock_exam_page.dart';
import '../../features/mock_exam_quiz/views/mock_exam_quiz_page.dart';
import '../../features/onboarding/views/onboarding_page.dart';
import '../../features/practice/views/practice_page.dart';
import '../../features/practice_quiz/views/practice_cards_page.dart';
import '../../features/settings/views/settings_page.dart';
import '../../features/traffic_signs/views/traffic_signs_page.dart';
import '../../features/why/views/why_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

Future<String?> _onboardingRedirect(_, GoRouterState state) async {
  // Only redirect from '/' on first launch
  if (state.matchedLocation != '/') return null;
  final prefs = await SharedPreferences.getInstance();
  final completed = prefs.getBool('onboarding_complete') ?? false;
  if (!completed) return '/onboarding';
  return null;
}

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: _onboardingRedirect,
  routes: [
    GoRoute(
      path: '/onboarding',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) =>
          CupertinoPage(key: state.pageKey, child: const OnboardingPage()),
    ),
    StatefulShellRoute(
      builder: (context, state, navigationShell) => navigationShell,
      navigatorContainerBuilder: (context, navigationShell, children) {
        return BasePage(navigationShell: navigationShell, children: children);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const PracticePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/traffic-signs',
              builder: (context, state) => const TrafficSignsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/mock-exam',
              builder: (context, state) => const MockExamPage(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/guide-list',
              builder: (context, state) => const GuideListPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/license-guide',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) =>
          CupertinoPage(key: state.pageKey, child: const LicenseGuidePage()),
    ),
    GoRoute(
      path: '/guide-registration',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const RegistrationGuidePage(),
      ),
    ),
    GoRoute(
      path: '/guide-license-renew',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const LicenseRenewGuidePage(),
      ),
    ),
    GoRoute(
      path: '/guide-tax-token-renew',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const TaxTokenRenewGuidePage(),
      ),
    ),
    GoRoute(
      path: '/guide-fitness-renew',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const FitnessRenewGuidePage(),
      ),
    ),
    GoRoute(
      path: '/guide-owner-change',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const OwnerChangeGuidePage(),
      ),
    ),
    GoRoute(
      path: '/guide-car-modification',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const CarModificationGuidePage(),
      ),
    ),
    GoRoute(
      path: '/why',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        return CupertinoPage(key: state.pageKey, child: const WhyPage());
      },
    ),
    GoRoute(
      path: '/practice-quiz',
      parentNavigatorKey: _rootNavigatorKey, // Full screen
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;

        return CupertinoPage(
          key: state.pageKey,
          child: PracticeCardsPage(
            dataPath: extra?['dataPath'] as String?,
            levelIndex: extra?['levelIndex'] as int?,
          ),
        );
      },
    ),
    GoRoute(
      path: '/mock-exam-quiz',
      parentNavigatorKey: _rootNavigatorKey, // Full screen
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return CupertinoPage(
          key: state.pageKey,
          child: MockExamQuizPage(
            dataPath: extra?['dataPath'] as String?,
            // Mock exam specific defaults can be handled here or in the page
            isPractice: extra?['isPractice'] as bool? ?? false,
            questionLimit: extra?['questionLimit'] as int?,
            passThreshold: extra?['passThreshold'] as int?,
          ),
        );
      },
    ),
  ],
);
