import 'dart:io';
import 'package:app/View/Screens/meal_details.dart';
import 'package:app/View/Screens/success_checkout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/Screens/Authentication/SignIn.dart';
import 'View/Screens/Authentication/SignUp.dart';
import 'View/Screens/CategoryMeal.dart';
import 'View/Screens/MenuList.dart';
import 'ViewModel/meal_view_model.dart';
import 'View/Screens/HomePage.dart';
import 'View/Screens/OnBoarding1.dart';
import 'View/Screens/OnBoarding2.dart';
import 'themes/theme-provider.dart';
import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:go_router/go_router.dart';

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
  runApp(MyApp());
}

final _router = GoRouter(
  initialLocation: "/onboarding1",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePageScreen(),
    ),
    // GoRoute(
    //   path: '/Home',
    //   builder: (context, state) => HomePageScreen(),
    // ),
    GoRoute(
      path: '/signIn',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => Onboarding1(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => Onboarding2Screen(),
    ),
    GoRoute(
      path: '/MealCategoryScreen',
      builder: (context, state) => MealCategoryScreen(),
    ),
    GoRoute(
      path: '/mealDetailsScreen/:mealId',
      builder: (context, state) =>
          MealDetailsScreen(mealId: state.pathParameters['mealId']!),
    ),
    GoRoute(
      path: '/meal-list/:categoryId',
      builder: (context, state) => MealList(categoryId: state.pathParameters['categoryId']!),
    ),
    GoRoute(
      path: '/successful_checkout',
      builder: (context, state) => SuccessMessageScreen(),
    ),

  ],
);

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
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => MomFood()),
        ChangeNotifierProvider(create: (_) => MealViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          print(_router.configuration);
          return MaterialApp.router(
            title: 'Flutter Demo',
            themeMode:
            themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: themeProvider.isDarkMode ? darkMode : lightMode,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}