import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class ContinueAsGuestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueAsGuestButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textColor2,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        elevation: 5,
      ),
      child: const Text('تصفح كضيف' , style: TextStyle(fontWeight: FontWeight.bold ,color: AppColors.textColor1,) ),
    );
  }
}