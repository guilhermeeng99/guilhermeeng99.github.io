import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/app/widgets/tech_chip.dart';

import '../../harness/helpers.dart';

void main() {
  testWidgets('TechChip renders the provided label', (tester) async {
    await pumpMaterialApp(
      tester,
      child: const TechChip(label: 'Flutter'),
    );

    expect(find.text('Flutter'), findsOneWidget);
  });
}
