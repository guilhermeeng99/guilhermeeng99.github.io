import 'package:my_portfolio/app/app_constants.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

final $LibAppAssetsImagesProjectsGen _projectImages =
    Assets.lib.app.assets.images.projects;

enum ProjectCompany {
  bluStudios
  ;

  String get name {
    switch (this) {
      case ProjectCompany.bluStudios:
        return AppConstants.bluCompany;
    }
  }

  String get url {
    switch (this) {
      case ProjectCompany.bluStudios:
        return AppConstants.bluCompanyUrl;
    }
  }
}

enum ProjectAward {
  indieGamesAccelerator2024,
  indieGamesFund2023,
  googlePlayBestOf2021
  ;

  String get label {
    switch (this) {
      case ProjectAward.indieGamesAccelerator2024:
        return t.projects.items.magic_sort.award;
      case ProjectAward.indieGamesFund2023:
        return t.projects.items.farm_vs_aliens.award;
      case ProjectAward.googlePlayBestOf2021:
        return t.projects.items.rabit.award;
    }
  }

  String get url {
    switch (this) {
      case ProjectAward.indieGamesAccelerator2024:
        return AppConstants.googlePlayIndieGamesAccelerator2024Url;
      case ProjectAward.indieGamesFund2023:
        return AppConstants.googlePlayIndieGamesFund2023Url;
      case ProjectAward.googlePlayBestOf2021:
        return AppConstants.googlePlayBestOf2021Url;
    }
  }
}

class ProjectsSectionData {
  const ProjectsSectionData({
    required this.name,
    required this.description,
    required this.details,
    required this.technologies,
    required this.image,
    required this.company,
    required this.downloadLink,

    this.metric,
    this.award,
  });

  final String name;
  final String description;
  final String details;
  final ProjectCompany company;

  final String? metric;
  final ProjectAward? award;
  final List<String> technologies;
  final AssetGenImage image;
  final String downloadLink;

  static final List<ProjectsSectionData> projects = [
    _magicSort,
    _rabit,
    _capy,
    _cups,
    _farmVsAliens,
    _dropMerge,
  ];

  static final List<ProjectsSectionData> otherProjects = [
    _vdx,
    _booze,
    _neverHaveIEverX,
  ];

  static final _magicSort = ProjectsSectionData(
    name: t.projects.items.magic_sort.name,
    description: t.projects.items.magic_sort.description,
    details: t.projects.items.magic_sort.details,
    metric: t.projects.items.magic_sort.metric,
    award: ProjectAward.indieGamesAccelerator2024,
    technologies: const ['Flutter', 'Firebase', 'Riverpod'],
    image: _projectImages.magicSortPreview,
    downloadLink: AppConstants.magicSortUrl,
    company: ProjectCompany.bluStudios,
  );

  static final _rabit = ProjectsSectionData(
    name: t.projects.items.rabit.name,
    description: t.projects.items.rabit.description,
    details: t.projects.items.rabit.details,
    metric: t.projects.items.rabit.metric,
    award: ProjectAward.googlePlayBestOf2021,
    technologies: const ['Flutter', 'Firebase', 'Analytics'],
    image: _projectImages.rabitPreview,
    downloadLink: AppConstants.rabitUrl,
    company: ProjectCompany.bluStudios,
  );

  static final _cups = ProjectsSectionData(
    name: t.projects.items.cups.name,
    description: t.projects.items.cups.description,
    details: t.projects.items.cups.details,
    metric: t.projects.items.cups.metric,
    technologies: const ['Flutter', 'Firebase', 'Ads SDK'],
    image: _projectImages.cupsPreview,
    downloadLink: AppConstants.cupsUrl,
    company: ProjectCompany.bluStudios,
  );

  static final _farmVsAliens = ProjectsSectionData(
    name: t.projects.items.farm_vs_aliens.name,
    description: t.projects.items.farm_vs_aliens.description,
    details: t.projects.items.farm_vs_aliens.details,
    award: ProjectAward.indieGamesFund2023,
    technologies: const ['Unity', 'C#', 'Firebase'],
    image: _projectImages.farmPreview,
    downloadLink: AppConstants.farmUrl,
    company: ProjectCompany.bluStudios,
  );

  static final _capy = ProjectsSectionData(
    name: t.projects.items.capy.name,
    description: t.projects.items.capy.description,
    details: t.projects.items.capy.details,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.capyPreview,
    downloadLink: AppConstants.capyUrl,
    company: ProjectCompany.bluStudios,
  );

  static final _dropMerge = ProjectsSectionData(
    name: t.projects.items.drop_merge.name,
    description: t.projects.items.drop_merge.description,
    details: t.projects.items.drop_merge.details,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.dropPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.dropAndMergeUrl,
  );

  static final _neverHaveIEverX = ProjectsSectionData(
    name: t.projects.items.never_have_i_ever_x.name,
    description: t.projects.items.never_have_i_ever_x.description,
    details: t.projects.items.never_have_i_ever_x.details,
    metric: t.projects.items.never_have_i_ever_x.metric,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.iNeverPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.neverHaveIEverXUrl,
  );

  static final _booze = ProjectsSectionData(
    name: t.projects.items.booze.name,
    description: t.projects.items.booze.description,
    details: t.projects.items.booze.details,
    metric: t.projects.items.booze.metric,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.boozePreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.boozeUrl,
  );

  static final _vdx = ProjectsSectionData(
    name: t.projects.items.vdx.name,
    description: t.projects.items.vdx.description,
    details: t.projects.items.vdx.details,
    metric: t.projects.items.vdx.metric,
    technologies: const ['Flutter', 'Firebase'],
    image: _projectImages.vdxPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.vdxUrl,
  );
}
