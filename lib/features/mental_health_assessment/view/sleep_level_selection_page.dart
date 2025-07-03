import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [SleepLevelSelectionPage] - Sleep level rating page
/// This page allows users to rate their sleep level from 1-5
/// as part of the comprehensive mental health assessment flow
class SleepLevelSelectionPage extends StatelessWidget {
  const SleepLevelSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const SleepLevelSelectionView(),
    );
  }
}

/// [SleepLevelSelectionView] - The main view for sleep level selection
/// Displays a horizontal tab group with sleep level options 1-5
class SleepLevelSelectionView extends StatelessWidget {
  const SleepLevelSelectionView({super.key});

  /// Sleep level options with descriptive text
  static const Map<int, String> _sleepLevelDescriptions = {
    1: 'Very Poor',
    2: 'Poor',
    3: 'Moderate',
    4: 'Good',
    5: 'Excellent',
  };

  /// Sleep duration descriptions for each level
  static const Map<int, String> _sleepDurationDescriptions = {
    1: 'I sleep 1 - 2 hours daily',
    2: 'I sleep 2 - 3 hours daily',
    3: 'I sleep 4 - 5 hours daily',
    4: 'I sleep 6 - 7 hours daily',
    5: 'I sleep 8+ hours daily',
  };

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [SleepLevelSelectionView] Navigate to next step when continue is pressed
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // TODO: Navigate to next step in assessment flow
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to next step')),
          );
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.primaryBackground,
            body: SafeArea(
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
          // Top navigation row with back button, progress bar, and skip
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
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
              // Progress bar section - showing 50% completion as per Figma
              Expanded(
                child: Column(
                  children: [
                    // Progress bar container
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
                  // [SleepLevelSelectionView] Handle skip action - navigate to next step
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
        'Comprehensive Mental Health Assessment',
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
  /// rating display, tab selector, and description
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
            "How would you rate your sleep level?",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.27,
              letterSpacing: -0.013 * 30.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Sleep level rating content
          _buildRatingContent(context, theme, state),
          const Spacer(),
          // Continue button
          _buildContinueButton(context, theme),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildRatingContent] - Builds the main rating content with
  /// large number display, tab selector, and description
  Widget _buildRatingContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    // Default to level 3 if none selected (as shown in Figma)
    final selectedLevel = state.selectedSleepLevel ?? 3;

    return Column(
      children: [
        // Large number and description display
        _buildRatingDisplay(theme, selectedLevel),
        SizedBox(height: 32.h),
        // Horizontal tab group for sleep level selection
        _buildSleepLevelTabs(context, theme, state),
        SizedBox(height: 24.h),
        // Sleep duration description with icon
        _buildSleepDescription(theme, selectedLevel),
      ],
    );
  }

  /// [_buildRatingDisplay] - Builds the large number and descriptive text
  Widget _buildRatingDisplay(YouthYogaTheme theme, int level) {
    return Column(
      children: [
        // Large number display
        Text(
          level.toString(),
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 128.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFF08C51), // Orange color from Figma
            height: 1.06,
            letterSpacing: -0.04 * 128.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        // Descriptive text
        Text(
          _sleepLevelDescriptions[level] ?? 'Moderate',
          style: theme.headlineLarge.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E), // Gray color
            height: 1.27,
            letterSpacing: -0.013 * 30.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// [_buildSleepLevelTabs] - Builds the horizontal tab group for level selection
  Widget _buildSleepLevelTabs(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    final selectedLevel = state.selectedSleepLevel ?? 3;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E5E4), // Background color from Figma
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        children: List.generate(5, (index) {
          final level = index + 1;
          final isSelected = level == selectedLevel;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                // [SleepLevelSelectionView] Handle sleep level selection
                context
                    .read<MentalHealthAssessmentBloc>()
                    .add(SleepLevelChanged(level));
              },
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primaryBackground // White for selected
                      : Colors.transparent, // Transparent for unselected
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0x000f172a).withOpacity(0.02),
                            offset: const Offset(0, 8),
                            blurRadius: 16,
                          ),
                          BoxShadow(
                            color: const Color(0x000f172a).withOpacity(0.03),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    level.toString(),
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF292524) // Dark for selected
                          : const Color(0xFF57534E), // Gray for unselected
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// [_buildSleepDescription] - Builds the sleep description with icon
  Widget _buildSleepDescription(YouthYogaTheme theme, int level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Sleep icon
        SvgPicture.asset(
          'assets/images/sleep_zzz_icon.svg',
          width: 20.w,
          height: 20.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFFA8A29E), // Light gray color
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 8.w),
        // Sleep duration description
        Text(
          _sleepDurationDescriptions[level] ?? 'I sleep 4 - 5 hours daily',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E), // Gray color
            height: 1.375,
            letterSpacing: -0.007 * 16.sp,
          ),
        ),
      ],
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [SleepLevelSelectionView] Handle continue action
          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primary, // Orange primary
          foregroundColor: theme.primaryBackground, // White text
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
              'Continue',
              style: theme.labelLarge.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: theme.primaryBackground,
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                theme.primaryBackground,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
