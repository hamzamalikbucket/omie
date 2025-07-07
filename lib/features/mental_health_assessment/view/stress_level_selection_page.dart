import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [StressLevelSelectionPage] - Stress level selection page
/// This page allows users to select their stress level
/// as part of the comprehensive mental health assessment flow
class StressLevelSelectionPage extends StatelessWidget {
  const StressLevelSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const StressLevelSelectionView(),
    );
  }
}

/// [StressLevelSelectionView] - The main view for stress level selection
/// Displays stress level options with emoji faces and descriptions
class StressLevelSelectionView extends StatefulWidget {
  const StressLevelSelectionView({super.key});

  @override
  State<StressLevelSelectionView> createState() =>
      _StressLevelSelectionViewState();
}

class _StressLevelSelectionViewState extends State<StressLevelSelectionView> {
  /// [_StressLevelSelectionViewState] Current slider position (0.0 to 1.0)
  double _sliderPosition = 0.0;

  /// [_StressLevelSelectionViewState] Get stress level based on slider position
  String _getStressLevelFromPosition(double position) {
    // Map position to exact stress level positions (0, 0.25, 0.5, 0.75, 1.0)
    if (position <= 0.125) return 'Extreme';
    if (position <= 0.375) return 'High';
    if (position <= 0.625) return 'Neutral';
    if (position <= 0.875) return 'Mild';
    return 'Calm';
  }

  /// [_StressLevelSelectionViewState] Get position based on stress level
  double _getPositionFromStressLevel(String? stressLevel) {
    switch (stressLevel) {
      case 'Extreme':
        return 0.0;
      case 'High':
        return 0.25;
      case 'Neutral':
        return 0.5;
      case 'Mild':
        return 0.75;
      case 'Calm':
        return 1.0;
      default:
        return 0.0;
    }
  }

  /// [_StressLevelSelectionViewState] Snap position to nearest stress level
  double _snapToNearestLevel(double position) {
    const levels = [0.0, 0.25, 0.5, 0.75, 1.0];
    double closestLevel = levels[0];
    double minDistance = (position - levels[0]).abs();

    for (double level in levels) {
      double distance = (position - level).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestLevel = level;
      }
    }
    return closestLevel;
  }

  /// [_StressLevelSelectionViewState] Update slider position and stress level
  void _updateSliderPosition(double position) {
    final snappedPosition = _snapToNearestLevel(position);
    setState(() {
      _sliderPosition = snappedPosition;
    });
    final stressLevel = _getStressLevelFromPosition(snappedPosition);
    context
        .read<MentalHealthAssessmentBloc>()
        .add(StressLevelChanged(stressLevel));
  }

  @override
  void initState() {
    super.initState();
    // [_StressLevelSelectionViewState] Initialize with "Extreme" stress level selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MentalHealthAssessmentBloc>()
          .add(const StressLevelChanged('Extreme'));
      setState(() {
        _sliderPosition = _getPositionFromStressLevel('Extreme');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [StressLevelSelectionView] Navigate to next step when continue is pressed
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // TODO: Navigate to next assessment step
        }
        // [StressLevelSelectionView] Update slider position when stress level changes externally
        if (state.selectedStressLevel != null) {
          final newPosition =
              _getPositionFromStressLevel(state.selectedStressLevel);
          if (newPosition != _sliderPosition) {
            setState(() {
              _sliderPosition = newPosition;
            });
          }
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
                  // [StressLevelSelectionView] Handle skip action - navigate to next step
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
  /// stress level options, and continue button
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 24.h),
          // Main question text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "How would you rate your stress level?",
              style: theme.headlineLarge.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF533630), // Stone color from Figma
                height: 1.27,
                letterSpacing: -0.013 * 30.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.h),
          // Stress level options with slider
          Expanded(
            child: _buildStressLevelOptions(context, theme, state),
          ),
          SizedBox(height: 24.h),
          // Continue button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _buildContinueButton(context, theme, state),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildStressLevelOptions] - Builds the stress level options with vertical slider
  Widget _buildStressLevelOptions(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return Container(
      height: 320.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Left side - Stress level labels
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStressLevelLabel(
                    'Extreme', state.selectedStressLevel == 'Extreme'),
                _buildStressLevelLabel(
                    'High', state.selectedStressLevel == 'High'),
                _buildStressLevelLabel(
                    'Neutral', state.selectedStressLevel == 'Neutral'),
                _buildStressLevelLabel(
                    'Mild', state.selectedStressLevel == 'Mild'),
                _buildStressLevelLabel(
                    'Calm', state.selectedStressLevel == 'Calm'),
              ],
            ),
          ),
          SizedBox(width: 24.w),
          // Center - Vertical slider
          _buildCenteredVerticalSlider(context, theme, state),
          SizedBox(width: 24.w),
          // Right side - Emoji faces
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildEmojiIcon('assets/images/face_extreme_stressed_icon.svg',
                    state.selectedStressLevel == 'Extreme'),
                _buildEmojiIcon('assets/images/face_high_stressed_icon.svg',
                    state.selectedStressLevel == 'High'),
                _buildEmojiIcon('assets/images/face_neutral_icon.svg',
                    state.selectedStressLevel == 'Neutral'),
                _buildEmojiIcon('assets/images/face_mild_stressed_icon.svg',
                    state.selectedStressLevel == 'Mild'),
                _buildEmojiIcon('assets/images/face_calm_icon.svg',
                    state.selectedStressLevel == 'Calm'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildStressLevelLabel] - Builds individual stress level label
  Widget _buildStressLevelLabel(String level, bool isSelected) {
    return GestureDetector(
      onTap: () {
        final position = _getPositionFromStressLevel(level);
        _updateSliderPosition(position);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Text(
          level,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color:
                isSelected ? const Color(0xFF292524) : const Color(0xFFA8A29E),
            height: 1.33,
            letterSpacing: -0.008 * 18.sp,
          ),
        ),
      ),
    );
  }

  /// [_buildEmojiIcon] - Builds individual emoji icon
  Widget _buildEmojiIcon(String iconPath, bool isSelected) {
    // Extract level from iconPath for tap functionality
    String level = 'Extreme';
    if (iconPath.contains('high'))
      level = 'High';
    else if (iconPath.contains('neutral'))
      level = 'Neutral';
    else if (iconPath.contains('mild'))
      level = 'Mild';
    else if (iconPath.contains('calm')) level = 'Calm';

    return GestureDetector(
      onTap: () {
        final position = _getPositionFromStressLevel(level);
        _updateSliderPosition(position);
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        child: SvgPicture.asset(
          iconPath,
          width: 48.w,
          height: 48.w,
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFFDF4024) : const Color(0xFFD6D3D1),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /// [_buildCenteredVerticalSlider] - Builds the centered vertical slider
  Widget _buildCenteredVerticalSlider(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return SizedBox(
      width: 80.w, // Increased touch area
      height: 320.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque, // Ensure gesture detection works
            onPanStart: (details) {
              final localPosition = details.localPosition;
              final relativePosition = (localPosition.dy - 20.h) / 256.h;
              final clampedPosition = relativePosition.clamp(0.0, 1.0);
              _updateSliderPosition(clampedPosition);
            },
            onPanUpdate: (details) {
              final localPosition = details.localPosition;
              final relativePosition = (localPosition.dy - 20.h) / 256.h;
              final clampedPosition = relativePosition.clamp(0.0, 1.0);
              _updateSliderPosition(clampedPosition);
            },
            onTapDown: (details) {
              final localPosition = details.localPosition;
              final relativePosition = (localPosition.dy - 20.h) / 256.h;
              final clampedPosition = relativePosition.clamp(0.0, 1.0);
              _updateSliderPosition(clampedPosition);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Invisible touch area for better gesture detection
                Container(
                  width: 80.w,
                  height: 320.h,
                  color: Colors.transparent,
                ),
                // Slider track
                Container(
                  width: 4.w,
                  height: 280.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                // Slider dots/indicators at exact positions
                ...List.generate(5, (index) {
                  final position = index * 64.h;
                  return Positioned(
                    top: 20.h + position,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: const Color(0xFFFFFFFF),
                          width: 1,
                        ),
                      ),
                    ),
                  );
                }),
                // Active slider handle
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  top: 20.h + (_sliderPosition * 256.h),
                  child: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF08C51),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: const Color(0xFFFFFFFF),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF292524).withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.unfold_more_rounded,
                      color: const Color(0xFFFFFFFF),
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: state.selectedStressLevel != null
            ? () {
                // [StressLevelSelectionView] Handle continue action - navigate to profile setup
                Navigator.of(context).pushNamed(AppRoutes.profileSetup);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary
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
