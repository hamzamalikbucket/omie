import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessGoalSettingsPage] - Page wrapper for Mindfulness Goal Settings screen
/// This page displays goal configuration, maintenance dates, and reminder settings
/// following Apple's Human Interface Guidelines for settings and configuration screens
class MindfulnessGoalSettingsPage extends StatelessWidget {
  const MindfulnessGoalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MindfulnessGoalSettingsBloc()
        ..add(const LoadMindfulnessGoalSettings()),
      child: const MindfulnessGoalSettingsView(),
    );
  }
}

/// [MindfulnessGoalSettingsView] - Main view for the Mindfulness Goal Settings screen
/// Displays goal targets, maintenance dates, reminders, and edit functionality
/// using modern, intuitive design patterns for settings management
class MindfulnessGoalSettingsView extends StatelessWidget {
  const MindfulnessGoalSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessGoalSettingsBloc,
        MindfulnessGoalSettingsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF), // White background
          body: Column(
            children: [
              // Decorative top section
              _buildTopDecorativeSection(),

              // Main content
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 48.h),
                    child: Center(
                      child: _buildMainContent(context, theme, state),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// [_buildTopDecorativeSection] - Builds the decorative ellipse section at the top
  Widget _buildTopDecorativeSection() {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: Stack(
        children: [
          Positioned(
            left: -253.w,
            top: 0,
            child: Container(
              width: 880.w,
              height: 880.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content section
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MindfulnessGoalSettingsState state) {
    if (state.status == MindfulnessGoalSettingsStatus.loading) {
      return _buildLoadingState();
    }

    if (state.status == MindfulnessGoalSettingsStatus.error) {
      return _buildErrorState(context, theme, state.errorMessage);
    }

    return SizedBox(
      width: 343.w,
      child: Column(
        children: [
          // Goal display section
          _buildGoalSection(theme, state),

          SizedBox(height: 32.h),

          // Settings list section
          _buildSettingsSection(context, theme, state),

          SizedBox(height: 32.h),

          // Edit goal button
          _buildEditGoalButton(context, theme),
        ],
      ),
    );
  }

  /// [_buildGoalSection] - Builds the goal display with heart icon and target
  Widget _buildGoalSection(
      YouthYogaTheme theme, MindfulnessGoalSettingsState state) {
    return Column(
      children: [
        // Goal display with heart icon
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heart icon
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: SvgPicture.asset(
                'assets/images/wellness_heart_filled_icon.svg',
                width: 40.w,
                height: 40.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFF08C51), // Orange heart
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // Goal display
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${state.goalTarget}',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF533630), // Dark brown
                    height: 1.133,
                    letterSpacing: -0.018 * 60.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Text(
                    state.goalDescription,
                    style: theme.bodyMedium.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E), // Medium gray
                      height: 1.333,
                      letterSpacing: -0.012 * 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Goal title
        Text(
          state.goalTitle,
          style: theme.bodyMedium.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E),
            height: 1.333,
            letterSpacing: -0.008 * 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// [_buildSettingsSection] - Builds the settings list items
  Widget _buildSettingsSection(BuildContext context, YouthYogaTheme theme,
      MindfulnessGoalSettingsState state) {
    return Column(
      children: state.settingItems.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildSettingItem(context, theme, item),
        );
      }).toList(),
    );
  }

  /// [_buildSettingItem] - Builds individual setting list item
  Widget _buildSettingItem(
      BuildContext context, YouthYogaTheme theme, GoalSettingItem item) {
    return GestureDetector(
      onTap: () {
        // [_buildSettingItem] Handle setting item tap
        print('[MindfulnessGoalSettingsPage] Setting item tapped: ${item.id}');

        if (item.id == 'maintain_until') {
          // [_buildSettingItem] Navigate to date picker modal
          print(
              '[MindfulnessGoalSettingsPage] Maintain until pressed - navigating to date picker');
          Navigator.of(context).pushNamed(AppRoutes.datePickerModal);
        } else if (item.id == 'reminder') {
          context
              .read<MindfulnessGoalSettingsBloc>()
              .add(const ViewReminderSettings());
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // White background
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.12),
              offset: const Offset(0, 5),
              blurRadius: 18,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Color(item.backgroundColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.iconPath,
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E), // Medium gray
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            // Title section
            Expanded(
              child: Text(
                item.title,
                style: theme.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF292524), // Dark gray
                  height: 1.429,
                  letterSpacing: -0.006 * 14.sp,
                ),
              ),
            ),

            SizedBox(width: 10.w),

            // Value and chevron
            Row(
              children: [
                Text(
                  item.value,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF292524), // Dark gray
                    height: 1.429,
                    letterSpacing: -0.006 * 14.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(
                  'assets/images/chevron_right_icon.svg',
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E), // Medium gray
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildEditGoalButton] - Builds the edit goal level button
  Widget _buildEditGoalButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: 343.w,
      child: GestureDetector(
        onTap: () {
          // [_buildEditGoalButton] Handle edit goal button press
          print('[MindfulnessGoalSettingsPage] Edit goal level button pressed');
          context
              .read<MindfulnessGoalSettingsBloc>()
              .add(const EditGoalLevel());
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
              SvgPicture.asset(
                'assets/images/edit_pencil_icon.svg',
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFFFF), // White icon
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'Edit level goal',
                style: theme.bodyMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF), // White text
                  height: 1.375,
                  letterSpacing: -0.007 * 16.sp,
                ),
              ),
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
                  .read<MindfulnessGoalSettingsBloc>()
                  .add(const LoadMindfulnessGoalSettings());
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
