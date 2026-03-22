// ignore_for_file: prefer_constructors_over_static_methods

import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

final $LibAppAssetsImagesProjectsGen _projectImages =
    Assets.lib.app.assets.images.projects;

enum ProjectCompany {
  bluStudios(
    name: AppConstants.bluCompany,
    url: AppConstants.bluCompanyUrl,
  )
  ;

  const ProjectCompany({required this.name, required this.url});

  final String name;
  final String url;
}

class ProjectAward {
  const ProjectAward({
    required this.label,
    required this.awardUrl,
  });

  final String label;
  final String awardUrl;
}

class ProjectsSectionData {
  const ProjectsSectionData({
    required this.name,
    required this.description,
    required this.details,
    required this.technologies,
    required this.image,
    this.downloadLink,
    this.company,

    this.metric,
    this.award,
  });

  final String name;
  final String description;
  final String details;
  final ProjectCompany? company;

  final String? metric;
  final ProjectAward? award;
  final List<String> technologies;
  final AssetGenImage image;
  final String? downloadLink;

  static List<ProjectsSectionData> projects(RemoteConstants remote) => [
    _magicSort(remote),
    _rabit(remote),
    _capy(remote),
    _cups(remote),
    _farmVsAliens(remote),
    _dropMerge(remote),
  ];

  static List<ProjectsSectionData> otherProjects(RemoteConstants remote) => [
    _vdx(remote),
    _flutterBase,
    _financo,
    _bluBi,
    _booze(remote),
    _neverHaveIEverX(remote),
  ];

  static ProjectsSectionData _magicSort(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.magic_sort.name,
        description: t.projects.items.magic_sort.description,
        details: t.projects.items.magic_sort.details,
        metric: t.projects.items.magic_sort.metric,
        award: ProjectAward(
          label: t.projects.items.magic_sort.award,
          awardUrl: remote.googlePlayIndieGamesAccelerator2024Url,
        ),
        technologies: const ['Flutter', 'Firebase', 'Riverpod'],
        image: _projectImages.magicSortPreview,
        downloadLink: remote.magicSortUrl,
        company: ProjectCompany.bluStudios,
      );

  static ProjectsSectionData _rabit(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.rabit.name,
        description: t.projects.items.rabit.description,
        details: t.projects.items.rabit.details,
        metric: t.projects.items.rabit.metric,
        award: ProjectAward(
          label: t.projects.items.rabit.award,
          awardUrl: remote.googlePlayBestOf2021Url,
        ),
        technologies: const ['Flutter', 'Firebase', 'Analytics'],
        image: _projectImages.rabitPreview,
        downloadLink: remote.rabitUrl,
        company: ProjectCompany.bluStudios,
      );

  static ProjectsSectionData _cups(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.cups.name,
        description: t.projects.items.cups.description,
        details: t.projects.items.cups.details,
        metric: t.projects.items.cups.metric,
        technologies: const ['Flutter', 'Firebase', 'Ads SDK'],
        image: _projectImages.cupsPreview,
        downloadLink: remote.cupsUrl,
        company: ProjectCompany.bluStudios,
      );

  static ProjectsSectionData _farmVsAliens(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.farm_vs_aliens.name,
        description: t.projects.items.farm_vs_aliens.description,
        details: t.projects.items.farm_vs_aliens.details,
        award: ProjectAward(
          label: t.projects.items.farm_vs_aliens.award,
          awardUrl: remote.googlePlayIndieGamesFund2023Url,
        ),
        technologies: const ['Unity', 'C#', 'Firebase'],
        image: _projectImages.farmPreview,
        downloadLink: remote.farmUrl,
        company: ProjectCompany.bluStudios,
      );

  static ProjectsSectionData _capy(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.capy.name,
        description: t.projects.items.capy.description,
        details: t.projects.items.capy.details,
        technologies: const ['Flutter', 'Firebase'],
        image: _projectImages.capyPreview,
        downloadLink: remote.capyUrl,
        company: ProjectCompany.bluStudios,
      );

  static ProjectsSectionData _dropMerge(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.drop_merge.name,
        description: t.projects.items.drop_merge.description,
        details: t.projects.items.drop_merge.details,
        technologies: const ['Flutter', 'Firebase'],
        image: _projectImages.dropPreview,
        company: ProjectCompany.bluStudios,
        downloadLink: remote.dropAndMergeUrl,
      );

  static ProjectsSectionData _neverHaveIEverX(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.never_have_i_ever_x.name,
        description: t.projects.items.never_have_i_ever_x.description,
        details: t.projects.items.never_have_i_ever_x.details,
        metric: t.projects.items.never_have_i_ever_x.metric,
        technologies: const ['Flutter', 'Firebase'],
        image: _projectImages.iNeverPreview,
        company: ProjectCompany.bluStudios,
        downloadLink: remote.neverHaveIEverXUrl,
      );

  static ProjectsSectionData _booze(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.booze.name,
        description: t.projects.items.booze.description,
        details: t.projects.items.booze.details,
        metric: t.projects.items.booze.metric,
        technologies: const ['Flutter', 'Firebase'],
        image: _projectImages.boozePreview,
        company: ProjectCompany.bluStudios,
        downloadLink: remote.boozeUrl,
      );

  static ProjectsSectionData _vdx(RemoteConstants remote) =>
      ProjectsSectionData(
        name: t.projects.items.vdx.name,
        description: t.projects.items.vdx.description,
        details: t.projects.items.vdx.details,
        metric: t.projects.items.vdx.metric,
        technologies: const ['Flutter', 'Firebase'],
        image: _projectImages.vdxPreview,
        company: ProjectCompany.bluStudios,
        downloadLink: remote.vdxUrl,
      );

  static final _flutterBase = ProjectsSectionData(
    name: t.projects.items.flutter_base.name,
    description: t.projects.items.flutter_base.description,
    details: t.projects.items.flutter_base.details,
    technologies: const ['Flutter', 'Riverpod', 'SOLID'],
    image: _projectImages.flutterBasePreview,
    downloadLink: AppConstants.flutterBaseUrl,
  );

  static final _financo = ProjectsSectionData(
    name: t.projects.items.financo.name,
    description: t.projects.items.financo.description,
    details: t.projects.items.financo.details,
    technologies: const ['Flutter', 'GetX'],
    image: _projectImages.financoPreview,
    downloadLink: AppConstants.financoUrl,
  );

  static final _bluBi = ProjectsSectionData(
    name: t.projects.items.blu_bi.name,
    description: t.projects.items.blu_bi.description,
    details: t.projects.items.blu_bi.details,
    technologies: const ['Flutter', 'GetX'],
    image: _projectImages.bluBiPreview,
  );
}
