import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [BiometricSetupPage] - Biometric Setup page
/// This page allows users to set up fingerprint authentication
/// as part of the mental health assessment flow
class BiometricSetupPage extends StatelessWidget {
  const BiometricSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const BiometricSetupView(),
    );
  }
}

/// [BiometricSetupView] - The main view for biometric setup
/// Displays fingerprint setup instructions with illustration and action buttons
class BiometricSetupView extends StatefulWidget {
  const BiometricSetupView({super.key});

  @override
  State<BiometricSetupView> createState() => _BiometricSetupViewState();
}

class _BiometricSetupViewState extends State<BiometricSetupView> {
  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [BiometricSetupView] Handle navigation when biometric setup is complete
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          print('[BiometricSetupView] Navigate to FaceID setup');
          Navigator.of(context).pushNamed(AppRoutes.faceIdSetup);
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        _buildTopNavigation(context, theme),
                        _buildTitle(theme),
                        Expanded(
                          child: _buildMainContent(context, theme, state),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation bar with back button,
  /// progress indicator, and skip option
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        children: [
          // Top navigation row
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle back navigation
                  print('[BiometricSetupView] Back button pressed');
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    'assets/images/chevron_left.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF533630), // Stone color from Figma
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Progress bar section
              Expanded(
                child: Column(
                  children: [
                    // Progress bar
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E5E4), // Background
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          // Filled portion (50%)
                          Expanded(
                            flex: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (50%)
                          const Expanded(
                            flex: 50,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Skip button
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle skip action
                  print('[BiometricSetupView] Skip button pressed');
                  // TODO: Handle skip action
                },
                child: Text(
                  'Skip',
                  style: theme.labelLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF533630), // Stone color
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildTitle] - Builds the assessment title section
  Widget _buildTitle(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 8.h),
      child: Text(
        'Profile Setup & Account Completion',
        style: theme.bodyLarge.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57534E), // Stone/60 from Figma
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content area with question,
  /// illustration, and action buttons
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.h),
          // Main question text
          Text(
            "Biometric Setup",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.27, // 38px line height / 30px font size
              letterSpacing: -0.012 * 30.sp, // -1.2%
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Subtitle text
          Text(
            "Please put your fingerprint on your touch sensor for 5 seconds",
            style: theme.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60 from Figma
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Illustration from Figma design
          _buildIllustration(),
          const Spacer(),
          // Action buttons
          _buildActionButtons(context, theme, state),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildIllustration] - Builds the fingerprint illustration image
  Widget _buildIllustration() {
    return Container(
      width: 343.w,
      height: 250.h,
      alignment: Alignment.center,
      child: SizedBox(
        width: 226.11.w,
        height: 233.25.h,
        child: SvgPicture.asset(
          'assets/images/biometric_setup_illustration.svg',
          width: 226.11.w,
          height: 233.25.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// [_buildActionButtons] - Builds the action buttons (Continue and Skip this step)
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Column(
      children: [
        // Continue button
        _buildContinueButton(context, theme, state),
        SizedBox(height: 12.h),

        // Skip this step button
        _buildSkipButton(context, theme, state),
      ],
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildContinueButton] Handle continue action
          print('[BiometricSetupView] Continue button pressed');

          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange background
          foregroundColor: const Color(0xFFFFFFFF), // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF), // White text
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFFFF), // White color for the icon
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildSkipButton] - Builds the skip this step button
  Widget _buildSkipButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: 342.w,
      child: TextButton(
        onPressed: () {
          // [_buildSkipButton] Handle skip this step action
          print('[BiometricSetupView] Skip this step button pressed');
          // TODO: Navigate to next step or skip biometric setup
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF08C51), // Orange text
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        ),
        child: Text(
          'Skip this step',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF08C51), // Orange text
            height: 1.375, // 22px line height / 16px font size
            letterSpacing: -0.007 * 16.sp, // -0.7%
          ),
        ),
      ),
    );
  }
}
