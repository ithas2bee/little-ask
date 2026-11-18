import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/app_routes.dart';
import 'package:little_ask/app/little_ask_app.dart';
import 'package:little_ask/features/architecture_example/presentation/counter_screen.dart';

void main() {
  testWidgets('initial named route opens the development placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleAskApp());

    expect(AppRoutes.initialRoute, AppRoutes.developmentPlaceholder);
    expect(AppRoutes.routes.keys, contains(AppRoutes.initialRoute));
    expect(find.byType(CounterScreen), findsOneWidget);
  });
}
