// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_config.dart';
import '../constants/app_constants.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class YouthYogaTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static YouthYogaTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color containerBackground;
  late Color barBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color accent5;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;
  late Color navBarColor;
  late Color buttonColor;
  late Color navBarSelectedBackground;
  late Color headerColor;
  late Color boxShadowColor;
  late Color grey;
  late Color navBarMultipleItems;
  late Color inRange;
  late Color darkShadowColor;
  late Color cardBackground;
  late Color cardText;
  late Color cardAccent;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  BoxDecoration get primaryButtonDecoration => BoxDecoration(
        color: secondaryBackground,
        border: Border.all(color: primaryText.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: boxShadowColor.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      );

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);

  // Material 3 Theme Data
  ThemeData get materialTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: primaryBackground == const Color(0xFFFFFFFF)
              ? Brightness.light
              : Brightness.dark,
          primary: primary,
          secondary: secondary,
          tertiary: tertiary,
          surface: secondaryBackground,
          background: primaryBackground,
        ),
        useMaterial3: true,
        fontFamily: 'Urbanist',
        textTheme: GoogleFonts.urbanistTextTheme().copyWith(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineLarge: headlineLarge,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          labelLarge: labelLarge,
          labelMedium: labelMedium,
          labelSmall: labelSmall,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          bodySmall: bodySmall,
        ),
        scaffoldBackgroundColor: primaryBackground,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 1,
          backgroundColor: headerColor,
          foregroundColor: primaryText,
          titleTextStyle: headlineMedium,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: info,
            textStyle: labelLarge.copyWith(fontWeight: FontWeight.w600),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            elevation: 2,
          ),
        ),
        cardTheme: CardThemeData(
          color: secondaryBackground,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          margin: EdgeInsets.all(8.w),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: accent1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: alternate),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: alternate),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: primary, width: 2),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          labelStyle: bodyMedium.copyWith(color: secondaryText),
          hintStyle: bodyMedium.copyWith(color: secondaryText),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryText,
          contentTextStyle: bodyMedium.copyWith(color: primaryBackground),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
}

class LightModeTheme extends YouthYogaTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFF08C51); // Orange from Figma
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFE8F5E8);
  late Color alternate = const Color(0xFFD6D3D1); // Border color from Figma
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFFFFFFF); // White background
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color containerBackground = const Color(0xFFF08C51); // Orange container
  late Color barBackground = const Color(0xFFF9F9F9);
  late Color accent1 = const Color(0xFFF5F5F5);
  late Color accent2 = const Color(0xFFDBDBDB);
  late Color accent3 = const Color(0xFFD7D7D7);
  late Color accent4 = const Color(0xFFF3F3F3);
  late Color accent5 = const Color(0xFFFCFCFC);
  late Color success = const Color(0xFF9BB167); // Updated success color
  late Color warning = const Color(0xFFFF9800);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFE6FFA9);
  late Color navBarColor = const Color(0xFFF08C51);
  late Color headerColor = const Color(0xFFF9F9F9);
  late Color buttonColor = const Color(0xFFF08C51);
  late Color navBarSelectedBackground = const Color(0xFFFFFFFF);
  late Color boxShadowColor = const Color(0xFF57636C);
  late Color grey = const Color(0xFFF3F3F3);
  late Color navBarMultipleItems = const Color(0x4DF08C51);
  late Color inRange = const Color(0xFFE8F5E8);
  late Color darkShadowColor = const Color(0xFF000000);
  late Color cardBackground =
      const Color(0xFFF7F3EF); // Beige background for onboarding cards
  late Color cardText = const Color(0xFF533630); // Dark brown text for cards
  late Color cardAccent = const Color(0xFFEBE2D6); // Light beige accent color
}

class DarkModeTheme extends YouthYogaTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFF08C51); // Orange from Figma
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFF2D4A3E);
  late Color alternate = const Color.fromARGB(255, 42, 47, 54);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFFAAAAAA);
  late Color primaryBackground = const Color(0xFF1A1A1A);
  late Color secondaryBackground = const Color(0xFF2A2A2A);
  late Color containerBackground = const Color(0xFFF08C51);
  late Color barBackground = const Color(0xFF242f3c);
  late Color accent1 = const Color(0xFF3A3A3A);
  late Color accent2 = const Color(0xFF4A4A4A);
  late Color accent3 = const Color(0xFF5A5A5A);
  late Color accent4 = const Color(0xFF6A6A6A);
  late Color accent5 = const Color(0xFF7A7A7A);
  late Color success = const Color(0xFF9BB167); // Updated success color
  late Color warning = const Color(0xFFFF9800);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFE6FFA9);
  late Color navBarColor = const Color(0xFF2A2A2A);
  late Color buttonColor = const Color(0xFFF08C51);
  late Color navBarSelectedBackground = const Color(0xFFF08C51);
  late Color headerColor = const Color(0xFF2A2A2A);
  late Color boxShadowColor = const Color(0xFF000000);
  late Color grey = const Color(0xFF3A3A3A);
  late Color navBarMultipleItems = const Color(0x4DF08C51);
  late Color inRange = const Color(0xFF2D4A3E);
  late Color darkShadowColor = const Color(0xFF000000);
  late Color cardBackground =
      const Color(0xFF2A2A2A); // Dark background for onboarding cards
  late Color cardText =
      const Color(0xFFFFFFFF); // White text for cards in dark mode
  late Color cardAccent = const Color(0xFF3A3A3A); // Dark accent color
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final YouthYogaTheme theme;

  String get displayLargeFamily => 'Urbanist';
  TextStyle get displayLarge => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 57.sp,
        height: 1.12,
        letterSpacing: -0.25,
      );

  String get displayMediumFamily => 'Urbanist';
  TextStyle get displayMedium => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 45.sp,
        height: 1.16,
        letterSpacing: 0,
      );

  String get displaySmallFamily => 'Urbanist';
  TextStyle get displaySmall => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.sp,
        height: 1.22,
        letterSpacing: 0,
      );

  String get headlineLargeFamily => 'Urbanist';
  TextStyle get headlineLarge => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.sp,
        height: 1.25,
        letterSpacing: 0,
      );

  String get headlineMediumFamily => 'Urbanist';
  TextStyle get headlineMedium => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 28.sp,
        height: 1.29,
        letterSpacing: 0,
      );

  String get headlineSmallFamily => 'Urbanist';
  TextStyle get headlineSmall => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24.sp,
        height: 1.33,
        letterSpacing: 0,
      );

  String get titleLargeFamily => 'Urbanist';
  TextStyle get titleLarge => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22.sp,
        height: 1.27,
        letterSpacing: 0,
      );

  String get titleMediumFamily => 'Urbanist';
  TextStyle get titleMedium => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
        height: 1.50,
        letterSpacing: 0.15,
      );

  String get titleSmallFamily => 'Urbanist';
  TextStyle get titleSmall => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        height: 1.43,
        letterSpacing: 0.1,
      );

  String get labelLargeFamily => 'Urbanist';
  TextStyle get labelLarge => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        height: 1.43,
        letterSpacing: 0.1,
      );

  String get labelMediumFamily => 'Urbanist';
  TextStyle get labelMedium => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        height: 1.43,
        letterSpacing: 0.5,
      );

  String get labelSmallFamily => 'Urbanist';
  TextStyle get labelSmall => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        height: 1.45,
        letterSpacing: 0.5,
      );

  String get bodyLargeFamily => 'Urbanist';
  TextStyle get bodyLarge => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 1.50,
        letterSpacing: 0.15,
      );

  String get bodyMediumFamily => 'Urbanist';
  TextStyle get bodyMedium => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        height: 1.43,
        letterSpacing: 0.25,
      );

  String get bodySmallFamily => 'Urbanist';
  TextStyle get bodySmall => GoogleFonts.urbanist(
        color: theme.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        height: 1.33,
        letterSpacing: 0.4,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts && fontFamily != null
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration ?? this.decoration,
              height: lineHeight ?? height,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}

// Legacy AppTheme class for backward compatibility
class AppTheme {
  static ThemeData getTheme() {
    // Return a basic theme using LightModeTheme for backward compatibility
    final lightTheme = LightModeTheme();
    return lightTheme.materialTheme;
  }

  static Color get primaryColor => const Color(0xFFF08C51);
  static Color get successColor =>
      const Color(0xFF9BB167); // Updated success color
  static Color get warningColor => const Color(0xFFFF9800);
  static Color get errorColor => const Color(0xFFFF5963);
  static Color get infoColor => const Color(0xFF2196F3);
}
