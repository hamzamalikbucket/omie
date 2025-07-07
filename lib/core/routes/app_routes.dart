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
import '../../features/mental_health_assessment/view/time_dedication_selection_page.dart';
import '../../features/mental_health_assessment/view/meditation_time_selection_page.dart';
import '../../features/mental_health_assessment/view/happiness_selection_page.dart';
import '../../features/mental_health_assessment/view/stress_level_selection_page.dart';
import '../../features/mental_health_assessment/view/profile_setup_page.dart';
import '../../features/mental_health_assessment/view/general_info_page.dart';
import '../../features/mental_health_assessment/view/avatar_selection_page.dart';
import '../../features/mental_health_assessment/view/image_format_error_page.dart';
import '../../features/mental_health_assessment/view/image_upload_status_page.dart';
import '../../features/mental_health_assessment/view/security_questions_page.dart';
import '../../features/mental_health_assessment/view/phone_otp_setup_page.dart';
import '../../features/mental_health_assessment/view/passcode_verification_page.dart';
import '../../features/mental_health_assessment/view/faceid_setup_page.dart';

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
  static const String timeDedicationSelection = '/time-dedication-selection';
  static const String meditationTimeSelection = '/meditation-time-selection';
  static const String happinessSelection = '/happiness-selection';
  static const String stressLevelSelection = '/stress-level-selection';
  static const String profileSetup = '/profile-setup';
  static const String generalInfo = '/general-info';
  static const String avatarSelection = '/avatar-selection';
  static const String imageFormatError = '/image-format-error';
  static const String imageUploadStatus = '/image-upload-status';
  static const String securityQuestions = '/security-questions';
  static const String phoneOtpSetup = '/phone-otp-setup';
  static const String passcodeVerification = '/passcode-verification';
  static const String faceIdSetup = '/faceid-setup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const PasscodeVerificationPage(),
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
      case timeDedicationSelection:
        return MaterialPageRoute(
          builder: (_) => const TimeDedicationSelectionPage(),
          settings: settings,
        );
      case meditationTimeSelection:
        return MaterialPageRoute(
          builder: (_) => const MeditationTimeSelectionPage(),
          settings: settings,
        );
      case happinessSelection:
        return MaterialPageRoute(
          builder: (_) => const HappinessSelectionPage(),
          settings: settings,
        );
      case stressLevelSelection:
        return MaterialPageRoute(
          builder: (_) => const StressLevelSelectionPage(),
          settings: settings,
        );
      case profileSetup:
        return MaterialPageRoute(
          builder: (_) => const ProfileSetupPage(),
          settings: settings,
        );
      case generalInfo:
        return MaterialPageRoute(
          builder: (_) => const GeneralInfoPage(),
          settings: settings,
        );
      case avatarSelection:
        return MaterialPageRoute(
          builder: (_) => const AvatarSelectionPage(),
          settings: settings,
        );
      case imageFormatError:
        return MaterialPageRoute(
          builder: (_) => const ImageFormatErrorPage(),
          settings: settings,
        );
      case imageUploadStatus:
        return MaterialPageRoute(
          builder: (_) => const ImageUploadStatusPage(),
          settings: settings,
        );
      case securityQuestions:
        return MaterialPageRoute(
          builder: (_) => const SecurityQuestionsPage(),
          settings: settings,
        );
      case phoneOtpSetup:
        return MaterialPageRoute(
          builder: (_) => const PhoneOtpSetupPage(),
          settings: settings,
        );
      case passcodeVerification:
        return MaterialPageRoute(
          builder: (_) => const PasscodeVerificationPage(),
          settings: settings,
        );
      case faceIdSetup:
        return MaterialPageRoute(
          builder: (_) => const FaceIdSetupPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AvatarSelectionPage(),
          settings: settings,
        );
    }
  }
}
