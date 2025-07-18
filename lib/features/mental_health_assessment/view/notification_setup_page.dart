import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [NotificationSetupPage] - Notification Setup page
/// This page allows users to enable push notifications for staying on top of their finances
/// following Apple's Human Interface Guidelines for modern, sleek design
/// as part of the mental health assessment flow
class NotificationSetupPage extends StatelessWidget {
  const NotificationSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const NotificationSetupView(),
    );
  }
}

/// [NotificationSetupView] - The main view for notification setup
/// Displays notification illustration, description, and action buttons
/// with modern Apple-inspired design aesthetics
class NotificationSetupView extends StatefulWidget {
  const NotificationSetupView({super.key});

  @override
  State<NotificationSetupView> createState() => _NotificationSetupViewState();
}

class _NotificationSetupViewState extends State<NotificationSetupView> {
  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [NotificationSetupView] Handle navigation when notification setup is complete
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          print('[NotificationSetupView] Navigate to next assessment step');
          // TODO: Navigate to next step in the flow
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
                  print('[NotificationSetupView] Back button pressed');
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
                  print('[NotificationSetupView] Skip button pressed');
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

  /// [_buildMainContent] - Builds the main content area with notification messaging,
  /// illustration, and action buttons following Apple HIG
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.w, 16.h, 32.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section with title and description
          _buildHeaderSection(theme),

          SizedBox(height: 40.h),

          // Notification illustration and info section
          _buildNotificationSection(theme),

          const Spacer(),

          // Action buttons section
          _buildActionButtons(context, theme, state),
        ],
      ),
    );
  }

  /// [_buildHeaderSection] - Builds the header with title and description
  /// following Apple's typography guidelines
  Widget _buildHeaderSection(YouthYogaTheme theme) {
    return Column(
      children: [
        // Main title with Apple-style bold typography
        Text(
          "Enable Notifications",
          style: theme.headlineLarge.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF533630), // Stone color from Figma
            height: 1.27, // 38px line height / 30px font size
            letterSpacing: -0.012 * 30.sp, // -1.2%
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 12.h),

        // Description text with Apple-style secondary text
        Text(
          "Enable push notifications to stay on top of your finances with updates on balances and goals made for you.",
          style: theme.bodyLarge.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E), // Stone/60 from Figma
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// [_buildNotificationSection] - Builds the notification mockup and info
  /// with modern Apple-style layout
  Widget _buildNotificationSection(YouthYogaTheme theme) {
    return Column(
      children: [
        // Notification mockup illustration
        _buildNotificationMockup(),

        SizedBox(height: 24.h),

        // Information row with icon and text
        _buildInfoRow(theme),
      ],
    );
  }

  /// [_buildNotificationMockup] - Builds the notification mockup illustration
  /// with proper sizing and modern presentation
  Widget _buildNotificationMockup() {
    return Container(
      width: double.infinity,
      height: 251.h,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/notification_mockup_illustration.svg',
        width: 343.w,
        height: 240.h,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  /// [_buildInfoRow] - Builds the information row with icon and text
  /// following Apple's information display guidelines
  Widget _buildInfoRow(YouthYogaTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Information icon with Apple-style design
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: SvgPicture.asset(
            'assets/images/info_circle_icon.svg',
            width: 20.w,
            height: 20.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFFD6D3D1), // Light gray from Figma
              BlendMode.srcIn,
            ),
          ),
        ),

        SizedBox(width: 8.w),

        // Information text with Apple-style typography
        Text(
          "You can change the settings at anytime.",
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF57534E), // Stone/60 from Figma
            height: 1.43, // 20px line height / 14px font size
            letterSpacing: -0.006 * 14.sp, // -0.6%
          ),
        ),
      ],
    );
  }

  /// [_buildActionButtons] - Builds the action buttons (Enable All and Skip)
  /// following Apple's Human Interface Guidelines for modern button design
  Widget _buildActionButtons(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Column(
      children: [
        // Enable All button (primary)
        _buildEnableAllButton(context, theme, state),

        SizedBox(height: 24.h),

        // Skip this step button (secondary)
        _buildSkipButton(context, theme, state),
      ],
    );
  }

  /// [_buildEnableAllButton] - Builds the primary "Enable All" button
  /// with Apple-style design and modern interaction states
  Widget _buildEnableAllButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildEnableAllButton] Handle enable all action with modern interaction
          print('[NotificationSetupView] Enable All button pressed');

          // Navigate to home screen
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.homeScreen,
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFFF08C51), // Orange brand color from Figma
          foregroundColor: const Color(0xFFFFFFFF), // White text
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
              'Enable All',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),
            // Check icon from Figma design
            SvgPicture.asset(
              'assets/images/check_single_icon.svg',
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

  /// [_buildSkipButton] - Builds the secondary "Skip this step" button
  /// with Apple-style link design
  Widget _buildSkipButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          // [_buildSkipButton] Handle skip action with modern interaction
          print('[NotificationSetupView] Skip this step button pressed');
          // Navigate to home screen
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.homeScreen,
            (route) => false,
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF08C51), // Orange text
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        ),
        child: Text(
          'Skip this step',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF08C51), // Orange text from Figma
            height: 1.375, // 22px line height / 16px font size
            letterSpacing: -0.007 * 16.sp, // -0.7%
          ),
        ),
      ),
    );
  }
}
