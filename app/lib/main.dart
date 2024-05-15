import 'package:app/View/Screens/Home.dart';
import 'package:app/ViewModel/meal_view_mode.dart';
import 'package:flutter/material.dart';
import 'Model/search-model.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';
import 'View/Screens/OnBoarding1.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'themes/theme-provider.dart';
import 'package:provider/provider.dart';

import 'View/Screens/offer.dart';
import 'package:app/View/Widgets/app_bar.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MomFood()),
        ChangeNotifierProvider(create: (_) => MealViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: themeProvider.isDarkMode ? darkMode : lightMode,
            home: Scaffold(
              appBar: MyAppBar(
                title: 'Mom Food',
                isLightTheme: !themeProvider.isDarkMode,
              ),
              body: SplashScreen(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                tooltip: 'Switch',
                child: Icon(
                  themeProvider.getThemeIcon(),
                ),
              ),
            ),
            routes: {
              '/onboarding1': (context) => Onboarding1(),
              '/onboarding2': (context) => Onboarding2Screen(),
              '/offer': (context) => HomePage(),
            },
          );
        },
      ),
    );
  }
}
