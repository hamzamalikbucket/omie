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
import '../../features/mental_health_assessment/view/comprehensive_mental_health_assessment_page.dart';
import '../../features/mental_health_assessment/view/height_selection_page.dart';
import '../../features/mental_health_assessment/view/mental_health_conditions_page.dart';
import '../../features/mental_health_assessment/view/sleep_level_selection_page.dart';

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
  static const String comprehensiveMentalHealthAssessment =
      '/comprehensive-mental-health-assessment';
  static const String heightSelection = '/height-selection';
  static const String mentalHealthConditions = '/mental-health-conditions';
  static const String sleepLevelSelection = '/sleep-level-selection';

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
      case comprehensiveMentalHealthAssessment:
        return MaterialPageRoute(
          builder: (_) => const ComprehensiveMentalHealthAssessmentPage(),
          settings: settings,
        );
      case heightSelection:
        return MaterialPageRoute(
          builder: (_) => const HeightSelectionPage(),
          settings: settings,
        );
      case mentalHealthConditions:
        return MaterialPageRoute(
          builder: (_) => const MentalHealthConditionsPage(),
          settings: settings,
        );
      case sleepLevelSelection:
        return MaterialPageRoute(
          builder: (_) => const SleepLevelSelectionPage(),
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
