import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SuccessMessageScreen extends StatefulWidget {
  const SuccessMessageScreen({super.key});

  @override
  SuccessMessageScreenState createState() => SuccessMessageScreenState();
}

class SuccessMessageScreenState extends State<SuccessMessageScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(microseconds: 100000), () {});
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
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
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