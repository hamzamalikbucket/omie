import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';
import 'weight_selection_page.dart';

class GenderSelectionPage extends StatelessWidget {
  const GenderSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const GenderSelectionView(),
    );
  }
}

class GenderSelectionView extends StatefulWidget {
  const GenderSelectionView({super.key});

  @override
  State<GenderSelectionView> createState() => _GenderSelectionViewState();
}

class _GenderSelectionViewState extends State<GenderSelectionView> {
  String? _selectedGender;


  @override
  void initState() {
    super.initState();
    _selectedGender = 'neutral'; // Default to neutral as shown in Figma
  }
  final List<GenderSelectionOption> _genderOptions = [
    GenderSelectionOption(
      id: 'Male',
      title: 'I am Male',
      iconAsset: 'assets/images/health_plus_icon.svg',
    ),
    GenderSelectionOption(
      id: 'Female',
      title: 'I am Female',
      iconAsset: 'assets/images/health_plus_icon.svg',
    ),
    GenderSelectionOption(
      id: 'Other',
      title: 'I am Other',
      iconAsset: 'assets/images/health_plus_icon.svg',
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
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          // Main question
          Text(
            "What is your gender?",
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
          Text(
            'For the purpose of regulations please specify your gender truthfully',
            style: theme.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60 from Figma
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          // gender Options
          SizedBox(height: 24.h),
          // Health goal options
          _buildGenderOptions(theme),
          SizedBox(height: 24.h),
          // Selected Gender Buttons

          const Spacer(),
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _selectedGender != null
                  ? () {
                context
                    .read<MentalHealthAssessmentBloc>()
                    .add(const ReadyButtonPressed());
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedGender != null
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

  //make this view in vertical scrollable
  // This method

  Widget _buildGenderOptions(YouthYogaTheme theme) {
    return SingleChildScrollView(
      child: Column(
        children: _genderOptions.map((goal) {
          final isSelected = _selectedGender == goal.id;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedGender = goal.id;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width:MediaQuery.sizeOf(context).width,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
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
                            SizedBox(width: 12.w),
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
                      Radio<String>(
                        value: goal.id,
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        activeColor: const Color(0xFF9BB167), // Green when selected
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
class GenderSelectionOption {
  final String id;
  final String title;
  final String iconAsset;

  GenderSelectionOption({
    required this.id,
    required this.title,
    required this.iconAsset,
  });
}


