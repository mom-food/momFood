
import 'package:flutter/material.dart';

class DarkThemeData {
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0x57D9D9D9),
      primary: Color(0xFFECEDF0),
      secondary: Color(0xFFA8DF83),
    ),
  );
}

/**/