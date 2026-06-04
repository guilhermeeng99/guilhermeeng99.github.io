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

  static List<ProjectsSectionData> projects() => [
    _magicSort(),
    _rabit(),
    _financo(),
    _capy(),
    _cups(),
    _farmVsAliens(),
  ];

  static List<ProjectsSectionData> otherProjects() => [
    _vdx(),
    _harvest(),
    _dropMerge(),
    _bluBi(),
    _booze(),
    _neverHaveIEverX(),
  ];

  static ProjectsSectionData _magicSort() => ProjectsSectionData(
    name: t.projects.items.magic_sort.name,
    description: t.projects.items.magic_sort.description,
    details: t.projects.items.magic_sort.details,
    metric: t.projects.items.magic_sort.metric,
    award: ProjectAward(
      label: t.projects.items.magic_sort.award,
      awardUrl: AppConstants.googlePlayIndieGamesAccelerator2024Url,
    ),
    technologies: const [
      'Flutter',
      'Firebase',
      'Riverpod',
      'GetX',
      'Remote Config',
    ],
    image: _projectImages.magicSortPreview,
    downloadLink: AppConstants.magicSortUrl,
    company: ProjectCompany.bluStudios,
  );

  static ProjectsSectionData _rabit() => ProjectsSectionData(
    name: t.projects.items.rabit.name,
    description: t.projects.items.rabit.description,
    details: t.projects.items.rabit.details,
    metric: t.projects.items.rabit.metric,
    award: ProjectAward(
      label: t.projects.items.rabit.award,
      awardUrl: AppConstants.googlePlayBestOf2021Url,
    ),
    technologies: const [
      'Flutter',
      'Firebase',
      'Firestore',
      'FCM',
      'GetX',
    ],
    image: _projectImages.rabitPreview,
    downloadLink: AppConstants.rabitUrl,
    company: ProjectCompany.bluStudios,
  );

  static ProjectsSectionData _cups() => ProjectsSectionData(
    name: t.projects.items.cups.name,
    description: t.projects.items.cups.description,
    details: t.projects.items.cups.details,
    metric: t.projects.items.cups.metric,
    technologies: const ['Flutter', 'Firebase', 'GetX', 'AdMob'],
    image: _projectImages.cupsPreview,
    downloadLink: AppConstants.cupsUrl,
    company: ProjectCompany.bluStudios,
  );

  static ProjectsSectionData _farmVsAliens() => ProjectsSectionData(
    name: t.projects.items.farm_vs_aliens.name,
    description: t.projects.items.farm_vs_aliens.description,
    details: t.projects.items.farm_vs_aliens.details,
    award: ProjectAward(
      label: t.projects.items.farm_vs_aliens.award,
      awardUrl: AppConstants.googlePlayIndieGamesFund2023Url,
    ),
    technologies: const ['Unity', 'C#', 'Firebase'],
    image: _projectImages.farmPreview,
    downloadLink: AppConstants.farmUrl,
    company: ProjectCompany.bluStudios,
  );

  static ProjectsSectionData _capy() => ProjectsSectionData(
    name: t.projects.items.capy.name,
    description: t.projects.items.capy.description,
    details: t.projects.items.capy.details,
    award: ProjectAward(
      label: t.projects.items.capy.award,
      awardUrl: AppConstants.capyArticleUrl,
    ),
    technologies: const [
      'Flutter',
      'Firebase',
      'Riverpod',
      'OpenAI',
    ],
    image: _projectImages.capyPreview,
    downloadLink: AppConstants.capyUrl,
    company: ProjectCompany.bluStudios,
  );

  static ProjectsSectionData _dropMerge() => ProjectsSectionData(
    name: t.projects.items.drop_merge.name,
    description: t.projects.items.drop_merge.description,
    details: t.projects.items.drop_merge.details,
    technologies: const ['Flutter', 'Firebase', 'GetX', 'AdMob'],
    image: _projectImages.dropPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.dropAndMergeUrl,
  );

  static ProjectsSectionData _neverHaveIEverX() => ProjectsSectionData(
    name: t.projects.items.never_have_i_ever_x.name,
    description: t.projects.items.never_have_i_ever_x.description,
    details: t.projects.items.never_have_i_ever_x.details,
    metric: t.projects.items.never_have_i_ever_x.metric,
    technologies: const ['Flutter', 'Firebase', 'GetX', 'AdMob'],
    image: _projectImages.iNeverPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.neverHaveIEverXUrl,
  );

  static ProjectsSectionData _booze() => ProjectsSectionData(
    name: t.projects.items.booze.name,
    description: t.projects.items.booze.description,
    details: t.projects.items.booze.details,
    metric: t.projects.items.booze.metric,
    technologies: const ['Flutter', 'Firebase', 'GetX', 'AdMob'],
    image: _projectImages.boozePreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.boozeUrl,
  );

  static ProjectsSectionData _vdx() => ProjectsSectionData(
    name: t.projects.items.vdx.name,
    description: t.projects.items.vdx.description,
    details: t.projects.items.vdx.details,
    metric: t.projects.items.vdx.metric,
    technologies: const ['Flutter', 'Firebase', 'GetX', 'AdMob'],
    image: _projectImages.vdxPreview,
    company: ProjectCompany.bluStudios,
    downloadLink: AppConstants.vdxUrl,
  );

  static ProjectsSectionData _harvest() => ProjectsSectionData(
    name: t.projects.items.harvest.name,
    description: t.projects.items.harvest.description,
    details: t.projects.items.harvest.details,
    award: ProjectAward(
      label: t.projects.items.harvest.award,
      awardUrl: AppConstants.harvestArticleUrl,
    ),
    technologies: const [
      'Flutter',
      'BLoC',
      'Firebase',
      'Firestore',
      'go_router',
    ],
    image: _projectImages.harvestPreview,
    downloadLink: AppConstants.harvestUrl,
  );

  static ProjectsSectionData _financo() => ProjectsSectionData(
    name: t.projects.items.financo.name,
    description: t.projects.items.financo.description,
    details: t.projects.items.financo.details,
    award: ProjectAward(
      label: t.projects.items.financo.award,
      awardUrl: AppConstants.financoArticleUrl,
    ),
    technologies: const [
      'Flutter',
      'BLoC',
      'Vertex AI',
      'Firestore',
      'Cloud Functions',
    ],
    image: _projectImages.financoPreview,
    downloadLink: AppConstants.financoUrl,
  );

  static ProjectsSectionData _bluBi() => ProjectsSectionData(
    name: t.projects.items.blu_bi.name,
    description: t.projects.items.blu_bi.description,
    details: t.projects.items.blu_bi.details,
    technologies: const [
      'Flutter',
      'GetX',
      'Firebase',
      'Isar',
      'fl_chart',
    ],
    image: _projectImages.bluBiPreview,
  );
}
