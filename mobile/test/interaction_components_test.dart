import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/theme/app_theme.dart';
import 'package:little_ask/app/widgets/interaction_components.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('buttons expose labels and invoke their callbacks', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    addTearDown(semantics.dispose);

    var primaryPressed = false;
    var secondaryPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Column(
            children: [
              PrimaryButton(
                label: 'Send request',
                onPressed: () => primaryPressed = true,
              ),
              SecondaryButton(
                label: 'Maybe later',
                onPressed: () => secondaryPressed = true,
              ),
            ],
          ),
        ),
      ),
    );

    expect(
      tester.getSize(find.byType(PrimaryButton)).height,
      greaterThanOrEqualTo(48),
    );
    expect(
      tester.getSemantics(find.byType(PrimaryButton)).label,
      'Send request',
    );
    expect(
      tester.getSemantics(find.byType(SecondaryButton)).label,
      'Maybe later',
    );
    expect(
      tester
          .getSemantics(find.byType(PrimaryButton))
          .hasFlag(SemanticsFlag.isEnabled),
      isTrue,
    );
    expect(
      tester
          .getSemantics(find.byType(PrimaryButton))
          .hasAction(SemanticsAction.tap),
      isTrue,
    );

    await tester.tap(find.byType(PrimaryButton));
    await tester.tap(find.byType(SecondaryButton));

    expect(primaryPressed, isTrue);
    expect(secondaryPressed, isTrue);
  });

  testWidgets('disabled buttons expose a disabled semantic state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    addTearDown(semanticsHandle.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: PrimaryButton(label: 'Send request', onPressed: null),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(PrimaryButton));

    expect(semantics.label, 'Send request');
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(semantics.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
    expect(semantics.hasAction(SemanticsAction.tap), isFalse);
  });

  testWidgets('selectable card reports and updates its selected state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    addTearDown(semanticsHandle.dispose);

    var selected = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => SelectableCard(
              label: 'Play a game',
              description: 'Choose a board game',
              selected: selected,
              onSelected: (value) => setState(() => selected = value),
            ),
          ),
        ),
      ),
    );

    var semantics = tester.getSemantics(find.byType(SelectableCard));
    expect(semantics.label, 'Play a game, Choose a board game');
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(semantics.hasFlag(SemanticsFlag.isSelected), isFalse);
    expect(
      tester.getSize(find.byType(SelectableCard)).height,
      greaterThanOrEqualTo(48),
    );

    await tester.tap(find.byType(SelectableCard));
    await tester.pump();

    semantics = tester.getSemantics(find.byType(SelectableCard));
    expect(selected, isTrue);
    expect(semantics.hasFlag(SemanticsFlag.isSelected), isTrue);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('disabled selectable card exposes its disabled state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    addTearDown(semanticsHandle.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: SelectableCard(
            label: 'Choose a parent',
            selected: false,
            onSelected: null,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(SelectableCard));

    expect(semantics.hasFlag(SemanticsFlag.hasEnabledState), isTrue);
    expect(semantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
    expect(semantics.hasAction(SemanticsAction.tap), isFalse);
  });
}
