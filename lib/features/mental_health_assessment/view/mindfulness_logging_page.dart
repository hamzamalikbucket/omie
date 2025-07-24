import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';
import 'widgets/mindfulness_success_dialog.dart';

/// [MindfulnessLoggingPage] - Page wrapper for Mindfulness Logging screen
/// This page displays comprehensive mindfulness tracking form
/// following Apple's Human Interface Guidelines for form design and user interaction
class MindfulnessLoggingPage extends StatelessWidget {
  const MindfulnessLoggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MindfulnessLoggingBloc()..add(const LoadMindfulnessLogging()),
      child: const MindfulnessLoggingView(),
    );
  }
}

/// [MindfulnessLoggingView] - Main view for the Mindfulness Logging screen
/// Displays comprehensive form with sliders, buttons, and input fields
/// using modern, intuitive design patterns for mindfulness data collection
class MindfulnessLoggingView extends StatelessWidget {
  const MindfulnessLoggingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MindfulnessLoggingBloc, MindfulnessLoggingState>(
      listener: (context, state) {
        // [MindfulnessLoggingView] Handle success state
        if (state.status == MindfulnessLoggingStatus.submitted) {
          print(
              '[MindfulnessLoggingPage] Log submitted successfully - showing success dialog');
          MindfulnessSuccessDialog.show(
            context,
            onButtonPressed: () {
              // [MindfulnessLoggingView] Close dialog and navigate to goal settings
              print(
                  '[MindfulnessLoggingPage] Success dialog dismissed - navigating to goal settings');
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context)
                  .pushNamed(AppRoutes.mindfulnessGoalSettings);
            },
          );
        }
      },
      child: BlocBuilder<MindfulnessLoggingBloc, MindfulnessLoggingState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF), // White background
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // Main content with scroll
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 48.h),

                            // Title
                            _buildTitle(theme),

                            SizedBox(height: 32.h),

                            // Form sections
                            _buildFormSections(context, theme, state),

                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),

                    // Submit button
                    _buildSubmitButton(context, theme, state),

                    SizedBox(height: 48.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildTitle] - Builds the main title section
  Widget _buildTitle(YouthYogaTheme theme) {
    return SizedBox(
      width: 343.w,
      child: Text(
        'Log your mindfulness level today',
        style: theme.bodyMedium.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57534E),
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// [_buildFormSections] - Builds all form sections
  Widget _buildFormSections(BuildContext context, YouthYogaTheme theme,
      MindfulnessLoggingState state) {
    if (state.status == MindfulnessLoggingStatus.loading) {
      return _buildLoadingState();
    }

    if (state.status == MindfulnessLoggingStatus.error) {
      return _buildErrorState(context, theme, state.errorMessage);
    }

    return SizedBox(
      width: 343.w,
      child: Column(
        children: [
          // Mindfulness level section
          _buildMindfulnessLevelSection(context, theme, state),

          SizedBox(height: 24.h),

          // Feeling selection section
          _buildFeelingSection(context, theme, state),

          SizedBox(height: 24.h),

          // Activity input section
          _buildActivitySection(context, theme, state),

          SizedBox(height: 24.h),

          // Emotion selection section
          _buildEmotionSection(context, theme, state),
        ],
      ),
    );
  }

  /// [_buildMindfulnessLevelSection] - Builds the mindfulness level slider section
  Widget _buildMindfulnessLevelSection(BuildContext context,
      YouthYogaTheme theme, MindfulnessLoggingState state) {
    return Column(
      children: [
        // Section header
        Row(
          children: [
            Expanded(
              child: Text(
                'How mindful are you today?',
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),

        // Slider with track and thumb
        Column(
          children: [
            SizedBox(
              width: 343.w,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8.h,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 10.w,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 20.w,
                  ),
                  activeTrackColor: const Color(0xFFF08C51), // Orange
                  inactiveTrackColor: const Color(0xFFE7E5E4), // Light gray
                  thumbColor: const Color(0xFFFFFFFF), // White
                  overlayColor: const Color(0xFFF08C51).withOpacity(0.1),
                ),
                child: Slider(
                  value: state.mindfulnessLevel,
                  onChanged: (value) {
                    // [_buildMindfulnessLevelSection] Update mindfulness level
                    print(
                        '[MindfulnessLoggingPage] Mindfulness level changed to: $value');
                    context
                        .read<MindfulnessLoggingBloc>()
                        .add(UpdateMindfulnessLevel(value));
                  },
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // Slider labels
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Points',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                ),
                Text(
                  '${state.mindfulnessPoints}',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// [_buildFeelingSection] - Builds the feeling selection section
  Widget _buildFeelingSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessLoggingState state) {
    return Column(
      children: [
        // Section header
        Row(
          children: [
            Expanded(
              child: Text(
                'How do you feel?',
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Feeling buttons
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: state.feelingOptions.map((feeling) {
            return _buildFeelingButton(context, theme, feeling);
          }).toList(),
        ),
      ],
    );
  }

  /// [_buildFeelingButton] - Builds individual feeling selection button
  Widget _buildFeelingButton(
      BuildContext context, YouthYogaTheme theme, FeelingOption feeling) {
    final isSelected = feeling.isSelected;

    return GestureDetector(
      onTap: () {
        // [_buildFeelingButton] Select feeling
        print('[MindfulnessLoggingPage] Feeling selected: ${feeling.id}');
        context.read<MindfulnessLoggingBloc>().add(SelectFeeling(feeling.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF7F3EF)
              : const Color(0xFFFFFFFF), // Light orange or white
          border: Border.all(
            color: isSelected
                ? const Color(0xFFF08C51)
                : const Color(0xFFD6D3D1), // Orange or gray
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(9999.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              feeling.iconPath,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                isSelected ? Color(feeling.color) : const Color(0xFF57534E),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              feeling.label,
              style: theme.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? Color(feeling.color) : const Color(0xFF57534E),
                height: 1.429,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildActivitySection] - Builds the activity input section
  Widget _buildActivitySection(BuildContext context, YouthYogaTheme theme,
      MindfulnessLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        Text(
          'What were you doing?',
          style: theme.bodyMedium.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524),
            height: 1.429,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),

        SizedBox(height: 8.h),

        // Activity input field
        Container(
          width: 343.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFFD6D3D1),
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/briefcase_alt_icon.svg',
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  state.activity,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/chevron_down_icon.svg',
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildEmotionSection] - Builds the emotion selection section
  Widget _buildEmotionSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessLoggingState state) {
    return Column(
      children: [
        // Section header
        Row(
          children: [
            Expanded(
              child: Text(
                'What emotion are you feeling?',
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524),
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Emotion slider
        Container(
          width: 343.w,
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: state.emotionOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final emotion = entry.value;
              final isLast = index == state.emotionOptions.length - 1;

              return Row(
                children: [
                  _buildEmotionButton(context, emotion),
                  if (!isLast)
                    Container(
                      width: 2.w,
                      height: 22.h,
                      color: const Color(0xFFF5F5F4),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// [_buildEmotionButton] - Builds individual emotion selection button
  Widget _buildEmotionButton(BuildContext context, EmotionOption emotion) {
    final isSelected = emotion.isSelected;

    return GestureDetector(
      onTap: () {
        // [_buildEmotionButton] Select emotion
        print('[MindfulnessLoggingPage] Emotion selected: ${emotion.id}');
        context.read<MindfulnessLoggingBloc>().add(SelectEmotion(emotion.id));
      },
      child: Container(
        width: 48.w,
        height: 48.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFBBF24)
              : Colors.transparent, // Yellow when selected
          borderRadius: BorderRadius.circular(9999.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF292524).withOpacity(0.03),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: const Color(0xFF292524).withOpacity(0.08),
                    offset: const Offset(0, 12),
                    blurRadius: 16,
                    spreadRadius: -4,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: SvgPicture.asset(
            emotion.iconPath,
            width: isSelected ? 48.w : 32.w,
            height: isSelected ? 48.w : 32.w,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? const Color(0xFF92400E)
                  : const Color(0xFFD6D3D1), // Dark yellow or gray
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  /// [_buildSubmitButton] - Builds the submit button
  Widget _buildSubmitButton(BuildContext context, YouthYogaTheme theme,
      MindfulnessLoggingState state) {
    final isSubmitting = state.status == MindfulnessLoggingStatus.submitting;

    return SizedBox(
      width: 343.w,
      child: GestureDetector(
        onTap: isSubmitting
            ? null
            : () {
                // [_buildSubmitButton] Submit mindfulness log
                print('[MindfulnessLoggingPage] Submit button pressed');
                context
                    .read<MindfulnessLoggingBloc>()
                    .add(const SubmitMindfulnessLog());
              },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isSubmitting
                ? const Color(0xFFD6D3D1)
                : const Color(0xFFF08C51), // Gray when submitting
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSubmitting) ...[
                SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    color: Color(0xFFFFFFFF),
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Logging...',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ] else ...[
                Text(
                  'Log Mindfulness Level',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF),
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
                    Color(0xFFFFFFFF),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildLoadingState] - Builds loading state UI
  Widget _buildLoadingState() {
    return SizedBox(
      width: 343.w,
      height: 400.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFF08C51),
        ),
      ),
    );
  }

  /// [_buildErrorState] - Builds error state UI
  Widget _buildErrorState(
      BuildContext context, YouthYogaTheme theme, String? errorMessage) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            errorMessage ?? 'Something went wrong',
            style: theme.bodyLarge.copyWith(
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              context
                  .read<MindfulnessLoggingBloc>()
                  .add(const LoadMindfulnessLogging());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF08C51),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
