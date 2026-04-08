import 'package:remote_config/remote_config.dart';

abstract final class AppConstants {
  static const String owner = 'Guilherme Passos';
  static const String bluCompany = 'Blu Studios';
  static const String bluCompanyUrl = 'https://blury.studio/';
  static const String vxCaseCompany = 'VX Case';
  static const String tecallCompany = 'Tecall Consultoria';
  static const String ucsalInstitution = 'Universidade Católica do Salvador';
  static const String senaiInstitution = 'SENAI CIMATEC';
  static const String allInstitution = 'Alternative Language Learning (ALL)';
  static const String linkedin = 'guigapassos';
  static const String linkedinUrl = 'https://linkedin.com/in/$linkedin';
  static const String github = 'guilhermeeng99';
  static const String githubUrl = 'https://github.com/$github';
  static const String email = 'guilhermeeng99@gmail.com';
  static const String emailUrl = 'mailto:$email';
}

class RemoteConstants {
  const RemoteConstants(this._getRemoteValue);

  final GetRemoteValueUseCase _getRemoteValue;

  String get resumeUrl => _getRemoteValue.callString(TypeEnum.resume_url);

  String get googlePlayIndieGamesAccelerator2024Url =>
      _getRemoteValue.callString(
        TypeEnum.google_play_indie_games_accelerator_2024_url,
      );

  String get googlePlayIndieGamesFund2023Url => _getRemoteValue.callString(
    TypeEnum.google_play_indie_games_fund_2023_url,
  );

  String get harvestArticleUrl => _getRemoteValue.callString(
    TypeEnum.harvest_article_url,
  );

  String get googlePlayBestOf2021Url =>
      _getRemoteValue.callString(TypeEnum.google_play_best_of_2021_url);

  String get googlePlayStoreUrl =>
      _getRemoteValue.callString(TypeEnum.google_play_store_url);

  String get appleStoreUrl =>
      _getRemoteValue.callString(TypeEnum.apple_store_url);

  String get magicSortUrl =>
      _getRemoteValue.callString(TypeEnum.magic_sort_url);

  String get rabitUrl => _getRemoteValue.callString(TypeEnum.rabit_url);

  String get cupsUrl => _getRemoteValue.callString(TypeEnum.cups_url);

  String get farmUrl => _getRemoteValue.callString(TypeEnum.farm_url);

  String get capyUrl => _getRemoteValue.callString(TypeEnum.capy_url);

  String get dropAndMergeUrl =>
      _getRemoteValue.callString(TypeEnum.drop_and_merge_url);

  String get neverHaveIEverXUrl =>
      _getRemoteValue.callString(TypeEnum.never_have_i_ever_x_url);

  String get boozeUrl => _getRemoteValue.callString(TypeEnum.booze_url);

  String get vdxUrl => _getRemoteValue.callString(TypeEnum.vdx_url);

  String get flutterBaseUrl =>
      _getRemoteValue.callString(TypeEnum.flutter_base_url);

  String get harvestUrl => _getRemoteValue.callString(TypeEnum.harvest_url);

  String get financoUrl => _getRemoteValue.callString(TypeEnum.financo_url);
}
