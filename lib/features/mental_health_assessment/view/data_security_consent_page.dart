import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [DataSecurityConsentPage] - Data Security Consent page
/// This page displays data security information with Privacy Policy and Terms & Conditions consent
/// following Apple's Human Interface Guidelines for modern, sleek design
/// as part of the mental health assessment flow
class DataSecurityConsentPage extends StatelessWidget {
  const DataSecurityConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const DataSecurityConsentView(),
    );
  }
}

/// [DataSecurityConsentView] - The main view for data security consent
/// Displays security illustration, consent checkboxes, and continue button
/// with modern Apple-inspired design aesthetics
class DataSecurityConsentView extends StatefulWidget {
  const DataSecurityConsentView({super.key});

  @override
  State<DataSecurityConsentView> createState() =>
      _DataSecurityConsentViewState();
}

class _DataSecurityConsentViewState extends State<DataSecurityConsentView> {
  // Checkbox states for Privacy Policy and Terms & Conditions
  bool _privacyPolicyChecked = true; // Starting checked as per Figma design
  bool _termsConditionsChecked = true; // Starting checked as per Figma design

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [DataSecurityConsentView] Handle navigation when consent is given
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          print('[DataSecurityConsentView] Navigate to Notification Setup');
          Navigator.of(context).pushNamed(AppRoutes.notificationSetup);
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF), // White background
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
  /// progress indicator (50%), and skip option following Apple HIG
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        children: [
          // Top navigation row with modern Apple-style spacing and alignment
          Row(
            children: [
              // Back button with Apple-style chevron
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle back navigation with smooth animation
                  print('[DataSecurityConsentView] Back button pressed');
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
              // Progress bar section with modern rounded design
              Expanded(
                child: Column(
                  children: [
                    // Progress bar with Apple-style rounded corners
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E5E4), // Light gray background
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          // Filled portion (50% progress as per Figma)
                          Expanded(
                            flex: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                    0xFF9BB167), // Success green from Figma
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
              // Skip button with Apple-style typography
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle skip action with modern interaction
                  print('[DataSecurityConsentView] Skip button pressed');
                  // TODO: Handle skip action
                },
                child: Text(
                  'Skip',
                  style: theme.labelLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF533630), // Stone color from Figma
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

  /// [_buildTitle] - Builds the assessment title section with Apple-style typography
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

  /// [_buildMainContent] - Builds the main content area with security messaging,
  /// illustration, consent checkboxes, and action button following Apple HIG
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),

          // Main security message with Apple-style bold typography
          Text(
            "Your Data is Secure With Us. Always Secure.",
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

          // Data security illustration with modern styling
          _buildSecurityIllustration(),

          SizedBox(height: 24.h),

          // Consent information and checkboxes section
          _buildConsentSection(theme),

          const Spacer(),

          // Action button with Apple-style design
          _buildActionButton(context, theme, state),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildSecurityIllustration] - Builds the data security illustration
  /// with proper sizing and modern presentation
  Widget _buildSecurityIllustration() {
    return Container(
      width: 230.35.w,
      height: 209.07.h,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/data_security_illustration.svg',
        width: 230.35.w,
        height: 209.07.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildConsentSection] - Builds the consent information and checkboxes
  /// following Apple's Human Interface Guidelines for forms and agreements
  Widget _buildConsentSection(YouthYogaTheme theme) {
    return Column(
      children: [
        // Information text about data coverage with Apple-style secondary text
        SizedBox(
          width: 343.w,
          child: Text(
            "Any information you give to us  is covered in line with our Terms & Conditions and Privacy Policy.",
            style: theme.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60 from Figma
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 24.h),

        // Consent checkboxes container with modern spacing
        Container(
          width: 343.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Privacy Policy checkbox with Apple-style interaction
              _buildConsentCheckbox(
                'I agree to the Privacy Policy',
                _privacyPolicyChecked,
                (value) {
                  // [_buildConsentSection] Handle Privacy Policy checkbox change
                  print(
                      '[DataSecurityConsentView] Privacy Policy checkbox changed to: $value');
                  setState(() {
                    _privacyPolicyChecked = value ?? false;
                  });
                },
                theme,
              ),

              SizedBox(height: 12.h),

              // Terms & Conditions checkbox with Apple-style interaction
              _buildConsentCheckbox(
                'I agree to the Terms & Condition',
                _termsConditionsChecked,
                (value) {
                  // [_buildConsentSection] Handle Terms & Conditions checkbox change
                  print(
                      '[DataSecurityConsentView] Terms & Conditions checkbox changed to: $value');
                  setState(() {
                    _termsConditionsChecked = value ?? false;
                  });
                },
                theme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildConsentCheckbox] - Builds individual consent checkbox with text
  /// following Apple's design system for modern, accessible checkboxes
  Widget _buildConsentCheckbox(
    String text,
    bool isChecked,
    Function(bool?) onChanged,
    YouthYogaTheme theme,
  ) {
    return Row(
      children: [
        // Modern checkbox with Apple-style design
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: isChecked
                  ? const Color(0xFF9BB167) // Success green when checked
                  : const Color(0xFFFFFFFF), // White when unchecked
              borderRadius: BorderRadius.circular(9999.r), // Fully circular
              border: Border.all(
                color: isChecked
                    ? const Color(0xFF9BB167) // Green border when checked
                    : const Color(0xFFE7E5E4), // Light gray when unchecked
                width: 1,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Color(0xFFFFFFFF), // White checkmark
                  )
                : null,
          ),
        ),

        SizedBox(width: 8.w),

        // Checkbox text with Apple-style typography
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!isChecked),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF292524), // Dark text color from Figma
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildActionButton] - Builds the continue button with Apple-style design
  /// and modern interaction states following Apple Human Interface Guidelines
  Widget _buildActionButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    // Button is enabled only when both checkboxes are checked
    final isEnabled = _privacyPolicyChecked && _termsConditionsChecked;

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                // [_buildActionButton] Handle continue action with modern interaction
                print('[DataSecurityConsentView] Continue button pressed');
                print(
                    '[DataSecurityConsentView] Privacy Policy: $_privacyPolicyChecked');
                print(
                    '[DataSecurityConsentView] Terms & Conditions: $_termsConditionsChecked');

                // Trigger bloc event to proceed to next step
                context
                    .read<MentalHealthAssessmentBloc>()
                    .add(const ReadyButtonPressed());
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? const Color(0xFFF08C51) // Orange brand color from Figma
              : const Color(0xFFEBE2D6), // Disabled background
          foregroundColor: isEnabled
              ? const Color(0xFFFFFFFF) // White text when enabled
              : const Color(0xFFC3A381), // Disabled text color
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(9999.r), // Fully rounded Apple-style
          ),
          elevation: 0, // Flat design following modern Apple guidelines
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button text with Apple-style typography
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
            // Arrow icon with proper color states
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                isEnabled
                    ? const Color(0xFFFFFFFF) // White when enabled
                    : const Color(0xFFC3A381), // Disabled color when disabled
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
