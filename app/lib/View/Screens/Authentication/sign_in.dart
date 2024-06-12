import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ViewModel/sign_in_view_model.dart';
import '../../../colors.dart';
import '../../Widgets/back_button.dart';
import 'forget_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInScreenController controller = SignInScreenController();

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
              context.go('/onboarding2'); // Adjust this route as necessary
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'تسجيل دخول',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/SignUpImage.png',
                height: 124,
                width: 183,
              ),
              _SignInForm(
                controller: controller,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'نسيت كلمة السر؟',
                        style: TextStyle(color: AppColors.primary2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 5),
                child: OutlinedButton(
                  onPressed: () async {
                    await controller.signIn(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textColor2,
                    minimumSize: const Size(301, 55),
                    backgroundColor:  AppColors.primary1,
                    side: const BorderSide(color:  AppColors.primary1),
                  ),
                  child: controller.loading
                      ? const CircularProgressIndicator()
                      : const Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontSize: 16, // حجم الخط
                    ),
                  ),
                ),
              ),
              const AskUserToLoginButton()
            ],
          ),
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
          const Text('هل تمتلك حساب ؟'),
          TextButton(
            onPressed: () {
              context.go("/sign-up");
            },
            child: const Text(
              'إنشاء حساب',
              style: TextStyle(
                color:  AppColors.primary2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({required this.controller});
  final SignInScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const SizedBox(height: 25),
          _FormField(
            icon: Icons.email,
            controller: controller.email,
            label: 'البريد الإلكتروني',
            validator: controller.emailValidator,
            hint: 'ادخل بريدك الإلكتروني',
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
          const SizedBox(height: 10),
        ],
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
    Widget? iconWidget = icon == null ? null : Icon(icon!);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: minHeight),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: iconWidget,
            hintText: hint,
            labelText: label,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: AppColors.secondary3),
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
        icon: Icon(show ? Icons.visibility_off : Icons.visibility));
  }
}
