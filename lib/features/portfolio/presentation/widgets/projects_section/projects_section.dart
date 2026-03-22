import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/features/portfolio/domain/entities/project_data.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/projects_section/widgets/project_content.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/projects_section/widgets/project_image.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

const _kCardRadius = BorderRadius.all(Radius.circular(20));

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isOtherExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final remote = context.read<RemoteConstants>();
    final projects = ProjectsSectionData.projects(remote);
    final otherProjects = ProjectsSectionData.otherProjects(remote);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      decoration: BoxDecoration(color: context.appColors.surface),
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
              isExpanded: _isOtherExpanded,
              onTap: () => setState(
                () => _isOtherExpanded = !_isOtherExpanded,
              ),
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
              crossFadeState: _isOtherExpanded
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

class _OtherProjectsToggle extends StatefulWidget {
  const _OtherProjectsToggle({
    required this.isExpanded,
    required this.onTap,
  });

  final bool isExpanded;
  final VoidCallback onTap;

  @override
  State<_OtherProjectsToggle> createState() => _OtherProjectsToggleState();
}

class _OtherProjectsToggleState extends State<_OtherProjectsToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? context.appColors.primary.withValues(alpha: 0.12)
                : context.appColors.surfaceLight.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: _hovered
                  ? context.appColors.primary.withValues(alpha: 0.4)
                  : context.appColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                t.projects.other_projects_toggle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: _hovered
                      ? context.appColors.primary
                      : context.appColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: widget.isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: _hovered
                      ? context.appColors.primary
                      : context.appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final ProjectsSectionData project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: context.appColors.cardGradient,
          borderRadius: _kCardRadius,
          border: Border.all(
            color: _hovered
                ? context.appColors.primary.withValues(alpha: 0.4)
                : context.appColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: context.appColors.primary.withValues(alpha: 0.08),
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
                  project: widget.project,
                  isHovered: _hovered,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: ProjectsSectionProjectContent(
                  project: widget.project,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
