import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/glass_card.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';
import 'package:my_portfolio/app/widgets/tech_chip.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      decoration: const BoxDecoration(
        color: AppColors.surface,
      ),
      child: ResponsiveLayout(
        child: Column(
          children: [
            SectionTitle(
              title: t.projects.title,
              subtitle: t.projects.subtitle,
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isMobile ? 1 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 1.15 : 1.05,
                  ),
                  itemCount: _projects.length,
                  itemBuilder: (context, index) =>
                      _ProjectCard(project: _projects[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final _ProjectData project;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: project.iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(project.icon, color: project.iconColor, size: 24),
              ),
              const Spacer(),
              if (project.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    project.badge!,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.success,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            project.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          Text(
            project.category,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              project.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 14),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: project.technologies
                .map((t) => TechChip(label: t))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (project.metric != null) ...[
                const Icon(
                  Icons.download_rounded,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  project.metric!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
              const Spacer(),
              if (project.links.isNotEmpty)
                ...project.links.map(
                  (link) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _LinkIcon(
                      icon: link.icon,
                      url: link.url,
                      tooltip: link.label,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkIcon extends HookWidget {
  const _LinkIcon({required this.icon, required this.url, this.tooltip = ''});

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        onEnter: (_) => hovered.value = true,
        onExit: (_) => hovered.value = false,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(url)),
          child: Icon(
            icon,
            size: 20,
            color: hovered.value ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _ProjectLink {
  const _ProjectLink({
    required this.label,
    required this.icon,
    required this.url,
  });
  final String label;
  final IconData icon;
  final String url;
}

class _ProjectData {
  const _ProjectData({
    required this.key,
    required this.technologies,
    required this.icon,
    required this.iconColor,
    this.links = const [],
  });

  final String key;
  final List<String> technologies;
  final IconData icon;
  final Color iconColor;
  final List<_ProjectLink> links;

  String get name {
    switch (key) {
      case 'magicSort':
        return t.projects.items.magicSort.name;
      case 'rabit':
        return t.projects.items.rabit.name;
      case 'cups':
        return t.projects.items.cups.name;
      case 'farmVsAliens':
        return t.projects.items.farmVsAliens.name;
      case 'capy':
        return t.projects.items.capy.name;
      case 'dropMerge':
        return t.projects.items.dropMerge.name;
      default:
        return key;
    }
  }

  String get category {
    switch (key) {
      case 'magicSort':
        return t.projects.items.magicSort.category;
      case 'rabit':
        return t.projects.items.rabit.category;
      case 'cups':
        return t.projects.items.cups.category;
      case 'farmVsAliens':
        return t.projects.items.farmVsAliens.category;
      case 'capy':
        return t.projects.items.capy.category;
      case 'dropMerge':
        return t.projects.items.dropMerge.category;
      default:
        return '';
    }
  }

  String get description {
    switch (key) {
      case 'magicSort':
        return t.projects.items.magicSort.description;
      case 'rabit':
        return t.projects.items.rabit.description;
      case 'cups':
        return t.projects.items.cups.description;
      case 'farmVsAliens':
        return t.projects.items.farmVsAliens.description;
      case 'capy':
        return t.projects.items.capy.description;
      case 'dropMerge':
        return t.projects.items.dropMerge.description;
      default:
        return '';
    }
  }

  String? get badge {
    switch (key) {
      case 'magicSort':
        return t.projects.items.magicSort.badge;
      case 'rabit':
        return t.projects.items.rabit.badge;
      case 'farmVsAliens':
        return t.projects.items.farmVsAliens.badge;
      default:
        return null;
    }
  }

  String? get metric {
    switch (key) {
      case 'magicSort':
        return t.projects.items.magicSort.metric;
      case 'rabit':
        return t.projects.items.rabit.metric;
      case 'cups':
        return t.projects.items.cups.metric;
      default:
        return null;
    }
  }
}

const _projects = <_ProjectData>[
  _ProjectData(
    key: 'magicSort',
    technologies: ['Flutter', 'Firebase', 'Riverpod'],
    icon: Icons.auto_awesome,
    iconColor: AppColors.primary,
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.magicsort',
      ),
    ],
  ),
  _ProjectData(
    key: 'rabit',
    technologies: ['Flutter', 'Firebase', 'Analytics'],
    icon: Icons.pets,
    iconColor: Color(0xFF22C55E),
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.rabito',
      ),
      _ProjectLink(
        label: 'App Store',
        icon: FontAwesomeIcons.appStoreIos,
        url:
            'https://apps.apple.com/us/app/rabit-daily-routine-planner/id1512605216',
      ),
    ],
  ),
  _ProjectData(
    key: 'cups',
    technologies: ['Flutter', 'Firebase', 'Ads SDK'],
    icon: Icons.local_drink_rounded,
    iconColor: Color(0xFF38BDF8),
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.cups',
      ),
      _ProjectLink(
        label: 'App Store',
        icon: FontAwesomeIcons.appStoreIos,
        url:
            'https://apps.apple.com/br/app/cups-water-sort-puzzle/id1541421297',
      ),
    ],
  ),
  _ProjectData(
    key: 'farmVsAliens',
    technologies: ['Unity', 'C#', 'Firebase'],
    icon: Icons.videogame_asset_rounded,
    iconColor: Color(0xFFF59E0B),
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url:
            'https://play.google.com/store/apps/details?id=com.blu.farmvsaliens',
      ),
    ],
  ),
  _ProjectData(
    key: 'capy',
    technologies: ['Flutter', 'Firebase'],
    icon: Icons.favorite_rounded,
    iconColor: Color(0xFFEC4899),
  ),
  _ProjectData(
    key: 'dropMerge',
    technologies: ['Flutter', 'Firebase'],
    icon: Icons.bubble_chart_rounded,
    iconColor: Color(0xFF8B5CF6),
  ),
];
