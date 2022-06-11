import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.accentColor,
        canvasColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryColor,
          secondary: Colors.orange,
          tertiary: Colors.yellow,
        ),
        // Define the default font family.
        fontFamily: 'Poppins',

        textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            headline5: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
              color: AppColors.darkColor,
            )),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          enabledBorder: inputBorder,
          errorBorder: inputBorder,
          focusedBorder: inputBorder,
          focusedErrorBorder: inputBorder,
          disabledBorder: inputBorder,
          border: inputBorder,
        ),
      );

  static InputBorder get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.lightColor,
          width: 1,
        ),
      );

  static LinearGradient backgroundGradient = LinearGradient(
    colors: [
      AppColors.accentColor,
      AppColors.primaryColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
