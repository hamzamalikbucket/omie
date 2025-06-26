import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<WelcomeBloc, WelcomeState>(
      listener: (context, state) {
        if (state.status == WelcomeStatus.navigatingToHome) {
          // TODO: Navigate to home or main app screen when implemented
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Welcome! Ready to start your yoga journey.'),
            ),
          );
        } else if (state.status == WelcomeStatus.navigatingToSignIn) {
          // Navigate to sign in screen
          // TODO: Implement sign in navigation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign in functionality coming soon!'),
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
                // Flexible spacer to push content lower without causing overflow
                Expanded(
                  child: Container(),
                ),

                // Top area with rounded container and ellipse - positioned lower
                SizedBox(
                  width: 375.w,
                  height: 48.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Large decorative ellipse positioned lower
                      Positioned(
                        left: -253.w,
                        top: -30
                            .h, // Move ellipse up relative to container for better curve
                        child: Container(
                          width: 880.w,
                          height: 880.w,
                          decoration: BoxDecoration(
                            color: theme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom orange container with exact Figma dimensions and layout
                Container(
                  width: 375.w,
                  height: 312.h,
                  decoration: BoxDecoration(
                    color: theme.primary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Content container with exact padding from Figma
                      Container(
                        width: 375.w,
                        height: 246.h,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                          bottom: 32.h,
                        ),
                        child: Column(
                          children: [
                            // Welcome text section
                            Column(
                              children: [
                                // Welcome text with new theme system
                                SizedBox(
                                  width: 343.w,
                                  height: 38.h,
                                  child: Text(
                                    'Welcome to Omie',
                                    style: theme.headlineLarge.copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                      color: theme.info,
                                      height: 38.h / 30.sp,
                                      letterSpacing: -0.013 * 30.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // Terms checkbox section with theme system
                                SizedBox(
                                  width: 343.w, // Exact width from CSS
                                  height: 20.h, // Exact height from CSS
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // justify-content: center
                                    children: [
                                      BlocBuilder<WelcomeBloc, WelcomeState>(
                                        builder: (context, state) {
                                          return Container(
                                            width: 20
                                                .w, // Exact dimensions from CSS
                                            height: 20.w,
                                            decoration: BoxDecoration(
                                              color: theme
                                                  .info, // White background
                                              border: Border.all(
                                                color: theme
                                                    .alternate, // Border color from theme
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                  9999), // border-radius: 9999px
                                            ),
                                            child: Checkbox(
                                              value: state.termsAccepted,
                                              onChanged: (value) {
                                                context.read<WelcomeBloc>().add(
                                                    const WelcomeTermsToggled());
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(9999),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(width: 8.w), // gap: 8px from CSS
                                      SizedBox(
                                        width: 275.w, // Exact width from CSS
                                        height: 16.h, // Exact height from CSS
                                        child: Text(
                                          'I agree to the Terms & Conditions and Privacy Policy',
                                          style: theme.labelSmall.copyWith(
                                            color: theme.info, // White text
                                            height: 16.h / 12.sp,
                                            letterSpacing: -0.005 * 12.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // gap: 24px from main container CSS

                      // Button section with theme system
                      Column(
                        children: [
                          // Get Started button using theme system
                          SizedBox(
                            width: 343.w, // Exact width from CSS
                            height: 48.h, // Exact height from CSS
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<WelcomeBloc>()
                                    .add(const WelcomeGetStarted());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.info, // White background
                                foregroundColor: theme.primary, // Orange text
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      9999), // border-radius: 9999px
                                ),
                                elevation: 0,
                                minimumSize:
                                    Size(343.w, 48.h), // min-height: 48px
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // justify-content: center
                                children: [
                                  Text(
                                    'Get Started',
                                    style: theme.labelLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: theme.primary,
                                      height: 22.h / 16.sp,
                                      letterSpacing: -0.007 * 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w), // gap: 10px
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 20.w, // width: 20px, height: 20px
                                    color: theme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h), // gap: 24px

                          // Sign in link with theme system
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<WelcomeBloc>()
                                  .add(const WelcomeSignInPressed());
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Already have an account? Sign In.',
                                style: theme.bodyMedium.copyWith(
                                  color: theme.info,
                                  height: 1.43,
                                  letterSpacing: -0.08,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
