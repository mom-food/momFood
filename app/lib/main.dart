import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/search-model.dart';
import 'ViewModel/meal_view_model.dart';
import 'View/Screens/Home.dart';
import 'View/Screens/OnBoarding1.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';
import 'View/Widgets/app_bar.dart';
import 'View/Screens/offer.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'themes/theme-provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => MomFood()),
        ChangeNotifierProvider(create: (_) => MealViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
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
