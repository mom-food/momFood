import 'dart:io';

import 'package:app/View/Screens/Authentication/SignUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'View/Screens/SplashScreen.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:app/View/widgets/app_bar.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAh1_uBnxz3toNPno1uvm0knZwtOwSKrek",
          appId: "1:175323531680:android:5cb7cd5c3878a57d47fcc5",
          messagingSenderId: "175323531680",
          projectId: "momfood-6ae63",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
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
      debugShowCheckedModeBanner: false,
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