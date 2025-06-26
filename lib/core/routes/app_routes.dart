import 'package:flutter/material.dart';

import '../../features/splash/view/splash_page.dart';
import '../../features/welcome/view/welcome_page.dart';
import '../../features/onboarding/view/onboarding_page.dart';
import '../../features/authentication/view/authentication_page.dart';
import '../../features/authentication/view/signin_page.dart';
import '../../features/authentication/view/signup_page.dart';
import '../../features/authentication/view/forgot_password_page.dart';
import '../../features/authentication/view/forgot_password_email_page.dart';
import '../../features/authentication/view/forgot_password_email_sent_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String authentication = '/authentication';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordEmail = '/forgot-password-email';
  static const String forgotPasswordEmailSent = '/forgot-password-email-sent';

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
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupPage(),
          settings: settings,
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: settings,
        );
      case forgotPasswordEmail:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordEmailPage(),
          settings: settings,
        );
      case forgotPasswordEmailSent:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordEmailSentPage(),
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
