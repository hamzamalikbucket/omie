import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordEmailPage extends StatelessWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: const ForgotPasswordEmailView(),
    );
  }
}

class ForgotPasswordEmailView extends StatefulWidget {
  const ForgotPasswordEmailView({super.key});

  @override
  State<ForgotPasswordEmailView> createState() =>
      _ForgotPasswordEmailViewState();
}

class _ForgotPasswordEmailViewState extends State<ForgotPasswordEmailView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.navigateBack) {
          Navigator.of(context).pop();
        } else if (state.status ==
            ForgotPasswordStatus.navigateToEmailSentScreen) {
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.forgotPasswordEmailSent);
        } else if (state.status == ForgotPasswordStatus.emailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
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
                _buildFormSection(theme, context),
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
      child: SvgPicture.asset('assets/images/forgot_password_email.svg'),
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
            'Please enter your email address to reset your password.',
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

  Widget _buildFormSection(YouthYogaTheme theme, BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          _buildFormContainer(theme, context),
        ],
      ),
    );
  }

  Widget _buildFormContainer(YouthYogaTheme theme, BuildContext context) {
    return Column(
      children: [
        _buildEmailInputSection(theme, context),
        SizedBox(height: 24.h),
        _buildSendPasswordButton(theme, context),
        SizedBox(height: 12.h),
        _buildHelpText(theme),
      ],
    );
  }

  Widget _buildEmailInputSection(YouthYogaTheme theme, BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return SizedBox(
          width: 343.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 343.w,
                margin: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  'Email Address',
                  style: theme.titleSmall.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292524),
                    height: 1.43,
                    letterSpacing: -0.006 * 14.sp,
                  ),
                ),
              ),
              _buildEmailInput(theme, context),
              if (state.status == ForgotPasswordStatus.emailError) ...[
                SizedBox(height: 2.h),
                _buildErrorMessage(theme, state.errorMessage),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmailInput(YouthYogaTheme theme, BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: state.status == ForgotPasswordStatus.emailError
                  ? const Color(0xFFFB7185)
                  : const Color(0xFFD6D3D1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  'assets/images/envelope_email_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E), // Gray/60 from Figma
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  onChanged: (value) {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ForgotPasswordEmailChanged(value));
                  },
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your email address...',
                    hintStyle: theme.bodyLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSendPasswordButton(YouthYogaTheme theme, BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        final isLoading = state.status == ForgotPasswordStatus.sendingEmail;

        return SizedBox(
          width: 343.w,
          height: 48.h,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(const ForgotPasswordEmailSubmitted());
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
                if (isLoading)
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      color: theme.primaryBackground,
                      strokeWidth: 2,
                    ),
                  )
                else ...[
                  Text(
                    'Send Password',
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorMessage(YouthYogaTheme theme, String errorMessage) {
    return SizedBox(
      width: 343.w,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/error_warning_icon.svg',
            width: 13.w,
            height: 13.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFFF43F5E),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 1.w),
          Expanded(
            child: Text(
              errorMessage,
              style: theme.bodySmall.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF949494),
                height: 1.2,
              ),
            ),
          ),
        ],
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
              text: "Don't remember your email? \nContact us at ",
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
                color: theme.success, // Stone/60
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
