import 'package:my_portfolio/core/remote_config/remote_config.dart';

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

  String get resumeUrl => _getRemoteValue.callString(TypeEnum.resumeUrl);

  String get googlePlayIndieGamesAccelerator2024Url =>
      _getRemoteValue.callString(
        TypeEnum.googlePlayIndieGamesAccelerator2024Url,
      );

  String get googlePlayIndieGamesFund2023Url => _getRemoteValue.callString(
    TypeEnum.googlePlayIndieGamesFund2023Url,
  );

  String get harvestArticleUrl => _getRemoteValue.callString(
    TypeEnum.harvestArticleUrl,
  );

  String get googlePlayBestOf2021Url =>
      _getRemoteValue.callString(TypeEnum.googlePlayBestOf2021Url);

  String get googlePlayStoreUrl =>
      _getRemoteValue.callString(TypeEnum.googlePlayStoreUrl);

  String get appleStoreUrl =>
      _getRemoteValue.callString(TypeEnum.appleStoreUrl);

  String get magicSortUrl => _getRemoteValue.callString(TypeEnum.magicSortUrl);

  String get rabitUrl => _getRemoteValue.callString(TypeEnum.rabitUrl);

  String get cupsUrl => _getRemoteValue.callString(TypeEnum.cupsUrl);

  String get farmUrl => _getRemoteValue.callString(TypeEnum.farmUrl);

  String get capyUrl => _getRemoteValue.callString(TypeEnum.capyUrl);

  String get dropAndMergeUrl =>
      _getRemoteValue.callString(TypeEnum.dropAndMergeUrl);

  String get neverHaveIEverXUrl =>
      _getRemoteValue.callString(TypeEnum.neverHaveIEverXUrl);

  String get boozeUrl => _getRemoteValue.callString(TypeEnum.boozeUrl);

  String get vdxUrl => _getRemoteValue.callString(TypeEnum.vdxUrl);

  String get flutterBaseUrl =>
      _getRemoteValue.callString(TypeEnum.flutterBaseUrl);

  String get harvestUrl => _getRemoteValue.callString(TypeEnum.harvestUrl);

  String get financoUrl => _getRemoteValue.callString(TypeEnum.financoUrl);
}
