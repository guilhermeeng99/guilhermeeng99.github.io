// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  /// Directory path: lib/app
  $LibAppGen get app => const $LibAppGen();
}

class $LibAppGen {
  const $LibAppGen();

  /// Directory path: lib/app/assets
  $LibAppAssetsGen get assets => const $LibAppAssetsGen();
}

class $LibAppAssetsGen {
  const $LibAppAssetsGen();

  /// Directory path: lib/app/assets/i18n
  $LibAppAssetsI18nGen get i18n => const $LibAppAssetsI18nGen();

  /// Directory path: lib/app/assets/images
  $LibAppAssetsImagesGen get images => const $LibAppAssetsImagesGen();

  /// Directory path: lib/app/assets/pdfs
  $LibAppAssetsPdfsGen get pdfs => const $LibAppAssetsPdfsGen();
}

class $LibAppAssetsI18nGen {
  const $LibAppAssetsI18nGen();

  /// File path: lib/app/assets/i18n/en.i18n.json
  String get enI18n => 'lib/app/assets/i18n/en.i18n.json';

  /// List of all assets
  List<String> get values => [enI18n];
}

class $LibAppAssetsImagesGen {
  const $LibAppAssetsImagesGen();

  /// File path: lib/app/assets/images/logo.png
  AssetGenImage get logo =>
      const AssetGenImage('lib/app/assets/images/logo.png');

  /// File path: lib/app/assets/images/my_profile.png
  AssetGenImage get myProfile =>
      const AssetGenImage('lib/app/assets/images/my_profile.png');

  /// Directory path: lib/app/assets/images/projects
  $LibAppAssetsImagesProjectsGen get projects =>
      const $LibAppAssetsImagesProjectsGen();

  /// List of all assets
  List<AssetGenImage> get values => [logo, myProfile];
}

class $LibAppAssetsPdfsGen {
  const $LibAppAssetsPdfsGen();

  /// File path: lib/app/assets/pdfs/Guilherme_Passos_Resume.pdf
  String get guilhermePassosResume =>
      'lib/app/assets/pdfs/Guilherme_Passos_Resume.pdf';

  /// List of all assets
  List<String> get values => [guilhermePassosResume];
}

class $LibAppAssetsImagesProjectsGen {
  const $LibAppAssetsImagesProjectsGen();

  /// File path: lib/app/assets/images/projects/INever_preview.png
  AssetGenImage get iNeverPreview =>
      const AssetGenImage('lib/app/assets/images/projects/INever_preview.png');

  /// File path: lib/app/assets/images/projects/booze_preview.png
  AssetGenImage get boozePreview =>
      const AssetGenImage('lib/app/assets/images/projects/booze_preview.png');

  /// File path: lib/app/assets/images/projects/capy_preview.png
  AssetGenImage get capyPreview =>
      const AssetGenImage('lib/app/assets/images/projects/capy_preview.png');

  /// File path: lib/app/assets/images/projects/cups_preview.png
  AssetGenImage get cupsPreview =>
      const AssetGenImage('lib/app/assets/images/projects/cups_preview.png');

  /// File path: lib/app/assets/images/projects/drop_preview.png
  AssetGenImage get dropPreview =>
      const AssetGenImage('lib/app/assets/images/projects/drop_preview.png');

  /// File path: lib/app/assets/images/projects/farm_preview.png
  AssetGenImage get farmPreview =>
      const AssetGenImage('lib/app/assets/images/projects/farm_preview.png');

  /// File path: lib/app/assets/images/projects/magic_sort_preview.png
  AssetGenImage get magicSortPreview => const AssetGenImage(
    'lib/app/assets/images/projects/magic_sort_preview.png',
  );

  /// File path: lib/app/assets/images/projects/rabit_preview.jpg
  AssetGenImage get rabitPreview =>
      const AssetGenImage('lib/app/assets/images/projects/rabit_preview.jpg');

  /// File path: lib/app/assets/images/projects/vdx_preview.png
  AssetGenImage get vdxPreview =>
      const AssetGenImage('lib/app/assets/images/projects/vdx_preview.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    iNeverPreview,
    boozePreview,
    capyPreview,
    cupsPreview,
    dropPreview,
    farmPreview,
    magicSortPreview,
    rabitPreview,
    vdxPreview,
  ];
}

class Assets {
  const Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
