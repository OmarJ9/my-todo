import 'package:flutter/material.dart';

import 'package:todo_app/core/theme/app_colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Montserrat",
    colorScheme: ColorScheme.fromSeed(
      seedColor: Appcolors.white,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Montserrat",
    colorScheme: ColorScheme.fromSeed(
      seedColor: Appcolors.black,
      brightness: Brightness.dark,
    ),
  );
}
