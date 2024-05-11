import 'package:flutter/material.dart';
import 'View/Screens/Home.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';
import 'package:app/View/Screens/OnBoarding1.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'themes/theme-provider.dart';
import 'package:app/View/widgets/app_bar.dart';
import 'package:provider/provider.dart';
void main() {
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode
                .light,
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
              '/Home': (context) => MyHomePage(title: '',),
            },
          );
        },
      ),
    );
  }
}