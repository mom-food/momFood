import 'package:app/Services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    if (res && UserServices.isSignedIn()) {
      context.go("/");
    } else {
      // Display notification for incorrect email or password
      if (res) {
        // If email is correct but password is wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('كلمة المرور غير صحيحة'),
          ),
        );
      } else {
        // If email is incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تأكد من البريد او كلمة السر !"),
          ),
        );
      }
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
