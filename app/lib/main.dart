import 'package:flutter/material.dart';
import 'View/Screens/SplashScreen.dart';
import 'themes/dark.dart';
import 'themes/light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Set the default theme mode

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: LightThemeData.light, // Use the light theme
      darkTheme: DarkThemeData.dark, // Use the dark theme
      themeMode: _themeMode, // Use the selected theme mode
      home: SplashScreen(), // Display SplashScreen as the initial screen
      builder: (context, child) {
        return GestureDetector(
          // This gesture detector listens for a tap anywhere on the screen
          onTap: _toggleTheme, // Toggle theme when tapped
          child: child, // Render the child widget (e.g., SplashScreen)
        );
      },
    );
  }
}
