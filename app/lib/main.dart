import 'package:flutter/material.dart';
import 'View/Screens/SplashScreen.dart';
import 'package:app/View/Screens/OnBoarding1.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:app/View/widgets/app_bar.dart';
import 'package:app/View/widgets/nav_bar.dart';
void main() {
  runApp( MyApp());
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _themeMode == ThemeMode.light ? ThemeData.light(): ThemeData.dark(),
      home: Scaffold(
        appBar: MyAppBar(

          title: 'Mom Food',
          isLightTheme: _themeMode == ThemeMode.light,
        ),
        body: SplashScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          tooltip: 'Switch',
          child: Icon(
            _themeMode == ThemeMode.light ? Icons.wb_sunny: Icons.nightlight_round,
            color: _themeMode == ThemeMode.light
                ? DarkThemeData.dark.colorScheme.secondary
                : LightThemeData.light.colorScheme.secondary,
          ),

          ),

        backgroundColor: _themeMode == ThemeMode.light
            ? DarkThemeData.dark.colorScheme.background
            : LightThemeData.light.colorScheme.background,
        ),

    );
  }
}