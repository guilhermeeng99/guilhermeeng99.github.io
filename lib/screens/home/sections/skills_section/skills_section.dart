import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/glass_card.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:my_portfolio/screens/home/sections/skills_section/skills_model.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final categories = SkillsSectionCategory.categories;

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      decoration: const BoxDecoration(color: AppColors.surface),
      child: ResponsiveLayout(
        child: Column(
          children: [
            SectionTitle(
              title: t.skills.title,
              subtitle: t.skills.subtitle,
            ),
            if (isMobile)
              ...categories.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _SkillCategoryCard(category: cat),
                ),
              )
            else
              for (int i = 0; i < categories.length; i += 2)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: i + 2 < categories.length ? 24 : 0,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _SkillCategoryCard(
                            category: categories[i],
                          ),
                        ),
                        if (i + 1 < categories.length) ...[
                          const SizedBox(width: 24),
                          Expanded(
                            child: _SkillCategoryCard(
                              category: categories[i + 1],
                            ),
                          ),
                        ] else
                          const Spacer(),
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

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final SkillsSectionCategory category;

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
              Expanded(
                child: Text(
                  category.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
