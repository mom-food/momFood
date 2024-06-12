import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ViewModel/sign_up_view_model.dart';
import '../../../colors.dart';
import '../../Widgets/Button/back_button.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(
            onPressed: () {
              context.go('/onboarding2');
            },
          ),
        ),
        body: Column(
          children: [
            const Text(
              'انشاء حساب',
              style:
                  TextStyle(fontFamily: 'Manrope_SemiBold.ttf', fontSize: 32),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/SignUpImage.png',
              height: 124,
              width: 183,
            ),
            _SignUpForm(
              controller: controller,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 5),
              child: OutlinedButton(
                onPressed: () {
                  controller.createAccount(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFFFFF),
                  minimumSize: const Size(301, 55),
                  backgroundColor: AppColors.primary1,
                  side: const BorderSide(color: AppColors.primary1),
                ),
                child: controller.loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'انشاء حساب',
                        style: TextStyle(
                          fontFamily: 'Manrope_SemiBold.ttf',
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
            const AskUserToLoginButton()
          ],
        ),
      ),
    );
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
          const Text('هل لديك حساب بالفعل؟',
              style: TextStyle(
                fontFamily: 'Manrope_SemiBold.ttf',
              )),
          TextButton(
            onPressed: () {
              context.go("/signIn");
            },
            child: const Text(
              'تسجيل دخول',
              style: TextStyle(
                color: AppColors.primary2,
                fontFamily: 'Manrope_SemiBold.ttf',
              ),
            ),
          ),
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
              const SizedBox(height: 25),
              _FormField(
                icon: Icons.email,
                controller: controller.email,
                label: 'البريد الالكتروني',
                validator: controller.emailValidator,
                hint: 'ادخل بريدك الالكتروني',
                minHeight: 48,
                width: 360,
              ),
              const SizedBox(height: 15),
              _FormField(
                icon: Icons.person,
                controller: controller.name,
                validator: controller.nameValidation,
                label: 'الاسم',
                hint: 'ادخل اسمك',
                minHeight: 48,
                width: 360,
              ),
              const SizedBox(height: 15),
              _FormField(
                icon: Icons.phone,
                controller: controller.phone,
                validator: controller.phoneValidation,
                label: 'الهاتف',
                hint: 'ادخل رقمك',
                minHeight: 48,
                width: 360,
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
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
              borderSide: const BorderSide(color: AppColors.secondary2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          obscureText: isObscure,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}

class ShowPasswordButton extends StatelessWidget {
  const ShowPasswordButton({super.key, this.onTap, required this.show});
  final VoidCallback? onTap;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(show ? Icons.visibility_off : Icons.visibility),
    );
  }
}
