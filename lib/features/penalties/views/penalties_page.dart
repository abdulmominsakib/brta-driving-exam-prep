import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/utils/responsive.dart';
import '../data/penalties_data.dart';
import 'components/penalty_offense_card.dart';
import 'components/penalty_rule_card.dart';

class PenaltiesPage extends StatelessWidget {
  const PenaltiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

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
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.maxContentWidth(context),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 150,
                  floating: false,
                  pinned: true,
                  centerTitle: true,
                  backgroundColor: theme.colorScheme.background,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'জরিমানা ও আইন',
                      style: theme.textTheme.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.foreground,
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.14),
                            theme.colorScheme.background,
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -16,
                            top: -10,
                            child: Icon(
                              Icons.gavel_rounded,
                              size: 170,
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  sliver: SliverList.list(
                    children: [
                      _IntroCard(text: penaltiesIntro),
                      const SizedBox(height: 12),
                      _HighlightInfoCard(
                        title: 'শিক্ষাগত যোগ্যতা',
                        description: penaltiesEducationRule,
                        icon: Icons.school_rounded,
                      ),
                      const SizedBox(height: 12),
                      _HighlightInfoCard(
                        title: 'পয়েন্ট কর্তন সিস্টেম (RSPS)',
                        description: penaltiesPointSystem,
                        icon: Icons.toll_rounded,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'প্রধান ড্রাইভিং নিয়মাবলী',
                        style: theme.textTheme.h4.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...majorDrivingRules.map(
                        (rule) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: PenaltyRuleCard(rule: rule),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'অপরাধ, জরিমানা ও শাস্তির তালিকা',
                        style: theme.textTheme.h4.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'সর্বোচ্চ জরিমানার তথ্য দ্রুত রিভিশনের জন্য কার্ড আকারে সাজানো হয়েছে।',
                        style: theme.textTheme.muted,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _offenseColumns(context),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 145,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return PenaltyOffenseCard(
                        offense: penaltyOffenses[index],
                      );
                    }, childCount: penaltyOffenses.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                    child: _FooterNoteCard(text: penaltiesEnforcement),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _offenseColumns(BuildContext context) {
    if (Responsive.isDesktop(context)) return 3;
    if (Responsive.isTablet(context)) return 2;
    return 1;
  }
}

class _IntroCard extends StatelessWidget {
  final String text;

  const _IntroCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Text(text, style: theme.textTheme.p.copyWith(height: 1.45)),
    );
  }
}

class _HighlightInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _HighlightInfoCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      radius: const BorderRadius.all(Radius.circular(18)),
      padding: const EdgeInsets.all(14),
      border: ShadBorder.all(color: theme.colorScheme.border),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.large.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.muted.copyWith(height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterNoteCard extends StatelessWidget {
  final String text;

  const _FooterNoteCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_rounded, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.p.copyWith(
                color: theme.colorScheme.mutedForeground,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
