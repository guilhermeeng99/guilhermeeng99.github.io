import 'package:my_portfolio/app/app_constants.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

final $LibAppAssetsImagesProjectsGen _projectImages =
    Assets.lib.app.assets.images.projects;

class ProjectsSectionData {
  const ProjectsSectionData({
    required this.name,
    required this.category,
    required this.description,
    required this.details,
    required this.technologies,
    required this.image,
    required this.company,
    required this.downloadLink,
    this.badge,
    this.metric,
  });

  final String name;
  final String category;
  final String description;
  final String details;
  final String company;
  final String? badge;
  final String? metric;
  final List<String> technologies;
  final AssetGenImage image;
  final String downloadLink;

  static final List<ProjectsSectionData> projects = [
    magicSort,
    rabit,
    capy,
    cups,
    farmVsAliens,
    dropMerge,
  ];

  static final magicSort = ProjectsSectionData(
    name: t.projects.items.magicSort.name,
    category: t.projects.items.magicSort.category,
    description: t.projects.items.magicSort.description,
    details: t.projects.items.magicSort.details,
    badge: t.projects.items.magicSort.badge,
    metric: t.projects.items.magicSort.metric,
    technologies: const ['Flutter', 'Firebase', 'Riverpod'],
    image: _projectImages.magicSortPreview,
    downloadLink: AppConstants.magicSortUrl,
    company: AppConstants.bluCompany,
  );

  static final rabit = ProjectsSectionData(
    name: t.projects.items.rabit.name,
    category: t.projects.items.rabit.category,
    description: t.projects.items.rabit.description,
    details: t.projects.items.rabit.details,
    badge: t.projects.items.rabit.badge,
    metric: t.projects.items.rabit.metric,
    technologies: const ['Flutter', 'Firebase', 'Analytics'],
    image: _projectImages.rabitPreview,
    downloadLink: AppConstants.rabitUrl,
    company: AppConstants.bluCompany,
  );

  static final cups = ProjectsSectionData(
    name: t.projects.items.cups.name,
    category: t.projects.items.cups.category,
    description: t.projects.items.cups.description,
    details: t.projects.items.cups.details,
    metric: t.projects.items.cups.metric,
    technologies: const ['Flutter', 'Firebase', 'Ads SDK'],
    image: _projectImages.cupsPreview,
    downloadLink: AppConstants.cupsUrl,
    company: AppConstants.bluCompany,
  );

  static final farmVsAliens = ProjectsSectionData(
    name: t.projects.items.farmVsAliens.name,
    category: t.projects.items.farmVsAliens.category,
    description: t.projects.items.farmVsAliens.description,
    details: t.projects.items.farmVsAliens.details,
    badge: t.projects.items.farmVsAliens.badge,
    technologies: const ['Unity', 'C#', 'Firebase'],
    image: _projectImages.farmPreview,
    downloadLink: AppConstants.farmUrl,
    company: AppConstants.bluCompany,
  );

  static final capy = ProjectsSectionData(
    name: t.projects.items.capy.name,
    category: t.projects.items.capy.category,
    description: t.projects.items.capy.description,
    details: t.projects.items.capy.details,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.capyPreview,
    downloadLink: AppConstants.capyUrl,
    company: AppConstants.bluCompany,
  );

  static final dropMerge = ProjectsSectionData(
    name: t.projects.items.dropMerge.name,
    category: t.projects.items.dropMerge.category,
    description: t.projects.items.dropMerge.description,
    details: t.projects.items.dropMerge.details,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.dropPreview,
    company: AppConstants.bluCompany,
    downloadLink: AppConstants.dropAndMergeUrl,
  );
}
