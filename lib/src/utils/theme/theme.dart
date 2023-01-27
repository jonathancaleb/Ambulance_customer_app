import 'package:ambulance_app/src/utils/widget-themes/text_theme.dart';
import 'package:flutter/material.dart';

class AAppTheme {
  AAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: ATextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: ATextTheme.darkTextTheme,
  );
}
