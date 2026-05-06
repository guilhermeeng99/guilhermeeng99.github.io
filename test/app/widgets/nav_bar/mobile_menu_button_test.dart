import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/mobile_menu_button.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

import '../../../harness/helpers.dart';

void main() {
  group('MobileMenuButton', () {
    const entries = <NavEntry>[
      (index: 1, label: 'About'),
      (index: 2, label: 'Projects'),
      (index: 3, label: 'Experience'),
      (index: 4, label: 'Skills'),
    ];

    testWidgets('opens a popup with all entries plus Contact', (tester) async {
      await pumpMaterialApp(
        tester,
        child: MobileMenuButton(
          entries: entries,
          onSectionTap: (_) {},
        ),
      );

      await tester.tap(find.byIcon(Icons.menu_rounded));
      await tester.pumpAndSettle();

      expect(find.text('About'), findsOneWidget);
      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text(t.nav.contact), findsOneWidget);
    });

    testWidgets('fires the Contact callback with kNavContactIndex (5)',
        (tester) async {
      final taps = <int>[];
      await pumpMaterialApp(
        tester,
        child: MobileMenuButton(
          entries: entries,
          onSectionTap: taps.add,
        ),
      );

      await tester.tap(find.byIcon(Icons.menu_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.nav.contact));
      await tester.pumpAndSettle();

      expect(kNavContactIndex, 5);
      expect(taps, [kNavContactIndex]);
    });

    testWidgets('fires the section index when an entry is tapped',
        (tester) async {
      final taps = <int>[];
      await pumpMaterialApp(
        tester,
        child: MobileMenuButton(
          entries: entries,
          onSectionTap: taps.add,
        ),
      );

      await tester.tap(find.byIcon(Icons.menu_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Projects'));
      await tester.pumpAndSettle();

      expect(taps, [2]);
    });
  });
}
