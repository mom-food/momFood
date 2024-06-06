import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ViewModel/sign_in_view_model.dart';
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
              Text(
                'تسجيل دخول',
                style: TextStyle(fontSize: 32),
              ),
              SizedBox(height: 20),
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
                          MaterialPageRoute(builder: (context) => ForgetPassword()),
                        );
                      },
                      child: Text(
                        'نسيت كلمة السر؟',
                        style: TextStyle(color: Colors.green),
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 5), // الهامش العلوي للزر فقط
                child: OutlinedButton(
                  onPressed: () {
                    controller.signIn(context);
                  },
                  child: controller.loading
                      ? CircularProgressIndicator()
                      : Text(
                    'تسجيل دخول',
                    style: TextStyle(
                      fontSize: 16, // حجم الخط
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
          TextButton(
            onPressed: () {
              context.go("/sign-up");
              // Navigator.pushReplacementNamed(context, '/sign-up');
            },
            child: Text(
              'هل تمتلك حساب ؟',
              style: TextStyle(
                color: Color(0xFFA8DF83),
              ),
            ),
          ),
          Text('إنشاء حساب'),
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
          SizedBox(height: 25),
          _FormField(
            icon: Icons.email,
            controller: controller.email,
            label: 'البريد الالكنروني',
            //icon: Icons.email,
            validator: controller.emailValidator,
            hint: 'ادخل بريدك الالكتروني',
            minHeight: 48,
            width: 360,
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
          SizedBox(height: 10),
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
          textAlign: TextAlign.right, // تعيين محاذاة النص على اليمين
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
