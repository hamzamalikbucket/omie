import 'package:flutter/material.dart';

import '../../features/splash/view/splash_page.dart';
import '../../features/counter/view/counter_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String counter = '/counter';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case counter:
        return MaterialPageRoute(
          builder: (_) => const CounterPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }
}
