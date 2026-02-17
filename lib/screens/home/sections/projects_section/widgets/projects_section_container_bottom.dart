import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/tech_chip.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section_model.dart';
import 'package:url_launcher/url_launcher.dart';

const _kBadgeRadius = BorderRadius.all(Radius.circular(16));
const _kBadgePadding = EdgeInsets.symmetric(horizontal: 10, vertical: 4);

class ProjectsSectionProjectContent extends StatelessWidget {
  const ProjectsSectionProjectContent({required this.project, super.key});

  final ProjectsSectionData project;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            Flexible(
              child: Text(
                project.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (!isMobile) ...[
              if (project.award != null) _AwardBadge(award: project.award!),
              if (project.metric != null) _MetricBadge(metric: project.metric!),
            ],
          ],
        ),
        if (isMobile) ...[
          if (project.award != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _AwardBadge(award: project.award!),
            ),
          if (project.metric != null)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: _MetricBadge(metric: project.metric!),
            ),
        ],
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: hovered.value
                ? const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  )
                : null,
            color: hovered.value
                ? null
                : AppColors.primary.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: hovered.value
                  ? Colors.transparent
                  : AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: hovered.value ? Colors.white : AppColors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                t.projects.view_on_store,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: hovered.value ? Colors.white : AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
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
            child: Container(
              color: Colors.transparent,
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

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.metric});

  final String metric;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 11,
    );

    return Container(
      padding: _kBadgePadding,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.85),
        borderRadius: _kBadgeRadius,
      ),
      child: Text('$metric downloads', style: labelStyle),
    );
  }
}

class _AwardBadge extends StatelessWidget {
  const _AwardBadge({required this.award});

  final ProjectAward award;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: const Color(0xFF1A1A1A),
      fontWeight: FontWeight.w700,
      fontSize: 11,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(award.url)),
        child: Container(
          padding: _kBadgePadding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFFD700).withValues(alpha: 0.85),
                const Color(0xFFFFA500).withValues(alpha: 0.85),
              ],
            ),
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
                size: 12,
                color: Color(0xFF1A1A1A),
              ),
              const SizedBox(width: 4),
              Text(award.label, style: labelStyle),
            ],
          ),
        ),
      ),
    );
  }
}
