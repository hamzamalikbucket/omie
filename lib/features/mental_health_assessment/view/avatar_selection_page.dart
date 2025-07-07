import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [AvatarSelectionPage] - Avatar selection page for profile setup
/// This page allows users to choose from predefined avatars or upload their own
class AvatarSelectionPage extends StatelessWidget {
  const AvatarSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const AvatarSelectionView(),
    );
  }
}

/// [AvatarSelectionView] - The main view for avatar selection
/// Displays avatar options and upload functionality
class AvatarSelectionView extends StatelessWidget {
  const AvatarSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [AvatarSelectionView] Handle navigation or other state changes
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
                  _buildTopNavigation(context),

                  // Main content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 24.h),
                          // Page title
                          _buildTitle(),
                          SizedBox(height: 24.h),

                          // Avatar selection grid
                          _buildAvatarSelection(context, state),
                          SizedBox(height: 24.h),

                          // Upload section
                          _buildUploadSection(),

                          // Spacer to push button to bottom
                          const Spacer(),

                          // Continue button
                          _buildContinueButton(context),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation with back button
  Widget _buildTopNavigation(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: SvgPicture.asset(
                'assets/images/chevron_left_profile_icon.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF533630), // Stone/80
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Empty space for centering (if needed)
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  /// [_buildTitle] - Builds the page title
  Widget _buildTitle() {
    return Text(
      'Set Up Your Profile Avatar or Upload Image',
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF533630), // Stone/80
        height: 1.27, // 38px line height / 30px font size
        letterSpacing: -0.013 * 30.sp, // -1.3%
      ),
      textAlign: TextAlign.center,
    );
  }

  /// [_buildAvatarSelection] - Builds the avatar selection grid
  Widget _buildAvatarSelection(
      BuildContext context, MentalHealthAssessmentState state) {
    // List of available avatars matching the Figma design
    // Center avatar is selected (orange), rightmost matches leftmost
    final avatars = [
      'avatar_female_profile_1.svg', // Left-center
      'avatar_male_profile_2.svg', // Center (selected, larger)
      'avatar_female_profile_2.svg', // Right-center
    ];

    return Container(
      decoration: BoxDecoration(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: avatars.asMap().entries.map((entry) {
          final index = entry.key;
          final avatar = entry.value;
          final isSelected = state.selectedAvatar == avatar;
          final isLargeAvatar =
              avatar == 'avatar_male_profile_2.svg'; // Middle avatar is larger

          return GestureDetector(
            onTap: () {
              // [AvatarSelectionView] Handle avatar selection
              context
                  .read<MentalHealthAssessmentBloc>()
                  .add(AvatarSelected(avatar));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Container(
                width: isLargeAvatar ? 128.w : 72.w,
                height: isLargeAvatar ? 128.h : 72.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: const Color(0xFFD97706), // Orange/600
                          width: 4.w,
                        )
                      : null,
                ),
                child: ClipOval(
                  child: SvgPicture.asset(
                    'assets/images/$avatar',
                    width: isLargeAvatar ? 128.w : 72.w,
                    height: isLargeAvatar ? 128.h : 72.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// [_buildUploadSection] - Builds the upload section with dotted border
  Widget _buildUploadSection() {
    return Column(
      children: [
        // Divider line
        Container(
          width: 343.w,
          height: 1.h,
          color: const Color(0xFFD6D3D1), // Stone/300
        ),
        SizedBox(height: 24.h),

        // Upload area
        SizedBox(
          width: 343.w,
          child: Column(
            children: [
              // Upload button with dashed border
              SizedBox(
                width: 64.w,
                height: 64.h,
                child: CustomPaint(
                  painter: DashedCirclePainter(
                    color: const Color(0xFFA8A29E), // Stone/400
                    strokeWidth: 2.w,
                    dashLength: 2.0,
                    gapLength: 8.0,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/add_plus_profile_icon.svg',
                      width: 24.w,
                      height: 24.h,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFA8A29E), // Stone/400
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Upload text
              Column(
                children: [
                  Text(
                    'Or upload your profile locally',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF533630), // Stone/80
                      height: 1.33, // 24px line height / 18px font size
                      letterSpacing: -0.008 * 18.sp, // -0.8%
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Max size: 5mb, Format: jpg, png',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E), // Stone/60
                      height: 1.375, // 22px line height / 16px font size
                      letterSpacing: -0.007 * 16.sp, // -0.7%
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [AvatarSelectionView] Handle continue action
          Navigator.pushNamed(context, AppRoutes.imageUploadStatus);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary
          foregroundColor: const Color(0xFFFFFFFF), // White text
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
              'assets/images/arrow_right_profile_icon.svg',
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

/// [DashedCirclePainter] - Custom painter for dashed circle border
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    this.dashLength = 2.0,
    this.gapLength = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = (size.width / 2) - (strokeWidth / 2);
    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();
    final adjustedDashLength = circumference / (dashCount * 2);
    final adjustedGapLength = adjustedDashLength;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * 2 * math.pi) / dashCount;
      final endAngle =
          startAngle + (adjustedDashLength / circumference) * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
