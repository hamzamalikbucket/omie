import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_config.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _getThemeColorForFlavor(),
        brightness: Brightness.light,
      ),
      useMaterial3: true,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL.w,
            vertical: AppConstants.paddingM.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          elevation: 2,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        margin: EdgeInsets.all(AppConstants.paddingS.w),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM.w,
          vertical: AppConstants.paddingM.h,
        ),
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        contentTextStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  static Color _getThemeColorForFlavor() {
    switch (AppConfig.flavor) {
      case Flavor.development:
        return Colors.red;
      case Flavor.staging:
        return Colors.orange;
      case Flavor.production:
        return Colors.deepPurple;
    }
  }

  static Color get primaryColor => _getThemeColorForFlavor();

  static Color get successColor => Colors.green;
  static Color get warningColor => Colors.orange;
  static Color get errorColor => Colors.red;
  static Color get infoColor => Colors.blue;
}
