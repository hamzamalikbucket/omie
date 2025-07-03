import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';
import 'health_goal_selection_page.dart';

class ComprehensiveMentalHealthAssessmentPage extends StatelessWidget {
  const ComprehensiveMentalHealthAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const ComprehensiveMentalHealthAssessmentView(),
    );
  }
}

class ComprehensiveMentalHealthAssessmentView extends StatefulWidget {
  const ComprehensiveMentalHealthAssessmentView({super.key});

  @override
  State<ComprehensiveMentalHealthAssessmentView> createState() =>
      _ComprehensiveMentalHealthAssessmentViewState();
}

class _ComprehensiveMentalHealthAssessmentViewState
    extends State<ComprehensiveMentalHealthAssessmentView> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  Color _getBorderColor(YouthYogaTheme theme) {
    if (_hasError) {
      return theme.error; // Red color for error state
    } else if (_isFocused) {
      return theme
          .primary; // Orange color for active/focused state (same as button)
    } else {
      return const Color(0xFFD6D3D1); // Gray color for inactive state
    }
  }

  Color _getTextColor(YouthYogaTheme theme) {
    if (_hasError) {
      return theme.error; // Red text for error state
    } else if (_isFocused || _nameController.text.isNotEmpty) {
      return const Color(0xFF292524); // Dark text when active or has content
    } else {
      return const Color(0xFF9CA3AF); // Gray text when inactive
    }
  }

  bool _isValidName(String name) {
    return name.trim().length >= 6; // Minimum 6 characters required
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
              builder: (context) => const HealthGoalSelectionPage(),
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
                          // Filled portion (20% - first step)
                          Expanded(
                            flex: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (80%)
                          const Expanded(
                            flex: 80,
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
            "What's your full legal name?",
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
          // Input field with different states
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent, // Transparent background
              border: Border.all(
                color: _getBorderColor(theme),
                width: _isFocused ? 2 : 1, // Thicker border when focused
              ),
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: TextFormField(
              controller: _nameController,
              focusNode: _focusNode,
              style: theme.titleMedium.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: _getTextColor(theme),
                height: 1.78,
                letterSpacing: -0.012 * 18.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Yasan Malik',
                hintStyle: theme.titleMedium.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF), // Consistent hint color
                  height: 1.78,
                  letterSpacing: -0.012 * 18.sp,
                ),
                border: InputBorder.none, // Remove default border
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false, // No fill color
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  // Clear error when user reaches minimum characters
                  if (_hasError && _isValidName(value)) {
                    _hasError = false;
                  }
                  // Set error if less than 6 characters and not empty
                  else if (value.isNotEmpty && !_isValidName(value)) {
                    _hasError = true;
                  }
                });
              },
              validator: (value) {
                if (value == null || !_isValidName(value)) {
                  setState(() {
                    _hasError = true;
                  });
                  return 'Name must be at least 6 characters long';
                }
                setState(() {
                  _hasError = false;
                });
                return null;
              },
            ),
          ),
          if (_hasError) ...[
            SizedBox(height: 8.h),
            Text(
              'Name must be at least 6 characters long',
              style: theme.bodySmall.copyWith(
                color: theme.error,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 24.h),
          // Helper text with icon
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/identity_badge_icon.svg',
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFA8A29E), // Gray color from Figma
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'For regulatory purposes, please enter name stated on your state ID.',
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E), // Stone/60 from Figma
                    height: 1.6,
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
              onPressed: () {
                // Validate input before continuing
                if (!_isValidName(_nameController.text)) {
                  setState(() {
                    _hasError = true;
                  });
                  return;
                }

                context
                    .read<MentalHealthAssessmentBloc>()
                    .add(const ReadyButtonPressed());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary, // Orange primary
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
}
