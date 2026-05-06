import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/remote_config/remote_config.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

import 'helpers.dart';

void main() {
  group('pumpMaterialApp', () {
    testWidgets('wires TranslationProvider so slang t.* resolves',
        (tester) async {
      await pumpMaterialApp(
        tester,
        child: Builder(
          builder: (context) => Text(t.app.title),
        ),
      );

      expect(find.text(t.app.title), findsOneWidget);
    });

    testWidgets('does not provide RemoteConstants by default', (tester) async {
      late BuildContext capturedContext;
      await pumpMaterialApp(
        tester,
        child: Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      expect(
        () => capturedContext.read<RemoteConstants>(),
        throwsA(isA<ProviderNotFoundException>()),
      );
    });

    testWidgets('exposes RemoteConstants when one is supplied',
        (tester) async {
      final fake = buildFakeRemoteConstants();
      late RemoteConstants resolved;

      await pumpMaterialApp(
        tester,
        remoteConstants: fake,
        child: Builder(
          builder: (context) {
            resolved = context.read<RemoteConstants>();
            return const SizedBox.shrink();
          },
        ),
      );

      expect(resolved, same(fake));
    });
  });

  group('buildFakeRemoteConstants', () {
    test('returns TypeEnum defaults when no overrides are supplied', () {
      final remote = buildFakeRemoteConstants();

      expect(remote.resumeUrl, TypeEnum.resumeUrl.defaultValue);
      expect(remote.financoUrl, TypeEnum.financoUrl.defaultValue);
    });

    test('honours override values for the keys provided', () {
      final remote = buildFakeRemoteConstants(
        overrides: {TypeEnum.resumeUrl: 'https://test.example/cv.pdf'},
      );

      expect(remote.resumeUrl, 'https://test.example/cv.pdf');
      // Untouched keys still fall back to TypeEnum defaults.
      expect(remote.financoUrl, TypeEnum.financoUrl.defaultValue);
    });
  });
}
