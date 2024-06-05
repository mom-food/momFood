import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../ViewModel/phone_auth_secive.dart';


class OtpScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
          create: (context) => PhoneAuthService(),
          child: Consumer<PhoneAuthService>(
            builder: (context, phoneAuthProvider, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 88),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
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
                      const Center(
                        child: Text(
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
                      const Center(
                        child: Text(
                          ' سوف تحصل على OTP عبر رسائل SMS',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'FontMAIN',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      //buildIntroTexts(phoneNumber: phoneNumber),
                      const SizedBox(
                        height: 88,
                      ),
                      buildPinCodeFields(context, phoneAuthProvider),
                      const SizedBox(
                        height: 60,
                      ),
                      buildVerifyButton(context, phoneAuthProvider),
                      buildPhoneVerificationBloc(context, phoneAuthProvider),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/*Widget buildIntroTexts({required phoneNumber}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: RichText(
          text: TextSpan(
            text: 'Enter your 6 digit code numbers sent to ',
            style:
            const TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
            children: <TextSpan>[
              TextSpan(
                text: '$phoneNumber',
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}*/

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

Widget buildPinCodeFields(BuildContext context, PhoneAuthService phoneAuthProvider) {
  return PinCodeTextField(
    appContext: context,
    autoFocus: true,
    cursorColor: Colors.black,
    keyboardType: TextInputType.number,
    length: 6,
    obscureText: false,
    animationType: AnimationType.scale,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      borderWidth: 1,
      activeColor: const Color(0xffFF9500),
      inactiveColor: AppColors.textColor1,
      inactiveFillColor: Colors.white,
      activeFillColor: const Color(0xffFF9500),
      selectedColor: AppColors.primary1,
      selectedFillColor: Colors.white,
    ),
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: Colors.white,
    enableActiveFill: true,
    onCompleted: (submitedCode)  {
      //bool iscorrect= await  context.read<PhoneAuthCubit>().submitOTP(submitedCode);
      //if(iscorrect){
     // phoneAuthProvider.otpCode = submitedCode;
      context.go('/SuccessDialog');
      //}
    },
    onChanged: (value) {},
  );
}

Widget buildVerifyButton(BuildContext context, PhoneAuthService phoneAuthProvider) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: () {
        showProgressIndicator(context);

        phoneAuthProvider.submitOTP(phoneAuthProvider.otpCode);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(110, 50),
        backgroundColor: const Color(0xffFF9500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'تحقق',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget buildPhoneVerificationBloc(BuildContext context, PhoneAuthService phoneAuthProvider) {
  // Replace with Provider-specific logic if needed
  // Example: use phoneAuthProvider to manage state and display messages
  return Container();
}
