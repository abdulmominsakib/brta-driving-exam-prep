import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'why_section_card.dart';

class DeveloperInfoSection extends StatelessWidget {
  const DeveloperInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return WhySectionCard(
      title: 'ডেভেলপার পরিচিতি',
      icon: HugeIcons.strokeRoundedUser,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://momin.pro/mominpro_logo-min.webp',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 24,
                  backgroundImage: imageProvider,
                  backgroundColor: ShadTheme.of(context).colorScheme.background,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 24,
                  backgroundColor: ShadTheme.of(context).colorScheme.background,
                  child: Text('👨‍💻', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'মুমিন',
                    style: ShadTheme.of(
                      context,
                    ).textTheme.large.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ফুল-স্ট্যাক মোবাইল ডেভেলপার',
                    style: ShadTheme.of(context).textTheme.muted,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'আমি দীর্ঘদিন ধরে মোবাইল অ্যাপ ও ওয়েব সলিউশন নিয়ে কাজ করছি। এই অ্যাপটি তৈরি করার পেছনে মূল লক্ষ্য হলো—প্রযুক্তির মাধ্যমে মানুষের উপকার করা এবং সচেতনতা বৃদ্ধি করা।',
            style: ShadTheme.of(context).textTheme.p,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialLink(
                context,
                icon: HugeIcons.strokeRoundedGlobe02,
                url: 'https://momin.pro',
                label: 'Website',
              ),
              _buildSocialLink(
                context,
                icon: HugeIcons.strokeRoundedGithub,
                url: 'https://github.com/abdulmominsakib',
                label: 'GitHub',
              ),
              _buildSocialLink(
                context,
                icon: HugeIcons.strokeRoundedLinkedin02,
                url: 'https://www.linkedin.com/in/abdul-momin-sakib/',
                label: 'LinkedIn',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(
    BuildContext context, {
    required dynamic icon,
    required String url,
    required String label,
  }) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: ShadTheme.of(context).colorScheme.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            HugeIcon(
              icon: icon,
              color: ShadTheme.of(context).colorScheme.foreground,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: ShadTheme.of(context).colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
