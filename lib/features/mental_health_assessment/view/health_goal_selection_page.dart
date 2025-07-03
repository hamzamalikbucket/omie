import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';
import 'date_of_birth_page.dart';

class HealthGoalSelectionPage extends StatelessWidget {
  const HealthGoalSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const HealthGoalSelectionView(),
    );
  }
}

class HealthGoalSelectionView extends StatefulWidget {
  const HealthGoalSelectionView({super.key});

  @override
  State<HealthGoalSelectionView> createState() =>
      _HealthGoalSelectionViewState();
}

class _HealthGoalSelectionViewState extends State<HealthGoalSelectionView> {
  String? _selectedGoal;

  final List<HealthGoalOption> _healthGoals = [
    HealthGoalOption(
      id: 'improve_mental_health',
      title: 'Improve my mental health',
      iconAsset: 'assets/images/health_plus_icon.svg',
    ),
    HealthGoalOption(
      id: 'manage_stress_anxiety',
      title: 'Manage stress & anxiety',
      iconAsset: 'assets/images/error_triangle_icon.svg',
    ),
    HealthGoalOption(
      id: 'ai_companion',
      title: 'I wanna try AI Companion',
      iconAsset: 'assets/images/robot_face_icon.svg',
    ),
    HealthGoalOption(
      id: 'mindful_meditate',
      title: 'Be more mindful & meditate',
      iconAsset: 'assets/images/leafs_icon.svg',
    ),
    HealthGoalOption(
      id: 'grow_focus',
      title: 'Grow myself and focus',
      iconAsset: 'assets/images/brain_top_icon.svg',
    ),
    HealthGoalOption(
      id: 'try_app',
      title: 'Just wanna try the app',
      iconAsset: 'assets/images/device_mobile_icon.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DateOfBirthPage(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopNavigation(theme),
              _buildTitle(theme),
              Expanded(
                child: _buildMainContent(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopNavigation(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        children: [
          // Top navigation row
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
              // Progress bar section
              Expanded(
                child: Column(
                  children: [
                    // Progress bar
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E5E4), // Background
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          // Filled portion (40% - second step)
                          Expanded(
                            flex: 40,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (60%)
                          const Expanded(
                            flex: 60,
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

  Widget _buildTitle(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
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

  Widget _buildMainContent(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          // Main question
          Text(
            "What is your health goal for the app?",
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
          // Health goal options
          Expanded(
            child: _buildHealthGoalOptions(theme),
          ),
          SizedBox(height: 24.h),
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _selectedGoal != null
                  ? () {
                      context
                          .read<MentalHealthAssessmentBloc>()
                          .add(const ReadyButtonPressed());
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedGoal != null
                    ? theme.primary
                    : const Color(0xFFE5E5E5), // Gray when disabled
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
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildHealthGoalOptions(YouthYogaTheme theme) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: _healthGoals.map((goal) {
          final isSelected = _selectedGoal == goal.id;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedGoal = goal.id;
              });
            },
            child: Container(
              width: 160.w,
              height: 104.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(
                        0xFFF5F7EE) // Light green background when selected
                    : theme
                        .primaryBackground, // White background when not selected
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF9BB167) // Green border when selected
                      : const Color(
                          0xFFE5E5E5), // Gray border when not selected
                  width: 1,
                ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    goal.iconAsset,
                    width: 24.w,
                    height: 24.w,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? const Color(0xFF9BB167) // Green icon when selected
                          : const Color(
                              0xFFA8A29E), // Gray icon when not selected
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    goal.title,
                    style: theme.bodyLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? const Color(
                              0xFF3F4B29) // Dark green text when selected
                          : const Color(
                              0xFF57534E), // Gray text when not selected
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HealthGoalOption {
  final String id;
  final String title;
  final String iconAsset;

  HealthGoalOption({
    required this.id,
    required this.title,
    required this.iconAsset,
  });
}
