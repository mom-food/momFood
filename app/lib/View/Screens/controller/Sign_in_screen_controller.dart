import 'package:app/Model/user/user_model.dart';
import 'package:app/Services/user_services.dart';
import 'package:app/View/Widgets/home-tab.dart';
import 'package:app/View/Widgets/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../History.dart';
import '../OnBoarding1.dart';

class SignInScreenController extends ChangeNotifier {
  SignInScreenController()
      : email = TextEditingController(),
        password = TextEditingController(),
        formKey = GlobalKey<FormState>();

  bool loading = false;
  bool showPassword = false;
  GlobalKey<FormState> formKey;
  TextEditingController email;
  TextEditingController password;

  Future<void> signIn(BuildContext context) async {
    if (loading) {
      return;
    }
    bool isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _updateStateLoading = true;
    bool res = await UserServices().signIn(email.text, password.text);
    if (res) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Onboarding1(),
        ),
      );
    }
    _updateStateLoading = false;
    //
    print("Emaill:: ${UserServices.userData?.email}");
    notifyListeners();
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

  String? passwordValidator(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return 'يرجى ادخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور تقل عن 8 ارقام';
    }
    if (!value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'يجب أن تحتوي كلمة المرور على أرقام ورموز وحروف عربية';
    }
    return null;
  }

  void showHidePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
