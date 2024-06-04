import 'package:app/Model/user/user_model.dart';
import 'package:app/Services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SignUpScreenController extends ChangeNotifier {
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
    bool res = await UserServices().signUp(request);
    if(res) {
      bool res = await UserServices().signIn(email.text, password.text);
      if(res && UserServices.isSignedIn()) {
        context.go('/');
      }
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
    if (!value.contains(RegExp(r'[0-9]')) || !value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
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

}
