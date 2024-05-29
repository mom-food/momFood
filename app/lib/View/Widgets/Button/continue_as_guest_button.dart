import 'package:flutter/material.dart';

class ContinueAsGuestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueAsGuestButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('تصفح كضيف',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          )),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, // Ripple color (on button press)
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        elevation: 5, // Shadow depth
      ),
    );
  }
}

