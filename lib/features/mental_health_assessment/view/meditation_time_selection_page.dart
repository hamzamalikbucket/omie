import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [MeditationTimeSelectionPage] - Meditation time selection page
/// This page allows users to select their preferred meditation time
/// as part of the comprehensive mental health assessment flow
class MeditationTimeSelectionPage extends StatelessWidget {
  const MeditationTimeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const MeditationTimeSelectionView(),
    );
  }
}

/// [MeditationTimeSelectionView] - The main view for meditation time selection
/// Displays three meditation time options in a horizontal layout
class MeditationTimeSelectionView extends StatelessWidget {
  const MeditationTimeSelectionView({super.key});

  /// Meditation time options with details
  static const List<MeditationTimeOption> _meditationTimeOptions = [
    MeditationTimeOption(
      id: 'morning',
      title: 'Morning',
      time: '~08:00 AM',
      iconPath: 'assets/images/sun_icon.svg',
    ),
    MeditationTimeOption(
      id: 'afternoon',
      title: 'Afternoon',
      time: '~02:00 PM',
      iconPath: 'assets/images/leaf_double_icon.svg',
    ),
    MeditationTimeOption(
      id: 'evening',
      title: 'Evening',
      time: '~08:00 PM',
      iconPath: 'assets/images/moon_icon.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [MeditationTimeSelectionView] Navigate to next step when continue is pressed
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
                  // [MeditationTimeSelectionView] Handle skip action - navigate to next step
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
  /// meditation time options, and continue button
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
            "What is the best time for you to meditate?",
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
          // Meditation time options container with fixed height
          SizedBox(
            height: 324.h, // Fixed height from Figma
            child: _buildMeditationTimeOptions(context, theme, state),
          ),
          const Spacer(),
          // Continue button
          _buildContinueButton(context, theme),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildMeditationTimeOptions] - Builds the meditation time options layout
  Widget _buildMeditationTimeOptions(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Stack(
      children: [
        // First option - Morning (top center)
        Positioned(
          left: 92.w,
          top: 0.h,
          child: _buildMeditationTimeOption(
            context,
            theme,
            state,
            _meditationTimeOptions[0],
          ),
        ),
        // Second option - Afternoon (bottom left) - selected state
        Positioned(
          left: 0.w,
          top: 162.h,
          child: _buildMeditationTimeOption(
            context,
            theme,
            state,
            _meditationTimeOptions[1],
          ),
        ),
        // Third option - Evening (bottom right)
        Positioned(
          left: 180.w,
          top: 162.h,
          child: _buildMeditationTimeOption(
            context,
            theme,
            state,
            _meditationTimeOptions[2],
          ),
        ),
      ],
    );
  }

  /// [_buildMeditationTimeOption] - Builds individual meditation time option card
  Widget _buildMeditationTimeOption(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
    MeditationTimeOption option,
  ) {
    final isSelected = state.selectedMeditationTime == option.id;

    return GestureDetector(
      onTap: () {
        // [MeditationTimeSelectionView] Handle meditation time selection
        context
            .read<MentalHealthAssessmentBloc>()
            .add(MeditationTimeChanged(option.id));
      },
      child: Container(
        width: 162.w,
        height: 162.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          // Background color changes based on selection
          color: isSelected
              ? const Color(
                  0xFFFFEDE2) // Light orange for selected (afternoon in Figma)
              : const Color(0xFFFFFFFF), // White for unselected
          borderRadius: BorderRadius.circular(1234.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFF08C51) // Orange border for selected
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
            SizedBox(
              width: 32.w,
              height: 32.w,
              child: SvgPicture.asset(
                option.iconPath,
                width: 32.w,
                height: 32.w,
                colorFilter: ColorFilter.mode(
                  // Icon color changes based on option and selection
                  option.id == 'morning'
                      ? const Color(0xFFFBBF24) // Yellow for sun
                      : isSelected && option.id == 'afternoon'
                          ? const Color(
                              0xFF9BB167) // Green for selected afternoon
                          : const Color(0xFF533630), // Stone for others
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // Title and time text
            Column(
              children: [
                // Title
                Text(
                  option.title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF533630), // Stone color for all
                    height: 1.33,
                    letterSpacing: -0.012 * 24.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Time
                Text(
                  option.time,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF57534E), // Gray for all
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
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
          // [MeditationTimeSelectionView] Handle continue action
          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary from Figma
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

/// [MeditationTimeOption] - Data class for meditation time options
class MeditationTimeOption {
  const MeditationTimeOption({
    required this.id,
    required this.title,
    required this.time,
    required this.iconPath,
  });

  final String id;
  final String title;
  final String time;
  final String iconPath;
}
