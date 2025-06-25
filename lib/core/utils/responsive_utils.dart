import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  static double getResponsiveFontSize(double baseFontSize) {
    return baseFontSize.sp;
  }

  static double getResponsiveWidth(double baseWidth) {
    return baseWidth.w;
  }

  static double getResponsiveHeight(double baseHeight) {
    return baseHeight.h;
  }

  static EdgeInsets getResponsivePadding({
    double? horizontal,
    double? vertical,
    double? all,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all.w);
    }

    return EdgeInsets.only(
      left: (left ?? horizontal ?? 0).w,
      right: (right ?? horizontal ?? 0).w,
      top: (top ?? vertical ?? 0).h,
      bottom: (bottom ?? vertical ?? 0).h,
    );
  }

  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing * 0.8;
    } else if (isTablet(context)) {
      return baseSpacing;
    } else {
      return baseSpacing * 1.2;
    }
  }

  static int getCrossAxisCount(
    BuildContext context, {
    int mobileCount = 1,
    int tabletCount = 2,
    int desktopCount = 3,
  }) {
    if (isMobile(context)) {
      return mobileCount;
    } else if (isTablet(context)) {
      return tabletCount;
    } else {
      return desktopCount;
    }
  }
}
