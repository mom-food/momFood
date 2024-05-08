import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('دخول' , style: TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFFF9500),
        padding: EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        minimumSize: Size(136, 42),
        elevation: 5, // Shadow depth
      ),
    );
  }
}