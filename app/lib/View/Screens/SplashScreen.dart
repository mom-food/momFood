import 'package:flutter/material.dart';
import 'Home.dart';
import 'OnBoarding1.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    // You can replace this with your own duration
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Onboarding1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // This sets the background color to orange
      body: Center(
        child: Image.asset(
            'assets/images/Logo.png'), // This adds the logo to the center of the splash screen
      ),
    );
  }
}