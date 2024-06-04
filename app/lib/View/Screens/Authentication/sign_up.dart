import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ViewModel/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpScreenController controller = SignUpScreenController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(
              'انشاء حساب',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/SignUpImage.png',
              height: 124,
              width: 183,
            ),
            _SignUpForm(
              controller: controller,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 5),
              child: OutlinedButton(
                onPressed: () {
                  controller.createAccount(context);
                },
                child: controller.loading
                    ? CircularProgressIndicator()
                    : Text(
                  'انشاء حساب',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(301, 55),
                  backgroundColor: Color(0xFFF6BD60),
                  side: BorderSide(color: Color(0xFFF6BD60)),
                ),
              ),
            ),
            AskUserToLoginButton()
          ],
        ));
  }
}

class AskUserToLoginButton extends StatelessWidget {
  const AskUserToLoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.go("/signIn");
            },
            child: Text(
              'تسجيل دخول',
              style: TextStyle(
                color: Color(0xFFA8DF83),
              ),
            ),
          ),
          Text('هل لديك حساب بالفعل؟'),
        ],
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({required this.controller});
  final SignUpScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: controller.formKey,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                _FormField(
                  icon: Icons.email,
                  controller: controller.email,
                  label: 'الإيميل',
                  //icon: Icons.email,
                  validator: controller.emailValidator,
                  hint: 'ادخل ايميلك',
                  minHeight: 48,
                  width: 360,
                ),
                SizedBox(height: 15),
                _FormField(
                  icon: Icons.person,
                  controller: controller.name,
                  validator: controller.nameValidation,
                  label: 'الاسم',
                  hint: 'ادخل اسمك',
                  minHeight: 48,
                  width: 360,
                  // icon: Icons.person,
                ),
                SizedBox(height: 15),
                _FormField(
                  icon: Icons.phone,
                  controller: controller.phone,
                  validator: controller.phoneValidation,
                  label: 'الهاتف',
                  hint: 'ادخل رقمك',
                  minHeight: 48,
                  width: 360,
                  //icon: Icons.phone,
                ),
                SizedBox(height: 15),
                _FormField(
                  controller: controller.password,
                  label: 'كلمة المرور',
                  hint: 'ادخل كلمة المرور',
                  minHeight: 48,
                  width: 360,
                  icon: Icons.lock,
                  validator: controller.passwordValidator,
                  isObscure: !controller.showPassword,
                  suffixIcon: ShowPasswordButton(
                    show: controller.showPassword,
                    onTap: controller.showHidePassword,
                  ),
                ),
                SizedBox(height: 15),
                _FormField(
                  controller: controller.repeatPassword,
                  label: 'اعادة كلمة المرور',
                  hint: 'تاكيد كلمة المرور',
                  minHeight: 48,
                  width: 360,
                  icon: Icons.lock,
                  isObscure: !controller.showPassword,
                  suffixIcon: ShowPasswordButton(
                    show: controller.showPassword,
                    onTap: controller.showHidePassword,
                  ),
                  validator: controller.repeatedPasswordValidator,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    this.controller,
    this.icon,
    this.validator,
    this.isObscure = false,
    this.hint,
    this.label,
    this.suffixIcon,
    this.width,
    required this.minHeight,
  });
  final TextEditingController? controller;
  final IconData? icon;
  final FormFieldValidator<String?>? validator;
  final bool isObscure;
  final String? hint;
  final String? label;
  final Widget? suffixIcon;
  final double? width;
  final double minHeight;
  @override
  Widget build(BuildContext context) {
    Widget? icon = this.icon == null ? null : Icon(this.icon!);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: minHeight),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint,
            labelText: label,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          obscureText: isObscure,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}

class ShowPasswordButton extends StatelessWidget {
  const ShowPasswordButton({this.onTap, required this.show});
  final VoidCallback? onTap;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(show ? Icons.visibility_off : Icons.visibility));
  }
}
