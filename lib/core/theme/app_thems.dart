import 'package:flutter/material.dart';

enum AppThemeColor {
  purple,

  green,

  orange
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
  };
}
