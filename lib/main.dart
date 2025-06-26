import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize theme system
  await YouthYogaTheme.initialize();

  // Set default flavor if not set
  if (AppConfig.flavor == Flavor.development) {
    // This will be overridden by flavor-specific main files
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 11 Pro design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Builder(
          builder: (context) {
            final lightTheme = LightModeTheme();
            final darkTheme = DarkModeTheme();

            return MaterialApp(
              title: AppConfig.appName,
              debugShowCheckedModeBanner: AppConfig.isDebugMode,
              theme: lightTheme.materialTheme,
              darkTheme: darkTheme.materialTheme,
              themeMode: ThemeMode.light,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        );
      },
    );
  }
}
