import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [HomeScreenPage] - Main home screen page
/// This page displays the user's mental health dashboard with metrics,
/// greeting, and quick action cards following Apple's Human Interface Guidelines
class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const HomeScreenView(),
    );
  }
}

/// [YogaPoseIconPainter] - Custom painter for the yoga pose icon
/// following the Figma design specifications
class YogaPoseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw yoga pose icon based on Figma design
    // Person in meditation pose
    final path = Path();

    // Head (circle)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.3),
      size.width * 0.08,
      paint,
    );

    // Body
    path.moveTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.75);

    // Arms in meditation position
    path.moveTo(size.width * 0.5, size.height * 0.55);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(size.width * 0.35, size.height * 0.7);

    path.moveTo(size.width * 0.5, size.height * 0.55);
    path.lineTo(size.width * 0.7, size.height * 0.6);
    path.lineTo(size.width * 0.65, size.height * 0.7);

    // Legs in cross-legged position
    path.moveTo(size.width * 0.5, size.height * 0.75);
    path.lineTo(size.width * 0.2, size.height * 0.9);

    path.moveTo(size.width * 0.5, size.height * 0.75);
    path.lineTo(size.width * 0.8, size.height * 0.9);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// [TriangleIndicatorPainter] - Custom painter for the triangle indicator
/// at the bottom of the modal matching the Figma design
class TriangleIndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFFFFF) // White color matching the image
      ..style = PaintingStyle.fill;

    final path = Path();
    // Create a downward-pointing triangle
    path.moveTo(size.width * 0.5, size.height); // Bottom center point
    path.lineTo(0, 0); // Top left point
    path.lineTo(size.width, 0); // Top right point
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// [HomeScreenView] - The main view for the home screen
/// Displays header with greeting, mental health metrics cards,
/// quick info cards, and bottom navigation
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [HomeScreenView] Handle any navigation or state changes
        print('[HomeScreenView] State changed: ${state.status}');
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF), // White background
            body: Column(
              children: [
                // Header section with gradient background
                _buildHeaderSection(context, theme),

                // Main content area
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Mental Health Metrics section
                        _buildMentalHealthMetricsSection(theme),

                        // Quick info cards section
                        _buildQuickInfoSection(theme),

                        // Bottom padding
                        SizedBox(height: 90.h), // Space for bottom navigation
                      ],
                    ),
                  ),
                ),

                // Bottom navigation
                _buildBottomNavigation(theme),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
    );
  }

  /// [_buildHeaderSection] - Builds the header section with gradient background,
  /// top navigation, and greeting text following Apple HIG
  Widget _buildHeaderSection(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF08C51), // Orange from Figma
            Color(0xFFD36321), // Darker orange from Figma
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          // Top navigation bar
          _buildTopNavigation(context, theme),

          // Greeting and status section
          _buildGreetingSection(theme),

          // Bottom padding
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation bar with avatar,
  /// notification, and search icons
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F5F4), // Light gray background
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF57534E),
                  size: 20,
                ),
              ),
            ),

            // Right side icons
            Row(
              children: [
                // Notification bell
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFEEE4), // Light orange background
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFFE06F2D),
                    size: 20,
                  ),
                ),
                SizedBox(width: 12.w),

                // Search icon
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFEEE4), // Light orange background
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Color(0xFFE06F2D),
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildGreetingSection] - Builds the greeting section with status indicators
  Widget _buildGreetingSection(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
      child: Column(
        children: [
          // Greeting container with arrow
          Container(
            width: 343.w,
            padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 16.h),
            child: Row(
              children: [
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting text
                      Text(
                        'Hello, Shinomiya! ??',
                        style: theme.headlineLarge.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFFFFF),
                          height: 1.33,
                          letterSpacing: -0.008 * 18.sp,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Status indicators
                      Row(
                        children: [
                          // Brain icon with "Anxious" status
                          Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFFE1CF),
                                ),
                                child: const Icon(
                                  Icons.psychology,
                                  color: Color(0xFFFFE1CF),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Anxious',
                                style: theme.bodyMedium.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFFFFFFF),
                                  height: 1.43,
                                  letterSpacing: -0.006 * 14.sp,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 8.w),

                          // Dot separator
                          Container(
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFFFFFF).withOpacity(0.32),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          // Sparkle icon with "Plus Member" status
                          Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFFE1CF),
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  color: Color(0xFFFFE1CF),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Plus Member',
                                style: theme.bodyMedium.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFFFFFFF),
                                  height: 1.43,
                                  letterSpacing: -0.006 * 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right arrow
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFFFFFFF),
                  size: 24,
                ),
              ],
            ),
          ),

          // Quick info cards
          _buildQuickInfoCards(theme),
        ],
      ),
    );
  }

  /// [_buildQuickInfoCards] - Builds the Omie Score and Mood cards
  Widget _buildQuickInfoCards(YouthYogaTheme theme) {
    return Row(
      children: [
        // Omie Score card
        Expanded(
          child: GestureDetector(
            onTap: () {
              // [_buildQuickInfoCards] Navigate to Omie Score Detail page
              print(
                  '[HomeScreenView] Omie Score card pressed - navigating to detail page');
              Navigator.pushNamed(context, AppRoutes.omieScoreDetail);
            },
            child: Container(
              height: 90.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFE8DA),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
                child: Row(
                  children: [
                    // Character illustration placeholder
                    Container(
                      width: 29.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE98862),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Score text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '88',
                          style: theme.headlineLarge.copyWith(
                            fontSize: 44.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF08C51),
                            height: 1.2,
                            letterSpacing: 0.0227 * 44.sp,
                          ),
                        ),
                        Text(
                          'Omie Score',
                          style: theme.bodySmall.copyWith(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF292524),
                            height: 1.2,
                            letterSpacing: 0.125 * 8.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Mood card
        Expanded(
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFE8DA),
                ],
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mood',
                  style: theme.bodySmall.copyWith(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF292524),
                    height: 1.2,
                    letterSpacing: 0.125 * 8.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\u{1F60A}",
                        style: TextStyle(
                          fontSize: 32.sp,
                          height: 1.17,
                          letterSpacing: 0.03125 * 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  /// [_buildMentalHealthMetricsSection] - Builds the mental health metrics section
  Widget _buildMentalHealthMetricsSection(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
      child: Column(
        children: [
          // Section header
          _buildSectionHeader(theme),

          SizedBox(height: 12.h),

          // Metrics cards
          _buildMetricsCards(theme),
        ],
      ),
    );
  }

  /// [_buildSectionHeader] - Builds the section header with title and "See All" link
  Widget _buildSectionHeader(YouthYogaTheme theme) {
    return Row(
      children: [
        // Light bulb icon (placeholder)
        Container(
          width: 20.w,
          height: 20.w,
          decoration: const BoxDecoration(
            color: Color(0xffffcca84),
            shape: BoxShape.circle,
          ),
        ),

        SizedBox(width: 6.w),

        // Title
        Expanded(
          child: Text(
            'Mental Health Metrics',
            style: theme.titleMedium.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF292524),
              height: 1.375,
              letterSpacing: -0.007 * 16.sp,
            ),
          ),
        ),

        // See All link
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
    );
  }

  /// [_buildMetricsCards] - Builds the three metrics cards
  Widget _buildMetricsCards(YouthYogaTheme theme) {
    return Column(
      children: [
        // Heart Rate card
        _buildHeartRateCard(theme),

        SizedBox(height: 14.h),

        // Blood Pressure card
        _buildBloodPressureCard(theme),

        SizedBox(height: 14.h),

        // Mindfulness Level card
        _buildMindfulnessCard(theme),
      ],
    );
  }

  /// [_buildHeartRateCard] - Builds the heart rate metrics card
  Widget _buildHeartRateCard(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3EF),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF292524).withOpacity(0.16),
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              // Heart icon
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color(0xffffcca84),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xffffcca84),
                  size: 16,
                ),
              ),

              SizedBox(width: 6.w),

              // Title
              Expanded(
                child: Text(
                  'Heart Rate',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),

              // "Today" with chevron
              Row(
                children: [
                  Text(
                    'Today',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.43,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFFA8A29E),
                    size: 20,
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
                          '72',
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.33,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            'bpm',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF292524),
                              height: 1.375,
                              letterSpacing: -0.007 * 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Label
                    Text(
                      'Resting Rate',
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
              ),

              SizedBox(width: 12.w),

              // Right side - chart
              Expanded(
                child: Column(
                  children: [
                    // Chart placeholder
                    Container(
                      width: 147.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffffcca84).withOpacity(0.24),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffffcca84),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Days labels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                          .map((day) => Text(
                                day,
                                style: theme.bodySmall.copyWith(
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildBloodPressureCard] - Builds the blood pressure metrics card
  Widget _buildBloodPressureCard(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3EF),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF292524).withOpacity(0.16),
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              // Water drop icon
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFFA6B39),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: Color(0xFFFA6B39),
                  size: 16,
                ),
              ),

              SizedBox(width: 6.w),

              // Title
              Expanded(
                child: Text(
                  'Blood Pressure',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),

              // "Today" with chevron
              Row(
                children: [
                  Text(
                    'Today',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.43,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFFA8A29E),
                    size: 20,
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
                          '128/80',
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.33,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            'mmHg',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF292524),
                              height: 1.375,
                              letterSpacing: -0.007 * 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Label
                    Text(
                      'Stable Range',
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
              ),

              SizedBox(width: 12.w),

              // Right side - chart
              Expanded(
                child: Column(
                  children: [
                    // Bar chart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBarChart(8.h, 17.h, 'M'),
                        _buildBarChart(17.h, 8.h, 'T'),
                        _buildBarChart(22.h, 8.h, 'W'),
                        _buildBarChart(22.h, 8.h, 'T'),
                        _buildBarChart(13.h, 8.h, 'F'),
                        _buildBarChart(13.h, 8.h, 'S'),
                        _buildBarChart(24.h, 8.h, 'S'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildBarChart] - Builds individual bar chart item
  Widget _buildBarChart(double height1, double height2, String day) {
    return Column(
      children: [
        // Bar chart
        SizedBox(
          width: 12.w,
          height: 40.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Top bar
              Container(
                width: 4.w,
                height: height1,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD2C2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              SizedBox(height: 2.h),
              // Bottom bar
              Container(
                width: 4.w,
                height: height2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFA6B39),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),

        // Day label
        Text(
          day,
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
  }

  /// [_buildMindfulnessCard] - Builds the mindfulness level card
  Widget _buildMindfulnessCard(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3EF),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF292524).withOpacity(0.16),
            offset: const Offset(0, 5),
            blurRadius: 10,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              // Steps icon
              Container(
                width: 20.w,
                height: 20.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF9BB167),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_walk,
                  color: Color(0xFF9BB167),
                  size: 16,
                ),
              ),

              SizedBox(width: 6.w),

              // Title
              Expanded(
                child: Text(
                  'Mindfulness Level',
                  style: theme.titleMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),

              // "Today" with chevron
              Row(
                children: [
                  Text(
                    'Today',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.43,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFFA8A29E),
                    size: 20,
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
                          '2,158',
                          style: theme.headlineLarge.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF292524),
                            height: 1.33,
                            letterSpacing: -0.012 * 24.sp,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            'steps',
                            style: theme.bodyMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF292524),
                              height: 1.375,
                              letterSpacing: -0.007 * 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Label
                    Text(
                      'On Track',
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
              ),

              SizedBox(width: 12.w),

              // Right side - progress bars
              Expanded(
                child: Column(
                  children: [
                    // Progress bars for each day
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressBar(0.5, 'M'),
                        _buildProgressBar(0.3, 'T'),
                        _buildProgressBar(0.7, 'W'),
                        _buildProgressBar(0.9, 'T'),
                        _buildProgressBar(0.4, 'F'),
                        _buildProgressBar(0.2, 'S'),
                        _buildProgressBar(0.4, 'S'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildProgressBar] - Builds individual progress bar
  Widget _buildProgressBar(double progress, String day) {
    return Column(
      children: [
        // Progress bar
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
                  color: const Color(0xFF9BB167),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),

        // Day label
        Text(
          day,
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
  }

  /// [_buildQuickInfoSection] - Builds the quick info section (placeholder)
  Widget _buildQuickInfoSection(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: const SizedBox(), // Empty for now
    );
  }

  /// [_showFeatureSelectionModal] - Shows the feature selection modal
  /// with health and wellness options following Apple HIG
  /// Ensures modal appears above the bottom navigation bar with curved bottom design
  void _showFeatureSelectionModal(BuildContext context, YouthYogaTheme theme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5), // Semi-transparent overlay
      useSafeArea: true, // Ensures modal respects safe area
      builder: (BuildContext context) {
        // Calculate proper height to ensure modal is above bottom nav
        final screenHeight = MediaQuery.of(context).size.height;
        final safeAreaBottom = MediaQuery.of(context).padding.bottom;
        final bottomNavHeight = 80.h; // Approximate bottom nav height
        final modalHeight =
            screenHeight * 0.55; // 55% of screen height for better fit

        return Container(
          height: modalHeight,
          margin: EdgeInsets.only(
            bottom: safeAreaBottom + bottomNavHeight, // Push above bottom nav
          ),
          child: Stack(
            children: [
              // Main modal container with curved bottom
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF6B7280), // Gray-500 matching the image
                      Color(0xFF4B5563), // Gray-600 for depth
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Handle indicator
                    Container(
                      width: 48.w,
                      height: 4.h,
                      margin: EdgeInsets.only(top: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),

                    // Feature grid
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                        child: Column(
                          children: [
                            // First row
                            Row(
                              children: [
                                _buildFeatureItem(
                                  icon: Icons.favorite_border,
                                  title: 'Health Metrics',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.access_time,
                                  title: 'Mindful Minute',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.bedtime,
                                  title: 'Sleep',
                                  theme: theme,
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Second row
                            Row(
                              children: [
                                _buildFeatureItem(
                                  icon: Icons.book_outlined,
                                  title: 'Self-Journaling',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.warning_amber_outlined,
                                  title: 'Stress Level',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.local_hospital_outlined,
                                  title: 'Therapist Ap...',
                                  theme: theme,
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Third row
                            Row(
                              children: [
                                _buildFeatureItem(
                                  icon: Icons.settings,
                                  title: 'Symptom Che...',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.article_outlined,
                                  title: 'Resources',
                                  theme: theme,
                                ),
                                SizedBox(width: 24.w),
                                _buildFeatureItem(
                                  icon: Icons.chat_bubble_outline,
                                  title: 'Community',
                                  theme: theme,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom triangle indicator positioned at the bottom center
              Positioned(
                bottom: 16.h,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 12.w,
                    height: 8.h,
                    child: CustomPaint(
                      painter: TriangleIndicatorPainter(),
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

  /// [_buildFeatureItem] - Builds individual feature item
  /// with styling matching the Figma design
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required YouthYogaTheme theme,
  }) {
    return Expanded(
      child: Column(
        children: [
          // Circular icon container with cream/beige background
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color:
                  const Color(0xFFF5F5DC), // Light cream/beige matching image
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Icon(
              icon,
              size: 28.w,
              color:
                  const Color(0xFFD2691E), // Orange/amber color matching image
            ),
          ),
          SizedBox(height: 12.h),
          // White text label
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFFFFFFF),
              height: 1.4,
              letterSpacing: -0.005 * 13.sp,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// [_buildBottomNavigation] - Builds the bottom navigation bar
  Widget _buildBottomNavigation(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          top: BorderSide(
            color: Color(0xFFF5F5F4),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Home tab (active)
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFF08C51),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color(0xFFF08C51),
                      size: 18,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Home',
                    style: theme.bodySmall.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF533630),
                      height: 1.33,
                      letterSpacing: -0.005 * 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Omie AI tab
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.psychology,
                    color: Color(0xFFA8A29E),
                    size: 24,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Omie AI',
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
          ),

          // Center yoga button
          GestureDetector(
            onTap: () {
              // [_buildBottomNavigation] Show feature selection modal
              print('[HomeScreenView] Center yoga button pressed');
              _showFeatureSelectionModal(context, theme);
            },
            child: Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF08C51),
                    Color(0xFFEB8448),
                  ],
                ),
                borderRadius: BorderRadius.circular(26.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF08C51).withOpacity(1.0),
                    offset: const Offset(0, 5),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Container(
                width: 35.w,
                height: 35.w,
                alignment: Alignment.center,
                child: CustomPaint(
                  size: Size(29.17.w, 26.25.h),
                  painter: YogaPoseIconPainter(),
                ),
              ),
            ),
          ),

          // Resources tab
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.library_books,
                    color: Color(0xFFA8A29E),
                    size: 24,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Resources',
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
          ),

          // Profile tab
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xFFA8A29E),
                    size: 24,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Profile',
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
          ),
        ],
      ),
    );
  }
}
