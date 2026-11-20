import 'package:flutter_test/flutter_test.dart';
import 'package:little_ask/app/theme/app_theme.dart';
import 'package:little_ask/app/widgets/interaction_components.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('buttons expose labels and invoke their callbacks', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
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
        tester.getSemantics(find.byType(PrimaryButton)),
        matchesSemantics(
          label: 'Send request',
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      expect(
        tester.getSemantics(find.byType(SecondaryButton)),
        matchesSemantics(
          label: 'Maybe later',
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );

      await tester.tap(find.byType(PrimaryButton));
      await tester.tap(find.byType(SecondaryButton));

      expect(primaryPressed, isTrue);
      expect(secondaryPressed, isTrue);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('disabled buttons expose a disabled semantic state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: PrimaryButton(label: 'Send request', onPressed: null),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(PrimaryButton));

      expect(
        semantics,
        matchesSemantics(
          label: 'Send request',
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
        ),
      );
    } finally {
      semanticsHandle.dispose();
    }
  });

  testWidgets('selectable card reports and updates its selected state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    try {
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
      expect(
        semantics,
        matchesSemantics(
          label: 'Play a game, Choose a board game',
          isButton: true,
          hasSelectedState: true,
          isSelected: false,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      expect(
        tester.getSize(find.byType(SelectableCard)).height,
        greaterThanOrEqualTo(48),
      );

      await tester.tap(find.byType(SelectableCard));
      await tester.pump();

      semantics = tester.getSemantics(find.byType(SelectableCard));
      expect(selected, isTrue);
      expect(
        semantics,
        matchesSemantics(
          label: 'Play a game, Choose a board game',
          isButton: true,
          hasSelectedState: true,
          isSelected: true,
          hasEnabledState: true,
          isEnabled: true,
          hasTapAction: true,
        ),
      );
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    } finally {
      semanticsHandle.dispose();
    }
  });

  testWidgets('disabled selectable card exposes its disabled state', (
    tester,
  ) async {
    final semanticsHandle = tester.ensureSemantics();
    try {
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

      expect(
        semantics,
        matchesSemantics(
          label: 'Choose a parent',
          isButton: true,
          hasSelectedState: true,
          isSelected: false,
          hasEnabledState: true,
          isEnabled: false,
          hasTapAction: false,
        ),
      );
    } finally {
      semanticsHandle.dispose();
    }
  });
}
