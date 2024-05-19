import 'package:flutter/material.dart';
import 'OnBoarding1.dart'; // Import your OnBoarding1 screen here

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

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/onboarding1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/Logo.png'),
      ),
    );
  }
}
