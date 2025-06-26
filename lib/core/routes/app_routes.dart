import 'package:flutter/material.dart';

import '../../features/splash/view/splash_page.dart';
import '../../features/welcome/view/welcome_page.dart';
import '../../features/onboarding/view/onboarding_page.dart';
import '../../features/authentication/view/authentication_page.dart';
import '../../features/authentication/view/signin_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String authentication = '/authentication';
  static const String signin = '/signin';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
          settings: settings,
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );
      case authentication:
        return MaterialPageRoute(
          builder: (_) => const AuthenticationPage(),
          settings: settings,
        );
      case signin:
        return MaterialPageRoute(
          builder: (_) => const SigninPage(),
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
