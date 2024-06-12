import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:AppColors.primary1,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        minimumSize: const Size(136, 42),
        elevation: 5, // Shadow depth
      ),
      child: const Text('دخول' , style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}