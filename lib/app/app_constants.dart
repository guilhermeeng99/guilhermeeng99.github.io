import 'package:remote_config/remote_config.dart';

class AppConstants {
  static final _remoteConfigRepository = RemoteConfigRepositoryImpl(
    FirebaseRemoteConfigServiceImpl(),
  );
  static final _getRemoteValueUseCase = GetRemoteValueUseCase(
    _remoteConfigRepository,
  );

  static String owner = 'Guilherme Passos';
  static String bluCompany = 'Blu Studios';
  static String bluCompanyUrl = 'https://blury.studio/';
  static String vxCaseCompany = 'VX Case';
  static String tecallCompany = 'Tecall Consultoria';
  static String ucsalInstitution = 'Universidade Católica do Salvador';
  static String senaiInstitution = 'SENAI CIMATEC';
  static String allInstitution = 'Alternative Language Learning (ALL)';
  static String linkedin = 'guigapassos';
  static String linkedinUrl = 'https://linkedin.com/in/$linkedin';
  static String github = 'guilhermeeng99';
  static String githubUrl = 'https://github.com/$github';
  static String email = 'guilhermeeng99@gmail.com';
  static String emailUrl = 'mailto:$email';
  static String get resumeUrl =>
      _getRemoteValueUseCase.callString(TypeEnum.resume_url);
  static String get googlePlayIndieGamesAccelerator2024Url =>
      _getRemoteValueUseCase.callString(
        TypeEnum.google_play_indie_games_accelerator_2024_url,
      );
  static String get googlePlayIndieGamesFund2023Url =>
      _getRemoteValueUseCase.callString(
        TypeEnum.google_play_indie_games_fund_2023_url,
      );
  static String get googlePlayBestOf2021Url =>
      _getRemoteValueUseCase.callString(
        TypeEnum.google_play_best_of_2021_url,
      );
  static String get googlePlayStoreUrl => _getRemoteValueUseCase.callString(
    TypeEnum.google_play_store_url,
  );
  static String get appleStoreUrl => _getRemoteValueUseCase.callString(
    TypeEnum.apple_store_url,
  );
  static String get magicSortUrl => _getRemoteValueUseCase.callString(
    TypeEnum.magic_sort_url,
  );
  static String get rabitUrl => _getRemoteValueUseCase.callString(
    TypeEnum.rabit_url,
  );
  static String get cupsUrl => _getRemoteValueUseCase.callString(
    TypeEnum.cups_url,
  );
  static String get farmUrl => _getRemoteValueUseCase.callString(
    TypeEnum.farm_url,
  );
  static String get capyUrl => _getRemoteValueUseCase.callString(
    TypeEnum.capy_url,
  );
  static String get dropAndMergeUrl => _getRemoteValueUseCase.callString(
    TypeEnum.drop_and_merge_url,
  );
  static String get neverHaveIEverXUrl => _getRemoteValueUseCase.callString(
    TypeEnum.never_have_i_ever_x_url,
  );
  static String get boozeUrl => _getRemoteValueUseCase.callString(
    TypeEnum.booze_url,
  );
  static String get vdxUrl => _getRemoteValueUseCase.callString(
    TypeEnum.vdx_url,
  );
}
