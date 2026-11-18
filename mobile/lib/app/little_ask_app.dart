import 'package:material_ui/material_ui.dart';

import 'app_routes.dart';
import 'theme/app_theme.dart';

class LittleAskApp extends StatelessWidget {
  const LittleAskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Ask',
      theme: AppTheme.light,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
