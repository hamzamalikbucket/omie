import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          // TODO: Navigate to next screen or main app
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Onboarding completed!'),
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
                // Page indicators at the top
                _buildPageIndicators(theme),

                // Flexible spacer with decorative card container
                Expanded(
                  child: _buildDecorativeContainer(theme),
                ),

                // Top area with rounded container and ellipse - same as welcome screen
                SizedBox(
                  width: 375.w,
                  height: 48.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Large decorative ellipse positioned exactly like welcome screen
                      Positioned(
                        left: -253.w,
                        top: -30.h,
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

                // Bottom orange container with navigation buttons
                Container(
                  width: 375.w,
                  height: 250.h,
                  decoration: BoxDecoration(
                    color: theme.primary,
                  ),
                  child: Column(
                    children: [
                      // Content container with exact padding
                      Container(
                        width: 375.w,
                        height: 120.h,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                          bottom: 0.h,
                        ),
                        child: Column(
                          children: [
                            // Title and description
                            Column(
                              children: [
                                SizedBox(
                                  width: 343.w,
                                  height: 38.h,
                                  child: Text(
                                    'Take Your Emotions, One Mood At A Time',
                                    style: theme.headlineLarge.copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                      color: theme.primaryBackground,
                                      height: 38.h / 30.sp,
                                      letterSpacing: -0.013 * 30.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // Description text
                                SizedBox(
                                  width: 343.w,
                                  height: 26.h,
                                  child: Text(
                                    'Easily log your feelings and uncover emotional patterns, with our smart mood tracker.',
                                    style: theme.bodyMedium.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: theme.primaryBackground,
                                      height: 1.6,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Navigation button section
                      Column(
                        children: [
                          // Navigation buttons (left/right chevrons)
                          SizedBox(
                            width: 343.w,
                            height: 64.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<OnboardingBloc, OnboardingState>(
                                  builder: (context, state) {
                                    return Container(
                                      width: 64.w,
                                      height: 64.w,
                                      decoration: BoxDecoration(
                                        color: theme.primaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: state.isFirstPage
                                            ? null
                                            : () {
                                                context.read<OnboardingBloc>().add(
                                                    const OnboardingPreviousPressed());
                                              },
                                        icon: Icon(
                                          Icons.chevron_left,
                                          size: 32.w,
                                          color: state.isFirstPage
                                              ? theme.alternate
                                              : theme.primary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 24.w),
                                BlocBuilder<OnboardingBloc, OnboardingState>(
                                  builder: (context, state) {
                                    return Container(
                                      width: 64.w,
                                      height: 64.w,
                                      decoration: BoxDecoration(
                                        color: theme.primaryBackground,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          context.read<OnboardingBloc>().add(
                                              const OnboardingNextPressed());
                                        },
                                        icon: Icon(
                                          Icons.chevron_right,
                                          size: 32.w,
                                          color: theme.primary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Home indicator (like in Figma)
                          Container(
                            width: 134.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: theme.primaryBackground,
                              borderRadius: BorderRadius.circular(1234.r),
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

  Widget _buildPageIndicators(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final isActive = index == state.currentPageIndex;
              return Container(
                width: 67.w, // (343 - 4*4) / 5 = approximately 67
                height: 4.h,
                margin: EdgeInsets.only(right: index < 4 ? 4.w : 0),
                decoration: BoxDecoration(
                  color:
                      isActive ? theme.primary : Colors.black.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(1234.r),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildDecorativeContainer(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 49.w),
      child: Center(
        child: SizedBox(
          width: 276.w,
          height: 482.h,
          child: Stack(
            children: [
              // Background gradient overlay with opacity
              Container(
                width: 276.w,
                height: 482.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.cardText,
                      theme.cardText.withOpacity(0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),

              // Main container with beige background
              Container(
                width: 276.w,
                height: 482.h,
                decoration: BoxDecoration(
                  color: theme.cardBackground,
                  borderRadius: BorderRadius.circular(48.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),

                    // Small rounded indicator
                    Container(
                      width: 90.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: theme.cardBackground,
                        borderRadius: BorderRadius.circular(9999.r),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Small ellipse
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: theme.cardAccent,
                        shape: BoxShape.circle,
                      ),
                    ),

                    // Expanded content area for the illustration/content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Placeholder for illustration - you can replace with actual image
                              Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  color: theme.cardAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.mood,
                                  size: 60.w,
                                  color: theme.primary,
                                ),
                              ),

                              SizedBox(height: 20.h),

                              Text(
                                'Mood Tracking',
                                style: theme.headlineSmall.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: theme.cardText,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 8.h),

                              Text(
                                'Track your daily emotions and discover patterns in your mental wellness journey.',
                                style: theme.bodyMedium.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: theme.cardText.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
