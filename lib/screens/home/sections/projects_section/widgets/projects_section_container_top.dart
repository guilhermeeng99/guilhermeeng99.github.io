import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/tech_chip.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSectionProjectContent extends StatelessWidget {
  const ProjectsSectionProjectContent({required this.project, super.key});

  final ProjectsSectionData project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            height: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: project.technologies
              .map((tech) => TechChip(label: tech))
              .toList(),
        ),
        const SizedBox(height: 14),
        _DownloadLink(project: project),
        const SizedBox(height: 14),
        const Divider(color: AppColors.divider, height: 1),
        _SeeMoreDetails(project: project),
      ],
    );
  }
}

class _DownloadLink extends HookWidget {
  const _DownloadLink({required this.project});

  final ProjectsSectionData project;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(project.downloadLink)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: hovered.value
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.surfaceLight,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: hovered.value
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 14,
                color: hovered.value
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                'Download',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: hovered.value
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeeMoreDetails extends HookWidget {
  const _SeeMoreDetails({required this.project});

  final ProjectsSectionData project;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);
    final hovered = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) => hovered.value = true,
          onExit: (_) => hovered.value = false,
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => expanded.value = !expanded.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Text(
                    t.projects.details_button,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: hovered.value
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: expanded.value ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: hovered.value
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: AppColors.cardBorder.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              project.details,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          crossFadeState: expanded.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
          sizeCurve: Curves.easeOut,
        ),
      ],
    );
  }
}
