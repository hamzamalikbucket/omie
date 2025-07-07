import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [GeneralInfoPage] - Profile setup and account completion page
/// This page shows the general information form as the first step
class GeneralInfoPage extends StatelessWidget {
  const GeneralInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const GeneralInfoView(),
    );
  }
}

/// [GeneralInfoView] - The main view for general information form
/// Displays the form with personal details fields
class GeneralInfoView extends StatefulWidget {
  const GeneralInfoView({super.key});

  @override
  State<GeneralInfoView> createState() => _GeneralInfoViewState();
}

class _GeneralInfoViewState extends State<GeneralInfoView> {
  String selectedGender = 'Select Gender';

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [GeneralInfoView] Handle navigation or other state changes
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // TODO: Navigate to next step
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SafeArea(
              child: Column(
                children: [
                  // Top navigation
                  _buildTopNavigation(theme, context),
                  // Main content
                  Expanded(
                    child: _buildMainContent(context, theme),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation with back button and progress
  Widget _buildTopNavigation(YouthYogaTheme theme, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: Column(
        children: [
          // Navigation row with back button, progress, and skip
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () {
                  // [GeneralInfoView] Handle back navigation
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/images/chevron_left_icon.svg',
                  width: 24.w,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF533630),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Progress bar
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E5E4),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.5, // 50% progress
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF9BB167),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Skip button
              GestureDetector(
                onTap: () {
                  // [GeneralInfoView] Handle skip action
                  Navigator.pushNamed(context, AppRoutes.profileSetup);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF533630),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Title
          Text(
            'Profile Setup & Account Completion',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content with form fields
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Please confirm and fill your identity below',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF533630),
                height: 1.27,
                letterSpacing: -0.013 * 30.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Step indicator card
            _buildStepIndicator(),
            SizedBox(height: 12.h),
            // Profile avatar section
            _buildProfileAvatar(),
            SizedBox(height: 20.h),
            // Form fields
            _buildFormFields(context, theme),
            SizedBox(height: 24.h),
            // Next button
            _buildNextButton(context, theme),
          ],
        ),
      ),
    );
  }

  /// [_buildStepIndicator] - Builds the step indicator card
  Widget _buildStepIndicator() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Step number
          Container(
            width: 41.w,
            height: 41.h,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 41.w,
                height: 41.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFF08C51),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF),
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Step content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/features.svg',
                      width: 22.w,
                      height: 22.h,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFA8A29E),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'General',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF533630),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Next: Health Information',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildProfileAvatar] - Builds the profile avatar with upload button
  Widget _buildProfileAvatar() {
    return Center(
      child: SizedBox(
        width: 96.w,
        height: 96.h,
        child: Stack(
          children: [
            // Avatar circle
            Container(
              width: 96.w,
              height: 96.h,
              decoration: BoxDecoration(
                color: const Color(0xFFEBE2D6),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/user_single_icon.svg',
                  width: 48.w,
                  height: 48.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF926247),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            // Upload button
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // [GeneralInfoView] Handle profile photo upload
                  // TODO: Show image picker
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF08C51),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F172A).withOpacity(0.02),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: const Color(0xFF0F172A).withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/arrow_upload_icon.svg',
                      width: 18.w,
                      height: 17.h,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFFFFFF),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildFormFields] - Builds all form input fields
  Widget _buildFormFields(BuildContext context, YouthYogaTheme theme) {
    return Column(
      children: [
        // Full Name field
        _buildInputField(
          label: 'Full Name',
          placeholder: 'Shinomiya Kaguya',
          icon: 'assets/images/user_single_icon.svg',
        ),
        SizedBox(height: 24.h),
        // Gender field
        _buildGenderField(),
        SizedBox(height: 24.h),
        // ID Card Number field
        _buildInputField(
          label: 'ID Card Number (Optional)',
          placeholder: '1234-4567-7890',
          icon: 'assets/images/identity_card_icon.svg',
          hasHelp: true,
        ),
        SizedBox(height: 24.h),
        // Date of Birth field
        _buildInputField(
          label: 'Date of Birth',
          placeholder: '01 / 01 / 2001',
          icon: 'assets/images/calendar_icon.svg',
          isDatePicker: true,
        ),
        SizedBox(height: 24.h),
        // Phone Number field
        _buildPhoneNumberField(),
      ],
    );
  }

  /// [_buildInputField] - Builds a standard input field
  Widget _buildInputField({
    required String label,
    required String placeholder,
    required String icon,
    bool isDropdown = false,
    bool hasHelp = false,
    bool isDatePicker = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524),
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        // Input field
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFFD6D3D1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              // Left icon
              SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              // Text
              Expanded(
                child: Text(
                  placeholder,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
              // Right icon
              if (isDropdown)
                SvgPicture.asset(
                  'assets/images/chevron_down_icon.svg',
                  width: 10.w,
                  height: 10.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E),
                    BlendMode.srcIn,
                  ),
                ),
              if (hasHelp)
                SvgPicture.asset(
                  'assets/images/question_mark_circle_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFA8A29E),
                    BlendMode.srcIn,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildPhoneNumberField] - Builds the phone number field with country picker
  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Phone Number',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524),
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        // Input field
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFFD6D3D1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              // Country picker
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAF9),
                  border: Border(
                    right: BorderSide(
                      color: const Color(0xFFD6D3D1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // US Flag (placeholder)
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    SvgPicture.asset(
                      'assets/images/chevron_down_icon.svg',
                      width: 10.w,
                      height: 10.h,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF57534E),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
              // Phone number input
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Text(
                        '+44',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF57534E),
                          height: 1.375,
                          letterSpacing: -0.007 * 16.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          '(000) 000-0000',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF57534E),
                            height: 1.375,
                            letterSpacing: -0.007 * 16.sp,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/question_mark_circle_icon.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFA8A29E),
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
      ],
    );
  }

  /// [_buildGenderField] - Builds the gender selection field with dropdown
  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Gender',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524),
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        // Gender selection field
        GestureDetector(
          onTap: () {
            // [GeneralInfoView] Show gender selection bottom sheet
            _showGenderSelection();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              border: Border.all(
                color: const Color(0xFFD6D3D1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(9999.r),
            ),
            child: Row(
              children: [
                // Gender icon
                SvgPicture.asset(
                  'assets/images/gender_trans_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 8.w),
                // Selected gender text
                Expanded(
                  child: Text(
                    selectedGender,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: selectedGender == 'Select Gender'
                          ? const Color(0xFFA8A29E)
                          : const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ),
                // Dropdown arrow
                SvgPicture.asset(
                  'assets/images/chevron_down_icon.svg',
                  width: 10.w,
                  height: 10.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// [_showGenderSelection] - Shows gender selection bottom sheet
  void _showGenderSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 8.h),
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6D3D1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              // Title
              Text(
                'Select Gender',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.33,
                ),
              ),
              SizedBox(height: 24.h),
              // Gender options
              _buildGenderOption('Male'),
              _buildGenderOption('Female'),
              SizedBox(height: 32.h),
            ],
          ),
        );
      },
    );
  }

  /// [_buildGenderOption] - Builds a gender option row
  Widget _buildGenderOption(String gender) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF08C51).withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            // Gender icon
            SvgPicture.asset(
              'assets/images/gender_trans_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                isSelected ? const Color(0xFFF08C51) : const Color(0xFF57534E),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            // Gender text
            Expanded(
              child: Text(
                gender,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFFF08C51)
                      : const Color(0xFF57534E),
                  height: 1.375,
                ),
              ),
            ),
            // Check mark for selected option
            if (isSelected)
              Container(
                width: 20.w,
                height: 20.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFF08C51),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 12.sp,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// [_buildNextButton] - Builds the next button
  Widget _buildNextButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [GeneralInfoView] Handle next action
          Navigator.pushNamed(context, AppRoutes.profileSetup);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51),
          foregroundColor: const Color(0xFFFFFFFF),
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
              'Next',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFFFF),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
