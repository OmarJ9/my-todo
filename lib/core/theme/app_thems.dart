import 'package:flutter/material.dart';

enum AppThemeColor {
  purple,

  green,

  orange,

  red,

  teal,

  pink,
}

class AppTheme {
  static final Map<AppThemeColor, ThemeData> themes = {
    AppThemeColor.purple: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.deepPurple,
    ),
    AppThemeColor.green: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.green,
    ),
    AppThemeColor.orange: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.orange,
    ),
    AppThemeColor.red: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.red,
    ),
    AppThemeColor.teal: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.teal,
    ),
    AppThemeColor.pink: ThemeData(
      fontFamily: "Montserrat",
      primaryColor: Colors.pink,
    ),
  };
}
