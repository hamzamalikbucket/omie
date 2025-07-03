import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [MentalHealthConditionsPage] - Mental Health Conditions selection page
/// This page allows users to select mental health conditions they may have
/// as part of the comprehensive mental health assessment flow
class MentalHealthConditionsPage extends StatelessWidget {
  const MentalHealthConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const MentalHealthConditionsView(),
    );
  }
}

/// [MentalHealthConditionsView] - The main view for mental health conditions selection
/// Displays various mental health condition options as selectable badges
class MentalHealthConditionsView extends StatelessWidget {
  const MentalHealthConditionsView({super.key});

  /// List of available mental health conditions as shown in Figma
  static const List<String> _mentalHealthConditions = [
    'Anxious',
    'PTSD',
    'Bipolar',
    'Depressed',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [MentalHealthConditionsView] Navigate to sleep level selection page
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).pushNamed(AppRoutes.sleepLevelSelection);
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
                  // [MentalHealthConditionsViewState] Handle skip action - navigate to next step
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
  /// illustration, condition selection, and action buttons
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
            "Do you have any mental health conditions?",
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
          // Illustration from Figma design
          _buildIllustration(),
          SizedBox(height: 24.h),
          // Mental health conditions selection container
          _buildConditionsContainer(context, theme, state),
          const Spacer(),
          // Action buttons - Continue and No
          _buildActionButtons(context, theme, state),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildIllustration] - Builds the illustration section showing
  /// the mental health assessment image from Figma
  Widget _buildIllustration() {
    return SizedBox(
      width: 238.w,
      height: 177.h,
      child: SvgPicture.asset(
        'assets/images/mental_health_conditions_illustration.svg',
        width: 238.w,
        height: 177.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildConditionsContainer] - Builds the container with selectable
  /// mental health condition badges and step indicator
  Widget _buildConditionsContainer(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        border: Border.all(
          color: const Color(0xFFF08C51), // Orange border from Figma
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24.r),
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
        children: [
          // Condition badges section
          _buildConditionOptions(context, theme, state),
          SizedBox(height: 32.h),
          // Step indicator - dynamic based on selections
          _buildStepIndicator(theme, state),
        ],
      ),
    );
  }

  /// [_buildConditionOptions] - Builds the selectable mental health condition badges
  /// Users can select multiple conditions from the available options
  Widget _buildConditionOptions(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        spacing: 8.w,
        runSpacing: 8.h,
        children: _mentalHealthConditions.map((condition) {
          final isSelected = state.selectedConditions.contains(condition);
          return GestureDetector(
            onTap: () {
              // [MentalHealthConditionsView] Toggle condition selection via BLoC
              context
                  .read<MentalHealthAssessmentBloc>()
                  .add(MentalHealthConditionToggled(condition));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                // Change background color based on selection state
                color: isSelected
                    ? const Color(0xFFFFEDE2) // Light orange for selected
                    : Colors.transparent, // Transparent for unselected
                borderRadius: BorderRadius.circular(9999.r),
                border: isSelected
                    ? null
                    : Border.all(
                        color: const Color(0xFFE7E5E4), // Light gray border
                        width: 1,
                      ),
              ),
              child: Text(
                condition,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  // Change text color based on selection state
                  color: isSelected
                      ? const Color(0xFFF08C51) // Orange for selected
                      : const Color(0xFF57534E), // Gray for unselected
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// [_buildStepIndicator] - Builds the step indicator showing current progress
  /// Updates dynamically based on number of selected conditions
  Widget _buildStepIndicator(
      YouthYogaTheme theme, MentalHealthAssessmentState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Note icon
        SvgPicture.asset(
          'assets/images/question_mark_circle_icon.svg',
          width: 20.w,
          height: 20.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFFA8A29E), // Light gray color
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: 4.w),
        // Step indicator text - dynamic based on selections
        Text(
          '${state.selectedConditions.length}/10',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF57534E), // Gray color
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
      ],
    );
  }

  /// [_buildActionButtons] - Builds the Continue and No action buttons
  /// Continue button is primary, No button is outlined style
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Column(
      children: [
        // Continue button - primary action
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              // [MentalHealthConditionsViewState] Handle continue action
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
        ),
        SizedBox(height: 12.h),
        // No button - outlined style
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton(
            onPressed: () {
              // [MentalHealthConditionsView] Handle "No" action - skip conditions
              // Clear any selected conditions and proceed
              // First clear all conditions
              for (final condition in state.selectedConditions.toList()) {
                context
                    .read<MentalHealthAssessmentBloc>()
                    .add(MentalHealthConditionToggled(condition));
              }
              // Then proceed
              context
                  .read<MentalHealthAssessmentBloc>()
                  .add(const ReadyButtonPressed());
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF926247), // Brown text
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999.r),
              ),
              side: const BorderSide(
                color: Color(0xFF926247), // Brown border
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/chevron_left.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF926247), // Brown color
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'No',
                  style: theme.labelLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF926247), // Brown text
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
