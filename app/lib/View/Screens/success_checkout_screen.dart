import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class SuccessMessageScreen extends StatefulWidget {
  @override
  _SuccessMessageScreen createState() => _SuccessMessageScreen();
}
class _SuccessMessageScreen extends State<SuccessMessageScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(Duration(microseconds: 3), () {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go("/");
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 350,
            height: 350,
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFFF6BD60),
                  size: 100,
                ),
                Text(
                  '!شكرا لك',
                  style: TextStyle(
                    fontSize: 24,
                    //fontWeight: FontWeight.bold,
                    color: Color(0xFFA8DF83),
                    fontFamily: 'Manrope_SemiBold.ttf',
                  ),
                ),
                Text(
                  'لقد اكتمل الطلب',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA8DF83),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}