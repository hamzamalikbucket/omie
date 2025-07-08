import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [PhoneOtpSetupPage] - Phone OTP Setup page
/// This page allows users to enter their phone number to receive an OTP code
/// for verification as part of the mental health assessment flow
class PhoneOtpSetupPage extends StatelessWidget {
  const PhoneOtpSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const PhoneOtpSetupView(),
    );
  }
}

/// [PhoneOtpSetupView] - The main view for phone OTP setup
/// Displays phone number input with country selection and send OTP button
class PhoneOtpSetupView extends StatefulWidget {
  const PhoneOtpSetupView({super.key});

  @override
  State<PhoneOtpSetupView> createState() => _PhoneOtpSetupViewState();
}

class _PhoneOtpSetupViewState extends State<PhoneOtpSetupView> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+44';
  String _phoneNumber = '(000) 000-0000';
  Country? _selectedCountry;
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [PhoneOtpSetupView] Handle navigation when OTP is sent
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          // TODO: Navigate to OTP verification page
          print('[PhoneOtpSetupView] Navigate to OTP verification');
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
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
                ),
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
          // Top navigation row
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle back navigation
                  print('[PhoneOtpSetupView] Back button pressed');
                  Navigator.of(context).pop();
                },
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
                  // [_buildTopNavigation] Handle skip action
                  print('[PhoneOtpSetupView] Skip button pressed');
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
        'Profile Setup & Account Completion',
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
  /// illustration, phone input, and send OTP button
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.h),
          // Main question text
          Text(
            "Phone OTP Setup",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.27, // 38px line height / 30px font size
              letterSpacing: -0.012 * 30.sp, // -1.2%
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Illustration from Figma design
          _buildIllustration(),
          SizedBox(height: 24.h),
          // Subtitle text
          Text(
            "We'll send a one time SMS message. Carrier rates may apply on your location.",
            style: theme.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60 from Figma
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Phone number input field
          _buildPhoneInput(theme),
          const Spacer(),
          // Send OTP button
          _buildSendOtpButton(context, theme, state),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildIllustration] - Builds the illustration image
  Widget _buildIllustration() {
    return SizedBox(
      width: 163.77.w,
      height: 153.h,
      child: SvgPicture.asset(
        'assets/images/phone_otp_setup_illustration.svg',
        width: 163.77.w,
        height: 153.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildPhoneInput] - Builds the phone number input field with country selector
  Widget _buildPhoneInput(YouthYogaTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // White background
        border: Border.all(
          color: const Color(0xFFD6D3D1), // Gray border
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9999.r), // Fully rounded
      ),
      child: Row(
        children: [
          // Country selector section
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAF9), // Light gray background
              border: const Border(
                right: BorderSide(
                  color: Color(0xFFD6D3D1), // Gray border
                  width: 1,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9999.r),
                bottomLeft: Radius.circular(9999.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                // UK Flag
                // Country flag

                Text(
                  _selectedCountry?.flagEmoji ?? '🇬🇧', // Default to UK flag
                  style: TextStyle(fontSize: 30.sp),
                ),
                SizedBox(width: 6.w),
                // Chevron down
                GestureDetector(
                  onTap: () {
                    // [_buildPhoneInput] Handle country selection
                    print('[PhoneOtpSetupView] Country selector tapped');
                    showCountryPicker(
                      context: context,
                      showPhoneCode: true,
                      onSelect: (Country country) {
                        print('Select country: ${country.displayName}');
                        _selectedCountryCode = country.displayNameNoCountryCode;
                        print(_selectedCountryCode);
                        setState(() {
                          _selectedCountry = country;
                          _selectedCountryCode = country.phoneCode;
                        });
                        //context.read<MentalHealthAssessmentBloc>().add(CountryCodeChanged(country.displayNameNoCountryCode));
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/chevron_down_icon.svg',
                    width: 10.w,
                    height: 10.h,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF57534E), // Gray color
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Phone number input section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  // Country code
                  Text(
                    _selectedCountryCode,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF57534E), // Gray text
                      height: 1.375, // 22px line height / 16px font size
                      letterSpacing: -0.007 * 16.sp, // -0.7%
                    ),
                  ),
                  SizedBox(width: 6.w),
                  // Phone number text
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF57534E), // Gray text
                        height: 1.375, // 22px line height / 16px font size
                        letterSpacing: -0.007 * 16.sp, // -0.7%
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '(000) 000-0000',
                        isCollapsed: false,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10, // No vertical padding
                          horizontal: 10, // No horizontal padding
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _phoneNumber = value;
                        });
                      },
                    ),
                  ),
                  // Question mark icon
                  SvgPicture.asset(
                    'assets/images/question_mark_circle_icon.svg',
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFA8A29E), // Light gray color
                      BlendMode.srcIn,
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

  /// [_buildSendOtpButton] - Builds the send OTP button
  Widget _buildSendOtpButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildSendOtpButton] Handle send OTP action
          print('[PhoneOtpSetupView] Send OTP Code button pressed');
          print(
              '[PhoneOtpSetupView] Phone number: $_selectedCountryCode $_phoneNumber');

          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange background
          foregroundColor: const Color(0xFFFFFFFF), // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Send OTP Code',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF), // White text
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFFFF), // White color for the icon
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
