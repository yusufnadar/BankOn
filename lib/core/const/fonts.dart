import 'package:flutter/material.dart';
import 'app.dart';
import 'colors.dart';

class Fonts {
  static TextStyle lightTextStyle({double? fontSize, color,letterSpacing}) => TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.black,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w300,
        fontFamily: App.fontFamily,
      );

  static TextStyle regularTextStyle({double? fontSize, color, letterSpacing}) =>
      TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.black,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing,
        fontFamily: App.fontFamily,
      );

  static TextStyle mediumTextStyle({double? fontSize, color, letterSpacing}) =>
      TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.black,
        letterSpacing: letterSpacing,
        fontWeight: FontWeight.w500,
        fontFamily: App.fontFamily,
      );

  static TextStyle semiBoldTextStyle({double? fontSize, color, letterSpacing}) =>
      TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        fontFamily: App.fontFamily,
      );

  static TextStyle boldTextStyle(
          {double? fontSize, color, fontWeight, letterSpacing}) =>
      TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.w700,
        letterSpacing: letterSpacing,
        fontFamily: App.fontFamily,
      );
}
