import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordEmailSentPage extends StatelessWidget {
  const ForgotPasswordEmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: const ForgotPasswordEmailSentView(),
    );
  }
}

class ForgotPasswordEmailSentView extends StatelessWidget {
  const ForgotPasswordEmailSentView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.navigateBack) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: SizedBox(
            width: 375.w,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                _buildTopNavigation(theme, context),
                _buildTopNavHeading(theme),
                _buildMainContent(theme, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopNavigation(YouthYogaTheme theme, BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<ForgotPasswordBloc>()
                  .add(const ForgotPasswordBackPressed());
            },
            child: Container(
              width: 24.w,
              height: 24.w,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/images/chevron_left.svg',
                width: 24.w,
                height: 24.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF292524), // Stone/80
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Password Sent',
              style: theme.headlineLarge.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF533630), // Stone/70
                height: 1.27,
                letterSpacing: -0.013 * 30.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavHeading(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 8.h),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Text(
            'Please check your email in a few minutes - we\'ve sent you an email containing the recovery link.',
            style: theme.bodyLarge.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF57534E), // Stone/60
              height: 1.6,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(YouthYogaTheme theme, BuildContext context) {
    return Expanded(
      child: Container(
        width: 375.w,
        padding: EdgeInsets.fromLTRB(0.w, 12.h, 0.w, 12.h),
        child: Column(
          children: [
            _buildButtonAndHelpText(theme, context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonAndHelpText(YouthYogaTheme theme, BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildOpenEmailButton(theme, context),
          SizedBox(height: 12.h),
          _buildHelpText(theme),
        ],
      ),
    );
  }

  Widget _buildOpenEmailButton(YouthYogaTheme theme, BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement open email app logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary
          foregroundColor: theme.primaryBackground, // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r),
          ),
          elevation: 0,
          minimumSize: Size(343.w, 48.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Open My Email',
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
    );
  }

  Widget _buildHelpText(YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Didn't receive the email?\nContact us at ",
              style: theme.bodySmall.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E), // Stone/60
                height: 1.43,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
            TextSpan(
              text: "team@youthforyoga.org",
              style: theme.bodySmall.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: theme.success, // Using theme.success for email
                height: 1.43,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
