import 'package:ekorek/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppText {
  static TextStyle get button => TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get body => TextStyle(
    color: AppColors.lightColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get headline => TextStyle(
    color: AppColors.darkColor,
    fontWeight: FontWeight.w600,
  );
}