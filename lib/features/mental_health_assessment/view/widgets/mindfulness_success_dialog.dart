import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_routes.dart';

/// [MindfulnessSuccessDialog] - Success dialog shown after mindfulness logging completion
/// Displays congratulatory message with illustration and action button
/// Following Apple's Human Interface Guidelines for modal dialog design
class MindfulnessSuccessDialog extends StatelessWidget {
  /// [title] - Main title of the dialog
  final String title;

  /// [description] - Description text below the title
  final String description;

  /// [buttonText] - Text for the action button
  final String buttonText;

  /// [onButtonPressed] - Callback when action button is pressed
  final VoidCallback? onButtonPressed;

  const MindfulnessSuccessDialog({
    super.key,
    this.title = 'Mindfulness level logged',
    this.description =
        'You logged your mindfulness level for today. Let\'s do it again tomorrow!',
    this.buttonText = 'Got it, thanks!',
    this.onButtonPressed,
  });

  /// [show] - Static method to show the dialog
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? description,
    String? buttonText,
    VoidCallback? onButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return MindfulnessSuccessDialog(
          title: title ?? 'Mindfulness level logged',
          description: description ??
              'You logged your mindfulness level for today. Let\'s do it again tomorrow!',
          buttonText: buttonText ?? 'Got it, thanks!',
          onButtonPressed: onButtonPressed ??
              () {
                // [show] Default action - close dialog and navigate to goal settings
                print(
                    '[MindfulnessSuccessDialog] Dialog dismissed - navigating to goal settings');
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context)
                    .pushNamed(AppRoutes.mindfulnessGoalSettings);
              },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 343.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // White background
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            // Primary shadow
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.02),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 0,
            ),
            // Secondary shadow
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.03),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success illustration
            _buildIllustration(),

            SizedBox(height: 24.h),

            // Content section
            _buildContent(theme),

            SizedBox(height: 24.h),

            // Action button
            _buildActionButton(context, theme),
          ],
        ),
      ),
    );
  }

  /// [_buildIllustration] - Builds the success illustration
  Widget _buildIllustration() {
    return SizedBox(
      width: 292.29.w,
      height: 197.06.h,
      child: SvgPicture.asset(
        'assets/images/mindfulness_success_illustration.svg',
        width: 292.29.w,
        height: 197.06.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildContent] - Builds the title and description content
  Widget _buildContent(YouthYogaTheme theme) {
    return Column(
      children: [
        // Title
        Text(
          title,
          style: theme.bodyMedium.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292524), // Dark gray
            height: 1.333,
            letterSpacing: -0.012 * 24.sp,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 12.h),

        // Description
        Text(
          description,
          style: theme.bodyMedium.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E), // Medium gray
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// [_buildActionButton] - Builds the main action button
  Widget _buildActionButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          // [_buildActionButton] Handle button press
          print('[MindfulnessSuccessDialog] Action button pressed');
          onButtonPressed?.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF08C51), // Orange background
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: theme.bodyMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF), // White text
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
              ),
              SizedBox(width: 10.w),
              SvgPicture.asset(
                'assets/images/check_single_icon.svg',
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFFFF), // White icon
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
