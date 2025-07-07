import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [ImageUploadStatusPage] - Image upload status page
/// This page shows the upload progress for a user's profile image
class ImageUploadStatusPage extends StatelessWidget {
  const ImageUploadStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const ImageUploadStatusView(),
    );
  }
}

/// [ImageUploadStatusView] - The main view for image upload status
/// Displays upload progress with visual indicators and status text
class ImageUploadStatusView extends StatelessWidget {
  const ImageUploadStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [ImageUploadStatusView] Handle navigation or other state changes
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
              child: SizedBox(
                width: 375.w,
                height: 778.h,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 227.h, 16.w, 0),
                  child: Column(
                    children: [
                      // Main content frame
                      SizedBox(
                        width: 343.w,
                        child: Column(
                          children: [
                            // Upload visual container
                            _buildUploadVisual(),
                            SizedBox(height: 32.h),

                            // Text section
                            _buildTextSection(),
                            SizedBox(height: 40.h),

                            // Continue button for testing navigation
                            _buildContinueButton(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildUploadVisual] - Builds the upload visual with profile image and progress indicators
  Widget _buildUploadVisual() {
    return SizedBox(
      width: 343.w,
      height: 218.h,
      child: Stack(
        children: [
          // Outer circle (light stroke)
          Positioned(
            left: 82.w,
            top: 19.h,
            child: Container(
              width: 180.w,
              height: 180.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFEBE2D6), // Light stroke
                  width: 8.w,
                ),
              ),
            ),
          ),

          // Inner circle (orange stroke)
          Positioned(
            left: 82.w,
            top: 19.h,
            child: Container(
              width: 180.w,
              height: 180.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFF08C51), // Orange stroke
                  width: 8.w,
                ),
              ),
            ),
          ),

          // Profile image
          Positioned(
            left: 107.w,
            top: 45.h,
            child: Container(
              width: 128.w,
              height: 128.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE5E7EB), // Placeholder background
                image: const DecorationImage(
                  // Placeholder for uploaded image
                  image: AssetImage('assets/images/avatar_male_profile_2.svg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipOval(
                child: Container(
                  width: 128.w,
                  height: 128.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E7EB), // Placeholder gray
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildTextSection] - Builds the text section with upload status
  Widget _buildTextSection() {
    return SizedBox(
      width: 343.w,
      child: Column(
        children: [
          // "Uploading Image..." text
          Text(
            'Uploading Image...',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone/80
              height: 1.33, // 32px line height / 24px font size
              letterSpacing: -0.012 * 24.sp, // -1.2%
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // "profile_picture.jpeg" text
          Text(
            'profile_picture.jpeg',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60
              height: 1.6, // 28.8px line height / 18px font size
              letterSpacing: 0, // No letter spacing specified
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// [_buildContinueButton] - Builds the continue button for testing navigation
  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: 44.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildContinueButton] Navigate to image format error page for testing
          print(
              '[ImageUploadStatusView] Continue button pressed - navigating to error page');
          Navigator.pushNamed(context, AppRoutes.imageFormatError);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange background
          foregroundColor: const Color(0xFFFFFFFF), // White text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.007 * 16.sp, // -0.7%
          ),
        ),
      ),
    );
  }
}
