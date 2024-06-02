/*
import 'package:app/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/OTP_input_fields.dart';

class OTPBuiltinKeyboard extends StatefulWidget {
  const OTPBuiltinKeyboard({super.key});

  @override
  State<OTPBuiltinKeyboard> createState() => _OTPBuiltinKeyboardState();
}

class _OTPBuiltinKeyboardState extends State<OTPBuiltinKeyboard> {
  String field1 = '';
  String field2 = '';
  String field3 = '';
  String field4 = '';


  void resetFieldOnExit() {
    field1 = '';
    field2 = '';
    field3 = '';
    field4 = '';
    setState(() {});
  }

  Widget buildNumberButton(String text) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () => setState(
              () {
            if (field1.isEmpty) {
              field1 = text;
            } else if (field2.isEmpty) {
              field2 = text;
            } else if (field3.isEmpty) {
              field3 = text;
            } else if (field4.isEmpty) {
              field4 = text;
            }
          },
        ),
        icon: Text(
          text,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    ),
  );

  Widget buildClearButton() => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () => setState(
              () {
            if (field4.isNotEmpty) {
              field4 = '';
            } else if (field3.isNotEmpty) {
              field3 = '';
            } else if (field2.isNotEmpty) {
              field2 = '';
            } else if (field1.isNotEmpty) {
              field1 = '';
            }
          },
        ),
        icon: const Icon(
          Icons.backspace_outlined,
          size: 30,
          color: Colors.black,
        ),
      ),
    ),
  );

  Widget submitButton() => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          final String pin = field1 + field2 + field3 + field4;
          if (pin.length == 4) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'your pin is confirm $pin',
                ),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.check,
          size: 30,
          color: Colors.black,
        ),
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Center(
              child: Image.asset(
                'assets/images/otp.png',
                height: 124,
                width: 183,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: const Text(
                'التحقق',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'FontMAIN',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: const Text(
                ' سوف تحصل على OTP عبر رسائل SMS',
                style: TextStyle(
                  color: AppColors.textColor1,
                  fontSize: 15,
                  fontFamily: 'FontMAIN',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(value: field1),
                OtpInput(value: field2),
                OtpInput(value: field3),
                OtpInput(value: field4),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                buildNumberButton('1'),
                buildNumberButton('2'),
                buildNumberButton('3')
              ],
            ),
            Row(
              children: [
                buildNumberButton('4'),
                buildNumberButton('5'),
                buildNumberButton('6')
              ],
            ),
            Row(
              children: [
                buildNumberButton('7'),
                buildNumberButton('8'),
                buildNumberButton('9')
              ],
            ),
            Row(
              children: [
                submitButton(),
                buildNumberButton('0'),
                buildClearButton()
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}*/
