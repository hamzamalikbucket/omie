import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [TimeDedicationSelectionPage] - Time dedication selection page
/// This page allows users to select how much time they would dedicate daily
/// as part of the comprehensive mental health assessment flow
class TimeDedicationSelectionPage extends StatelessWidget {
  const TimeDedicationSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const TimeDedicationSelectionView(),
    );
  }
}

/// [TimeDedicationSelectionView] - The main view for time dedication selection
/// Displays four time commitment options in a 2x2 grid layout
class TimeDedicationSelectionView extends StatelessWidget {
  const TimeDedicationSelectionView({super.key});

  /// Time dedication options with details
  static const List<TimeDedicationOption> _timeDedicationOptions = [
    TimeDedicationOption(
      id: 'less_than_5',
      title: '< 5 minutes',
      subtitle: "I don't have time",
      iconPath: 'assets/images/clock_icon.svg',
    ),
    TimeDedicationOption(
      id: '5_to_10',
      title: '5 - 10 minutes',
      subtitle: "I'm a little busy",
      iconPath: 'assets/images/briefcase_alt_icon.svg',
    ),
    TimeDedicationOption(
      id: '10_to_20',
      title: '10 - 20 minutes',
      subtitle: 'I can do a few thing',
      iconPath: 'assets/images/activity_yoga_icon.svg',
    ),
    TimeDedicationOption(
      id: 'more_than_30',
      title: '> 30 minutes',
      subtitle: 'I have all the time ',
      iconPath: 'assets/images/activity_meditation_icon.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [TimeDedicationSelectionView] Navigate to happiness selection when continue is pressed
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).pushNamed(AppRoutes.happinessSelection);
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
                  // [TimeDedicationSelectionView] Handle skip action - navigate to next step
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
  /// time dedication options grid, and continue button
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
            "How much time would you dedicate daily?",
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
          // Time dedication options
          _buildTimeDedicationGrid(context, theme, state),
          const Spacer(),
          // Continue button
          _buildContinueButton(context, theme),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildTimeDedicationGrid] - Builds the 2x2 grid of time dedication options
  Widget _buildTimeDedicationGrid(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Column(
      children: [
        // First row - 2 options
        Row(
          children: [
            Expanded(
              child: _buildTimeDedicationOption(
                context,
                theme,
                state,
                _timeDedicationOptions[0],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTimeDedicationOption(
                context,
                theme,
                state,
                _timeDedicationOptions[1],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        // Second row - 2 options
        Row(
          children: [
            Expanded(
              child: _buildTimeDedicationOption(
                context,
                theme,
                state,
                _timeDedicationOptions[2],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTimeDedicationOption(
                context,
                theme,
                state,
                _timeDedicationOptions[3],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// [_buildTimeDedicationOption] - Builds individual time dedication option card
  Widget _buildTimeDedicationOption(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
    TimeDedicationOption option,
  ) {
    final isSelected = state.selectedTimeDedication == option.id;

    return GestureDetector(
      onTap: () {
        // [TimeDedicationSelectionView] Handle time dedication selection
        context
            .read<MentalHealthAssessmentBloc>()
            .add(TimeDedicationChanged(option.id));
      },
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          // Background color changes based on selection
          color: isSelected
              ? const Color(0xFFF5F7EE) // Light green for selected
              : theme.primaryBackground, // White for unselected
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF9BB167) // Green border for selected
                : const Color(0xFFE5E5E5), // Light gray border for unselected
            width: 1,
          ),
          boxShadow: [
            // Shadow effect as shown in Figma
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
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(
                        0xFFE9EED9) // Darker green for selected icon background
                    : const Color(0xFFFAFAF9), // Light gray for unselected
                borderRadius: BorderRadius.circular(9999.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  option.iconPath,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? const Color(0xFF9BB167) // Green for selected
                        : const Color(0xFF57534E), // Gray for unselected
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Title and subtitle text
            Column(
              children: [
                // Title
                Text(
                  option.title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF3F4B29) // Dark green for selected
                        : const Color(0xFF292524), // Dark for unselected
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                // Subtitle
                Text(
                  option.subtitle,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E), // Gray for both states
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [TimeDedicationSelectionView] Handle continue action
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

/// [TimeDedicationOption] - Data class for time dedication options
class TimeDedicationOption {
  const TimeDedicationOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconPath;
}
