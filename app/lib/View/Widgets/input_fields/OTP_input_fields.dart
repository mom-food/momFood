import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class OtpInput extends StatelessWidget {
  final String value;

  const OtpInput({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frameColor = value.isEmpty ? AppColors.textColor1 : AppColors.primary2;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 650),
        height: 60,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: frameColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          value.isEmpty ? '*' : value,
          style: TextStyle(
            fontSize: 24,
            color: value.isEmpty ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}
