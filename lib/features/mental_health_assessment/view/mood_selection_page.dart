import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';
import 'weight_selection_page.dart';

class MoodSelectionPage extends StatelessWidget {
  const MoodSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const MoodSelectionView(),
    );
  }
}

class MoodSelectionView extends StatefulWidget {
  const MoodSelectionView({super.key});

  @override
  State<MoodSelectionView> createState() => _MoodSelectionViewState();
}

class _MoodSelectionViewState extends State<MoodSelectionView> {
  String? _selectedMood;
  Color _getMoodHighlightColor(MoodOption mood) {
    switch (mood.id) {
      case 'sad':
        return const Color(0xFFFFF3E0); // Light orange
      case 'neutral':
        return const Color(0xFFFFF9C4); // Light yellow
      case 'happy':
        return const Color(0xFFF1F8E9); // Light green
      default:
        return mood.backgroundColor;
    }
  }
  final List<MoodOption> _moodOptions = [
    MoodOption(
      id: 'sad',
      title: 'Sad',
      iconAsset: 'assets/images/sad_emoji_icon.svg',
      backgroundColor: const Color(0xFFFB923C), // Orange background
      textColor: const Color(0xFFFFFFFF),
      hasGlow: false,// White text
    ),
    MoodOption(
      id: 'neutral',
      title: 'Neutral',
      iconAsset: 'assets/images/neutral_emoji_icon.svg',
      backgroundColor: const Color(0xFFFBBF24), // Yellow background
      borderColor: const Color(0xFFE9A800), // Yellow border
      textColor: const Color(0xFFFFFFFF), // White text
      hasGlow: true,
    ),
    MoodOption(
      id: 'happy',
      title: 'Happy',
      iconAsset: 'assets/images/happy_emoji_icon.svg',
      backgroundColor: const Color(0xFF9BB167), // Green background
      textColor: const Color(0xFFFFFFFF),
      hasGlow: false,// White text
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedMood = 'neutral'; // Default to neutral as shown in Figma
  }

  String _getMoodText() {
    switch (_selectedMood) {
      case 'sad':
        return 'I Feel Sad.';
      case 'neutral':
        return 'I Feel Neutral.';
      case 'happy':
        return 'I Feel Happy.';
      default:
        return 'I Feel Neutral.';
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WeightSelectionPage(),
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
                          // Filled portion (80% - fourth step)
                          Expanded(
                            flex: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (20%)
                          const Expanded(
                            flex: 20,
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
            "How would you describe your mood?",
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
          // Mood options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _moodOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final mood = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  left: index > 0 ? 24.w : 0,
                ),
                child: _buildMoodOption(mood),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),
          // Selected mood text
          SizedBox(
            width: 343.w,
            child: Column(
              children: [
                Text(
                  _getMoodText(),
                  style: theme.headlineSmall.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF57534E), // Stone/60 from Figma
                    height: 1.4,
                    letterSpacing: -0.01 * 20.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _selectedMood != null
                  ? () {
                      context
                          .read<MentalHealthAssessmentBloc>()
                          .add(const ReadyButtonPressed());
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedMood != null
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

  Widget _buildMoodOption(MoodOption mood) {
    final isSelected = _selectedMood == mood.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood.id;
        });
      },
      child: Container(
        width: 95.w,
        height: 104.h,
        decoration: BoxDecoration(
          color:mood.backgroundColor,
          border: mood.borderColor != null
              ? Border.all(color: mood.borderColor!, width: 1)
              : null,
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
            // Add special glow for neutral (selected in Figma)
            if (isSelected)
              BoxShadow(
                color: mood.backgroundColor.withOpacity(1.0),
                offset: const Offset(0, 5),
                blurRadius: 52,
                spreadRadius: 0,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: SvgPicture.asset(
                mood.iconAsset,
                width: 52.w,
                height: 44.h,
              ),
            ),
            // Text
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                mood.title,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: mood.textColor,
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodOption {
  final String id;
  final String title;
  final String iconAsset;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final bool? hasGlow;

  MoodOption({
    required this.id,
    required this.title,
    required this.iconAsset,
    required this.backgroundColor,
    this.borderColor,
    required this.textColor,
    this.hasGlow,
  });
}
