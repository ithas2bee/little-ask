import 'package:material_ui/material_ui.dart';

import '../features/architecture_example/presentation/counter_screen.dart';

abstract final class AppRoutes {
  static const developmentPlaceholder = '/';
  static const initialRoute = developmentPlaceholder;

  static final Map<String, WidgetBuilder> routes = Map.unmodifiable({
    developmentPlaceholder: (_) => const CounterScreen(),
  });
}
