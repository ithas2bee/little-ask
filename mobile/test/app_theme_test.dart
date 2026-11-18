import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:little_ask/app/little_ask_app.dart';
import 'package:little_ask/app/theme/app_theme.dart';

void main() {
  testWidgets('app uses the shared light theme and semantic status colors', (
    tester,
  ) async {
    await tester.pumpWidget(const LittleAskApp());

    final theme = tester.widget<MaterialApp>(find.byType(MaterialApp)).theme!;
    final statusColors = theme.extension<RequestStatusColors>()!;

    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, AppColors.primary);
    expect(theme.colorScheme.secondary, AppColors.secondary);
    expect(theme.textTheme.headlineMedium?.fontSize, 22);
    expect(AppSpacing.xl, 24);
    expect(AppRadii.large, 24);
    expect(statusColors.pendingContainer, AppColors.softGold);
    expect(statusColors.acceptedContainer, AppColors.softGreen);
    expect(statusColors.laterSuggestedContainer, AppColors.softBlue);
  });

  test('filled button styles distinguish enabled and disabled states', () {
    final style = AppTheme.light.filledButtonTheme.style!;

    expect(style.minimumSize!.resolve(const {}), const Size(48, 48));
    expect(style.backgroundColor!.resolve(const {}), AppColors.primary);
    expect(
      style.backgroundColor!.resolve({WidgetState.disabled}),
      AppColors.disabledSurface,
    );
  });
}
