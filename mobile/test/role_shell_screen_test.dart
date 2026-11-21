import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/app_router.dart';
import 'package:little_ask/app/little_ask_app.dart';
import 'package:little_ask/app/theme/app_theme.dart';
import 'package:little_ask/app/widgets/interaction_components.dart';
import 'package:little_ask/features/app_shell/presentation/role_shell_screen.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('child shell makes asking for time together prominent', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const LittleAskApp());
    AppRouter.router.go(AppRouter.childHomePath);
    await tester.pumpAndSettle();

    expect(find.text('What would you like to do together?'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(find.text('Ask for time together'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Ask for time together'));
    await tester.pump();

    expect(
      find.text('Sending a request will be available soon.'),
      findsOneWidget,
    );
  });

  testWidgets('parent shell prioritizes child requests and offers an invite', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const LittleAskApp());
    AppRouter.router.go(AppRouter.parentHomePath);
    await tester.pumpAndSettle();

    expect(find.text('Requests from your child'), findsOneWidget);
    expect(
      find.text('Requests from your child will show up here.'),
      findsOneWidget,
    );
    expect(find.byType(SecondaryButton), findsOneWidget);
    expect(find.text('Invite your child'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Invite your child'));
    await tester.pump();

    expect(find.text('Invitations will be available soon.'), findsOneWidget);
  });

  testWidgets('role loading state is announced accessibly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const RoleShellScreen(state: RoleShellState.loading),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CircularProgressIndicator &&
            widget.semanticsLabel == 'Loading your home',
      ),
      findsOneWidget,
    );
  });

  testWidgets('role error state provides a retry action', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: RoleShellScreen(
          state: RoleShellState.error,
          onRetry: () => retried = true,
        ),
      ),
    );

    expect(find.text('We couldn’t load your home.'), findsOneWidget);
    await tester.tap(find.text('Try again'));

    expect(retried, isTrue);
  });

  testWidgets('unknown role state explains what to do next', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const RoleShellScreen(state: RoleShellState.unknownRole),
      ),
    );

    expect(
      find.text(
        'We couldn’t tell which home to show. Ask a parent or guardian '
        'for help with your account.',
      ),
      findsOneWidget,
    );
  });
}
