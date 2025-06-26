import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.navigateBack) {
          Navigator.of(context).pop();
        } else if (state.status == ForgotPasswordStatus.navigateToEmailScreen) {
          Navigator.of(context).pushNamed(AppRoutes.forgotPasswordEmail);
        } else if (state.status == ForgotPasswordStatus.smsOptionSelected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('SMS reset option coming soon!'),
            ),
          );
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
                _buildSVGImage(theme),
                _buildOptionsSection(theme, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSVGImage(YouthYogaTheme theme) {
    return SizedBox(
      width: 375.w,
      height: 200.h,
      child: SvgPicture.asset('assets/images/forgot_password.svg'),
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
              'Forgot Password',
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
            'Please select the following options to reset your password.',
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

  Widget _buildOptionsSection(YouthYogaTheme theme, BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          _buildEmailOption(theme, context),
          SizedBox(height: 12.h),
          _buildSmsOption(theme, context),
        ],
      ),
    );
  }

  Widget _buildEmailOption(YouthYogaTheme theme, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ForgotPasswordBloc>()
            .add(const ForgotPasswordEmailOptionPressed());
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          border: Border.all(
            color: const Color(0xFFEDF1F3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.02),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.03),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E9), // Orange/5
                borderRadius: BorderRadius.circular(9999.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/envelope_email_icon.svg',
                  width: 20.w,
                  height: 16.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF08C51), // Orange/40
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Send via Email',
                style: theme.titleMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524), // Stone/80
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            SvgPicture.asset(
              'assets/images/chevron_right.svg',
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF57534E), // Stone/60
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmsOption(YouthYogaTheme theme, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ForgotPasswordBloc>()
            .add(const ForgotPasswordSmsOptionPressed());
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          border: Border.all(
            color: const Color(0xFFEDF1F3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.02),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.03),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E9), // Orange/5
                borderRadius: BorderRadius.circular(9999.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/device_mobile_icon.svg',
                  width: 14.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF08C51), // Orange/40
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Send via SMS',
                style: theme.titleMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524), // Stone/80
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            SvgPicture.asset(
              'assets/images/chevron_right.svg',
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF57534E), // Stone/60
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
