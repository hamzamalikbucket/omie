import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_metrics_bloc.dart';

/// [MentalHealthMetricsPage] - Page wrapper for Mental Health Metrics screen
/// This page displays a comprehensive list of mental health metrics with filtering
/// and detailed health information cards following Apple's Human Interface Guidelines
class MentalHealthMetricsPage extends StatelessWidget {
  const MentalHealthMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MentalHealthMetricsBloc()..add(const LoadMentalHealthMetrics()),
      child: const MentalHealthMetricsView(),
    );
  }
}

/// [MentalHealthMetricsView] - Main view for the Mental Health Metrics screen
/// Displays header, featured insight card, filter options, and comprehensive metrics list
class MentalHealthMetricsView extends StatelessWidget {
  const MentalHealthMetricsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MentalHealthMetricsBloc, MentalHealthMetricsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF), // White background
          body: Column(
            children: [
              // Top navigation
              _buildTopNavigation(context, theme),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header section
                      _buildHeaderSection(context, theme),

                      // Featured insight card
                      _buildFeaturedInsightCard(context, theme),

                      // All metrics section
                      _buildAllMetricsSection(context, theme, state),

                      // Privacy notice
                      _buildPrivacyNotice(context, theme),

                      // Bottom padding
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation with back button, title, and settings
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      color: const Color(0xFFFFFFFF),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // [_buildTopNavigation] Navigate back
                      print('[MentalHealthMetricsPage] Back button pressed');
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/chevron_left_icon.svg',
                      width: 24.w,
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF292524),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Mental Health Metrics',
                    style: theme.headlineLarge.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF533630),
                      height: 1.9,
                      letterSpacing: -0.013 * 20.sp,
                    ),
                  ),
                ],
              ),

              // Settings icon
              IconButton(
                onPressed: () {
                  // [_buildTopNavigation] Open settings
                  print('[MentalHealthMetricsPage] Settings button pressed');
                },
                icon: SvgPicture.asset(
                  'assets/images/gear_icon.svg',
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF292524),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildHeaderSection] - Builds the header section with subtitle
  Widget _buildHeaderSection(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
      child: Column(
        children: [
          Text(
            'See your mental health metrics here.',
            style: theme.bodyLarge.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_buildFeaturedInsightCard] - Builds the featured insight card with illustration
  Widget _buildFeaturedInsightCard(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 6.h),
      child: Container(
        padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF1E9),
          border: Border.all(color: const Color(0xFFF08C51), width: 1.w),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'See your health metric insights',
                    style: theme.titleMedium.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFFFFF),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      // [_buildFeaturedInsightCard] Navigate to wellness score detail page
                      print(
                          '[MentalHealthMetricsPage] See Insight button pressed - navigating to wellness score detail');
                      Navigator.of(context)
                          .pushNamed(AppRoutes.wellnessScoreDetail);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See Insight',
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF08C51),
                            height: 1.429,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          'assets/images/arrow_right_icon.svg',
                          width: 16.w,
                          height: 16.w,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFF08C51),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Illustration
            SizedBox(
              width: 82.84.w,
              height: 87.37.h,
              child: SvgPicture.asset(
                'assets/images/mental_health_metrics_illustration.svg',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildAllMetricsSection] - Builds the all metrics section with filter and cards
  Widget _buildAllMetricsSection(BuildContext context, YouthYogaTheme theme,
      MentalHealthMetricsState state) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Section header with filter
          _buildSectionHeader(context, theme, state),

          SizedBox(height: 16.h),

          // Metrics cards
          if (state is MentalHealthMetricsLoaded) ...[
            Column(
              children: state.metricsData.metrics.map((metric) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  child: _buildMetricCard(context, theme, metric),
                );
              }).toList(),
            ),
          ] else if (state is MentalHealthMetricsLoading) ...[
            SizedBox(height: 200.h),
            const Center(child: CircularProgressIndicator()),
          ] else if (state is MentalHealthMetricsError) ...[
            SizedBox(height: 200.h),
            Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(state.message, style: theme.bodyLarge),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// [_buildSectionHeader] - Builds the section header with title and centered filter button
  Widget _buildSectionHeader(BuildContext context, YouthYogaTheme theme,
      MentalHealthMetricsState state) {
    return Column(
      children: [
        // Title
        Row(
          children: [
            Text(
              'All Metrics',
              style: theme.titleMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292524),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Centered filter button
        Center(
          child: GestureDetector(
            onTap: () {
              // [_buildSectionHeader] Show filter options
              print('[MentalHealthMetricsPage] Filter button pressed');
              _showFilterOptions(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/calendar_icon.svg',
                    width: 16.w,
                    height: 16.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6B7280),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    state is MentalHealthMetricsLoaded
                        ? state.metricsData.currentFilter
                        : 'Most Relevant',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF374151),
                      height: 1.429,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    'assets/images/chevron_down_icon.svg',
                    width: 12.w,
                    height: 12.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6B7280),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildMetricCard] - Builds individual metric card
  Widget _buildMetricCard(
      BuildContext context, YouthYogaTheme theme, HealthMetricCard metric) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 24.h),
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and title
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      metric.iconPath,
                      width: 20.w,
                      height: 20.w,
                      colorFilter: ColorFilter.mode(
                        Color(metric.statusColor),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    metric.title,
                    style: theme.titleMedium.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFFFFF),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ],
              ),

              // Today with chevron
              Row(
                children: [
                  Text(
                    'Today',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.429,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(
                    'assets/images/chevron_right_icon.svg',
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFA8A29E),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Content
          Row(
            children: [
              // Left side - metrics
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Value and unit
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          metric.value,
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFFFFF),
                            height: 1.33,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            metric.unit,
                            style: theme.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFFFFFF),
                              height: 1.375,
                              letterSpacing: -0.007 * 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Status
                    Text(
                      metric.status,
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
              ),

              SizedBox(width: 12.w),

              // Right side - chart
              Expanded(
                child: _buildMetricChart(metric),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildMetricChart] - Builds the chart for each metric type
  Widget _buildMetricChart(HealthMetricCard metric) {
    switch (metric.chartType) {
      case MetricChartType.progressBars:
        return _buildProgressBarsChart(metric);
      case MetricChartType.barChart:
        return _buildBarChart(metric);
      case MetricChartType.lineChart:
        return _buildLineChart(metric);
      case MetricChartType.checkmarks:
        return _buildCheckmarksChart(metric);
      case MetricChartType.circles:
        return _buildCirclesChart(metric);
      case MetricChartType.barChart3Series:
        return _buildBarChart3Series(metric);
    }
  }

  /// [_buildProgressBarsChart] - Builds progress bars chart
  Widget _buildProgressBarsChart(HealthMetricCard metric) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final progress = double.parse(metric.weeklyData[index]) / 100;
            return Column(
              children: [
                Container(
                  width: 8.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E5E4),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 8.w,
                        height: (40.h * progress),
                        decoration: BoxDecoration(
                          color: Color(metric.statusColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.4,
                    letterSpacing: -0.004 * 10.sp,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  /// [_buildBarChart] - Builds bar chart with dual bars
  Widget _buildBarChart(HealthMetricCard metric) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final height1 = double.parse(metric.weeklyData[index]);
            final height2 = height1 * 0.5; // Second bar is half height
            return Column(
              children: [
                SizedBox(
                  width: 12.w,
                  height: 40.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 4.w,
                        height: height1,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9D5FF),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        width: 4.w,
                        height: height2,
                        decoration: BoxDecoration(
                          color: Color(metric.statusColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.4,
                    letterSpacing: -0.004 * 10.sp,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  /// [_buildLineChart] - Builds line chart
  Widget _buildLineChart(HealthMetricCard metric) {
    return Column(
      children: [
        Container(
          width: 147.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(metric.statusColor), width: 2),
          ),
          child: const Center(
            child: Text(
              'Line Chart',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
              .map((day) => Text(
                    day,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.4,
                      letterSpacing: -0.004 * 10.sp,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  /// [_buildCheckmarksChart] - Builds checkmarks chart
  Widget _buildCheckmarksChart(HealthMetricCard metric) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final isCompleted = metric.weeklyData[index] == 'true';
        return Column(
          children: [
            Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFA8A29E),
                  width: 2.w,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Color(0xFF57534E),
                    )
                  : const Icon(
                      Icons.close,
                      size: 12,
                      color: Color(0xFFFB7185),
                    ),
            ),
            SizedBox(height: 4.h),
            Text(
              ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E),
                height: 1.4,
                letterSpacing: -0.004 * 10.sp,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// [_buildCirclesChart] - Builds circles chart
  Widget _buildCirclesChart(HealthMetricCard metric) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final value = int.parse(metric.weeklyData[index]);
        return Column(
          children: [
            SizedBox(
              width: 8.w,
              height: 8.w,
              child: Column(
                children: List.generate(3, (circleIndex) {
                  return Container(
                    width: 8.w,
                    height: 8.w,
                    margin: EdgeInsets.only(bottom: circleIndex < 2 ? 8.h : 0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleIndex < value
                          ? Color(metric.statusColor)
                          : const Color(0xFFE7E5E4),
                    ),
                  );
                }).reversed.toList(),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E),
                height: 1.4,
                letterSpacing: -0.004 * 10.sp,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// [_buildBarChart3Series] - Builds 3-series bar chart
  Widget _buildBarChart3Series(HealthMetricCard metric) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final height = double.parse(metric.weeklyData[index]);
        return Column(
          children: [
            SizedBox(
              width: 8.w,
              height: 40.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 8.w,
                    height: height,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: height * 0.7,
                    decoration: BoxDecoration(
                      color: const Color(0xFF93C5FD),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      color: Color(metric.statusColor),
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E),
                height: 1.4,
                letterSpacing: -0.004 * 10.sp,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// [_buildPrivacyNotice] - Builds the privacy notice at the bottom
  Widget _buildPrivacyNotice(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/lock_locked_alt_icon.svg',
            width: 24.w,
            height: 24.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFFA8A29E),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'At freud.ai, your health metrics data is owned by you and only you. We never share these data with anyone!',
            style: theme.bodyMedium.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_showFilterOptions] - Shows filter options modal
  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                title: const Text('Most Relevant'),
                onTap: () {
                  context
                      .read<MentalHealthMetricsBloc>()
                      .add(const UpdateFilter('Most Relevant'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Recent'),
                onTap: () {
                  context
                      .read<MentalHealthMetricsBloc>()
                      .add(const UpdateFilter('Recent'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Critical'),
                onTap: () {
                  context
                      .read<MentalHealthMetricsBloc>()
                      .add(const UpdateFilter('Critical'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
