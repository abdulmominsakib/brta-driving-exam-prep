import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/responsive.dart';
import '../models/guide.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'components/guide_tutorial_helper.dart';

class GuideListPage extends StatefulWidget {
  const GuideListPage({super.key});

  @override
  State<GuideListPage> createState() => _GuideListPageState();
}

class _GuideListPageState extends State<GuideListPage> {
  final GlobalKey _firstGuideKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _checkAndShowTutorial();
  }

  Future<void> _checkAndShowTutorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasShownTutorial =
          prefs.getBool('hasShownGuideListTutorial') ?? false;

      if (!hasShownTutorial) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            GuideTutorialHelper.showTutorial(
              context: context,
              firstGuideKey: _firstGuideKey,
              onFinish: () {
                prefs.setBool('hasShownGuideListTutorial', true);
              },
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Error showing tutorial: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final List<Guide> guides = [
      Guide(
        id: 'license_guide',
        title: 'লাইসেন্স গাইড',
        description: 'ড্রাইভিং লাইসেন্স পাওয়ার সম্পূর্ণ প্রক্রিয়া',
        imagePath: 'assets/images/guides/license_guide.webp',
        route: '/license-guide',
      ),
      Guide(
        id: 'license_renew',
        title: 'লাইসেন্স নবায়ন',
        description: 'লাইসেন্স নবায়ন করার নিয়ম ও ফি',
        imagePath: 'assets/images/guides/license_renew.webp',
        route: '/guide-license-renew',
      ),
      Guide(
        id: 'tax_token_renew',
        title: 'ট্যাক্স টোকেন নবায়ন',
        description: 'ট্যাক্স টোকেন নবায়ন ও ফি প্রদানের নিয়ম',
        imagePath: 'assets/images/guides/tax_token_renew.webp',
        route: '/guide-tax-token-renew',
      ),
      Guide(
        id: 'fitness_renew',
        title: 'ফিটনেস নবায়ন',
        description: 'মোটরযানের ফিটনেস সার্টিফিকেট নবায়ন প্রক্রিয়া',
        imagePath: 'assets/images/guides/fitness_renew.webp',
        route: '/guide-fitness-renew',
      ),
      Guide(
        id: 'registration_process',
        title: 'রেজিস্ট্রেশন প্রক্রিয়া',
        description: 'নতুন মোটরযান রেজিস্ট্রেশন করার ধাপসমূহ',
        imagePath: 'assets/images/guides/registration_process.webp',
        route: '/guide-registration',
      ),
      Guide(
        id: 'owner_change',
        title: 'মালিকানা পরিবর্তন',
        description: 'মোটরযানের মালিকানা বদলি করার নিয়ম',
        imagePath: 'assets/images/guides/owner_change.webp',
        route: '/guide-owner-change',
      ),
      Guide(
        id: 'car_modification',
        title: 'গাড়ি পরিবর্তন/পরিবর্ধন',
        description: 'মোটরযানের কাঠামো পরিবর্তনের নিয়ম',
        imagePath: 'assets/images/guides/car_modification.webp',
        route: '/guide-car-modification',
      ),
    ];

    final SystemUiOverlayStyle overlayStyle =
        theme.brightness == Brightness.light
        ? SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent)
        : SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              collapsedHeight: 70,
              floating: false,
              pinned: true,
              centerTitle: true,
              backgroundColor: theme.colorScheme.background,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'প্রক্রিয়া ও গাইড',
                  style: theme.textTheme.h4.copyWith(
                    color: theme.colorScheme.foreground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                        theme.colorScheme.background,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Icon(
                          Icons.menu_book_rounded,
                          size: 150,
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _gridColumns(context),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 140,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final guide = guides[index];
                  return _buildGuideCard(
                    context,
                    guide,
                    index == 0 ? _firstGuideKey : null,
                  );
                }, childCount: guides.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  int _gridColumns(BuildContext context) {
    if (Responsive.isDesktop(context)) return 3;
    if (Responsive.isTablet(context)) return 2;
    return 1;
  }

  Widget _buildGuideCard(BuildContext context, Guide guide, Key? key) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      key: key,
      onTap: () {
        if (guide.route != null) {
          context.push(guide.route!);
        }
      },
      child: ShadCard(
        padding: EdgeInsets.zero,
        backgroundColor: theme.colorScheme.card,
        border: ShadBorder.all(color: theme.colorScheme.border, width: 1.5),
        radius: const BorderRadius.all(Radius.circular(16)),
        child: Row(
          children: [
            Hero(
              tag: 'guide-${guide.id}-image',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  guide.imagePath,
                  width: 120,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 120,
                    color: theme.colorScheme.muted,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                ),
              ),
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            guide.title,
                            style: theme.textTheme.large.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      guide.description,
                      style: theme.textTheme.muted,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'বিস্তারিত দেখুন',
                          style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
