import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/glass_card.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      child: ResponsiveLayout(
        child: Column(
          children: [
            SectionTitle(
              title: t.about.title,
              subtitle: t.about.subtitle,
            ),
            if (isMobile) ...[
              _buildStats(context, isMobile),
              const SizedBox(height: 32),
              _buildBio(context),
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildBio(context)),
                  const SizedBox(width: 48),
                  Expanded(flex: 2, child: _buildStats(context, isMobile)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.about.bio1,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text(
          t.about.bio2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Text(
          t.about.bio3,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, bool isMobile) {
    final stats = [
      _StatData(t.about.stats.downloads.value, t.about.stats.downloads.label),
      _StatData(t.about.stats.experience.value, t.about.stats.experience.label),
      _StatData(t.about.stats.products.value, t.about.stats.products.label),
      _StatData(t.about.stats.teamSize.value, t.about.stats.teamSize.label),
    ];

    return Column(
      children: stats.map((stat) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    stat.value,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    stat.label,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatData {
  const _StatData(this.value, this.label);
  final String value;
  final String label;
}
