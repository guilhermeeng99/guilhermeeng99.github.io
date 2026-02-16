import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section_model.dart';
import 'package:url_launcher/url_launcher.dart';

const _kBadgeRadius = BorderRadius.all(Radius.circular(16));
const _kBadgePadding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);

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
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

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
        _CompanyName(project: project, labelStyle: labelStyle),
        _Award(project: project, labelStyle: labelStyle),
        _Metric(project: project, labelStyle: labelStyle),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.project,
    required this.labelStyle,
  });

  final ProjectsSectionData project;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    if (project.metric == null) return const SizedBox.shrink();

    return Positioned(
      left: 12,
      top: 12,
      child: Container(
        padding: _kBadgePadding,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.85),
          borderRadius: _kBadgeRadius,
        ),
        child: Text(
          '${project.metric} downloads',
          style: labelStyle?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Award extends StatelessWidget {
  const _Award({
    required this.project,
    required this.labelStyle,
  });

  final ProjectsSectionData project;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    if (project.award == null) return const SizedBox.shrink();

    final kAwardGradient = LinearGradient(
      colors: [
        const Color(0xFFFFD700).withValues(alpha: 0.85),
        const Color(0xFFFFA500).withValues(alpha: 0.85),
      ],
    );

    return Positioned(
      left: 12,
      bottom: 12,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(project.award!.url)),
          child: Container(
            padding: _kBadgePadding,
            decoration: BoxDecoration(
              gradient: kAwardGradient,
              borderRadius: _kBadgeRadius,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40FFD700),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 14,
                  color: Color(0xFF1A1A1A),
                ),
                const SizedBox(width: 6),
                Text(
                  project.award!.label,
                  style: labelStyle?.copyWith(
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompanyName extends StatelessWidget {
  const _CompanyName({
    required this.project,
    required this.labelStyle,
  });

  final ProjectsSectionData project;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      top: 12,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(project.company.url)),
          child: Container(
            padding: _kBadgePadding,
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.75),
              borderRadius: _kBadgeRadius,
            ),
            child: Text(project.company.name, style: labelStyle),
          ),
        ),
      ),
    );
  }
}
