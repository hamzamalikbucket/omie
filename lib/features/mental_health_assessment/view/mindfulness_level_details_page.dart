import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessLevelDetailsPage] - Page wrapper for Mindfulness Level Details screen
/// This page displays detailed mindfulness metrics and insights
/// following Apple's Human Interface Guidelines for data-rich interfaces
class MindfulnessLevelDetailsPage extends StatelessWidget {
  const MindfulnessLevelDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MindfulnessLevelDetailsBloc()
        ..add(const LoadMindfulnessLevelDetails()),
      child: const MindfulnessLevelDetailsView(),
    );
  }
}

/// [MindfulnessLevelDetailsView] - Main view for the Mindfulness Level Details screen
/// Displays score, date/time info, description, key metrics, and action buttons
/// using modern, clean design patterns inspired by Apple's health and data apps
class MindfulnessLevelDetailsView extends StatelessWidget {
  const MindfulnessLevelDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessLevelDetailsBloc,
        MindfulnessLevelDetailsState>(
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
                            child: Column(
                              children: [
                                // Score header section
                                _buildScoreHeader(context, theme, state),

                                // Key metrics and actions section
                                _buildMetricsAndActions(context, theme, state),
                              ],
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
                    print('[MindfulnessLevelDetailsPage] Back button pressed');
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
                  'Mindfulness Level Details',
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
                    '[MindfulnessLevelDetailsPage] Notification button pressed');
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

  /// [_buildScoreHeader] - Builds the score header with heart icon, score, status, date/time, and description
  Widget _buildScoreHeader(BuildContext context, YouthYogaTheme theme,
      MindfulnessLevelDetailsState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: SizedBox(
        width: 343.w,
        child: Column(
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
                    // Score value (72.8)
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
                          color:
                              const Color(0xFF57534E), // Medium gray from Figma
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
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF57534E), // Medium gray from Figma
                height: 1.333,
                letterSpacing: -0.008 * 18.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Date and time row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Date with calendar icon
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/calendar_icon.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFA8A29E), // Light gray from Figma
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      state.date,
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF57534E),
                        height: 1.429,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(width: 12.w),

                // Dot separator
                Container(
                  width: 4.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6D3D1), // Light gray from Figma
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(width: 12.w),

                // Time with clock icon
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/clock_icon.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFA8A29E), // Light gray from Figma
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      state.time,
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF57534E),
                        height: 1.429,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Description text
            Text(
              state.description,
              style: theme.bodyMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildMetricsAndActions] - Builds the key metrics section and action buttons
  Widget _buildMetricsAndActions(BuildContext context, YouthYogaTheme theme,
      MindfulnessLevelDetailsState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 32.h, 32.w, 48.h),
      child: SizedBox(
        width: 311.w,
        child: Column(
          children: [
            // Key metrics section
            _buildKeyMetricsSection(context, theme, state),

            SizedBox(height: 32.h),

            // Action buttons
            _buildActionButtons(context, theme, state),
          ],
        ),
      ),
    );
  }

  /// [_buildKeyMetricsSection] - Builds the key metrics section with header and list
  Widget _buildKeyMetricsSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessLevelDetailsState state) {
    return Column(
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Key Metrics',
              style: theme.titleMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292524),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            Text(
              'See All',
              style: theme.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF08C51),
                height: 1.429,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Metrics list
        if (state.status == MindfulnessLevelDetailsStatus.loading) ...[
          SizedBox(
            height: 200.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF08C51),
              ),
            ),
          ),
        ] else if (state.status == MindfulnessLevelDetailsStatus.error) ...[
          SizedBox(
            height: 200.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.errorMessage ?? 'Something went wrong',
                    style: theme.bodyLarge.copyWith(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MindfulnessLevelDetailsBloc>()
                          .add(const RefreshDetails());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF08C51),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          Column(
            children: state.metrics.asMap().entries.map((entry) {
              final index = entry.key;
              final metric = entry.value;
              final isLast = index == state.metrics.length - 1;

              return Column(
                children: [
                  _buildMetricItem(theme, metric),
                  if (!isLast)
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: const Color(0xFFE7E5E4), // Light gray divider
                    ),
                ],
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  /// [_buildMetricItem] - Builds a single metric item
  Widget _buildMetricItem(YouthYogaTheme theme, MetricEntry metric) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // Icon
          SvgPicture.asset(
            metric.iconPath,
            width: 20.w,
            height: 20.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFF57534E), // Medium gray from Figma
              BlendMode.srcIn,
            ),
          ),

          SizedBox(width: 8.w),

          // Label
          Expanded(
            child: Text(
              metric.label,
              style: theme.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF292524),
                height: 1.429,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ),

          // Value and optional up arrow
          Row(
            children: [
              Text(
                metric.value,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
              if (metric.hasUpArrow) ...[
                SizedBox(width: 4.w),
                SvgPicture.asset(
                  'assets/images/arrow_drop_up_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF08C51), // Orange color from Figma
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildActionButtons] - Builds the action buttons section
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MindfulnessLevelDetailsState state) {
    return Column(
      children: [
        // View Insight button (outlined)
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] View insight
            print('[MindfulnessLevelDetailsPage] View Insight button pressed');
            context
                .read<MindfulnessLevelDetailsBloc>()
                .add(const ViewInsight());
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0xFFF08C51), // Orange border
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View Insight',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF08C51), // Orange text
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(
                  'assets/images/arrow_right_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF08C51), // Orange arrow
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Continue button
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] Navigate to mindfulness metrics overview
            print(
                '[MindfulnessLevelDetailsPage] Continue button pressed - navigating to metrics overview');
            Navigator.of(context)
                .pushNamed(AppRoutes.mindfulnessMetricsOverview);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF292524), // Dark gray background
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF), // White text
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(
                  'assets/images/arrow_right_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFFFFFF), // White arrow
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Consult AI Assistant button (filled)
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] Consult AI assistant
            print(
                '[MindfulnessLevelDetailsPage] Consult AI Assistant button pressed');
            context
                .read<MindfulnessLevelDetailsBloc>()
                .add(const ConsultAIAssistant());
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF08C51), // Orange background
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/robot_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFFFFFF), // White robot icon
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Consult AI Assistant',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF), // White text
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
