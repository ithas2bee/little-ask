import 'package:go_router/go_router.dart';

import '../features/app_shell/presentation/role_shell_screen.dart';
import '../features/architecture_example/presentation/counter_screen.dart';

abstract final class AppRouter {
  static const developmentPlaceholderPath = '/';
  static const childHomePath = '/child';
  static const parentHomePath = '/parent';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: developmentPlaceholderPath,
        builder: (context, state) => const CounterScreen(),
      ),
      GoRoute(
        path: childHomePath,
        builder: (context, state) =>
            const RoleShellScreen(state: RoleShellState.child),
      ),
      GoRoute(
        path: parentHomePath,
        builder: (context, state) =>
            const RoleShellScreen(state: RoleShellState.parent),
      ),
    ],
  );
}
