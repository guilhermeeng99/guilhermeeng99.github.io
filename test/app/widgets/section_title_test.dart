import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/widgets/section_title.dart';

import '../../harness/helpers.dart';

void main() {
  testWidgets('SectionTitle renders title and subtitle', (tester) async {
    await pumpMaterialApp(
      tester,
      child: const SectionTitle(
        title: 'Projects',
        subtitle: 'Things I have shipped',
      ),
    );

    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Things I have shipped'), findsOneWidget);
  });
}
