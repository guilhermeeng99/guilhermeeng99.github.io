// ignore_for_file: constant_identifier_names

part of remote_config;

enum TypeEnum implements RemoteConfigEnum {
  google_play_indie_games_accelerator_2024_url(
      'https://android-developers.googleblog.com/2024/03/meet-class-of-2024-for-google-play-indie-games-accelerator.html'),
  google_play_indie_games_fund_2023_url(
      'https://blog.google/products-and-platforms/platforms/google-play/10-studios-selected-for-google-plays-2023-indie-games-fund/'),
  google_play_best_of_2021_url(
      'https://blog.google/products-and-platforms/platforms/google-play/google-plays-best-of-2021/'),
  google_play_store_url(
      'https://play.google.com/store/apps/dev?id=6372918774674573544'),
  apple_store_url('https://apps.apple.com/developer/bluebook/id1467351824'),
  magic_sort_url('https://appmagic.rocks/google-play/magic-sort/com.blu.wsp'),
  rabit_url('https://appmagic.rocks/google-play/rabit/com.blu.rabito'),
  cups_url('https://appmagic.rocks/ipad/cups/1541421297'),
  farm_url(
      'https://play.google.com/store/apps/details?gl=US&hl=en-US&id=com.blu.farmvsaliens'),
  capy_url('https://appmagic.rocks/iphone/capy-self-care-pet/6739744609'),
  drop_and_merge_url('https://appmagic.rocks/iphone/drop-and-merge/1559407907'),
  never_have_i_ever_x_url(
      'https://appmagic.rocks/iphone/never-have-i-ever-x/1467821712'),
  booze_url(
      'https://appmagic.rocks/iphone/booze-jogo-de-bebida/1495727658?hl=en'),
  vdx_url(
      'https://drive.google.com/file/d/11Dj0-tAeB0LPlH9yPZUon_XQVrOVAf-l/view?usp=drive_link'),
  resume_url(
      'https://drive.google.com/file/d/1kBdRtvansGXKFDBIRdtKrUwFU3RuhU4s/view?usp=sharing');

  @override
  final dynamic defaultValue;

  const TypeEnum(this.defaultValue);
}
