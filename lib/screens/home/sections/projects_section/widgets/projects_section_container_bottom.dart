import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section_model.dart';

const _kBadgeRadius = BorderRadius.all(Radius.circular(16));

class ProjectsSectionProjectImage extends StatelessWidget {
  const ProjectsSectionProjectImage({
    required this.project,
    required this.isHovered,
    super.key,
  });

  final ProjectsSectionData project;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: Stack(
            fit: StackFit.expand,
            children: [
              project.image.image(
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.5),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.75),
              borderRadius: _kBadgeRadius,
            ),
            child: Text(
              project.company,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
        if (project.metric != null)
          Positioned(
            left: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.85),
                borderRadius: _kBadgeRadius,
              ),
              child: Text(
                '${project.metric} downloads',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
