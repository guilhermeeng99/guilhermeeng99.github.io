import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';

import '../../harness/helpers.dart';

void main() {
  group('RemoteConstants', () {
    test('returns TypeEnum defaults when no overrides are supplied', () {
      final remote = buildFakeRemoteConstants();

      expect(remote.resumeUrl, TypeEnum.resumeUrl.defaultValue);
      expect(remote.financoUrl, TypeEnum.financoUrl.defaultValue);
      expect(
        remote.googlePlayBestOf2021Url,
        TypeEnum.googlePlayBestOf2021Url.defaultValue,
      );
    });

    test('routes each getter to its matching TypeEnum key', () {
      // One override per getter — if any getter were wired to the wrong key
      // it would return the default instead of the marker.
      final overrides = <RemoteConfigEnum, Object>{
        for (final key in TypeEnum.values) key: 'override:${key.key}',
      };
      final remote = buildFakeRemoteConstants(overrides: overrides);

      expect(remote.resumeUrl, 'override:${TypeEnum.resumeUrl.key}');
      expect(remote.appleStoreUrl, 'override:${TypeEnum.appleStoreUrl.key}');
      expect(
        remote.googlePlayStoreUrl,
        'override:${TypeEnum.googlePlayStoreUrl.key}',
      );
      expect(remote.magicSortUrl, 'override:${TypeEnum.magicSortUrl.key}');
      expect(remote.rabitUrl, 'override:${TypeEnum.rabitUrl.key}');
      expect(remote.cupsUrl, 'override:${TypeEnum.cupsUrl.key}');
      expect(remote.farmUrl, 'override:${TypeEnum.farmUrl.key}');
      expect(remote.capyUrl, 'override:${TypeEnum.capyUrl.key}');
      expect(
        remote.dropAndMergeUrl,
        'override:${TypeEnum.dropAndMergeUrl.key}',
      );
      expect(
        remote.neverHaveIEverXUrl,
        'override:${TypeEnum.neverHaveIEverXUrl.key}',
      );
      expect(remote.boozeUrl, 'override:${TypeEnum.boozeUrl.key}');
      expect(remote.vdxUrl, 'override:${TypeEnum.vdxUrl.key}');
      expect(remote.harvestUrl, 'override:${TypeEnum.harvestUrl.key}');
      expect(remote.financoUrl, 'override:${TypeEnum.financoUrl.key}');
      expect(
        remote.harvestArticleUrl,
        'override:${TypeEnum.harvestArticleUrl.key}',
      );
      expect(
        remote.googlePlayIndieGamesAccelerator2024Url,
        'override:${TypeEnum.googlePlayIndieGamesAccelerator2024Url.key}',
      );
      expect(
        remote.googlePlayIndieGamesFund2023Url,
        'override:${TypeEnum.googlePlayIndieGamesFund2023Url.key}',
      );
      expect(
        remote.googlePlayBestOf2021Url,
        'override:${TypeEnum.googlePlayBestOf2021Url.key}',
      );
    });
  });
}
