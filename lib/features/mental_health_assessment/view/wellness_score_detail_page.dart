import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [WellnessScoreDetailPage] - Page wrapper for Wellness Score Detail screen
/// This page displays detailed wellness score information with interactive charts
/// following Apple's Human Interface Guidelines for health and wellness apps
class WellnessScoreDetailPage extends StatelessWidget {
  const WellnessScoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WellnessScoreDetailBloc()..add(const LoadWellnessScoreDetail()),
      child: const WellnessScoreDetailView(),
    );
  }
}

/// [WellnessScoreDetailView] - Main view for the Wellness Score Detail screen
/// Displays wellness score, status message, time period tabs, interactive line chart,
/// insights, history, and goal tracking sections using modern, sleek design patterns
class WellnessScoreDetailView extends StatelessWidget {
  const WellnessScoreDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<WellnessScoreDetailBloc, WellnessScoreDetailState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.primaryBackground,
          body: SafeArea(
            child: SizedBox(
              width: 375.w,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  // Top decorative section with ellipse (matching Figma design)
                  _buildTopDecorativeSection(theme),

                  // Main content area
                  Expanded(
                    child: Container(
                      width: 375.w,
                      color: const Color(
                          0xFFFFFFFF), // White background from Figma
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 48.h),
                          child: SizedBox(
                            width: 343.w,
                            child: Column(
                              children: [
                                // Wellness score header section
                                _buildWellnessScoreHeader(
                                    context, theme, state),

                                SizedBox(height: 32.h),

                                // Time period tabs
                                _buildTimePeriodTabs(context, theme, state),

                                SizedBox(height: 32.h),

                                // Chart section
                                _buildChartSection(context, theme, state),

                                SizedBox(height: 24.h),

                                // Mindfulness Level Insight section
                                _buildInsightSection(context, theme, state),

                                SizedBox(height: 24.h),

                                // Mindfulness Level History section
                                _buildHistorySection(context, theme, state),

                                SizedBox(height: 24.h),

                                // Mindfulness Level Goal section
                                _buildGoalSection(context, theme, state),
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
          ),
        );
      },
    );
  }

  /// [_buildReminderModal] - Builds the reminder setup modal based on Figma design
  /// Displays a bottom sheet modal for setting mindfulness reminders with day and time selection
  Widget _buildReminderModal(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 661.h,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Modal header with close button
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 58.h, 16.w, 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set Reminder',
                  style: theme.headlineMedium.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.333,
                    letterSpacing: -0.008 * 18.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: SvgPicture.asset(
                      'assets/images/close_x_icon.svg',
                      width: 24.w,
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF57534E),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Day selection section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Day',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDayBadge('S', false),
                    _buildDayBadge('M', false),
                    _buildDayBadge('T', true),
                    _buildDayBadge('W', false),
                    _buildDayBadge('T', true),
                    _buildDayBadge('F', false),
                    _buildDayBadge('S', false),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Time selection section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Column(
                  children: [
                    _buildTimeOption('9', '06', false),
                    _buildTimeOption('10', '07', false),
                    _buildTimeOption('11', '08', true),
                    _buildTimeOption('12', '09', false),
                    _buildTimeOption('01', '10', false),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Set Reminder button
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 48.h),
            child: SizedBox(
              width: 343.w,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement reminder setting logic
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08C51),
                  foregroundColor: const Color(0xFFFFFFFF),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Set Reminder',
                      style: theme.labelLarge.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFFFFF),
                        height: 1.375,
                        letterSpacing: -0.007 * 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: SvgPicture.asset(
                        'assets/images/check_single_icon.svg',
                        width: 20.w,
                        height: 20.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFFFFFFF),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildDayBadge] - Builds individual day selection badges
  /// Shows selected/unselected states with proper styling
  Widget _buildDayBadge(String day, bool isSelected) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF08C51) : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(123),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFFF08C51).withOpacity(0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color:
                isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF979797),
            height: 1.375,
            letterSpacing: -0.007 * 16.sp,
          ),
        ),
      ),
    );
  }

  /// [_buildTimeOption] - Builds individual time selection options
  /// Shows selected/unselected states with proper styling
  Widget _buildTimeOption(String hour, String minute, bool isSelected) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 9.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFEEE4) : Colors.transparent,
        borderRadius: BorderRadius.circular(9999),
        border: isSelected
            ? Border.all(
                color: const Color(0xFFF08C51),
                width: 1,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$hour:$minute',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: isSelected
                  ? const Color(0xFFF08C51)
                  : const Color(0xFF57534E),
              height: 1.4,
              letterSpacing: -0.01 * 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildTopDecorativeSection] - Builds the top decorative section with ellipse
  /// Matches the Figma design with exact positioning and styling
  Widget _buildTopDecorativeSection(YouthYogaTheme theme) {
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
                color: const Color(0xFFFFFFFF), // White background from Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildWellnessScoreHeader] - Builds the wellness score header with icon and status
  /// Displays the heart icon, score, and status message as shown in Figma
  Widget _buildWellnessScoreHeader(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
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
                // Score value (88.1)
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
        SizedBox(
          width: 343.w,
          child: Text(
            state.statusMessage,
            style: theme.bodyLarge.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Medium gray from Figma
              height: 1.333,
              letterSpacing: -0.008 * 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// [_buildTimePeriodTabs] - Builds the horizontal time period tabs
  /// Creates tab buttons for different time periods with active state styling
  Widget _buildTimePeriodTabs(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
    final timePeriods = ['1d', '1w', '1m', '1y', 'All Time'];

    return Container(
      width: 343.w,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E5E4), // Light gray background from Figma
        borderRadius: BorderRadius.circular(9999.r), // Fully rounded
      ),
      child: Row(
        children: timePeriods.map((period) {
          final isSelected = period == state.selectedTimePeriod;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                // [_buildTimePeriodTabs] Handle time period selection
                print(
                    '[WellnessScoreDetailPage] Time period selected: $period');
                context
                    .read<WellnessScoreDetailBloc>()
                    .add(ChangeTimePeriod(period));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(
                          0xFFFFFFFF) // White background for active tab
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            offset: const Offset(0, 8),
                            blurRadius: 16,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  period,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF292524) // Dark text for active tab
                        : const Color(
                            0xFF57534E), // Medium gray for inactive tabs
                    height: 1.333,
                    letterSpacing: -0.005 * 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// [_buildChartSection] - Builds the interactive line chart section
  /// Creates a line chart with grid background, data points, and gradient fill
  Widget _buildChartSection(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
    if (state.status == WellnessScoreDetailStatus.loading) {
      return SizedBox(
        height: 240.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF08C51),
          ),
        ),
      );
    }

    if (state.status == WellnessScoreDetailStatus.error) {
      return SizedBox(
        height: 240.h,
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
                      .read<WellnessScoreDetailBloc>()
                      .add(const RefreshWellnessData());
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
      );
    }

    return Column(
      children: [
        // Chart container (reduced height for the new compact design)
        SizedBox(
          width: 343.w,
          height: 212.h, // Adjusted height from Figma
          child: Stack(
            children: [
              // Grid background
              _buildChartGrid(),

              // Chart area with gradient and line
              _buildChartContent(state),

              // Data points
              _buildDataPoints(state),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        // X-axis labels
        _buildXAxisLabels(theme, state),
      ],
    );
  }

  /// [_buildChartGrid] - Builds the grid background for the chart
  /// Creates dashed grid lines as shown in the Figma design
  Widget _buildChartGrid() {
    return SizedBox(
      width: 343.w,
      height: 212.h,
      child: Stack(
        children: [
          // Vertical grid lines
          ...List.generate(10, (index) {
            return Positioned(
              left: (index * 343.w / 9),
              top: 0,
              child: Container(
                width: 1.w,
                height: 212.h,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: const Color(0xFFD6D3D1), // Light gray from Figma
                      width: 1.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            );
          }),
          // Horizontal grid lines
          ...List.generate(4, (index) {
            return Positioned(
              left: 0,
              top: (index * 212.h / 3),
              child: Container(
                width: 343.w,
                height: 1.h,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFFD6D3D1), // Light gray from Figma
                      width: 1.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// [_buildChartContent] - Builds the chart content with gradient and line
  /// Creates the visual representation of the wellness data
  Widget _buildChartContent(WellnessScoreDetailState state) {
    return SizedBox(
      width: 343.w,
      height: 212.h,
      child: CustomPaint(
        painter: ChartPainter(
          dataPoints: state.chartDataPoints,
          chartWidth: 343.w,
          chartHeight: 212.h,
        ),
      ),
    );
  }

  /// [_buildDataPoints] - Builds the interactive data points on the chart
  /// Creates circular dots at each data point location
  Widget _buildDataPoints(WellnessScoreDetailState state) {
    return SizedBox(
      width: 343.w,
      height: 212.h,
      child: Stack(
        children: state.chartDataPoints.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          final xPosition =
              (index * 343.w / (state.chartDataPoints.length - 1)) - 6.w;
          final yPosition = ((1 - value) * (212.h - 14.h)) + 7.h;

          return Positioned(
            left: xPosition,
            top: yPosition,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF08C51), // Orange color from Figma
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFFFFF), // White border
                  width: 2.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// [_buildXAxisLabels] - Builds the x-axis labels below the chart
  /// Displays time period labels (days, weeks, etc.) based on selected time period
  Widget _buildXAxisLabels(
      YouthYogaTheme theme, WellnessScoreDetailState state) {
    return SizedBox(
      width: 343.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: state.xAxisLabels.map((label) {
          return Expanded(
            child: Text(
              label,
              style: theme.bodyMedium.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFA8A29E), // Light gray from Figma
                height: 1.333,
                letterSpacing: -0.005 * 12.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// [_buildInsightSection] - Builds the mindfulness level insight section
  /// Shows monthly average, trend, and description
  Widget _buildInsightSection(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
    return Column(
      children: [
        // Section header
        _buildSectionHeader(
          theme,
          'Mindfulness Level Insight',
          onSeeAllTap: () {
            // [_buildInsightSection] Navigate to mindfulness explanation
            print(
                '[WellnessScoreDetailPage] Insight See All pressed - navigating to mindfulness explanation');
            Navigator.of(context).pushNamed(AppRoutes.mindfulnessExplanation);
          },
        ),

        SizedBox(height: 12.h),

        // Insight card
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
            children: [
              // Top row with average and mini chart
              Row(
                children: [
                  // Left side - text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Average',
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF292524),
                            height: 1.429,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.monthlyAverage,
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.333,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Trend indicator
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/arrow_trend_down_icon.svg',
                              width: 20.w,
                              height: 20.w,
                              colorFilter: ColorFilter.mode(
                                state.isPositiveTrend
                                    ? const Color(
                                        0xFF22C55E) // Green for positive
                                    : const Color(
                                        0xFFFB7185), // Red for negative
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              state.monthlyTrend,
                              style: theme.bodyMedium.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF292524),
                                height: 1.429,
                                letterSpacing: -0.006 * 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // Right side - mini chart placeholder
                  Container(
                    width: 108.w,
                    height: 88.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: const Color(0xFFF08C51),
                        width: 2.w,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mini Chart',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Description text
              Text(
                state.insightDescription,
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
        ),
      ],
    );
  }

  /// [_buildHistorySection] - Builds the mindfulness level history section
  /// Shows historical wellness entries with scores and times
  Widget _buildHistorySection(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
    return Column(
      children: [
        // Section header
        _buildSectionHeader(
          theme,
          'Mindfulness Level History',
          onSeeAllTap: () {
            // [_buildHistorySection] Navigate to history detail
            print('[WellnessScoreDetailPage] History See All pressed');
          },
        ),

        SizedBox(height: 12.h),

        // History entries
        Column(
          children: state.historyEntries.map((entry) {
            return Container(
              width: 343.w,
              margin: EdgeInsets.only(bottom: 16.h),
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
              child: Row(
                children: [
                  // Heart icon
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: SvgPicture.asset(
                      'assets/images/wellness_heart_icon.svg',
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFF08C51),
                        BlendMode.srcIn,
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
                          entry.score,
                          style: theme.titleMedium.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.375,
                            letterSpacing: -0.007 * 16.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          entry.status,
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF57534E),
                            height: 1.429,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Time and chevron
                  Row(
                    children: [
                      Text(
                        entry.time,
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
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF57534E),
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// [_buildGoalSection] - Builds the mindfulness level goal section
  /// Shows goal target, progress, and edit functionality
  Widget _buildGoalSection(BuildContext context, YouthYogaTheme theme,
      WellnessScoreDetailState state) {
    return Column(
      children: [
        // Section header
        _buildSectionHeader(
          theme,
          'Mindfulness Level Goal',
          onSeeAllTap: () {
            // [_buildGoalSection] Navigate to goal detail
            print('[WellnessScoreDetailPage] Goal See All pressed');
          },
        ),

        SizedBox(height: 12.h),

        // Goal card
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
            children: [
              // Top row with icon and goal info
              Row(
                children: [
                  // Flag icon container
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF2E5), // Light orange background
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/flag_icon.svg',
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFF08C51),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Goal info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.goalTarget,
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.333,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          state.goalDescription,
                          style: theme.bodyMedium.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF57534E),
                            height: 1.375,
                            letterSpacing: -0.007 * 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Goal advice text
              Text(
                state.goalAdvice,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E),
                  height: 1.6,
                ),
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 16.h),

              // Progress section
              Column(
                children: [
                  // Progress bar
                  Container(
                    width: double.infinity,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E4),
                      borderRadius: BorderRadius.circular(9999.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: state.goalProgress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF08C51),
                          borderRadius: BorderRadius.circular(9999.r),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Progress text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.goalProgressText,
                        style: theme.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF57534E),
                          height: 1.429,
                          letterSpacing: -0.006 * 14.sp,
                        ),
                      ),
                      Text(
                        state.goalTotalText,
                        style: theme.bodyMedium.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF57534E),
                          height: 1.429,
                          letterSpacing: -0.006 * 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Divider line
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                width: double.infinity,
                height: 1.h,
                color: const Color(0xFFE7E5E4),
              ),

              // Action buttons row
              Row(
                children: [
                  // Edit goal button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // [_buildGoalSection] Handle edit goal action
                        print(
                            '[WellnessScoreDetailPage] Edit Goal button pressed');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/edit_pencil_icon.svg',
                            width: 16.w,
                            height: 16.w,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFF08C51),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Edit Goal',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF08C51),
                              height: 1.429,
                              letterSpacing: -0.006 * 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Set Reminder button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // [_buildGoalSection] Show reminder modal
                        print(
                            '[WellnessScoreDetailPage] Set Reminder button pressed');
                        _showReminderModal(context, theme);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/bell_notification_icon.svg',
                            width: 16.w,
                            height: 16.w,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFF08C51),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Set Reminder',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF08C51),
                              height: 1.429,
                              letterSpacing: -0.006 * 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_showReminderModal] - Shows the reminder setup modal as a bottom sheet
  /// Displays the modal with day and time selection options
  void _showReminderModal(BuildContext context, YouthYogaTheme theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 661.h,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: _buildReminderModal(context, theme),
      ),
    );
  }

  /// [_buildSectionHeader] - Builds a section header with title and See All link
  /// Used consistently across insight, history, and goal sections
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
}

/// [ChartPainter] - Custom painter for drawing the chart line and gradient
/// Creates smooth curves and gradient fills for the wellness chart
class ChartPainter extends CustomPainter {
  /// [dataPoints] - List of normalized data points (0.0 to 1.0)
  final List<double> dataPoints;

  /// [chartWidth] - Width of the chart area
  final double chartWidth;

  /// [chartHeight] - Height of the chart area
  final double chartHeight;

  ChartPainter({
    required this.dataPoints,
    required this.chartWidth,
    required this.chartHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFFF08C51) // Orange color from Figma
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF08C51), // Orange at top
          Color(0x00F08C51), // Transparent at bottom
        ],
      ).createShader(Rect.fromLTWH(0, 0, chartWidth, chartHeight))
      ..style = PaintingStyle.fill;

    final path = Path();
    final gradientPath = Path();

    // Calculate positions for data points
    final positions = dataPoints.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;
      final x = index * chartWidth / (dataPoints.length - 1);
      final y = (1 - value) * (chartHeight - 14) + 7; // Account for dot size
      return Offset(x, y);
    }).toList();

    // Build line path
    if (positions.isNotEmpty) {
      path.moveTo(positions[0].dx, positions[0].dy);
      gradientPath.moveTo(positions[0].dx, chartHeight);
      gradientPath.lineTo(positions[0].dx, positions[0].dy);

      for (int i = 1; i < positions.length; i++) {
        path.lineTo(positions[i].dx, positions[i].dy);
        gradientPath.lineTo(positions[i].dx, positions[i].dy);
      }

      // Close gradient path
      gradientPath.lineTo(positions.last.dx, chartHeight);
      gradientPath.close();
    }

    // Draw gradient fill with opacity
    final gradientPaintWithOpacity = Paint()
      ..shader = gradientPaint.shader
      ..style = PaintingStyle.fill;
    canvas.drawPath(gradientPath, gradientPaintWithOpacity);

    // Draw line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
