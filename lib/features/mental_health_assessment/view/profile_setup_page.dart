import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [ProfileSetupPage] - Profile setup and account completion page
/// This page shows the final step of the assessment with profile setup options
class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const ProfileSetupView(),
    );
  }
}

/// [ProfileSetupView] - The main view for profile setup
/// Displays the completion screen with profile setup options
class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [ProfileSetupView] Handle navigation or other state changes
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // TODO: Navigate to next step
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: Stack(
              children: [
                // Orange top section that extends to the top of the screen
                _buildOrangeTopSection(theme),

                // Main content in safe area
                SafeArea(
                  child: Column(
                    children: [
                      // Space for the orange section content
                      SizedBox(
                          height:
                              90.h), // Height to accommodate logo and padding

                      _buildSlider(theme, state),
                      // Main content on white background
                      Expanded(
                        child: _buildMainContent(context, theme),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlider(YouthYogaTheme theme, MentalHealthAssessmentState state) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            children: [
              // Progress dots and lines
              Row(
                children: [
                  // Step 1 line (hidden)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: const Color(0xFFD6D3D1),
                    ),
                  ),
                  // Step 1 dot (completed)
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BB167),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  // Line between step 1 and 2
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: const Color(0xFF9BB167),
                    ),
                  ),
                  // Step 2 dot (active)
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF9BB167),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9BB167).withOpacity(0.25),
                          blurRadius: 4,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9BB167),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  // Line between step 2 and 3
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: const Color(0xFFD6D3D1),
                    ),
                  ),
                  // Step 3 dot (incomplete)
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6D3D1),
                      border: Border.all(
                        color: const Color(0xFFD6D3D1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6D3D1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  // Step 3 line (hidden)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: const Color(0xFFD6D3D1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Step labels
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Assessment',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.43,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'Personal Info',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.43,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                'Choose Plan',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.43,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// [_buildOrangeTopSection] - Builds the orange top section with logo and progress indicator
  /// This section extends to the top of the screen but keeps content within safe area
  Widget _buildOrangeTopSection(YouthYogaTheme theme) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF08C51), // Orange primary
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          bottom: false, // Only respect top safe area
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo and app name
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Yoga logo
                    SvgPicture.asset(
                      'assets/images/yoga_logo_profile.svg',
                      width: 25.w,
                      height: 25.h,
                    ),
                    SizedBox(width: 4.w),
                    // App name
                    Text(
                      'Omie',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFFFFFF),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildProgressStep] - Builds individual progress step
  Widget _buildProgressStep({
    required String title,
    required bool isCompleted,
    required bool isActive,
    required bool showLineBefore,
    required bool showLineAfter,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step indicator with lines
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Line before
              if (showLineBefore)
                Expanded(
                  child: Container(
                    height: 2.h,
                    color: isCompleted || isActive
                        ? const Color(0xFF9BB167) // Green
                        : const Color(0xFFD6D3D1), // Gray
                  ),
                ),
              SizedBox(width: 4.w),
              // Step dot
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF9BB167) // Green filled
                      : isActive
                          ? const Color(0xFFFFFFFF) // White
                          : const Color(0xFFD6D3D1), // Gray
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF9BB167) // Green
                        : isActive
                            ? const Color(0xFF9BB167) // Green
                            : const Color(0xFFD6D3D1), // Gray
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(0xFF9BB167).withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 4,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFFFFFFFF) // White dot
                          : isActive
                              ? const Color(0xFF9BB167) // Green dot
                              : const Color(0xFFD6D3D1), // Gray dot
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              // Line after
              if (showLineAfter)
                Expanded(
                  child: Container(
                    height: 2.h,
                    color: isCompleted
                        ? const Color(0xFF9BB167) // Green
                        : const Color(0xFFD6D3D1), // Gray
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          // Step title - white text for visibility on orange background
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFFFFFF), // White text on orange background
              height: 1.43,
              letterSpacing: -0.006 * 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content with illustration and buttons
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      child: Column(
        children: [
          // Background illustration
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  // Background illustration
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/profile_setup_background.svg',
                      width: 343.w,
                      height: 192.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Text content
          Column(
            children: [
              // Main title
              Text(
                'Almost there! Let\'s set up your profile and security.',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF08C51), // Orange
                  height: 1.27,
                  letterSpacing: -0.013 * 30.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              // Subtitle
              Text(
                'Your mental health data is very important, and we don\'t sell it to anyone! ??',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E), // Stone/60
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          // Buttons
          Column(
            children: [
              // I'm ready button (primary)
              _buildPrimaryButton(context, theme),
              SizedBox(height: 24.h),
              // I need help button (secondary)
              _buildSecondaryButton(context, theme),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildPrimaryButton] - Builds the primary "I'm ready" button
  Widget _buildPrimaryButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [ProfileSetupView] Handle I'm ready action
          Navigator.pushNamed(context, AppRoutes.avatarSelection);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary
          foregroundColor: const Color(0xFFFFFFFF), // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'I\'m ready',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFFFF),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildSecondaryButton] - Builds the secondary "I need help" button
  Widget _buildSecondaryButton(BuildContext context, YouthYogaTheme theme) {
    return GestureDetector(
      onTap: () {
        // [ProfileSetupView] Handle I need help action
        // TODO: Navigate to help or support page
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/question_mark_circle_icon.svg',
            width: 20.w,
            height: 20.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFF9BB167), // Green
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'I need help',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9BB167), // Green
              height: 1.375,
              letterSpacing: -0.007 * 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
