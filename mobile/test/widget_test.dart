import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/main.dart';

void main() {
  testWidgets('shows the mobile app placeholder', (tester) async {
    await tester.pumpWidget(const LittleAskApp());

    expect(
      find.text('Little Ask mobile app is ready to get started.'),
      findsOneWidget,
    );
  });
}
