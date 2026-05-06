import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/glass_card.dart';

import '../../harness/helpers.dart';

void main() {
  group('GlassCard', () {
    testWidgets('renders the child widget', (tester) async {
      await pumpMaterialApp(
        tester,
        child: const GlassCard(child: Text('payload')),
      );

      expect(find.text('payload'), findsOneWidget);
    });

    testWidgets('uses the cardBorder color before hover', (tester) async {
      late BuildContext capturedContext;
      await pumpMaterialApp(
        tester,
        child: Builder(
          builder: (context) {
            capturedContext = context;
            return const GlassCard(child: Text('payload'));
          },
        ),
      );

      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.byType(GlassCard),
          matching: find.byType(AnimatedContainer),
        ),
      );

      final decoration = container.decoration! as BoxDecoration;
      expect(
        decoration.border,
        Border.all(color: capturedContext.appColors.cardBorder),
      );
    });
  });
}
