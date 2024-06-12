import 'package:flutter/material.dart';

ThemeData darkMode= ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color(0x57D9D9D9),
    primary: const Color(0xFFECEDF0),
    secondary: const Color(0xFFA8DF83),
    tertiary: const Color.fromARGB(255,47,47,47),
    inversePrimary: Colors.grey.shade300,
  ),
);