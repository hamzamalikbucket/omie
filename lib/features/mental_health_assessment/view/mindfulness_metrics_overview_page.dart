import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessMetricsOverviewPage] - Page wrapper for Mindfulness Metrics Overview screen
/// This page displays comprehensive mindfulness metrics and insights overview
/// following Apple's Human Interface Guidelines for data-rich overview interfaces
class MindfulnessMetricsOverviewPage extends StatelessWidget {
  const MindfulnessMetricsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MindfulnessMetricsOverviewBloc()
        ..add(const LoadMindfulnessMetricsOverview()),
      child: const MindfulnessMetricsOverviewView(),
    );
  }
}

/// [MindfulnessMetricsOverviewView] - Main view for the Mindfulness Metrics Overview screen
/// Displays comprehensive score, date/time info, description, key metrics, and action buttons
/// using modern, clean design patterns inspired by Apple's health and data overview apps
class MindfulnessMetricsOverviewView extends StatelessWidget {
  const MindfulnessMetricsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessMetricsOverviewBloc,
        MindfulnessMetricsOverviewState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              const Color(0xFFF08C51), // Orange background from Figma
          body: SafeArea(
            child: Column(
              children: [
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
              ],
            ),
          ),
        );
      },
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
      MindfulnessMetricsOverviewState state) {
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
      MindfulnessMetricsOverviewState state) {
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
      MindfulnessMetricsOverviewState state) {
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
        if (state.status == MindfulnessMetricsOverviewStatus.loading) ...[
          SizedBox(
            height: 200.h,
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF08C51),
              ),
            ),
          ),
        ] else if (state.status == MindfulnessMetricsOverviewStatus.error) ...[
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
                          .read<MindfulnessMetricsOverviewBloc>()
                          .add(const RefreshOverviewData());
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
                  _buildOverviewMetricItem(theme, metric),
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

  /// [_buildOverviewMetricItem] - Builds a single metric item for overview
  Widget _buildOverviewMetricItem(
      YouthYogaTheme theme, OverviewMetricEntry metric) {
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

  /// [_buildActionButtons] - Builds the action buttons section for overview
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MindfulnessMetricsOverviewState state) {
    return Column(
      children: [
        // View Insight button (outlined)
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] View insight from overview
            print(
                '[MindfulnessMetricsOverviewPage] View Insight button pressed');
            context
                .read<MindfulnessMetricsOverviewBloc>()
                .add(const ViewInsightFromOverview());
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

        // Consult AI Assistant button (filled)
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] Consult AI assistant from overview
            print(
                '[MindfulnessMetricsOverviewPage] Consult AI Assistant button pressed');
            context
                .read<MindfulnessMetricsOverviewBloc>()
                .add(const ConsultAIAssistantFromOverview());
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

        SizedBox(height: 12.h),

        // Continue button
        GestureDetector(
          onTap: () {
            // [_buildActionButtons] Navigate to mindfulness insight
            print(
                '[MindfulnessMetricsOverviewPage] Continue button pressed - navigating to mindfulness insight');
            Navigator.of(context).pushNamed(AppRoutes.mindfulnessInsight);
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
      ],
    );
  }
}
