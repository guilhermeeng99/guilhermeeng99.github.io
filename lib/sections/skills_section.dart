import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      decoration: const BoxDecoration(color: AppColors.surface),
      child: ResponsiveLayout(
        child: Column(
          children: [
            const SectionTitle(
              title: 'Skills & Expertise',
              subtitle: 'Technologies and tools I use to bring ideas to life',
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isMobile ? 2.2 : 2.0,
              ),
              itemCount: _skillCategories.length,
              itemBuilder: (context, index) =>
                  _SkillCategoryCard(category: _skillCategories[index]),
            ),
            const SizedBox(height: 60),
            _buildAwardsRow(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardsRow(BuildContext context, bool isMobile) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'Awards & Recognition',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: const [
            _AwardBadge(
              icon: Icons.emoji_events_rounded,
              title: 'Google Play Best of 2021',
              subtitle: 'App of the Year Nominee (Rabit)',
              color: Color(0xFFF59E0B),
            ),
            _AwardBadge(
              icon: Icons.military_tech_rounded,
              title: 'Indie Games Fund 2023',
              subtitle: 'Winner (Farm vs Aliens)',
              color: Color(0xFFEF4444),
            ),
            _AwardBadge(
              icon: Icons.school_rounded,
              title: 'Indie Games Accelerator 2024',
              subtitle: 'Graduate',
              color: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final _SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Text(
                    skill,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AwardBadge extends StatelessWidget {
  const _AwardBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillCategory {
  const _SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });

  final String title;
  final IconData icon;
  final List<String> skills;
}

const _skillCategories = <_SkillCategory>[
  _SkillCategory(
    title: 'Mobile Development',
    icon: Icons.phone_android_rounded,
    skills: [
      'Flutter',
      'Dart',
      'Riverpod',
      'Bloc',
      'MobX',
      'MVVM',
      'Clean Architecture',
      'TDD',
      'Native Plugins',
    ],
  ),
  _SkillCategory(
    title: 'Backend & Cloud',
    icon: Icons.cloud_rounded,
    skills: [
      'Firebase (Full Suite)',
      'Node.js',
      'GraphQL',
      'REST APIs',
      'SQL',
      'NoSQL',
    ],
  ),
  _SkillCategory(
    title: 'Languages',
    icon: Icons.code_rounded,
    skills: ['Dart', 'Java', 'Kotlin', 'JavaScript', 'TypeScript', 'C#'],
  ),
  _SkillCategory(
    title: 'Tools & Product',
    icon: Icons.build_rounded,
    skills: [
      'Git',
      'CI/CD',
      'Figma',
      'ASO',
      'Monetization',
      'Codemagic',
      'GitHub Actions',
    ],
  ),
];
