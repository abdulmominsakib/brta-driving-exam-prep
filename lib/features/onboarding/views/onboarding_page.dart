import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/onboarding_slide.dart';
import '../providers/onboarding_provider.dart';
import 'components/hero_image.dart';
import 'components/icon_illustration.dart';
import 'components/slide_text.dart';
import 'components/page_indicators.dart';
import 'components/cta_button.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
    _fadeController.reset();
    _slideController.reset();
    _fadeController.forward();
    _slideController.forward();
  }

  void _next() {
    if (_currentPage < onboardingSlides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _complete();
    }
  }

  void _skip() => _complete();

  Future<void> _complete() async {
    await ref.read(onboardingProvider.notifier).completeOnboarding();
    if (mounted) context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final slide = onboardingSlides[_currentPage];
    final isLast = _currentPage == onboardingSlides.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          // ── Background Gradient ────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.3),
                radius: 1.2,
                colors: [
                  slide.iconColor.withAlpha(slide.useHeroImage ? 30 : 45),
                  theme.colorScheme.background,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Skip button (Glassmorphism) ──────────────
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 16),
                    child: AnimatedOpacity(
                      opacity: isLast ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: isLast ? null : _skip,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                'এড়িয়ে যান',
                                style: theme.textTheme.p.copyWith(
                                  color: theme.colorScheme.mutedForeground,
                                  fontSize: 15,
                                  fontFamily: 'SolaimanLipi',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Illustration area ────────────────────────
                Expanded(
                  flex: slide.useHeroImage ? 6 : 5,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: onboardingSlides.length,
                    itemBuilder: (context, index) {
                      final s = onboardingSlides[index];
                      return s.useHeroImage
                          ? const HeroImage()
                          : IconIllustration(slide: s);
                    },
                  ),
                ),

                // ── Text content ─────────────────────────────
                Expanded(
                  flex: slide.useHeroImage ? 3 : 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: SlideText(slide: slide),
                      ),
                    ),
                  ),
                ),

                // ── Bottom controls ──────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 36),
                  child: Column(
                    children: [
                      PageIndicators(
                        count: onboardingSlides.length,
                        current: _currentPage,
                        activeColor: slide.iconColor,
                      ),
                      const SizedBox(height: 24),
                      CTAButton(
                        isLast: isLast,
                        color: slide.iconColor,
                        onPressed: _next,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
