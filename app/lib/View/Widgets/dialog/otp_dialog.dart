import 'package:flutter/material.dart';

class OTPDialog extends StatefulWidget {
  final String verificationId;

  const OTPDialog({super.key, required this.verificationId});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends State<OTPDialog> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter OTP'),
      content: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Enter OTP',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_otpController.text);
          },
          child: const Text('Verify'),
        ),
      ],
    );
  }
}
