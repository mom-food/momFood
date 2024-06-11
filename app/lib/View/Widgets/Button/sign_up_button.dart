import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.textColor1,
        backgroundColor: AppColors.textColor2,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: const Size.fromHeight(40),
        minimumSize: const Size(136, 42),
        elevation: 5,
      ),
      child: const Center(
        child: Text(
          'إنشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
