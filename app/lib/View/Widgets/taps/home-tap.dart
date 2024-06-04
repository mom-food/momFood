import 'package:flutter/material.dart';
import '../../Screens/home_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomePageScreen(), // عرض صفحة الصفحة الرئيسية مباشرة
    );
  }
}
