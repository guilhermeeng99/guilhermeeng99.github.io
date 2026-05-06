import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/widgets/scroll_fade_in.dart';

import '../../harness/helpers.dart';

void main() {
  group('ScrollFadeIn', () {
    testWidgets('renders the child widget', (tester) async {
      await pumpMaterialApp(
        tester,
        child: const ScrollFadeIn(child: Text('payload')),
      );

      expect(find.text('payload'), findsOneWidget);
    });

    testWidgets('starts hidden (opacity 0) when off-viewport', (tester) async {
      // Wrapping in Padding (not a CustomScrollView) means the
      // RenderAbstractViewport lookup returns null, so the visibility
      // detector never fires — opacity stays at the initial 0.
      await pumpMaterialApp(
        tester,
        child: const Padding(
          padding: EdgeInsets.zero,
          child: ScrollFadeIn(child: Text('payload')),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      final opacity = tester.widget<Opacity>(
        find.ancestor(
          of: find.text('payload'),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacity.opacity, 0.0);
    });

    testWidgets('fades in when visibleThreshold is 0 inside a viewport',
        (tester) async {
      await pumpMaterialApp(
        tester,
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ScrollFadeIn(
                visibleThreshold: 0,
                child: SizedBox(
                  height: 200,
                  child: Text('payload'),
                ),
              ),
            ),
          ],
        ),
      );

      // Initial paint registers the visibility detector; pump past the
      // animation duration so the controller reaches 1.0.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 700));

      final opacity = tester.widget<Opacity>(
        find.ancestor(
          of: find.text('payload'),
          matching: find.byType(Opacity),
        ),
      );
      expect(opacity.opacity, 1.0);
    });
  });
}
