import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:todo_app/shared/styles/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Appcolors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: Appcolors.white, brightness: Brightness.light));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Montserrat",
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Appcolors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Appcolors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: Appcolors.black, brightness: Brightness.dark));
}
