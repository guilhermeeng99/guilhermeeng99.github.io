import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      child: ResponsiveLayout(
        child: Column(
          children: [
            const SectionTitle(
              title: 'Experience',
              subtitle: 'My professional journey so far',
            ),
            ...List.generate(_experiences.length, (index) {
              return _TimelineItem(
                experience: _experiences[index],
                isLast: index == _experiences.length - 1,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.experience, required this.isLast});

  final _ExperienceData experience;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) ...[
            SizedBox(
              width: 140,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      experience.period,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.location,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
          ],
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.4),
                          AppColors.primary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isMobile) ...[
                    Text(
                      experience.period,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    experience.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${experience.company}${isMobile ? ' · ${experience.location}' : ''}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...experience.points.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              point,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceData {
  const _ExperienceData({
    required this.title,
    required this.company,
    required this.period,
    required this.location,
    required this.points,
  });

  final String title;
  final String company;
  final String period;
  final String location;
  final List<String> points;
}

const _experiences = <_ExperienceData>[
  _ExperienceData(
    title: 'Partner & Pleno Flutter Engineer',
    company: 'Blu Studios',
    period: '2019 – 2026',
    location: 'Remote',
    points: [
      'Built and maintained multiple mobile apps and games totaling 15M+ downloads worldwide.',
      'Architected scalable systems supporting millions of users, including real-time leaderboards, live events, and ranking systems.',
      'Owned the full mobile product lifecycle: architecture, development, testing, CI/CD, publishing, ASO, monetization, live ops, and store compliance.',
      'Integrated backend services using Firebase (Full Suite), GraphQL APIs, and Node.js.',
      'Designed and optimized monetization systems achieving consistently high eCPM performance.',
      'Led fully remote teams of up to 14 people.',
      'Established partnerships with Wildlife Studios and Homa Games.',
    ],
  ),
  _ExperienceData(
    title: 'Junior Desktop Developer',
    company: 'VX Case',
    period: 'Oct 2018 – Mar 2019',
    location: 'Salvador, Brazil',
    points: [
      'Developed a desktop application focused on user interface implementation using TypeScript, Angular, and VTEX.',
      'Built reusable UI components ensuring usability, scalability, and design consistency.',
      'Collaborated with senior engineers to integrate frontend features with backend services.',
    ],
  ),
  _ExperienceData(
    title: 'IT Support Intern',
    company: 'Tecall Consultoria',
    period: 'Jan 2018 – Oct 2018',
    location: 'Salvador, Brazil',
    points: [
      'Provided technical support and infrastructure troubleshooting for corporate clients.',
      'Assisted in system maintenance and hardware configuration.',
      'Gained foundational experience in networking, system administration, and customer support.',
    ],
  ),
];
