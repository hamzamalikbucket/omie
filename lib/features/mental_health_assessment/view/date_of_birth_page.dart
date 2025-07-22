import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth_for_yoga/features/mental_health_assessment/view/gender_selection_page.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';
import 'mood_selection_page.dart';

class DateOfBirthPage extends StatelessWidget {
  const DateOfBirthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const DateOfBirthView(),
    );
  }
}

class DateOfBirthView extends StatefulWidget {
  const DateOfBirthView({super.key});

  @override
  State<DateOfBirthView> createState() => _DateOfBirthViewState();
}

class _DateOfBirthViewState extends State<DateOfBirthView> {
  FixedExtentScrollController? _monthController;
  FixedExtentScrollController? _dayController;
  FixedExtentScrollController? _yearController;

  int _selectedMonthIndex = 2; // March (index 2)
  int _selectedDayIndex = 5; // 3 (index 2)
  int _selectedYearIndex = 180; // 2001 (index 2)

  final List<String> _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov','Dec'];

 /* final List<String> _days = ['01','02','03','06', '07', '08', '09', '10'];*/
  final List<String> _days = [
    for (int i = 1; i <= 30; i++) i.toString().padLeft(2, '0')
  ];
 /* final List<String> _years = ['1999', '2000', '2001', '2002', '2003'];*/
  final List<String> _years = [
    for (int i = 1800; i <= 3000; i++) i.toString().padLeft(2, '0')
  ];

  @override
  void initState() {
    super.initState();
    _monthController =
        FixedExtentScrollController(initialItem: _selectedMonthIndex);
    _dayController =
        FixedExtentScrollController(initialItem: _selectedDayIndex);
    _yearController =
        FixedExtentScrollController(initialItem: _selectedYearIndex);
  }

  @override
  void dispose() {
    _monthController?.dispose();
    _dayController?.dispose();
    _yearController?.dispose();
    super.dispose();
  }

  int _calculateAge() {
    final currentYear = DateTime.now().year;
    final birthYear = int.parse(_years[_selectedYearIndex]);
    return currentYear - birthYear;
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
              builder: (context) => const GenderSelectionPage(),

              //MoodSelectionPage() // Navigate to MoodSelectionPage
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
                          // Filled portion (60% - third step)
                          Expanded(
                            flex: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (40%)
                          const Expanded(
                            flex: 40,
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
            "When were you born?",
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
          // Date picker container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8F3), // Light orange background
              borderRadius: BorderRadius.circular(24.r),
            ),
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                // Date picker wheels
                SizedBox(
                  height: 260.h,
                  child: Row(
                    children: [
                      // Month picker
                      Expanded(
                        child: _monthController != null
                            ? _buildDateWheelPicker(
                                controller: _monthController!,
                                items: _months,
                                selectedIndex: _selectedMonthIndex,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedMonthIndex = index;
                                  });
                                },
                                alignment: TextAlign.right,
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(width: 24.w),
                      // Day picker
                      Expanded(
                        child: _dayController != null
                            ? _buildDateWheelPicker(
                                controller: _dayController!,
                                items: _days,
                                selectedIndex: _selectedDayIndex,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedDayIndex = index;
                                  });
                                },
                                alignment: TextAlign.center,
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(width: 24.w),
                      // Year picker
                      Expanded(
                        child: _yearController != null
                            ? _buildDateWheelPicker(
                                controller: _yearController!,
                                items: _years,
                                selectedIndex: _selectedYearIndex,
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    _selectedYearIndex = index;
                                  });
                                },
                                alignment: TextAlign.left,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Age indicator
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFFFF8F3), // Same light orange background
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/cake_icon.svg',
                        width: 20.w,
                        height: 20.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFA8A29E), // Gray color from Figma
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'I\'m ${_calculateAge()} years of age',
                        style: theme.bodySmall.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF57534E), // Stone/60 from Figma
                          height: 1.43,
                          letterSpacing: -0.006 * 14.sp,
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildDateWheelPicker({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedIndex,
    required ValueChanged<int> onSelectedItemChanged,
    required TextAlign alignment,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: 52.h,
      perspective: 0.003,
      diameterRatio: 2.0,
      squeeze: 1.0,
      useMagnifier: false,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: items.length,
        builder: (context, index) {
          final isSelected = index == selectedIndex;
          return Container(
            width: double.infinity,
            height: 52.h,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: isSelected
                ? BoxDecoration(
                    color: const Color(0xFFF5F7EE), // Light green background
                    border: Border.all(
                      color: const Color(0xFF9BB167), // Green border
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(9999.r),
                  )
                : null,
            child: Text(
              items[index],
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: isSelected
                    ? const Color(0xFF9BB167) // Green text when selected
                    : (index == 0 || index == items.length - 1)
                        ? const Color(0xFFA8A29E) // Gray for edge items
                        : const Color(0xFF57534E), // Normal text color
                height: 1.33,
                letterSpacing: -0.012 * 24.sp,
              ),
              textAlign: alignment,
            ),
          );
        },
      ),
    );
  }
}
