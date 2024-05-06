import 'package:flutter/material.dart';
import 'View/Screens/Authentication/SignIn.dart';
import 'View/Screens/Authentication/SignUp.dart';
import 'View/Screens/Home.dart';
import 'View/Screens/OnBoarding1.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mom Food',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding1': (context) => Onboarding1(),
        '/onboarding2': (context) => Onboarding2Screen(),
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/home': (context) => MyHomePage(title: 'Mom Food'),
      },
    );
  }
}

