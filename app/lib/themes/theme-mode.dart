import 'package:flutter/material.dart';

class ThemeModeSwitch extends StatefulWidget {
  const ThemeModeSwitch({Key? key}) : super(key: key);

  @override
  _ThemeModeSwitchState createState() => _ThemeModeSwitchState();
}

class _ThemeModeSwitchState extends State<ThemeModeSwitch> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
      onPressed: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
        ThemeMode mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
        MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? mode = ThemeMode.dark
            : mode = ThemeMode.light;
        MediaQuery.platformBrightnessOf(context);
        var DynamicTheme;
        DynamicTheme.of(context)!.setThemeMode(mode);
      },
    );
  }
}
