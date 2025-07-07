import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [ImageFormatErrorPage] - Image format error page
/// This page shows an error when the uploaded image format is invalid
/// Allows users to re-upload or choose a premade avatar
class ImageFormatErrorPage extends StatelessWidget {
  const ImageFormatErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const ImageFormatErrorView(),
    );
  }
}

/// [ImageFormatErrorView] - The main view for image format error
/// Displays error message with options to re-upload or choose avatar
class ImageFormatErrorView extends StatelessWidget {
  const ImageFormatErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [ImageFormatErrorView] Handle navigation based on user selection
        if (state.status ==
            MentalHealthAssessmentStatus.navigateToImageUpload) {
          // TODO: Navigate back to image upload
        } else if (state.status ==
            MentalHealthAssessmentStatus.navigateToAvatarSelection) {
          // TODO: Navigate to avatar selection page
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
                  padding: EdgeInsets.fromLTRB(16.w, 224.h, 16.w, 0),
                  child: Column(
                    children: [
                      // Main content frame
                      SizedBox(
                        width: 343.w,
                        child: Column(
                          children: [
                            // Error avatar with exclamation icon
                            _buildErrorAvatar(),
                            SizedBox(height: 24.h),

                            // Text section with error message
                            _buildTextSection(),
                            SizedBox(height: 24.h),

                            // Action buttons
                            _buildActionButtons(context),
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

  /// [_buildErrorAvatar] - Builds the error avatar with exclamation triangle icon
  Widget _buildErrorAvatar() {
    return Container(
      width: 96.w,
      height: 96.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFFE4E6), // Light red background
      ),
      child: Center(
        child: Container(
          width: 48.w,
          height: 48.h,
          padding: EdgeInsets.all(3.59.w),
          child: SvgPicture.asset(
            'assets/images/error_triangle_icon.svg',
            width: 40.81.w,
            height: 38.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF43F5E), // Red color for the icon
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  /// [_buildTextSection] - Builds the text section with error message
  Widget _buildTextSection() {
    return Column(
      children: [
        // "Invalid Format!" title
        Text(
          'Invalid Format!',
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
        SizedBox(height: 16.h),

        // "Please ensure format is .jpg or png" subtitle
        Text(
          'Please ensure format is .jpg or png',
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
    );
  }

  /// [_buildActionButtons] - Builds the action buttons for re-upload and avatar selection
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // "Re-upload image" primary button
        _buildReUploadButton(context),
        SizedBox(height: 12.h),

        // "Choose premade avatar" outlined button
        _buildChooseAvatarButton(context),
      ],
    );
  }

  /// [_buildReUploadButton] - Builds the re-upload image button
  Widget _buildReUploadButton(BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: 44.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildReUploadButton] Handle re-upload action
          print('[ImageFormatErrorView] Re-upload image button pressed');
          context.read<MentalHealthAssessmentBloc>().add(
                const MentalHealthAssessmentReUploadImageRequested(),
              );
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button text
            Text(
              'Re-upload image',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),

            // Upload arrow icon
            SvgPicture.asset(
              'assets/images/arrow_upload_icon.svg',
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

  /// [_buildChooseAvatarButton] - Builds the choose premade avatar button
  Widget _buildChooseAvatarButton(BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: 44.h,
      child: OutlinedButton(
        onPressed: () {
          // [_buildChooseAvatarButton] Handle avatar selection navigation
          print('[ImageFormatErrorView] Choose premade avatar button pressed');
          context.read<MentalHealthAssessmentBloc>().add(
                const MentalHealthAssessmentNavigateToAvatarSelection(),
              );
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
            // Chevron left icon
            SvgPicture.asset(
              'assets/images/chevron_left_icon.svg',
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
              'Choose premade avatar',
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
}
