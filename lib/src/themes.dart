import 'package:flutter/material.dart';

class Themes {
  static const theme = 0;
  static final thm = ThemeData(
      primarySwatch: MaterialColor(
        Colors.black.value,
        const <int, Color>{
          50: Colors.black12,
          100: Colors.black26,
          200: Colors.black38,
          300: Colors.black45,
          400: Colors.black54,
          500: Colors.black87,
          600: Colors.black87,
          700: Colors.black87,
          800: Colors.black87,
          900: Colors.black87,
        },
      ),
      accentColor: Colors.white,
      disabledColor: Colors.green);

  static ThemeData getTheme(int code) {
    return thm;
  }
}
