import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/little_ask_app.dart';

void main() {
  testWidgets('counter screen updates its ChangeNotifier state', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleAskApp());

    expect(find.text('Counter: 0'), findsOneWidget);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('Counter: 1'), findsOneWidget);
  });
}
