import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
  });
}
