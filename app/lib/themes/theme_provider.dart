import 'package:flutter/material.dart';
import 'dark.dart';
import 'light.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData= lightMode;

  ThemeData get themeData=> _themeData;

  bool get isDarkMode=>_themeData== darkMode;

  set themeData(ThemeData themeData){

    _themeData= themeData;
    notifyListeners();
  }
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    }
    else {
      themeData = lightMode;
    }
  }
  IconData getThemeIcon() {
    return _themeData == lightMode ? Icons.wb_sunny : Icons.nightlight_round;
  }
}


