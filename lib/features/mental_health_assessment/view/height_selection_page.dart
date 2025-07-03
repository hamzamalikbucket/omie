import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

class HeightSelectionPage extends StatelessWidget {
  const HeightSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const HeightSelectionView(),
    );
  }
}

class HeightSelectionView extends StatefulWidget {
  const HeightSelectionView({super.key});

  @override
  State<HeightSelectionView> createState() => _HeightSelectionViewState();
}

class _HeightSelectionViewState extends State<HeightSelectionView> {
  String _selectedUnit = 'cm'; // Default to cm as shown in Figma
  int _selectedHeight = 162; // Default height shown in Figma
  late FixedExtentScrollController _scrollController;

  final List<int> _heightOptionsCm =
      List.generate(120, (index) => index + 120); // 120-239 cm
  final List<int> _heightOptionsInch =
      List.generate(60, (index) => index + 48); // 48-107 inches (4'-8'11")

  List<int> get _currentHeightOptions =>
      _selectedUnit == 'cm' ? _heightOptionsCm : _heightOptionsInch;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      initialItem: _currentHeightOptions.indexOf(_selectedHeight),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // [HeightSelectionPage] Navigate to mental health conditions page
          Navigator.of(context).pushNamed(AppRoutes.mentalHealthConditions);
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

  Widget _buildMainContent(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.h),
          // Main question
          Text(
            "What is your height?",
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
          _buildUnitSelector(theme),
          SizedBox(height: 24.h),
          // Height picker
          _buildHeightPicker(theme),
          const Spacer(),
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
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
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildUnitSelector(YouthYogaTheme theme) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E5E4), // Background color from Figma
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        children: [
          // cm tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedUnit = 'cm';
                  // Convert height if switching from inch to cm
                  if (_selectedHeight < 120) {
                    _selectedHeight =
                        (_selectedHeight * 2.54).round().clamp(120, 239);
                  }
                  // Update scroll controller for new unit
                  _scrollController.dispose();
                  _scrollController = FixedExtentScrollController(
                    initialItem: _currentHeightOptions.indexOf(_selectedHeight),
                  );
                });
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: _selectedUnit == 'cm'
                      ? theme.primaryBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: _selectedUnit == 'cm'
                      ? [
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
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'cm',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: _selectedUnit == 'cm'
                          ? const Color(0xFF292524)
                          : const Color(0xFF57534E),
                      height: 1.43,
                      letterSpacing: -0.006 * 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // inch tab
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedUnit = 'inch';
                  // Convert height if switching from cm to inch
                  if (_selectedHeight > 107) {
                    _selectedHeight =
                        (_selectedHeight / 2.54).round().clamp(48, 107);
                  }
                  // Update scroll controller for new unit
                  _scrollController.dispose();
                  _scrollController = FixedExtentScrollController(
                    initialItem: _currentHeightOptions.indexOf(_selectedHeight),
                  );
                });
              },
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: _selectedUnit == 'inch'
                      ? theme.primaryBackground
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999.r),
                  boxShadow: _selectedUnit == 'inch'
                      ? [
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
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    'inch',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: _selectedUnit == 'inch'
                          ? const Color(0xFF292524)
                          : const Color(0xFF57534E),
                      height: 1.43,
                      letterSpacing: -0.006 * 14.sp,
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

  Widget _buildHeightPicker(YouthYogaTheme theme) {
    return SizedBox(
      height: 400.h, // Fixed height for the picker
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 80.h, // Height of each item
        perspective: 0.001,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          if (index >= 0 && index < _currentHeightOptions.length) {
            setState(() {
              _selectedHeight = _currentHeightOptions[index];
            });
          }
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index >= _currentHeightOptions.length) {
              return null;
            }

            final height = _currentHeightOptions[index];
            final isSelected = height == _selectedHeight;
            final selectedIndex =
                _currentHeightOptions.indexOf(_selectedHeight);
            final distance = (index - selectedIndex).abs();

            // Determine styling based on distance from center
            double fontSize;
            Color textColor;
            FontWeight fontWeight = FontWeight.w700;

            if (isSelected) {
              fontSize = 60.sp;
              textColor = const Color(0xFF9BB167); // Green color
            } else if (distance == 1) {
              fontSize = 50.sp;
              textColor = const Color(0xFF57534E); // Medium gray
            } else {
              fontSize = 30.sp;
              textColor = const Color(0xFFA8A29E); // Lighter gray
            }

            Widget heightText = Text(
              height.toString(),
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
                height: isSelected ? 0.5 : (distance == 1 ? 1.13 : 1.27),
                letterSpacing: isSelected
                    ? -0.03 * fontSize
                    : (distance == 1 ? -0.018 * fontSize : -0.013 * fontSize),
              ),
              textAlign: TextAlign.center,
            );

            // Add background and border for selected item
            if (isSelected) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7EE), // Light green background
                  border: Border.all(
                    color: const Color(0xFF9BB167), // Green border
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Center(child: heightText),
              );
            }

            return Center(child: heightText);
          },
          childCount: _currentHeightOptions.length,
        ),
      ),
    );
  }
}
