import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          'إنشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black45,
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: Size.fromHeight(40),
        minimumSize: Size(136, 42),
        elevation: 5,
      ),
    );
  }
}
