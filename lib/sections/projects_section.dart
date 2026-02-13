import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/section_title.dart';
import '../widgets/tech_chip.dart';

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
            const SectionTitle(
              title: 'Featured Projects',
              subtitle: 'Real-world products across games and mobile apps',
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: project.technologies.map((t) => TechChip(label: t)).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (project.metric != null) ...[
                Icon(Icons.download_rounded, size: 16, color: AppColors.textMuted),
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
                ...project.links.map((link) => Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _LinkIcon(
                        icon: link.icon,
                        url: link.url,
                        tooltip: link.label,
                      ),
                    )),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkIcon extends StatefulWidget {
  const _LinkIcon({required this.icon, required this.url, this.tooltip = ''});

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  State<_LinkIcon> createState() => _LinkIconState();
}

class _LinkIconState extends State<_LinkIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: Icon(
            widget.icon,
            size: 20,
            color: _hovered ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _ProjectLink {
  const _ProjectLink({required this.label, required this.icon, required this.url});
  final String label;
  final IconData icon;
  final String url;
}

class _ProjectData {
  const _ProjectData({
    required this.name,
    required this.category,
    required this.description,
    required this.technologies,
    required this.icon,
    required this.iconColor,
    this.badge,
    this.metric,
    this.links = const [],
  });

  final String name;
  final String category;
  final String description;
  final List<String> technologies;
  final IconData icon;
  final Color iconColor;
  final String? badge;
  final String? metric;
  final List<_ProjectLink> links;
}

const _projects = <_ProjectData>[
  _ProjectData(
    name: 'Magic Sort',
    category: 'Hybrid Casual Puzzle · 2024 – Present',
    description:
        'First hybrid casual water-sort puzzle game on the market. Designed complex/high-performance UI systems, monetization flows, and live-event mechanics.',
    technologies: ['Flutter', 'Firebase', 'Riverpod'],
    icon: Icons.auto_awesome,
    iconColor: AppColors.primary,
    badge: '480K+ downloads',
    metric: '480K+',
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.magicsort',
      ),
    ],
  ),
  _ProjectData(
    name: 'Rabit',
    category: 'Gamified Habit Tracker · 2020 – 2022',
    description:
        'Google Play Best of 2021 – App of the Year Nominee. Implemented gamified habit tracking with notifications, cloud sync, and analytics.',
    technologies: ['Flutter', 'Firebase', 'Analytics'],
    icon: Icons.pets,
    iconColor: Color(0xFF22C55E),
    badge: 'Best of 2021',
    metric: '3.5M+',
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.rabito',
      ),
      _ProjectLink(
        label: 'App Store',
        icon: FontAwesomeIcons.appStoreIos,
        url: 'https://apps.apple.com/us/app/rabit-daily-routine-planner/id1512605216',
      ),
    ],
  ),
  _ProjectData(
    name: 'Cups',
    category: 'Casual Puzzle · 2020 – 2023',
    description:
        'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Implemented UIs, monetization systems, and full ads integration.',
    technologies: ['Flutter', 'Firebase', 'Ads SDK'],
    icon: Icons.local_drink_rounded,
    iconColor: Color(0xFF38BDF8),
    metric: '4.5M+',
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.cups',
      ),
      _ProjectLink(
        label: 'App Store',
        icon: FontAwesomeIcons.appStoreIos,
        url: 'https://apps.apple.com/br/app/cups-water-sort-puzzle/id1541421297',
      ),
    ],
  ),
  _ProjectData(
    name: 'Farm vs Aliens',
    category: 'Tower Defense · 2023 – 2024',
    description:
        'Winner of the Google Play Indie Games Fund 2024. Led product direction, game design, and monetization strategy for this merge tower defense game.',
    technologies: ['Unity', 'C#', 'Firebase'],
    icon: Icons.videogame_asset_rounded,
    iconColor: Color(0xFFF59E0B),
    badge: 'Indie Fund Winner',
    links: [
      _ProjectLink(
        label: 'Google Play',
        icon: FontAwesomeIcons.googlePlay,
        url: 'https://play.google.com/store/apps/details?id=com.blu.farmvsaliens',
      ),
    ],
  ),
  _ProjectData(
    name: 'Capy: Self-Care Pet',
    category: 'Wellness App',
    description:
        'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.',
    technologies: ['Flutter', 'Firebase'],
    icon: Icons.favorite_rounded,
    iconColor: Color(0xFFEC4899),
    links: [],
  ),
  _ProjectData(
    name: 'Drop & Merge',
    category: 'Casual Puzzle',
    description:
        'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.',
    technologies: ['Flutter', 'Firebase'],
    icon: Icons.bubble_chart_rounded,
    iconColor: Color(0xFF8B5CF6),
    links: [],
  ),
];
