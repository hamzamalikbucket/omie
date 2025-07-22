import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/signin_bloc.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(),
      child: const SigninView(),
    );
  }
}

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.status == SigninStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign in successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushNamed(AppRoutes.comprehensiveMentalHealthAssessment);
        } else if (state.status == SigninStatus.forgotPassword) {
          Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
        } else if (state.status == SigninStatus.googleSignin) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Google sign in feature coming soon!'),
            ),
          );
        } else if (state.status == SigninStatus.navigateToSignUp) {
          // Navigate to signup screen
          Navigator.of(context).pushNamed(AppRoutes.signup);
        }
      },
      child: Scaffold(
        backgroundColor: theme.primary,
        body: SafeArea(
          child: SizedBox(
            width: 375.w,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                _buildLogoSection(theme),
                _buildTextSection(theme),
                Expanded(
                  child: Column(
                    children: [
                      _buildCircularContainer(theme),
                      _buildSigninContainer(theme),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(YouthYogaTheme theme) {
    return SizedBox(
      width: 375.w,
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/yoga_logo_signin.svg',
            width: 25.w,
            height: 25.w,
          ),
          SizedBox(width: 4.w),
          Text(
            'Omie',
            style: theme.headlineLarge.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: theme.primaryBackground,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 12.h),
      height: 26.h,
      child: Text(
        'Sign In to gain access to intelligent mental health',
        style: theme.bodyLarge.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: theme.primaryBackground,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCircularContainer(YouthYogaTheme theme) {
    return SizedBox(
      width: 375.w,
      height: 48.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -253.w,
            top: 0.h,
            child: Container(
              width: 880.w,
              height: 880.w,
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSigninContainer(YouthYogaTheme theme) {
    return Expanded(
      child: Container(
        width: 375.w,
        decoration: BoxDecoration(
          color: theme.primaryBackground,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: 375.w,
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitleSection(theme),
                SizedBox(height: 24.h),
                _buildFormSection(theme),
                SizedBox(height: 32.h),
                _buildSigninButtonSection(theme),
                SizedBox(height: 16.h),
                _buildOrDividerSection(theme),
                SizedBox(height: 16.h),
                _buildGoogleSigninButton(theme),
                SizedBox(height: 24.h),
                _buildSignUpText(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(YouthYogaTheme theme) {
    return Container(
      alignment: Alignment.center,
      width: 343.w,
      child: Text(
        'Sign In',
        style: theme.headlineLarge.copyWith(
          fontSize: 30.sp,
          fontWeight: FontWeight.w700,
          color: theme.primary,
          height: 1.27,
          letterSpacing: -0.013 * 30.sp,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildFormSection(YouthYogaTheme theme) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildEmailField(theme, state),
            if (state.emailError != null) ...[
              SizedBox(height: 2.h),
              _buildErrorMessage(theme, state.emailError!),
            ],
            SizedBox(height: 24.h),
            _buildPasswordField(theme, state),
            if (state.passwordError != null) ...[
              SizedBox(height: 2.h),
              _buildErrorMessage(theme, state.passwordError!),
            ] else if (state.password.isEmpty &&
                state.status == SigninStatus.initial) ...[
              SizedBox(height: 2.h),
              _buildPasswordRequirements(theme),
            ],
            SizedBox(height: 16.h),
            _buildOptionsRow(theme, state),
          ],
        );
      },
    );
  }

  Widget _buildEmailField(YouthYogaTheme theme, SigninState state) {
    return Column(
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
        Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: state.emailError != null
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
                    context.read<SigninBloc>().add(SigninEmailChanged(value));
                  },
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'elementary221b@gmail.com',
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
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(YouthYogaTheme theme, SigninState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 343.w,
          margin: EdgeInsets.only(bottom: 8.h),
          child: Text(
            'Password',
            style: theme.titleSmall.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF292524),
              height: 1.43,
              letterSpacing: -0.006 * 14.sp,
            ),
          ),
        ),
        Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: state.passwordError != null
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
                  'assets/images/lock_password_icon.svg',
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
                  controller: _passwordController,
                  obscureText: !state.isPasswordVisible,
                  onChanged: (value) {
                    context
                        .read<SigninBloc>()
                        .add(SigninPasswordChanged(value));
                  },
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter password',
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<SigninBloc>()
                      .add(const SigninPasswordVisibilityToggled());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SvgPicture.asset(
                    'assets/images/eye_visibility_icon.svg',
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFD6D3D1), // Gray/30 from Figma
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildOptionsRow(YouthYogaTheme theme, SigninState state) {
    return SizedBox(
      width: 343.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<SigninBloc>()
                  .add(const SigninKeepMeSignedInToggled());
            },
            child: Row(
              children: [
                Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: theme.primaryBackground,
                    border: Border.all(
                      color: const Color(0xFFD6D3D1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: state.keepMeSignedIn
                      ? Icon(
                          Icons.check,
                          size: 12.w,
                          color: theme.primary,
                        )
                      : null,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Keep me signed in',
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context
                  .read<SigninBloc>()
                  .add(const SigninForgotPasswordPressed());
            },
            child: Text(
              'Forgot Password',
              style: theme.titleSmall.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: theme.success, // Using new success color #9BB167
                height: 1.43,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSigninButtonSection(YouthYogaTheme theme) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        final isFormValid = state.email.isNotEmpty &&
            state.password.isNotEmpty &&
            state.emailError == null &&
            state.passwordError == null;
        final isEnabled = isFormValid && state.status != SigninStatus.loading;

        return Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: isEnabled ? theme.primary : theme.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9999.r),
              onTap: isEnabled
                  ? () {
                      context.read<SigninBloc>().add(const SigninSubmitted());
                    }
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.status == SigninStatus.loading) ...[
                      SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.primaryBackground,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                    ],
                    Text(
                      'Sign In',
                      style: theme.titleSmall.copyWith(
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
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrDividerSection(YouthYogaTheme theme) {
    return SizedBox(
      width: 343.w,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1.h,
              color: const Color(0xFFD6D3D1),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'OR',
              style: theme.labelSmall.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF57534E),
                height: 1.4,
                letterSpacing: 0.1 * 10.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1.h,
              color: const Color(0xFFD6D3D1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleSigninButton(YouthYogaTheme theme) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFEDF1F3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC6C6C6).withValues(alpha: 1),
                offset: const Offset(0, 1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(9999.r),
              onTap: () {
                context.read<SigninBloc>().add(const SigninGooglePressed());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/google_logo.svg',
                      width: 24.w,
                      height: 24.w,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Sign In With Google',
                      style: theme.titleSmall.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                        height: 1.375,
                        letterSpacing: -0.007 * 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignUpText(YouthYogaTheme theme) {
    return GestureDetector(
      onTap: () {
        context.read<SigninBloc>().add(const SigninSignUpPressed());
      },
      child: SizedBox(
        width: 343.w,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account? ",
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF57534E),
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
              TextSpan(
                text: "Sign Up",
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600, // Make it bold to stand out
                  color: theme.success, // Using new success color #9BB167
                  height: 1.43,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements(YouthYogaTheme theme) {
    return SizedBox(
      width: 343.w,
      child: Text(
        'Password must contain at least 8 characters, including uppercase, lowercase, number and special character',
        style: theme.bodySmall.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57534E),
          height: 1.2,
        ),
      ),
    );
  }
}
