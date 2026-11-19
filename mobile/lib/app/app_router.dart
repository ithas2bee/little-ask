import 'package:go_router/go_router.dart';

import '../features/architecture_example/presentation/counter_screen.dart';

abstract final class AppRouter {
  static const developmentPlaceholderPath = '/';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: developmentPlaceholderPath,
        builder: (context, state) => const CounterScreen(),
      ),
    ],
  );
}
