import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/omie_score_detail_bloc.dart';

/// [OmieScoreDetailPage] - Page wrapper for Omie Score Detail screen
/// This page displays detailed information about the user's Omie Score
/// including breakdown, health metrics, trend data, and AI recommendations
class OmieScoreDetailPage extends StatelessWidget {
  const OmieScoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OmieScoreDetailBloc()..add(const LoadOmieScoreDetail()),
      child: const OmieScoreDetailView(),
    );
  }
}

/// [OmieScoreDetailView] - Main view for the Omie Score Detail screen
/// Displays all score information with sections for breakdown, metrics, trends, and recommendations
class OmieScoreDetailView extends StatelessWidget {
  const OmieScoreDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<OmieScoreDetailBloc, OmieScoreDetailState>(
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
                      if (state is OmieScoreDetailLoaded) ...[
                        // Score visualization section
                        _buildScoreVisualizationSection(
                            context, theme, state.scoreData),

                        // Score breakdown section
                        _buildScoreBreakdownSection(
                            context, theme, state.scoreData),

                        // Health score trend section
                        _buildHealthScoreTrendSection(
                            context, theme, state.scoreData),

                        // AI recommendations section
                        _buildAIRecommendationsSection(
                            context, theme, state.scoreData),

                        // Bottom padding
                        SizedBox(height: 32.h),
                      ] else if (state is OmieScoreDetailLoading) ...[
                        // Loading state
                        SizedBox(height: 200.h),
                        const Center(child: CircularProgressIndicator()),
                      ] else if (state is OmieScoreDetailError) ...[
                        // Error state
                        SizedBox(height: 200.h),
                        Center(
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              SizedBox(height: 16.h),
                              Text(state.message, style: theme.bodyLarge),
                            ],
                          ),
                        ),
                      ],
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

  /// [_buildTopNavigation] - Builds the top navigation with back button and title
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
                      // [_buildTopNavigation] Navigate back to home screen
                      print('[OmieScoreDetailPage] Back button pressed');
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
                    'Omie Score',
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

              // Info icon
              IconButton(
                onPressed: () {
                  // [_buildTopNavigation] Show info modal
                  print('[OmieScoreDetailPage] Info button pressed');
                  _showOmieScoreInfoModal(context, theme);
                },
                icon: SvgPicture.asset(
                  'assets/images/question_mark_circle_icon.svg',
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

  /// [_buildScoreVisualizationSection] - Builds the central score visualization with circle
  Widget _buildScoreVisualizationSection(
      BuildContext context, YouthYogaTheme theme, OmieScoreData scoreData) {
    final timeSinceUpdate =
        DateTime.now().difference(scoreData.lastUpdated).inSeconds;

    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Score visualization with dots background
          SizedBox(
            width: 253.w,
            height: 213.h,
            child: Stack(
              children: [
                // Background dots pattern (simplified)
                _buildBackgroundDots(),

                // Central score circle
                Positioned(
                  left: 73.w,
                  top: 54.h,
                  child: Container(
                    width: 106.w,
                    height: 106.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${scoreData.currentScore}',
                          style: theme.headlineLarge.copyWith(
                            fontSize: 44.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF9BB167),
                            height: 1.2,
                            letterSpacing: 0.0227 * 44.sp,
                          ),
                        ),
                        Text(
                          'Out of ${scoreData.maxScore}',
                          style: theme.bodySmall.copyWith(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF292524),
                            height: 1.2,
                            letterSpacing: 0.1 * 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Last updated info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/arrow_repeat_icon.svg',
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFA8A29E),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'Last updated: ${timeSinceUpdate}s ago',
                style: theme.bodyMedium.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E),
                  height: 1.33,
                  letterSpacing: -0.005 * 12.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            scoreData.description,
            style: theme.bodyLarge.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF292524),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_buildBackgroundDots] - Builds the background dots pattern
  Widget _buildBackgroundDots() {
    return SizedBox(
      width: 253.w,
      height: 213.h,
      child: SvgPicture.asset('assets/images/score.svg'),
    );
  }

  /// [_buildScoreBreakdownSection] - Builds the score breakdown section
  Widget _buildScoreBreakdownSection(
      BuildContext context, YouthYogaTheme theme, OmieScoreData scoreData) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Score breakdown list
          Column(
            children: scoreData.scoreBreakdown.map((item) {
              return Container(
                padding: EdgeInsets.fromLTRB(0.w, 12.h, 0.w, 12.h),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE7E5E4), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    // Left side with dot and range
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              color: Color(item.color),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            item.range,
                            style: theme.bodyMedium.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF292524),
                              height: 1.43,
                              letterSpacing: -0.006 * 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right side with category and info icon
                    Row(
                      children: [
                        Text(
                          item.category,
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF292524),
                            height: 1.43,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(
                          'assets/images/info_circle_icon.svg',
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
              );
            }).toList(),
          ),

          SizedBox(height: 24.h),

          // Score breakdown section
          _buildScoreBreakdownCard(context, theme, scoreData),
        ],
      ),
    );
  }

  /// [_buildScoreBreakdownCard] - Builds the detailed score breakdown card
  Widget _buildScoreBreakdownCard(
      BuildContext context, YouthYogaTheme theme, OmieScoreData scoreData) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score Breakdown',
                style: theme.titleMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF292524),
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // [_buildScoreBreakdownCard] Navigate to Mental Health Metrics page
                  print(
                      '[OmieScoreDetailPage] See All button pressed - navigating to Mental Health Metrics');
                  Navigator.pushNamed(context, '/mental-health-metrics');
                },
                child: Text(
                  'See All',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF08C51),
                    height: 1.43,
                    letterSpacing: -0.006 * 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            "Your Omie Score reflects your overall mental health state, including mental wellness, mindfulness, stress, gratitude, sleep and more.",
            style: theme.bodyMedium.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E),
              height: 1.6,
            ),
          ),

          SizedBox(height: 16.h),

          // Divider
          const Divider(color: Color(0xFFE7E5E4), thickness: 1),

          SizedBox(height: 16.h),

          // Health metrics
          Column(
            children: scoreData.healthMetrics.map((metric) {
              return _buildHealthMetricItem(theme, metric);
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// [_buildHealthMetricItem] - Builds individual health metric item
  Widget _buildHealthMetricItem(YouthYogaTheme theme, HealthMetric metric) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.w, 12.h, 0.w, 12.h),
      child: Row(
        children: [
          // Icon
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F3EF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: _getHealthMetricIcon(metric.title),
            ),
          ),

          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      metric.title,
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF292524),
                        height: 1.43,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: Color(metric.color),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          metric.status,
                          style: theme.bodySmall.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF57534E),
                            height: 1.33,
                            letterSpacing: -0.005 * 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Progress bar
                Container(
                  width: double.infinity,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E5E4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: metric.progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(metric.color),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // Description
                Text(
                  metric.description,
                  style: theme.bodySmall.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.33,
                    letterSpacing: -0.005 * 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_getHealthMetricIcon] - Returns appropriate icon for health metric
  Widget _getHealthMetricIcon(String title) {
    switch (title) {
      case 'Physical Health':
        return SvgPicture.asset(
          'assets/images/health_plus_icon.svg',
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        );
      case 'Mental Health':
        return SvgPicture.asset(
          'assets/images/human_head_plus_icon.svg',
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        );
      case 'Stress Level':
        return SvgPicture.asset(
          'assets/images/leaf_single_icon.svg',
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        );
      case 'Activity Level':
        return SvgPicture.asset(
          'assets/images/activity_walking_icon.svg',
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        );
      case 'Sleep Level':
        return SvgPicture.asset(
          'assets/images/sleep_zzz_icon.svg',
          width: 16.w,
          height: 16.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        );
      default:
        return const Icon(Icons.help_outline, size: 16);
    }
  }

  /// [_buildHealthScoreTrendSection] - Builds the health score trend section
  Widget _buildHealthScoreTrendSection(
      BuildContext context, YouthYogaTheme theme, OmieScoreData scoreData) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Health Score Trend',
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
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Trend card
          Container(
            width: 343.w,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                // Top section with score and dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Score display
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          scoreData.trendData.currentValue.toStringAsFixed(1),
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.33,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            'pts',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF57534E),
                              height: 1.375,
                              letterSpacing: -0.007 * 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Time frame dropdown
                    GestureDetector(
                      onTap: () {
                        // [_buildHealthScoreTrendSection] Show time frame options
                        print(
                            '[OmieScoreDetailPage] Time frame dropdown pressed');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF08C51)),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/calendar_icon.svg',
                              width: 16.w,
                              height: 16.w,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFF08C51),
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              scoreData.trendData.timeFrame,
                              style: theme.bodyMedium.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFF08C51),
                                height: 1.43,
                                letterSpacing: -0.006 * 14.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            SvgPicture.asset(
                              'assets/images/chevron_down_icon.svg',
                              width: 10.w,
                              height: 10.w,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFF08C51),
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Change indicator
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/arrow_drop_down_icon.svg',
                      width: 16.w,
                      height: 16.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFF43F5E),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${scoreData.trendData.changePercentage}% from last month',
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF57534E),
                        height: 1.43,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Chart placeholder
                Container(
                  width: 311.w,
                  height: 123.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8.r),
                    border:
                        Border.all(color: const Color(0xFFF43F5E), width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      'Chart Area',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Days labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      .map((day) => Text(
                            day,
                            style: theme.bodySmall.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF57534E),
                              height: 1.33,
                              letterSpacing: -0.005 * 12.sp,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildAIRecommendationsSection] - Builds the AI recommendations section
  Widget _buildAIRecommendationsSection(
      BuildContext context, YouthYogaTheme theme, OmieScoreData scoreData) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI Recommendations',
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
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Recommendations card
          Container(
            width: 343.w,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                // Recommendation items
                for (int i = 0;
                    i < scoreData.aiRecommendations.length;
                    i++) ...[
                  _buildAIRecommendationItem(
                      theme, scoreData.aiRecommendations[i]),
                  if (i < scoreData.aiRecommendations.length - 1) ...[
                    SizedBox(height: 16.h),
                    const Divider(color: Color(0xFFE7E5E4), thickness: 1),
                    SizedBox(height: 16.h),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildAIRecommendationItem] - Builds individual AI recommendation item
  Widget _buildAIRecommendationItem(
      YouthYogaTheme theme, AIRecommendation recommendation) {
    return Row(
      children: [
        // Icon
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1E9),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              recommendation.iconPath,
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

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category
              Text(
                recommendation.category,
                style: theme.bodySmall.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF08C51),
                  height: 1.33,
                  letterSpacing: -0.005 * 12.sp,
                ),
              ),

              SizedBox(height: 8.h),

              // Title
              Text(
                recommendation.title,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),

              SizedBox(height: 4.h),

              // Description
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Text(
                  recommendation.description,
                  style: theme.bodySmall.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Target and score increase
              Column(
                children: [
                  // Target value
                  Row(
                    children: [
                      Icon(
                        Icons.track_changes,
                        size: 16.w,
                        color: const Color(0xFFA8A29E),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        recommendation.targetValue,
                        style: theme.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF292524),
                          height: 1.33,
                          letterSpacing: -0.005 * 12.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 16.w),

                  // Score increase
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/star_four_magic_icon.svg',
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFC084FC),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${recommendation.scoreIncrease} Score Increase',
                        style: theme.bodySmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF292524),
                          height: 1.33,
                          letterSpacing: -0.005 * 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Arrow
        SvgPicture.asset(
          'assets/images/chevron_right_icon.svg',
          width: 15.w,
          height: 15.w,
          colorFilter: const ColorFilter.mode(
            Color(0xFF57534E),
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }

  /// [_showOmieScoreInfoModal] - Shows the modal explaining what Omie Score is
  void _showOmieScoreInfoModal(BuildContext context, YouthYogaTheme theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 168.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main modal container
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(32.r),
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
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Illustration
                      Container(
                        width: 311.w,
                        height: 199.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F3EF),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/score.svg',
                            width: 200.w,
                            height: 150.h,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Text content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'What is Omie score?',
                            style: theme.headlineLarge.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF292524),
                              height: 1.33,
                              letterSpacing: -0.012 * 24.sp,
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // Description
                          Text(
                            'The Omie Score is a comprehensive mental health score provided by AI. It summarizes overall mental state based on your active data.',
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

                      SizedBox(height: 24.h),

                      // Action button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // [_showOmieScoreInfoModal] Dismiss modal
                            print(
                                '[OmieScoreDetailPage] Got it button pressed');
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF08C51),
                            foregroundColor: const Color(0xFFFFFFFF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Got it, thanks!',
                                style: theme.bodyMedium.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFFFFFF),
                                  height: 1.375,
                                  letterSpacing: -0.007 * 16.sp,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              SvgPicture.asset(
                                'assets/images/check_single_icon.svg',
                                width: 20.w,
                                height: 20.w,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFFFFFFFF),
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
              ),

              SizedBox(height: 16.h),

              // Close button positioned below the modal
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    // [_showOmieScoreInfoModal] Close modal
                    print('[OmieScoreDetailPage] Close button pressed');
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(
                    'assets/images/close_x_icon.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF292524),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
