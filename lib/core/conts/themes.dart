import 'package:control_bank_accounts/core/conts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'colors.dart';

class Themes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: App.fontFamily,
    appBarTheme:  AppBarTheme(
      color: AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.subColor),
      titleTextStyle: Fonts.regularTextStyle(color: AppColors.subColor, fontSize: 24),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: App.fontFamily,
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      elevation: 0,
      titleTextStyle: Fonts.regularTextStyle(color: AppColors.subColor, fontSize: 24),
    ),
  );
}
