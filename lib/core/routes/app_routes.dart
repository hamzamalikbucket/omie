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
import '../../features/mental_health_assessment/view/data_security_consent_page.dart';
import '../../features/mental_health_assessment/view/height_selection_page.dart';
import '../../features/mental_health_assessment/view/mental_health_conditions_page.dart';
import '../../features/mental_health_assessment/view/sleep_level_selection_page.dart';
import '../../features/mental_health_assessment/view/time_dedication_selection_page.dart';
import '../../features/mental_health_assessment/view/meditation_time_selection_page.dart';
import '../../features/mental_health_assessment/view/happiness_selection_page.dart';
import '../../features/mental_health_assessment/view/notification_setup_page.dart';
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
import '../../features/mental_health_assessment/view/biometric_setup_page.dart';
import '../../features/mental_health_assessment/view/home_screen_page.dart';
import '../../features/mental_health_assessment/view/mental_health_metrics_page.dart';
import '../../features/mental_health_assessment/view/omie_score_detail_page.dart';
import '../../features/mental_health_assessment/view/wellness_score_detail_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_explanation_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_history_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_level_details_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_metrics_overview_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_insight_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_logging_page.dart';
import '../../features/mental_health_assessment/view/mindfulness_goal_settings_page.dart';
import '../../features/mental_health_assessment/view/date_picker_modal_page.dart';

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
  static const String dataSecurityConsent = '/data-security-consent';
  static const String heightSelection = '/height-selection';
  static const String mentalHealthConditions = '/mental-health-conditions';
  static const String sleepLevelSelection = '/sleep-level-selection';
  static const String timeDedicationSelection = '/time-dedication-selection';
  static const String meditationTimeSelection = '/meditation-time-selection';
  static const String happinessSelection = '/happiness-selection';
  static const String notificationSetup = '/notification-setup';
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
  static const String biometricSetup = '/biometric-setup';
  static const String homeScreen = '/home-screen';
  static const String mentalHealthMetrics = '/mental-health-metrics';
  static const String omieScoreDetail = '/omie-score-detail';
  static const String wellnessScoreDetail = '/wellness-score-detail';
  static const String mindfulnessExplanation = '/mindfulness-explanation';
  static const String mindfulnessHistory = '/mindfulness-history';
  static const String mindfulnessLevelDetails = '/mindfulness-level-details';
  static const String mindfulnessMetricsOverview =
      '/mindfulness-metrics-overview';
  static const String mindfulnessInsight = '/mindfulness-insight';
  static const String mindfulnessLogging = '/mindfulness-logging';
  static const String mindfulnessGoalSettings = '/mindfulness-goal-settings';
  static const String datePickerModal = '/date-picker-modal';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const MentalHealthMetricsPage(),
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
      case dataSecurityConsent:
        return MaterialPageRoute(
          builder: (_) => const DataSecurityConsentPage(),
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
      case notificationSetup:
        return MaterialPageRoute(
          builder: (_) => const NotificationSetupPage(),
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
      case biometricSetup:
        return MaterialPageRoute(
          builder: (_) => const BiometricSetupPage(),
          settings: settings,
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreenPage(),
          settings: settings,
        );
      case mentalHealthMetrics:
        return MaterialPageRoute(
          builder: (_) => const MentalHealthMetricsPage(),
          settings: settings,
        );
      case omieScoreDetail:
        return MaterialPageRoute(
          builder: (_) => const OmieScoreDetailPage(),
          settings: settings,
        );
      case wellnessScoreDetail:
        return MaterialPageRoute(
          builder: (_) => const WellnessScoreDetailPage(),
          settings: settings,
        );
      case mindfulnessExplanation:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessExplanationPage(),
          settings: settings,
        );
      case mindfulnessHistory:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessHistoryPage(),
          settings: settings,
        );
      case mindfulnessLevelDetails:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessLevelDetailsPage(),
          settings: settings,
        );
      case mindfulnessMetricsOverview:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessMetricsOverviewPage(),
          settings: settings,
        );
      case mindfulnessInsight:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessInsightPage(),
          settings: settings,
        );
      case mindfulnessLogging:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessLoggingPage(),
          settings: settings,
        );
      case mindfulnessGoalSettings:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessGoalSettingsPage(),
          settings: settings,
        );
      case datePickerModal:
        return MaterialPageRoute(
          builder: (_) => const DatePickerModalPage(),
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
