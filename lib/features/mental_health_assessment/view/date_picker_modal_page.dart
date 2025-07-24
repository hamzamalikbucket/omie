import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/bloc.dart';

/// [DatePickerModalPage] - Page wrapper for Date Picker Modal screen
/// This page displays a calendar interface for selecting goal maintenance dates
/// following Apple's Human Interface Guidelines for date picker interfaces
class DatePickerModalPage extends StatelessWidget {
  const DatePickerModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DatePickerModalBloc()..add(const LoadDatePickerModal()),
      child: const DatePickerModalView(),
    );
  }
}

/// [DatePickerModalView] - Main view for the Date Picker Modal screen
/// Displays calendar grid, month navigation, and date selection functionality
/// using modern, intuitive design patterns for date selection
class DatePickerModalView extends StatelessWidget {
  const DatePickerModalView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocBuilder<DatePickerModalBloc, DatePickerModalState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF), // White background
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Main content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 62.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Header section
                        _buildHeaderSection(context, theme, state),

                        SizedBox(height: 32.h),

                        // Calendar section
                        _buildCalendarSection(context, theme, state),
                      ],
                    ),
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

  /// [_buildHeaderSection] - Builds the header with title and close button
  Widget _buildHeaderSection(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    return Row(
      children: [
        // Title
        Expanded(
          child: Text(
            state.title,
            style: theme.bodyMedium.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF292524), // Dark gray
              height: 1.333,
              letterSpacing: -0.008 * 18.sp,
            ),
          ),
        ),

        SizedBox(width: 16.w),

        // Close button
        GestureDetector(
          onTap: () {
            // [_buildHeaderSection] Handle close button press
            print('[DatePickerModalPage] Close button pressed');
            context.read<DatePickerModalBloc>().add(const CloseModal());
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: 24.w,
            height: 24.w,
            child: SvgPicture.asset(
              'assets/images/close_x_icon.svg',
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF57534E), // Medium gray
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildCalendarSection] - Builds the calendar interface
  Widget _buildCalendarSection(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    if (state.status == DatePickerModalStatus.loading) {
      return _buildLoadingState();
    }

    if (state.status == DatePickerModalStatus.error) {
      return _buildErrorState(context, theme, state.errorMessage);
    }

    return Column(
      children: [
        // Calendar header
        _buildCalendarHeader(context, theme, state),

        SizedBox(height: 16.h),

        // Calendar grid
        _buildCalendarGrid(context, theme, state),

        SizedBox(height: 24.h),

        // Deadline text
        _buildDeadlineText(theme, state),

        SizedBox(height: 24.h),

        // Set date button
        _buildSetDateButton(context, theme, state),
      ],
    );
  }

  /// [_buildCalendarHeader] - Builds the calendar header with month navigation
  Widget _buildCalendarHeader(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE7E5E4), // Light gray border
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Today button
          GestureDetector(
            onTap: () {
              // [_buildCalendarHeader] Handle today button press
              print('[DatePickerModalPage] Today button pressed');
              context.read<DatePickerModalBloc>().add(const GoToToday());
            },
            child: Text(
              'Today',
              style: theme.bodyMedium.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E), // Medium gray
                height: 1.429,
                letterSpacing: -0.006 * 14.sp,
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Month and year
          Expanded(
            child: Text(
              state.formattedMonthYear,
              style: theme.bodyMedium.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF292524), // Dark gray
                height: 1.333,
                letterSpacing: -0.008 * 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: 16.w),

          // Navigation buttons
          Row(
            children: [
              // Previous month button
              GestureDetector(
                onTap: () {
                  // [_buildCalendarHeader] Handle previous month
                  print('[DatePickerModalPage] Previous month pressed');
                  context
                      .read<DatePickerModalBloc>()
                      .add(const NavigateMonth(false));
                },
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    'assets/images/chevron_left_icon.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFA8A29E), // Light gray
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Next month button
              GestureDetector(
                onTap: () {
                  // [_buildCalendarHeader] Handle next month
                  print('[DatePickerModalPage] Next month pressed');
                  context
                      .read<DatePickerModalBloc>()
                      .add(const NavigateMonth(true));
                },
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    'assets/images/chevron_right_icon.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFA8A29E), // Light gray
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildCalendarGrid] - Builds the calendar grid with day headers and date cells
  Widget _buildCalendarGrid(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    return Column(
      children: [
        // Day headers
        Row(
          children:
              ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
            return Expanded(
              child: SizedBox(
                width: 48.w,
                child: Text(
                  day,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF57534E), // Medium gray
                    height: 1.429,
                    letterSpacing: -0.006 * 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 8.h),

        // Date grid
        Column(
          children: _buildDateRows(context, theme, state),
        ),
      ],
    );
  }

  /// [_buildDateRows] - Builds the date rows for the calendar grid
  List<Widget> _buildDateRows(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    final rows = <Widget>[];
    final dates = state.calendarDates;

    // Group dates into weeks (7 days per row)
    for (int i = 0; i < dates.length; i += 7) {
      final weekDates = dates.skip(i).take(7).toList();
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Row(
            children: weekDates.map((date) {
              return Expanded(
                child: _buildDateCell(context, theme, date),
              );
            }).toList(),
          ),
        ),
      );
    }

    return rows;
  }

  /// [_buildDateCell] - Builds individual date cell
  Widget _buildDateCell(
      BuildContext context, YouthYogaTheme theme, CalendarDate date) {
    return GestureDetector(
      onTap: () {
        // [_buildDateCell] Handle date selection
        if (date.isCurrentMonth) {
          print('[DatePickerModalPage] Date selected: ${date.day}');
          final selectedDate = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            date.day,
          );
          context.read<DatePickerModalBloc>().add(SelectDate(selectedDate));
        }
      },
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: date.isSelected
              ? const Color(0xFFF08C51) // Orange background for selected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(123.r),
          boxShadow: date.isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFF08C51).withOpacity(0.5),
                    offset: const Offset(0, 5),
                    blurRadius: 18,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: theme.bodyMedium.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: date.isSelected
                  ? const Color(0xFFFFFFFF) // White text for selected
                  : date.isCurrentMonth
                      ? const Color(0xFF57534E) // Medium gray for current month
                      : const Color(0xFFD6D3D1), // Light gray for other months
              height: 1.375,
              letterSpacing: -0.007 * 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  /// [_buildDeadlineText] - Builds the deadline text
  Widget _buildDeadlineText(YouthYogaTheme theme, DatePickerModalState state) {
    return Text(
      state.deadlineText,
      style: theme.bodyMedium.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF57534E), // Medium gray
        height: 1.375,
        letterSpacing: -0.007 * 16.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// [_buildSetDateButton] - Builds the set date button
  Widget _buildSetDateButton(
      BuildContext context, YouthYogaTheme theme, DatePickerModalState state) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          // [_buildSetDateButton] Handle set date button press
          print('[DatePickerModalPage] Set date button pressed');
          context.read<DatePickerModalBloc>().add(const ConfirmDateSelection());
          Navigator.of(context).pop(state.selectedDate);
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
              Text(
                'Set Date',
                style: theme.bodyMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFFFFF), // White text
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
                  Color(0xFFFFFFFF), // White icon
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildHomeIndicator] - Builds the home indicator
  Widget _buildHomeIndicator() {
    return SizedBox(
      width: 375.w,
      height: 24.h,
      child: Center(
        child: Container(
          width: 134.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: const Color(0xFF292524), // Dark gray
            borderRadius: BorderRadius.circular(1234.r),
          ),
        ),
      ),
    );
  }

  /// [_buildLoadingState] - Builds loading state UI
  Widget _buildLoadingState() {
    return SizedBox(
      width: double.infinity,
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
      width: double.infinity,
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
                  .read<DatePickerModalBloc>()
                  .add(const LoadDatePickerModal());
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
