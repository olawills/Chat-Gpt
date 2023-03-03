import 'package:flutter/material.dart';
import 'package:chat_gpt/exports/theme_exports.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: textColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: bodyColor,
    ),
  );
}
