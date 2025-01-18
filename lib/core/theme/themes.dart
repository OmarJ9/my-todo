import 'package:flutter/material.dart';

import 'package:todo_app/core/theme/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: "Montserrat",
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Appcolors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 30,
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
