import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'components/guide_step_card.dart';
import '../data/guides_data.dart';

class BaseGuidePage extends StatefulWidget {
  final String id;
  final String title;
  final List<GuideSection> sections;
  final String imagePath;
  final String? backgroundImage;

  const BaseGuidePage({
    super.key,
    required this.id,
    required this.title,
    required this.sections,
    required this.imagePath,
    this.backgroundImage,
  });

  @override
  State<BaseGuidePage> createState() => _BaseGuidePageState();
}

class _BaseGuidePageState extends State<BaseGuidePage> {
  final Set<String> _expandedIds = {};

  void _toggleExpansion(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

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
                  widget.title,
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
                        right: -10,
                        top: -10,
                        child: Hero(
                          tag: 'guide-${widget.id}-image',
                          child: Opacity(
                            opacity: 0.1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                widget.imagePath,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            for (var i = 0; i < widget.sections.length; i++) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(
                        context,
                        widget.sections[i].title,
                        widget.sections[i].icon,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final step = widget.sections[i].steps[index];
                    final id = 'section-$i-step-$index';
                    return GuideStepCard(
                      step: step,
                      isLast: index == widget.sections[i].steps.length - 1,
                      isExpanded: _expandedIds.contains(id),
                      onTap: () => _toggleExpansion(id),
                    );
                  }, childCount: widget.sections[i].steps.length),
                ),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.h4.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
