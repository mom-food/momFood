import 'package:flutter/material.dart';

class LightThemeData {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color(0xFFFFFFFF),
      primary: Color(0xFFF6BD60),
      secondary: Color(0xFFD9D9D9),

    ),
  );
}