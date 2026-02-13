import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_title.dart';

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
            const SectionTitle(
              title: 'About Me',
              subtitle: 'Building digital products that scale',
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
          'Pleno Flutter Developer with over five years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Text(
          'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 15M+ downloads worldwide.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Text(
          'I specialize in scalable architectures, long-term code maintainability, and high-performance mobile applications. My expertise spans multiple state management solutions (Riverpod, Bloc, MobX), native plugin integration, and the full Firebase ecosystem.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context, bool isMobile) {
    final stats = [
      _StatData('15M+', 'Downloads'),
      _StatData('5+', 'Years Experience'),
      _StatData('7+', 'Products Shipped'),
      _StatData('14', 'Max Team Size Led'),
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
