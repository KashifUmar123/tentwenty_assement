import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    primaryColor: AppColors.whiteColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.blueColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.whiteColor,
      contentTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      elevation: 0,
    ),
  );
}
