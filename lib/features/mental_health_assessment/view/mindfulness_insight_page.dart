import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessInsightPage] - Page wrapper for Mindfulness Insight screen
/// This page displays comprehensive mindfulness analytics and insights
/// following Apple's Human Interface Guidelines for data visualization interfaces
class MindfulnessInsightPage extends StatelessWidget {
  const MindfulnessInsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MindfulnessInsightBloc()..add(const LoadMindfulnessInsight()),
      child: const MindfulnessInsightView(),
    );
  }
}

/// [MindfulnessInsightView] - Main view for the Mindfulness Insight screen
/// Displays comprehensive analytics including trends, charts, and mindful moments
/// using modern, data-rich design patterns inspired by Apple's health analytics apps
class MindfulnessInsightView extends StatelessWidget {
  const MindfulnessInsightView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessInsightBloc, MindfulnessInsightState>(
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
                                // Header section with description and filter
                                _buildHeaderSection(context, theme, state),

                                // Analytics cards section
                                _buildAnalyticsSection(context, theme, state),
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
                    print('[MindfulnessInsightPage] Back button pressed');
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
                  'Mindfulness Level Insight',
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
                print('[MindfulnessInsightPage] Notification button pressed');
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

  /// [_buildHeaderSection] - Builds the header with description and date filter
  Widget _buildHeaderSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessInsightState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      child: SizedBox(
        width: 343.w,
        child: Column(
          children: [
            // Heart icon
            SvgPicture.asset(
              'assets/images/wellness_heart_icon.svg',
              width: 40.w,
              height: 40.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFFF08C51), // Orange color from Figma
                BlendMode.srcIn,
              ),
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

            SizedBox(height: 16.h),

            // Date filter button
            GestureDetector(
              onTap: () {
                // [_buildHeaderSection] Open date filter picker
                print('[MindfulnessInsightPage] Date filter button pressed');
                // Could open a date picker or dropdown here
              },
              child: Container(
                width: 343.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  border: Border.all(
                    color: const Color(0xFFD6D3D1), // Light gray border
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      offset: const Offset(0, 5),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/calendar_icon.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF57534E), // Medium gray
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        state.selectedDateFilter,
                        style: theme.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF57534E),
                          height: 1.429,
                          letterSpacing: -0.006 * 14.sp,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/chevron_down_icon.svg',
                      width: 10.w,
                      height: 10.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF57534E), // Medium gray
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildAnalyticsSection] - Builds the analytics cards section
  Widget _buildAnalyticsSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessInsightState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 48.h),
      child: SizedBox(
        width: 343.w,
        child: Column(
          children: [
            // Monthly Trend card
            _buildTrendCard(context, theme, state),

            SizedBox(height: 16.h),

            // Most Mindful Moment card
            _buildMomentCard(context, theme, state),
          ],
        ),
      ),
    );
  }

  /// [_buildTrendCard] - Builds the monthly trend analytics card
  Widget _buildTrendCard(BuildContext context, YouthYogaTheme theme,
      MindfulnessInsightState state) {
    if (state.status == MindfulnessInsightStatus.loading) {
      return _buildLoadingCard(theme);
    }

    if (state.status == MindfulnessInsightStatus.error) {
      return _buildErrorCard(theme, state.errorMessage, () {
        context.read<MindfulnessInsightBloc>().add(const RefreshInsightData());
      });
    }

    return Container(
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
        children: [
          // Section header
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/calendar_icon.svg',
                width: 22.w,
                height: 22.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFA8A29E), // Light gray
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Monthly Trend',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Score and trend row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.trendData.score,
                      style: theme.headlineLarge.copyWith(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF292524),
                        height: 1.267,
                        letterSpacing: -0.013 * 30.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/arrow_trend_up_icon.svg',
                          width: 24.w,
                          height: 24.w,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFF08C51), // Orange color
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          state.trendData.percentage,
                          style: theme.bodyMedium.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF57534E),
                            height: 1.375,
                            letterSpacing: -0.007 * 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Divider
          Container(
            width: double.infinity,
            height: 1.h,
            color: const Color(0xFFE7E5E4),
          ),

          SizedBox(height: 12.h),

          // Chart visualization
          _buildTrendChart(theme, state.trendData),

          SizedBox(height: 12.h),

          // Chart legend
          _buildChartLegend(theme, state.trendData.legendItems),
        ],
      ),
    );
  }

  /// [_buildTrendChart] - Builds the trend chart visualization
  Widget _buildTrendChart(YouthYogaTheme theme, dynamic trendData) {
    return SizedBox(
      width: double.infinity,
      height: 166.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: trendData.chartData.map<Widget>((dataPoint) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dataPoint.label,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF57534E),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 147.w,
                height: (138.h * dataPoint.value), // Max height 138
                decoration: BoxDecoration(
                  color: Color(dataPoint.color),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1234.r),
                    topRight: Radius.circular(1234.r),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// [_buildChartLegend] - Builds the chart legend
  Widget _buildChartLegend(YouthYogaTheme theme, List<dynamic> legendItems) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: legendItems.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: Color(item.color),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                item.label,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// [_buildMomentCard] - Builds the most mindful moment card
  Widget _buildMomentCard(BuildContext context, YouthYogaTheme theme,
      MindfulnessInsightState state) {
    if (state.status == MindfulnessInsightStatus.loading) {
      return _buildLoadingCard(theme);
    }

    if (state.status == MindfulnessInsightStatus.error) {
      return _buildErrorCard(theme, state.errorMessage, () {
        context.read<MindfulnessInsightBloc>().add(const RefreshInsightData());
      });
    }

    return Container(
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
        children: [
          // Section header
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/light_bulb_icon.svg',
                width: 22.w,
                height: 22.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFA8A29E), // Light gray
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Most Mindful Moment',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Moment details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.mindfulMoment.timeOfDay,
                    style: theme.headlineLarge.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF292524),
                      height: 1.267,
                      letterSpacing: -0.013 * 30.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.mindfulMoment.timeRange,
                    style: theme.bodyMedium.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                state.mindfulMoment.description,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E),
                  height: 1.6,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Divider
          Container(
            width: double.infinity,
            height: 1.h,
            color: const Color(0xFFE7E5E4),
          ),

          SizedBox(height: 16.h),

          // Activities section
          Row(
            children: [
              Expanded(
                child: Column(
                  children: state.mindfulMoment.activities.map((activity) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.value,
                            style: theme.titleMedium.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF292524),
                              height: 1.4,
                              letterSpacing: -0.01 * 20.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            activity.label,
                            style: theme.bodyMedium.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF57534E),
                              height: 1.429,
                              letterSpacing: -0.006 * 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Meditation illustration placeholder
              Container(
                width: 150.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7EE), // Light green background
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/meditation_icon.svg',
                    width: 240.w,
                    height: 240.w,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Continue button
          GestureDetector(
            onTap: () {
              // [_buildMomentCard] Navigate to mindfulness logging
              print(
                  '[MindfulnessInsightPage] Continue button pressed - navigating to mindfulness logging');
              Navigator.of(context).pushNamed(AppRoutes.mindfulnessLogging);
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
      ),
    );
  }

  /// [_buildLoadingCard] - Builds a loading card placeholder
  Widget _buildLoadingCard(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      height: 200.h,
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
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFF08C51),
        ),
      ),
    );
  }

  /// [_buildErrorCard] - Builds an error card with retry option
  Widget _buildErrorCard(
      YouthYogaTheme theme, String? errorMessage, VoidCallback onRetry) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            errorMessage ?? 'Something went wrong',
            style: theme.bodyLarge.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF08C51),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
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
