import 'package:material_ui/material_ui.dart';

import '../features/architecture_example/presentation/counter_screen.dart';
import 'theme/app_theme.dart';

class LittleAskApp extends StatelessWidget {
  const LittleAskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Ask',
      theme: AppTheme.light,
      home: const CounterScreen(),
    );
  }
}
