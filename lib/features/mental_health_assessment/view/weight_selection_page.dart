import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

class WeightSelectionPage extends StatelessWidget {
  const WeightSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const WeightSelectionView(),
    );
  }
}

class WeightSelectionView extends StatelessWidget {
  const WeightSelectionView({super.key});

  List<int> _getWeightOptions(String unit) {
    if (unit == 'lbs') {
      return List.generate(300, (index) => index + 50); // 50-349 lbs
    } else {
      return List.generate(200, (index) => index + 20); // 20-219 kg
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
      builder: (context, state) {
        return BlocListener<MentalHealthAssessmentBloc,
            MentalHealthAssessmentState>(
          listener: (context, state) {
            if (state.status ==
                MentalHealthAssessmentStatus.navigateToAssessment) {
              // Navigate to height selection page
              Navigator.of(context).pushNamed(AppRoutes.heightSelection);
            }
          },
          child: Scaffold(
            backgroundColor: theme.primaryBackground,
            body: SafeArea(
              child: Column(
                children: [
                  _buildTopNavigation(theme, context),
                  _buildTitle(theme),
                  Expanded(
                    child: _buildMainContent(theme, state, context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopNavigation(YouthYogaTheme theme, BuildContext context) {
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
                          // Filled portion (100% - final step)
                          Expanded(
                            flex: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
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

  Widget _buildMainContent(YouthYogaTheme theme,
      MentalHealthAssessmentState state, BuildContext context) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          // Main question
          Text(
            "What is your weight?",
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
          // Tab Group for units
          _buildUnitSelector(theme, state, context),
          SizedBox(height: 24.h),
          // Weight display and picker
          _buildWeightPicker(theme, state, context),
          const Spacer(),
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: BlocBuilder<MentalHealthAssessmentBloc,
                MentalHealthAssessmentState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
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
                );
              },
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildUnitSelector(YouthYogaTheme theme,
      MentalHealthAssessmentState state, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F4), // Stone background
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          // LBS Tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<MentalHealthAssessmentBloc>().add(
                      const WeightUnitChanged('lbs'),
                    );
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: state.weightUnit == 'lbs'
                      ? theme.primaryBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'LBS',
                    style: theme.labelLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: state.weightUnit == 'lbs'
                          ? const Color(0xFF533630)
                          : const Color(0xFF9CA3AF),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // KG Tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<MentalHealthAssessmentBloc>().add(
                      const WeightUnitChanged('kg'),
                    );
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: state.weightUnit == 'kg'
                      ? theme.primaryBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'KG',
                    style: theme.labelLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: state.weightUnit == 'kg'
                          ? const Color(0xFF533630)
                          : const Color(0xFF9CA3AF),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightPicker(YouthYogaTheme theme,
      MentalHealthAssessmentState state, BuildContext context) {
    final weightOptions = _getWeightOptions(state.weightUnit);

    return Column(
      children: [
        // Current weight display
        Text(
          '${state.weightValue} ${state.weightUnit}',
          style: theme.headlineLarge.copyWith(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF533630), // Stone color from Figma
            height: 1.11,
            letterSpacing: -0.014 * 36.sp,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        // Weight picker wheel
        SizedBox(
          height: 160.h,
          child: Stack(
            children: [
              // Selection indicator (overlay)
              Positioned.fill(
                child: Center(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BB167).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              // Scroll wheel
              ListWheelScrollView.useDelegate(
                controller: FixedExtentScrollController(
                  initialItem: weightOptions.indexOf(state.weightValue),
                ),
                itemExtent: 48.h,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  context.read<MentalHealthAssessmentBloc>().add(
                        WeightValueChanged(weightOptions[index]),
                      );
                },
                childDelegate: ListWheelChildListDelegate(
                  children: weightOptions.map((weight) {
                    final isSelected = weight == state.weightValue;
                    return Center(
                      child: Text(
                        weight.toString(),
                        style: theme.titleMedium.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFF533630)
                              : const Color(0xFF9CA3AF),
                          height: 1.78,
                          letterSpacing: -0.012 * 18.sp,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
