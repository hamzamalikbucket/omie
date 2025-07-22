import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const AuthenticationView(),
    );
  }
}

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication successful!'),
            ),
          );
        } else if (state.status == AuthenticationStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Authentication failed'),
              backgroundColor: theme.error,
            ),
          );
        } else if (state.status ==
            AuthenticationStatus.navigatingToEmailSignIn) {
          // Navigate to the new sign-in screen
          Navigator.of(context).pushNamed(AppRoutes.signin);
        } else if (state.status == AuthenticationStatus.navigatingToSignUp) {
          // Navigate to the signup screen
          Navigator.of(context).pushNamed(AppRoutes.signup);
        }
      },
      child: Scaffold(
        backgroundColor: theme.primary, // Orange background like Figma
        body: SafeArea(
          child: SizedBox(
            width: 375.w,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                // Logo section at the top
                _buildLogoSection(theme),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  width: 375.w,
                  height: 230.h,
                  child: Image.asset(
                    'assets/images/welcome_icon.png',
                  ),
                ),

                // Main container with circular design element
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // Circular container section - same pattern as onboarding
                      _buildCircularContainer(theme),
                      // Authentication container
                      _buildAuthenticationContainer(theme),

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
    return Container(
      width: 375.w,
      height: 100.h,
      padding: EdgeInsets.only(top: 52.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 100.w,
            height: 100.h,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularContainer(YouthYogaTheme theme) {
    return SizedBox(
      width: 375.w,
      height: 42.5.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Large decorative ellipse positioned exactly like onboarding screen
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

  Widget _buildAuthenticationContainer(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 350.h,
      decoration: BoxDecoration(
        color: theme.primaryBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 375.w,
            padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 32.h),
            child: Column(
              children: [
                // Content section
                Column(
                  children: [
                    // Title section
                    Column(
                      children: [
                        SizedBox(
                          width: 280.w,
                          child: Text(
                            'How would you like to proceed?',
                            style: theme.headlineLarge.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900,
                              color: theme.primary,
                              height: 1.27,
                              letterSpacing: -0.013 * 24.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Authentication buttons section
                    Column(
                      children: [
                        // Google sign in button
                        _buildGoogleSignInButton(theme),
                        SizedBox(height: 12.h),
                        // Apple sign in button
                        _buildAppleSignInButton(theme),
                        SizedBox(height: 12.h),
                        // Email sign in button
                        _buildEmailSignInButton(theme),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Sign up text
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(const SignUpPressed());
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: theme.bodyMedium.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color:
                            const Color(0xFF57534E), // Brown color from Figma
                        height: 1.43,
                        letterSpacing: -0.006 * 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleSignInButton(YouthYogaTheme theme) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: 280.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFEDF1F3), // Light gray border from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC6C6C6).withValues(alpha: 0.3),
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
              onTap: state.status == AuthenticationStatus.loading
                  ? null
                  : () {
                      context
                          .read<AuthenticationBloc>()
                          .add(const SignInWithGooglePressed());
                    },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/google_logo.svg',
                      width: 18.w,
                      height: 18.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Sign In With Google',
                      style: theme.titleSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333), // Dark gray from Figma
                        height: 1.375,
                        letterSpacing: -0.007 * 14.sp,
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

  Widget _buildAppleSignInButton(YouthYogaTheme theme) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: 280.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFEDF1F3), // Light gray border from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC6C6C6).withValues(alpha: 0.3),
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
              onTap: state.status == AuthenticationStatus.loading
                  ? null
                  : () {
                      context
                          .read<AuthenticationBloc>()
                          .add(const SignInWithApplePressed());
                    },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/apple_logo.svg',
                      width: 16.w,
                      height: 18.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF000000),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Sign In With Apple',
                      style: theme.titleSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333), // Dark gray from Figma
                        height: 1.375,
                        letterSpacing: -0.007 * 14.sp,
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

  Widget _buildEmailSignInButton(YouthYogaTheme theme) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: 280.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFEDF1F3), // Light gray border from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC6C6C6).withValues(alpha: 0.3),
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
              onTap: state.status == AuthenticationStatus.loading
                  ? null
                  : () {
                      context
                          .read<AuthenticationBloc>()
                          .add(const SignInWithEmailPressed());
                    },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/email_icon.svg',
                      width: 16.w,
                      height: 16.w,
                      colorFilter: ColorFilter.mode(
                        theme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Sign In With Email',
                      style: theme.titleSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333), // Dark gray from Figma
                        height: 1.375,
                        letterSpacing: -0.007 * 14.sp,
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
}
