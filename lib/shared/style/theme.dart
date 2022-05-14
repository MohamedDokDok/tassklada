import 'package:flutter/material.dart';

import 'color.dart';

class ThemeStyle{

  static ThemeData lightTheme = ThemeData(
    primaryColor: bluish,
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: darkGrey,
    brightness: Brightness.dark,
  );

}