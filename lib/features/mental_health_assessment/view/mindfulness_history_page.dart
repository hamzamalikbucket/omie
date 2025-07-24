import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

/// [MindfulnessHistoryPage] - Page wrapper for Mindfulness History screen
/// This page displays chronological history of mindfulness level entries
/// following Apple's Human Interface Guidelines for history and timeline interfaces
class MindfulnessHistoryPage extends StatelessWidget {
  const MindfulnessHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MindfulnessHistoryBloc()..add(const LoadMindfulnessHistory()),
      child: const MindfulnessHistoryView(),
    );
  }
}

/// [MindfulnessHistoryView] - Main view for the Mindfulness History screen
/// Displays description, filter controls, and date-organized history entries
/// using modern, clean design patterns inspired by Apple's health and data apps
class MindfulnessHistoryView extends StatelessWidget {
  const MindfulnessHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<MindfulnessHistoryBloc, MindfulnessHistoryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              const Color(0xFFF08C51), // Orange background from Figma
          body: SafeArea(
            child: Column(
              children: [
                // Top navigation
                _buildTopNavigation(context, theme),

                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      // Top decorative section with ellipse
                      _buildTopDecorativeSection(),

                      // White content area
                      Expanded(
                        child: Container(
                          width: 375.w,
                          color: const Color(0xFFFFFFFF), // White background
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                              child: SizedBox(
                                width: 343.w,
                                child: Column(
                                  children: [
                                    // Description text
                                    _buildDescription(theme, state),

                                    SizedBox(height: 24.h),

                                    // Filter header section
                                    _buildFilterHeader(context, theme, state),

                                    SizedBox(height: 24.h),

                                    // History sections
                                    _buildHistorySections(
                                        context, theme, state),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Home indicator
                _buildHomeIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation with back button, title, and notification
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 54.h,
      color: const Color(0xFFF08C51), // Orange background
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - back button and title
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // [_buildTopNavigation] Navigate back
                    print('[MindfulnessHistoryPage] Back button pressed');
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/images/chevron_left_icon.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFFFFFF), // White color
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Mindfulness Level History',
                  style: theme.headlineLarge.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF), // White color
                    height: 1.9,
                    letterSpacing: -0.013 * 20.sp,
                  ),
                ),
              ],
            ),

            // Right side - notification icon
            GestureDetector(
              onTap: () {
                // [_buildTopNavigation] Open notifications
                print('[MindfulnessHistoryPage] Notification button pressed');
              },
              child: SvgPicture.asset(
                'assets/images/bell_notification_icon.svg',
                width: 24.w,
                height: 24.w,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFFFFFF), // White color
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildTopDecorativeSection] - Builds the top decorative section with ellipse
  Widget _buildTopDecorativeSection() {
    return SizedBox(
      width: 375.w,
      height: 48.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Large decorative ellipse positioned exactly like Figma design
          Positioned(
            left: -253.w,
            top: 0.h,
            child: Container(
              width: 880.w,
              height: 880.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // White background
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildDescription] - Builds the description text section
  Widget _buildDescription(
      YouthYogaTheme theme, MindfulnessHistoryState state) {
    return SizedBox(
      width: 343.w,
      child: Text(
        state.description,
        style: theme.bodyMedium.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57534E), // Medium gray from Figma
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// [_buildFilterHeader] - Builds the filter header with title and filter button
  Widget _buildFilterHeader(BuildContext context, YouthYogaTheme theme,
      MindfulnessHistoryState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Section title
        Text(
          'All Recorded Log',
          style: theme.headlineLarge.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292524), // Dark gray from Figma
            height: 1.333,
            letterSpacing: -0.008 * 18.sp,
          ),
        ),

        // Filter button
        GestureDetector(
          onTap: () {
            // [_buildFilterHeader] Show filter options
            print('[MindfulnessHistoryPage] Filter button pressed');
            context
                .read<MindfulnessHistoryBloc>()
                .add(const FilterHistory('Date'));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                // Calendar icon
                SvgPicture.asset(
                  'assets/images/calendar_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF08C51), // Orange color
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 6.w),
                // Filter text
                Text(
                  'Filter',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292524), // Dark gray
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                // Dropdown chevron
                SvgPicture.asset(
                  'assets/images/chevron_down_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E), // Medium gray
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildHistorySections] - Builds all date-organized history sections
  Widget _buildHistorySections(BuildContext context, YouthYogaTheme theme,
      MindfulnessHistoryState state) {
    if (state.status == MindfulnessHistoryStatus.loading) {
      return SizedBox(
        height: 200.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFFF08C51),
          ),
        ),
      );
    }

    if (state.status == MindfulnessHistoryStatus.error) {
      return SizedBox(
        height: 200.h,
        child: Center(
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
                state.errorMessage ?? 'Something went wrong',
                style: theme.bodyLarge.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<MindfulnessHistoryBloc>()
                      .add(const RefreshHistory());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF08C51),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: state.historySections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        final isLast = index == state.historySections.length - 1;

        return Column(
          children: [
            _buildHistorySection(context, theme, section),
            if (!isLast) SizedBox(height: 32.h),
          ],
        );
      }).toList(),
    );
  }

  /// [_buildHistorySection] - Builds a single date-organized history section
  Widget _buildHistorySection(
      BuildContext context, YouthYogaTheme theme, HistorySection section) {
    return Column(
      children: [
        // Section date header
        Row(
          children: [
            Text(
              section.date,
              style: theme.titleMedium.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292524),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // History entries
        Column(
          children: section.entries.asMap().entries.map((entry) {
            final index = entry.key;
            final historyEntry = entry.value;
            final isLast = index == section.entries.length - 1;

            return Column(
              children: [
                _buildHistoryEntry(context, theme, historyEntry),
                if (!isLast) SizedBox(height: 16.h),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  /// [_buildHistoryEntry] - Builds a single history entry card
  Widget _buildHistoryEntry(
      BuildContext context, YouthYogaTheme theme, HistoryEntry entry) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 5),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          // Heart icon
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: SvgPicture.asset(
              'assets/images/wellness_heart_icon.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFFF08C51),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Score and status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.score,
                      style: theme.titleMedium.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF292524),
                        height: 1.375,
                        letterSpacing: -0.007 * 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      entry.status,
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF57534E),
                        height: 1.429,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                    ),
                  ],
                ),

                // Status message if present
                if (entry.hasStatusMessage) ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/info_circle_icon.svg',
                        width: 16.w,
                        height: 16.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFCF4C1E), // Reddish color from Figma
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          entry.statusMessage ?? '',
                          style: theme.bodyMedium.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFCF4C1E), // Reddish color
                            height: 1.333,
                            letterSpacing: -0.005 * 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Right side - time and action
          if (entry.isDeletable) ...[
            // Deletable entry with time and delete button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      entry.time,
                      style: theme.bodyMedium.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF57534E),
                        height: 1.429,
                        letterSpacing: -0.006 * 14.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgPicture.asset(
                      'assets/images/chevron_right_icon.svg',
                      width: 24.w,
                      height: 24.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF57534E),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    // [_buildHistoryEntry] Delete entry
                    print('[MindfulnessHistoryPage] Delete entry: ${entry.id}');
                    context
                        .read<MindfulnessHistoryBloc>()
                        .add(DeleteHistoryEntry(entry.id));
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB7185), // Red color from Figma
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/trash_icon.svg',
                        width: 24.w,
                        height: 24.w,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFFFFFFFF), // White icon
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Normal entry with time and chevron
            Row(
              children: [
                Text(
                  entry.time,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.429,
                    letterSpacing: -0.006 * 14.sp,
                  ),
                ),
                SizedBox(width: 4.w),
                SvgPicture.asset(
                  'assets/images/chevron_right_icon.svg',
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF57534E),
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// [_buildHomeIndicator] - Builds the home indicator at the bottom
  Widget _buildHomeIndicator() {
    return Container(
      width: 375.w,
      height: 24.h,
      color: const Color(0xFFFFFFFF),
      child: Center(
        child: Container(
          width: 134.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF292524), // Dark gray from Figma
            borderRadius: BorderRadius.circular(9999.r),
          ),
        ),
      ),
    );
  }
}
