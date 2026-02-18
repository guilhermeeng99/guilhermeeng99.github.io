import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/screens/home/sections/resume_section/resume_model.dart';

class ResumeSectionEducationTimelineItem extends StatelessWidget {
  const ResumeSectionEducationTimelineItem({
    required this.education,
    required this.isLast,
    super.key,
  });

  final EducationData education;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isLast)
          Positioned(
            left: 6,
            top: 14,
            bottom: 0,
            child: Container(
              width: 2,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(width: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      education.period,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      education.degree,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${education.institution} · ${education.location}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...education.points.map(
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
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
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
      ],
    );
  }
}
