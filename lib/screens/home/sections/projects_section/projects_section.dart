import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/projects_section_model.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/widgets/projects_section_container_bottom.dart';
import 'package:my_portfolio/screens/home/sections/projects_section/widgets/projects_section_container_top.dart';

const _kCardRadius = BorderRadius.all(Radius.circular(20));

class ProjectsSection extends HookWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final projects = ProjectsSectionData.projects;
    final otherProjects = ProjectsSectionData.otherProjects;
    final isOtherExpanded = useState(false);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      decoration: const BoxDecoration(color: AppColors.surface),
      child: ResponsiveLayout(
        child: Column(
          children: [
            SectionTitle(
              title: t.projects.title,
              subtitle: t.projects.subtitle,
            ),
            _ProjectsGrid(projects: projects, isMobile: isMobile),
            const SizedBox(height: 40),
            _OtherProjectsToggle(
              isExpanded: isOtherExpanded.value,
              onTap: () => isOtherExpanded.value = !isOtherExpanded.value,
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: _ProjectsGrid(
                  projects: otherProjects,
                  isMobile: isMobile,
                ),
              ),
              crossFadeState: isOtherExpanded.value
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.projects, required this.isMobile});

  final List<ProjectsSectionData> projects;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          for (int i = 0; i < projects.length; i++) ...[
            _ProjectCard(project: projects[i]),
            if (i < projects.length - 1) const SizedBox(height: 24),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              for (int i = 0; i < projects.length; i += 2) ...[
                _ProjectCard(project: projects[i]),
                if (i + 2 < projects.length) const SizedBox(height: 24),
              ],
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            children: [
              for (int i = 1; i < projects.length; i += 2) ...[
                _ProjectCard(project: projects[i]),
                if (i + 2 < projects.length) const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _OtherProjectsToggle extends HookWidget {
  const _OtherProjectsToggle({
    required this.isExpanded,
    required this.onTap,
  });

  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: hovered.value
                ? AppColors.primary.withValues(alpha: 0.12)
                : AppColors.surfaceLight.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: hovered.value
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.projects.otherProjectsToggle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: hovered.value
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
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
    );
  }
}

class _ProjectCard extends HookWidget {
  const _ProjectCard({required this.project});

  final ProjectsSectionData project;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: _kCardRadius,
          border: Border.all(
            color: hovered.value
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.cardBorder,
          ),
          boxShadow: hovered.value
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: _kCardRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ProjectsSectionProjectImage(
                  project: project,
                  isHovered: hovered.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: ProjectsSectionProjectContent(project: project),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
