import 'package:material_ui/material_ui.dart';

import '../features/architecture_example/presentation/counter_screen.dart';

class LittleAskApp extends StatelessWidget {
  const LittleAskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Little Ask',
      home: CounterScreen(),
    );
  }
}
