import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';

class AppTheme{
  static  final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor.withOpacity(0.4),

    appBarTheme: const AppBarTheme(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
  systemOverlayStyle: SystemUiOverlayStyle(
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  statusBarColor: Colors.white,

  ),
  ),);


  static  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    // iconTheme: IconThemeData(color: Colors.grey),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.black,
      ),
    ),
  );
}