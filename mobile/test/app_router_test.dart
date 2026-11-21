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

  testWidgets('child and parent routes open their corresponding shells', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleAskApp());

    AppRouter.router.go(AppRouter.childHomePath);
    await tester.pumpAndSettle();
    expect(find.text('What would you like to do together?'), findsOneWidget);
    expect(AppRouter.router.state.uri.path, AppRouter.childHomePath);

    AppRouter.router.go(AppRouter.parentHomePath);
    await tester.pumpAndSettle();
    expect(find.text('Requests from your child'), findsOneWidget);
    expect(AppRouter.router.state.uri.path, AppRouter.parentHomePath);
  });
}
