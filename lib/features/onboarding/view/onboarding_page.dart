import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/bloc.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

const List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    image: 'assets/images/on_boarding_one.png',
    title: 'Take Your Emotions, One Mood At A Time',
    description:
        'Easily log your feelings and uncover emotional patterns, with our smart mood tracker.',
  ),
  OnboardingContent(
    image: 'assets/images/on_boarding_two.png',
    title: 'Track Your Progress',
    description:
        'Monitor your yoga journey and see how your practice evolves over time.',
  ),
  OnboardingContent(
    image: 'assets/images/on_boarding_three.png',
    title: 'Personalized Sessions',
    description:
        'Get customized yoga sessions tailored to your skill level and goals.',
  ),
  OnboardingContent(
    image: 'assets/images/on_boarding_four.png',
    title: 'Community Support',
    description:
        'Connect with like-minded yogis and share your wellness journey.',
  ),
  OnboardingContent(
    image: 'assets/images/on_boarding_fifth.png',
    title: 'Daily Gratitude & Quote Inspirations',
    description:
        'Start and end your day with positivity and thankfulness. One gratitude at a time.',
  ),
];

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
                            // Title and description - Dynamic content based on current page
                            BlocBuilder<OnboardingBloc, OnboardingState>(
                              builder: (context, state) {
                                final currentContent =
                                    onboardingPages[state.currentPageIndex];
                                return Column(
                                  children: [
                                    SizedBox(
                                      width: 343.w,
                                      height: 38.h,
                                      child: Text(
                                        currentContent.title,
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
                                        currentContent.description,
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
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Navigation button section
                      Column(
                        children: [
                          // Navigation buttons (left/right chevrons) - Figma design
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
                                        color: const Color(
                                            0xFFFFFFFF), // White background from Figma
                                        borderRadius: BorderRadius.circular(
                                            9999.r), // Circular shape
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(9999.r),
                                          onTap: state.isFirstPage
                                              ? null
                                              : () {
                                                  context
                                                      .read<OnboardingBloc>()
                                                      .add(
                                                          const OnboardingPreviousPressed());
                                                },
                                          child: Container(
                                            width: 64.w,
                                            height: 64.w,
                                            padding: EdgeInsets.all(16
                                                .w), // 16px padding from Figma
                                            child: state.isFirstPage
                                                ? SvgPicture.asset(
                                                    'assets/images/chevron_left.svg',
                                                    width: 32.w,
                                                    height: 32.w,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      theme.alternate
                                                          .withOpacity(0.5),
                                                      BlendMode.srcIn,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.w),
                                                    child: SvgPicture.asset(
                                                      'assets/images/chevron_left.svg',
                                                      width: 32.w,
                                                      height: 32.w,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        Color(
                                                            0xFFF08C51), // Orange color from Figma
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 24.w), // 24px gap from Figma
                                BlocBuilder<OnboardingBloc, OnboardingState>(
                                  builder: (context, state) {
                                    return Container(
                                      width: 64.w,
                                      height: 64.w,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFFFFFFF), // White background from Figma
                                        borderRadius: BorderRadius.circular(
                                            9999.r), // Circular shape
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(9999.r),
                                          onTap: () {
                                            if (state.isLastPage) {
                                              context.read<OnboardingBloc>().add(
                                                  const OnboardingCompleted());
                                            } else {
                                              context.read<OnboardingBloc>().add(
                                                  const OnboardingNextPressed());
                                            }
                                          },
                                          child: Container(
                                            width: 64.w,
                                            height: 64.w,
                                            padding: EdgeInsets.all(16
                                                .w), // 16px padding from Figma
                                            child: state.isLastPage
                                                ? Icon(
                                                    Icons.check,
                                                    size: 32.w,
                                                    color: const Color(
                                                        0xFFF08C51), // Orange color from Figma
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6.w),
                                                    child: SvgPicture.asset(
                                                      'assets/images/chevron_right.svg',
                                                      width: 32.w,
                                                      height: 32.w,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        Color(
                                                            0xFFF08C51), // Orange color from Figma
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Home indicator (like in Figma)
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
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
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
    return SizedBox(
      width: 500.w,
      child: Center(
        child: SizedBox(
          height: 482.h,
          child: Stack(
            children: [
              // Main container with beige background
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 275.w,
                  height: 350.h,
                  decoration: BoxDecoration(
                    color: theme.cardBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48.r),
                      topRight: Radius.circular(48.r),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 16.h, right: 48.w),
                      decoration: BoxDecoration(
                        color: theme.accent2,
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                  ),
                ),
              ),
              // Dynamic image based on current page
              BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  final currentContent =
                      onboardingPages[state.currentPageIndex];
                  return Center(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: 350.w,
                      height: 350.w,
                      child: Image.asset(
                        currentContent.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
