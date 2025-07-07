import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [PasscodeVerificationPage] - Passcode verification page
/// This page allows users to enter a 4-digit verification code
/// and handles validation with error states as part of the mental health assessment flow
class PasscodeVerificationPage extends StatelessWidget {
  const PasscodeVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const PasscodeVerificationView(),
    );
  }
}

/// [PasscodeVerificationView] - The main view for passcode verification
/// Displays 4-digit input fields with validation, error handling, and continue button
class PasscodeVerificationView extends StatefulWidget {
  const PasscodeVerificationView({super.key});

  @override
  State<PasscodeVerificationView> createState() =>
      _PasscodeVerificationViewState();
}

class _PasscodeVerificationViewState extends State<PasscodeVerificationView> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  // Error state management
  bool _hasError = false;
  String _errorMessage = "Incorrect passcode! Try again in 20s";

  // Current passcode values for demonstration (using valid code initially)
  final List<String> _currentValues = ['1', '2', '3', '4'];

  @override
  void initState() {
    super.initState();

    // Initialize with current values from design
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].text = _currentValues[i];
      // Add listener to clear error when user starts typing and validate when complete
      _controllers[i].addListener(() {
        if (_hasError) {
          setState(() {
            _hasError = false;
          });
        }

        // Auto-validate when passcode is complete
        if (_isPasscodeFilled()) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _validatePasscode();
          });
        }
      });
    }

    // Start with no error state - errors only appear after validation
    _hasError = false;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [PasscodeVerificationView] Handle navigation when verification is successful
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          print('[PasscodeVerificationView] Navigate to FaceID setup');
          Navigator.of(context).pushNamed(AppRoutes.faceIdSetup);
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

  /// [_buildTopNavigation] - Builds the top navigation bar with back button
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              // [_buildTopNavigation] Handle back navigation
              print('[PasscodeVerificationView] Back button pressed');
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
        ],
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content area with title, illustration,
  /// passcode input, error notification, and action buttons
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),

          // Main title text
          Text(
            "Verify your Passcode",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.27, // 38px line height / 30px font size
              letterSpacing: -0.012 * 30.sp, // -1.2%
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          // Illustration from Figma design
          _buildIllustration(),

          SizedBox(height: 32.h),

          // Passcode input fields
          _buildPasscodeInput(theme),

          SizedBox(height: 32.h),

          // Error notification (if error state)
          if (_hasError) ...[
            _buildErrorNotification(),
            SizedBox(height: 32.h),
          ],

          // Description text and resend link
          _buildDescriptionSection(theme),

          const Spacer(),

          // Action buttons
          _buildActionButtons(context, theme, state),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildIllustration] - Builds the illustration image
  Widget _buildIllustration() {
    return SizedBox(
      width: 223.49.w,
      height: 139.2.h,
      child: SvgPicture.asset(
        'assets/images/passcode_verification_illustration.svg',
        width: 223.49.w,
        height: 139.2.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildPasscodeInput] - Builds the 4-digit passcode input fields
  Widget _buildPasscodeInput(YouthYogaTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          child: _buildPasscodeDigit(index, theme),
        );
      }),
    );
  }

  /// [_buildPasscodeDigit] - Builds individual passcode digit input
  Widget _buildPasscodeDigit(int index, YouthYogaTheme theme) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: _hasError
              ? const Color(0xFFEA4335)
              : const Color(0xFFD6D3D1), // Red border if error
          width: 1,
        ),
        borderRadius: BorderRadius.circular(9999.r), // Fully circular
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 48.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E), // Dark text color
            height: 1.17, // 56px line height / 48px font size
            letterSpacing: -0.016 * 48.sp, // -1.6%
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '', // Hide character counter
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            // [_buildPasscodeDigit] Handle digit input and auto-focus
            print('[PasscodeVerificationView] Digit $index changed to: $value');

            if (value.isNotEmpty && index < 3) {
              // Move to next field
              _focusNodes[index + 1].requestFocus();
            } else if (value.isEmpty && index > 0) {
              // Move to previous field
              _focusNodes[index - 1].requestFocus();
            }

            // Check if all fields are filled
            if (_isPasscodeFilled()) {
              _validatePasscode();
            }
          },
        ),
      ),
    );
  }

  /// [_buildErrorNotification] - Builds the error notification banner
  Widget _buildErrorNotification() {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2), // Light pink background
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          // Error icon
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: SvgPicture.asset(
              'assets/images/error_triangle_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFF43F5E), // Red color for error icon
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Error message
          Expanded(
            child: Text(
              _errorMessage,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292524), // Dark text
                height: 1.43, // 20px line height / 14px font size
                letterSpacing: -0.006 * 14.sp, // -0.6%
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Close button
          GestureDetector(
            onTap: () {
              // [_buildErrorNotification] Handle dismissing error
              print('[PasscodeVerificationView] Error notification dismissed');
              setState(() {
                _hasError = false;
              });
            },
            child: SizedBox(
              width: 20.w,
              height: 20.h,
              child: SvgPicture.asset(
                'assets/images/close_x_icon.svg',
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E), // Gray color for close icon
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildDescriptionSection] - Builds description text and resend link
  Widget _buildDescriptionSection(YouthYogaTheme theme) {
    return Column(
      children: [
        // Description text
        Text(
          "We've sent a code to ••9704. Please enter it here to verify your identity.",
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E), // Stone/60 from Figma
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 32.h),

        // Resend OTP link
        GestureDetector(
          onTap: () {
            // [_buildDescriptionSection] Handle resend OTP
            print('[PasscodeVerificationView] Resend OTP pressed');
            // TODO: Implement resend OTP functionality
          },
          child: Text(
            "Didn't receive? Re-send OTP",
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9BB167), // Success green
              height: 1.375, // 22px line height / 16px font size
              letterSpacing: -0.007 * 16.sp, // -0.7%
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// [_buildActionButtons] - Builds the action buttons (Continue and Email alternative)
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Column(
      children: [
        // Continue button
        _buildContinueButton(context, theme, state),
        SizedBox(height: 12.h),

        // Email alternative button
        _buildEmailButton(context, theme, state),
      ],
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    final isDisabled = _hasError || !_isPasscodeFilled();

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                // [_buildContinueButton] Handle continue action
                print('[PasscodeVerificationView] Continue button pressed');
                print('[PasscodeVerificationView] Passcode: ${_getPasscode()}');

                // Validate passcode before proceeding
                _validatePasscode();

                // Only proceed if validation passes
                if (!_hasError) {
                  context
                      .read<MentalHealthAssessmentBloc>()
                      .add(const ReadyButtonPressed());
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? const Color(0xFFEBE2D6) // Disabled background
              : const Color(0xFFF08C51), // Orange background
          foregroundColor: isDisabled
              ? const Color(0xFFC3A381) // Disabled text
              : const Color(0xFFFFFFFF), // White text
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
              'Continue',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                isDisabled
                    ? const Color(0xFFC3A381) // Disabled icon color
                    : const Color(0xFFFFFFFF), // White icon color
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildEmailButton] - Builds the email alternative button
  Widget _buildEmailButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: () {
          // [_buildEmailButton] Handle email alternative
          print(
              '[PasscodeVerificationView] Email the code instead button pressed');
          // TODO: Navigate to email verification flow
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFF08C51), // Orange text
          side: const BorderSide(
            color: Color(0xFFF08C51), // Orange border
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email icon
            SvgPicture.asset(
              'assets/images/envelope_email_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFF08C51), // Orange color for the icon
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),

            // Button text
            Text(
              'Email the code instead',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_isPasscodeFilled] - Check if all passcode fields are filled
  bool _isPasscodeFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  /// [_getPasscode] - Get the complete passcode as string
  String _getPasscode() {
    return _controllers.map((controller) => controller.text).join();
  }

  /// [_validatePasscode] - Validate the entered passcode
  void _validatePasscode() {
    final passcode = _getPasscode();
    print('[PasscodeVerificationView] Validating passcode: $passcode');

    // List of incorrect passcodes that should show error (for demo purposes)
    final incorrectCodes = ["2218", "0000", "1111", "9999"];

    if (incorrectCodes.contains(passcode)) {
      setState(() {
        _hasError = true;
        _errorMessage = "Incorrect passcode! Try again in 20s";
      });
      print('[PasscodeVerificationView] Validation failed for: $passcode');
    } else {
      setState(() {
        _hasError = false;
      });
      print('[PasscodeVerificationView] Validation passed for: $passcode');
    }
  }
}
