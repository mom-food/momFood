import 'dart:developer';

import 'package:app/Model/user/user_model.dart';
import 'package:app/Services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/phone_auth/phone_auth_cubit.dart';



class SignUpScreenController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationId;
  String? _errorMessage;
  bool _isVerificationCompleted = false;
  String? get verificationId => _verificationId;
  String? get errorMessage => _errorMessage;
  bool get isVerificationCompleted => _isVerificationCompleted;
  SignUpScreenController()
      : email = TextEditingController(),
        name = TextEditingController(),
        password = TextEditingController(),
        repeatPassword = TextEditingController(),
        phone = TextEditingController(),
        formKey = GlobalKey<FormState>();

  bool loading = false;
  bool showPassword = false;
  GlobalKey<FormState> formKey;
  TextEditingController email;
  TextEditingController name;
  TextEditingController phone;
  TextEditingController password;
  TextEditingController repeatPassword;


  Future<void> createAccount(BuildContext context) async {
    if(loading){
      return;
    }
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _updateStateLoading = true;
    final request = CreateUserRequestBody(
        email: email.text,
        name: name.text,
        password: password.text,
        phone: phone.text);
    bool isSignedUp = await UserServices().signUp(request);
    log('isSignedUp: $isSignedUp');
    if (isSignedUp) {
      log("register started");

      // تسجيل الدخول بعد التسجيل
      bool isSignedIn = await UserServices().signIn(email.text, password.text);
      if (isSignedIn && UserServices.isSignedIn()) {
        await context.read<PhoneAuthCubit>().submitPhoneNumber(phone.text);
        context.go("/otp");
        log("register finished");
      } else {
        log("SignIn failed after SignUp");
        // يمكنك إضافة معالجة الأخطاء هنا إذا كان تسجيل الدخول بعد التسجيل فشل
      }
    } else {
      log("SignUp failed");
      // يمكنك إضافة معالجة الأخطاء هنا إذا كان التسجيل فشل
    }
    _updateStateLoading = false;
    //todo handle sign up result
  }

  set _updateStateLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  String? emailValidator(String? value) {
    value ??= '';
    String? lastCheckedEmail;
    if (value.isEmpty) {
      return 'يرجى ادخال ايميلك';
    }
    if (!value.contains('@')) {
      return 'يرجى ادخال ايميل صحيح';
    }
    if (!value.contains('.com')) {
      return 'يرجى ادخال ايميل صحيح';
    }
    if (lastCheckedEmail == value) {
      return 'هذا البريد الإلكتروني تم استخدامه بالفعل';
    }
    return null;
  }

  String? nameValidation(String? value){
    value ??= '';
    if(value.isEmpty){
      return 'يرجى ادخال الاسم';
    }
    if (!RegExp(r'^[ء-ي ]+$').hasMatch(value)) {
      return 'الرجاء إدخال الاسم بالحروف العربية فقط';
    }
    return null;
  }

  String? phoneValidation(String? value){
    value ??= '';
    if(value.isEmpty){
      return 'يرجى ادخال رقم الهاتف';
    }
    if(value.length<10){
      return 'يرجى ادخال رقم الهاتف بشكل صحيح';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'يرجى ادخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور تقل عن 8 ارقام';
    }
    if (!value.contains(RegExp(r'[0-9]')) || !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'يجب أن تحتوي كلمة المرور على أرقام ورموز وحروف عربية';
    }
    return null;
  }

  String? repeatedPasswordValidator(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'يرجى ادخال كلمة المرور';
    }
    if(password.text != repeatPassword.text){
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }
  void showHidePassword(){
    showPassword =! showPassword;
    notifyListeners();
  }
  Future<void> phoneAuthentication(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        _isVerificationCompleted = true;
        notifyListeners();
      },
      verificationFailed: (FirebaseAuthException e) {
        _errorMessage = 'حدث خطأ أثناء التحقق: ${e.message}';
        notifyListeners();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        notifyListeners();
      },
    );
  }

  void reset() {
    _verificationId = null;
    _errorMessage = null;
    _isVerificationCompleted = false;
    notifyListeners();
  }

  // Function to handle phone number input and send OTP
  Future<void> sendOTP(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure (show error message)
          if (kDebugMode) {
            print(e.message);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          String enteredOTP; // Store user-entered OTP here
          // Display a dialog or UI element to prompt user to enter the OTP
          // Once the user enters the OTP, call verifyOTP function with enteredOTP and verificationId
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle auto-retrieval timeout (inform user to enter code manually)
        },
      );
    } catch (e) {
      print(e.toString()); // Handle other exceptions
    }
  }

// Function to verify the entered OTP
  Future<void> verifyOTP(String enteredOTP, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: enteredOTP);
      await auth.signInWithCredential(credential);
      // Handle successful sign-in (navigate to home screen etc.)
    } catch (e) {
      print(e.toString()); // Handle verification failure (show error message)
    }
  }
}
