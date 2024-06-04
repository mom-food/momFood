import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('إنشاء حساب' , style: TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black45, // Text Color
        backgroundColor: Colors.white, // Background color
        padding: EdgeInsets.symmetric(horizontal: 24), // Left/right padding 24dp
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 20dp corner radius
        ),
        fixedSize: Size.fromHeight(40), // Container height 40dp
        minimumSize: Size(136, 42),
        elevation: 5, // Shadow depth
      ),
    );
  }
}