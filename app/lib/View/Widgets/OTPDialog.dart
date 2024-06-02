import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTPDialog extends StatefulWidget {
  final String verificationId;

  OTPDialog({required this.verificationId});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter OTP'),
      content: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter OTP',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_otpController.text);
          },
          child: Text('Verify'),
        ),
      ],
    );
  }
}
