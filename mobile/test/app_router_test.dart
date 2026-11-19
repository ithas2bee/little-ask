import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/app_router.dart';
import 'package:little_ask/app/little_ask_app.dart';
import 'package:little_ask/features/architecture_example/presentation/counter_screen.dart';

void main() {
  testWidgets('initial route opens the development placeholder at /', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleAskApp());

    expect(find.byType(CounterScreen), findsOneWidget);
    expect(
      AppRouter.router.state.uri.path,
      AppRouter.developmentPlaceholderPath,
    );
  });
}
