import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/skills_section/skills_section.dart';

import '../../../../../harness/helpers.dart';

void main() {
  group('SkillsSection', () {
    testWidgets(
      'desktop layout pairs categories side-by-side without overflow',
      (tester) async {
        await pumpMaterialApp(
          tester,
          child: const SingleChildScrollView(child: SkillsSection()),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'tablet layout pairs categories side-by-side without overflow',
      (tester) async {
        await pumpMaterialApp(
          tester,
          child: const SingleChildScrollView(child: SkillsSection()),
          surfaceSize: const Size(900, 1200),
        );

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'mobile layout stacks categories vertically without overflow',
      (tester) async {
        await pumpMaterialApp(
          tester,
          child: const SingleChildScrollView(child: SkillsSection()),
          surfaceSize: const Size(400, 1600),
        );

        expect(tester.takeException(), isNull);
      },
    );
  });
}
