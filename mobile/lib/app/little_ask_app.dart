import 'package:material_ui/material_ui.dart';

import 'app_router.dart';
import 'theme/app_theme.dart';

class LittleAskApp extends StatelessWidget {
  const LittleAskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Little Ask',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
