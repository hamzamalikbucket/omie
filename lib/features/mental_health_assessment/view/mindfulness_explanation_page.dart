import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessExplanationPage] - Page wrapper for Mindfulness Explanation screen
/// This page displays educational content about how mindfulness scoring works
/// following Apple's Human Interface Guidelines for educational content
class MindfulnessExplanationPage extends StatelessWidget {
  const MindfulnessExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MindfulnessExplanationBloc()..add(const LoadMindfulnessExplanation()),
      child: const MindfulnessExplanationView(),
    );
  }
}

/// [MindfulnessExplanationView] - Main view for the Mindfulness Explanation screen
/// Displays current score, explanation text, measurement factors, and score breakdown
/// using modern, educational design patterns inspired by Apple's health apps
class MindfulnessExplanationView extends StatelessWidget {
  const MindfulnessExplanationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessExplanationBloc, MindfulnessExplanationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              const Color(0xFFF08C51), // Orange background from Figma
          body: SafeArea(
            child: Column(
              children: [
                // Top navigation
                _buildTopNavigation(context, theme),

                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      // Top decorative section with ellipse
                      _buildTopDecorativeSection(),

                      // White content area
                      Expanded(
                        child: Container(
                          width: 375.w,
                          color: const Color(0xFFFFFFFF), // White background
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 24.h),
                              child: SizedBox(
                                width: 343.w,
                                child: Column(
                                  children: [
                                    // Score header section
                                    _buildScoreHeader(context, theme, state),

                                    SizedBox(height: 32.h),

                                    // How it's measured section
                                    _buildHowMeasuredSection(
                                        context, theme, state),

                                    SizedBox(height: 24.h),

                                    // Score breakdown section
                                    _buildScoreBreakdownSection(
                                        context, theme, state),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Home indicator
                _buildHomeIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation with back button, title, and notification
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 54.h,
      color: const Color(0xFFF08C51), // Orange background
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - back button and title
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // [_buildTopNavigation] Navigate back
                    print('[MindfulnessExplanationPage] Back button pressed');
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/images/chevron_left_icon.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFFFFFF), // White color
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'What is Mindfulness Level?',
                  style: theme.headlineLarge.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF), // White color
                    height: 1.9,
                    letterSpacing: -0.013 * 20.sp,
                  ),
                ),
              ],
            ),

            // Right side - notification icon
            GestureDetector(
              onTap: () {
                // [_buildTopNavigation] Open notifications
                print(
                    '[MindfulnessExplanationPage] Notification button pressed');
              },
              child: SvgPicture.asset(
                'assets/images/bell_notification_icon.svg',
                width: 24.w,
                height: 24.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFFFF), // White color
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildTopDecorativeSection] - Builds the top decorative section with ellipse
  Widget _buildTopDecorativeSection() {
    return SizedBox(
      width: 375.w,
      height: 48.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Large decorative ellipse positioned exactly like Figma design
          Positioned(
            left: -253.w,
            top: 0.h,
            child: Container(
              width: 880.w,
              height: 880.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // White background
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildScoreHeader] - Builds the score header with heart icon, score, and explanation
  Widget _buildScoreHeader(BuildContext context, YouthYogaTheme theme,
      MindfulnessExplanationState state) {
    return Column(
      children: [
        // Heart icon with score
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Heart icon (40x40 from Figma)
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: SvgPicture.asset(
                'assets/images/wellness_heart_icon.svg',
                width: 40.w,
                height: 40.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFF08C51), // Orange color from Figma
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // Score and unit
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Score value (88.2)
                Text(
                  state.score,
                  style: theme.headlineLarge.copyWith(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF533630), // Dark brown from Figma
                    height: 1.133,
                    letterSpacing: -0.018 * 60.sp,
                  ),
                ),

                // Unit (pts) with bottom padding
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Text(
                    'pts',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E), // Medium gray from Figma
                      height: 1.333,
                      letterSpacing: -0.012 * 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Status message
        Text(
          state.statusMessage,
          style: theme.bodyMedium.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF57534E), // Medium gray from Figma
            height: 1.375,
            letterSpacing: -0.007 * 16.sp,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16.h),

        // Progress visualization
        _buildProgressVisualization(state),

        SizedBox(height: 16.h),

        // Explanation text
        Text(
          state.explanation,
          style: theme.bodyMedium.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// [_buildProgressVisualization] - Builds the progress visualization bars
  Widget _buildProgressVisualization(MindfulnessExplanationState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Three background bars
        ...List.generate(3, (index) {
          return Container(
            width: 72.w,
            height: 8.h,
            margin: EdgeInsets.only(right: index < 2 ? 8.w : 0),
            decoration: BoxDecoration(
              color: const Color(0xFF9BB167), // Green color from Figma
              borderRadius: BorderRadius.circular(9999.r),
            ),
          );
        }),

        SizedBox(width: 8.w),

        // Main progress bar
        SizedBox(
          width: 72.w,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 8.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5E4), // Light gray background
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: state.currentProgress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BB167), // Green progress color
                      borderRadius: BorderRadius.circular(9999.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildHowMeasuredSection] - Builds the "How it's measured" section
  Widget _buildHowMeasuredSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessExplanationState state) {
    return Column(
      children: [
        // Section header
        _buildSectionHeader(
          theme,
          'How it\'s measured',
          onSeeAllTap: () {
            // [_buildHowMeasuredSection] Navigate to mindfulness level details
            print(
                '[MindfulnessExplanationPage] How measured See All pressed - navigating to mindfulness level details');
            Navigator.of(context).pushNamed(AppRoutes.mindfulnessLevelDetails);
          },
        ),

        SizedBox(height: 12.h),

        // Measurement factors card
        Container(
          width: 343.w,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: const Offset(0, 5),
                blurRadius: 18,
              ),
            ],
          ),
          child: Column(
            children: state.measurementFactors.asMap().entries.map((entry) {
              final index = entry.key;
              final factor = entry.value;
              final isLast = index == state.measurementFactors.length - 1;

              return Column(
                children: [
                  _buildMeasurementFactor(theme, factor),
                  if (!isLast) ...[
                    SizedBox(height: 16.h),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xFFE7E5E4), // Light gray divider
                    ),
                    SizedBox(height: 16.h),
                  ],
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// [_buildMeasurementFactor] - Builds a single measurement factor item
  Widget _buildMeasurementFactor(
      YouthYogaTheme theme, MeasurementFactor factor) {
    return Row(
      children: [
        // Number badge
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFF08C51), // Orange border
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              factor.number,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF08C51), // Orange text
                height: 1.333,
                letterSpacing: -0.005 * 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                factor.title,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                factor.description,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E),
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildScoreBreakdownSection] - Builds the score breakdown section
  Widget _buildScoreBreakdownSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessExplanationState state) {
    return Column(
      children: [
        // Section header
        _buildSectionHeader(
          theme,
          'Score breakdown',
          onSeeAllTap: () {
            // [_buildScoreBreakdownSection] Navigate to mindfulness level details
            print(
                '[MindfulnessExplanationPage] Score breakdown See All pressed - navigating to mindfulness level details');
            Navigator.of(context).pushNamed(AppRoutes.mindfulnessLevelDetails);
          },
        ),

        SizedBox(height: 12.h),

        // Score breakdown card
        Container(
          width: 343.w,
          padding: EdgeInsets.fromLTRB(8.w, 16.w, 8.w, 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: const Offset(0, 5),
                blurRadius: 18,
              ),
            ],
          ),
          child: Column(
            children: state.scoreBreakdowns.asMap().entries.map((entry) {
              final index = entry.key;
              final breakdown = entry.value;
              final isLast = index == state.scoreBreakdowns.length - 1;

              return Column(
                children: [
                  _buildScoreBreakdownItem(theme, breakdown),
                  if (!isLast) ...[
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xFFE7E5E4), // Light gray divider
                    ),
                    SizedBox(height: 12.h),
                  ],
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// [_buildScoreBreakdownItem] - Builds a single score breakdown item
  Widget _buildScoreBreakdownItem(
      YouthYogaTheme theme, ScoreBreakdown breakdown) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          // Top row with icon and range
          Row(
            children: [
              // Icon container
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Color(breakdown.backgroundColor),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    breakdown.iconPath,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: ColorFilter.mode(
                      Color(breakdown.iconColor),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Range text
              Expanded(
                child: Text(
                  breakdown.range,
                  style: theme.headlineLarge.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.4,
                    letterSpacing: -0.01 * 20.sp,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Progress bars
              SizedBox(
                width: 64.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    final isFilled = index < breakdown.progressCount;
                    return Container(
                      width: 12.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? Color(breakdown.progressColor)
                            : const Color(0xFFE7E5E4),
                        borderRadius: BorderRadius.circular(9999.r),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Description text
          Text(
            breakdown.description,
            style: theme.bodyMedium.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E),
              height: 1.6,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  /// [_buildSectionHeader] - Builds a section header with title and See All link
  Widget _buildSectionHeader(YouthYogaTheme theme, String title,
      {VoidCallback? onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.titleMedium.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292524),
            height: 1.375,
            letterSpacing: -0.007 * 16.sp,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See All',
            style: theme.bodyMedium.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF08C51),
              height: 1.429,
              letterSpacing: -0.006 * 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildHomeIndicator] - Builds the home indicator at the bottom
  Widget _buildHomeIndicator() {
    return Container(
      width: 375.w,
      height: 24.h,
      color: const Color(0xFFFFFFFF),
      child: Center(
        child: Container(
          width: 134.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF292524), // Dark gray from Figma
            borderRadius: BorderRadius.circular(9999.r),
          ),
        ),
      ),
    );
  }
}
