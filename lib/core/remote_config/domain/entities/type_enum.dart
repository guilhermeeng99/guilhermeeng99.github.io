import 'package:my_portfolio/core/remote_config/domain/entities/remote_config_enum.dart';

enum TypeEnum implements RemoteConfigEnum {
  googlePlayIndieGamesAccelerator2024Url(
    'google_play_indie_games_accelerator_2024_url',
    'https://android-developers.googleblog.com/2024/03/meet-class-of-2024-for-google-play-indie-games-accelerator.html',
  ),
  googlePlayIndieGamesFund2023Url(
    'google_play_indie_games_fund_2023_url',
    'https://blog.google/products-and-platforms/platforms/google-play/10-studios-selected-for-google-plays-2023-indie-games-fund/',
  ),
  googlePlayBestOf2021Url(
    'google_play_best_of_2021_url',
    'https://blog.google/products-and-platforms/platforms/google-play/google-plays-best-of-2021/',
  ),
  googlePlayStoreUrl(
    'google_play_store_url',
    'https://play.google.com/store/apps/dev?id=6372918774674573544',
  ),
  harvestArticleUrl(
    'harvest_article_url',
    'https://www.linkedin.com/pulse/i-built-production-ready-app-24-hours-using-ai-heres-what-passos-e6fcf/',
  ),
  appleStoreUrl(
    'apple_store_url',
    'https://apps.apple.com/developer/bluebook/id1467351824',
  ),
  magicSortUrl(
    'magic_sort_url',
    'https://appmagic.rocks/google-play/magic-sort/com.blu.wsp',
  ),
  rabitUrl(
    'rabit_url',
    'https://appmagic.rocks/google-play/rabit/com.blu.rabito',
  ),
  cupsUrl('cups_url', 'https://appmagic.rocks/ipad/cups/1541421297'),
  farmUrl(
    'farm_url',
    'https://play.google.com/store/apps/details?gl=US&hl=en-US&id=com.blu.farmvsaliens',
  ),
  capyUrl(
    'capy_url',
    'https://appmagic.rocks/iphone/capy-self-care-pet/6739744609',
  ),
  dropAndMergeUrl(
    'drop_and_merge_url',
    'https://appmagic.rocks/iphone/drop-and-merge/1559407907',
  ),
  neverHaveIEverXUrl(
    'never_have_i_ever_x_url',
    'https://appmagic.rocks/iphone/never-have-i-ever-x/1467821712',
  ),
  boozeUrl(
    'booze_url',
    'https://appmagic.rocks/iphone/booze-jogo-de-bebida/1495727658?hl=en',
  ),
  vdxUrl(
    'vdx_url',
    'https://drive.google.com/file/d/11Dj0-tAeB0LPlH9yPZUon_XQVrOVAf-l/view?usp=drive_link',
  ),
  resumeUrl(
    'resume_url',
    'https://drive.google.com/file/d/1SoUNPSx_SgQX25yy_znxPR3DBGqPq-h3/view?usp=sharing',
  ),
  financoUrl('financo_url', 'https://github.com/guilhermeeng99/financo'),
  flutterBaseUrl(
    'flutter_base_url',
    'https://guilhermeeng99.github.io/flutter_base/',
  ),
  harvestUrl('harvest_url', 'https://guilhermeeng99.github.io/harvest/')
  ;

  const TypeEnum(this.key, this.defaultValue);

  @override
  final String key;

  @override
  final Object defaultValue;
}
