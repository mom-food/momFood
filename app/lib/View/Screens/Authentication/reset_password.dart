import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/Services/user_services.dart';
import 'package:go_router/go_router.dart';
import '../../../colors.dart';

class ResetPassword extends StatefulWidget {
  final String oobCode;

  const ResetPassword(this.oobCode, {super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استعادة كلمة السر'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'استعادة كلمة السر',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.encodeSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor1,
                  ),
                ),
                const SizedBox(height: 80),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  validator: (value) {
                    if ((value?.length ?? 0) < 8) {
                      return "كلمة المرور يجب أن لا تقل عن ثمانية حروف";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "********",
                    label: RichText(
                      text: const TextSpan(
                        text: "كلمة المرور",
                        style: TextStyle(
                          color: AppColors.textColor1,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_showConfirmPassword,
                  validator: (value) {
                    if (_passwordController.text != value) {
                      return "كلمة المرور غير متطابقة";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "********",
                    label: RichText(
                      text: const TextSpan(
                        text: "تأكيد كلمة المرور",
                        style: TextStyle(
                          color: AppColors.textColor1,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    final resetSuccess = await UserServices.resetPassword(
                      _passwordController.text,
                      widget.oobCode,
                    );

                    if (resetSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("تم إعادة تعيين كلمة المرور بنجاح"),
                        backgroundColor: Colors.green,
                      ));
                      context.go('/signIn');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("فشل في إعادة تعيين كلمة المرور"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textColor2,
                    backgroundColor: AppColors.primary1,
                  ),
                  child: Text(
                    'حفظ',
                    style: GoogleFonts.encodeSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
