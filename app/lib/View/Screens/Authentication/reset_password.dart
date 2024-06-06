import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/Services/user_services.dart';

class ResetPassword extends StatefulWidget {
  final String oobCode;

  ResetPassword(this.oobCode);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('استعادة كلمة السر'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'استعادة كلمة السر',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSansArabic(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 80),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if ((value?.length ?? 0) < 8) {
                      return "كلمة المرور يجب أن لا تقل عن ثمانية حروف";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "********",
                    label: RichText(
                      text: TextSpan(
                        text: "كلمة المرور",
                        style: TextStyle(
                          color: Colors.black,
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
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (_passwordController.text != value) {
                      return "كلمة المرور غير متطابقة";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "********",
                    label: RichText(
                      text: TextSpan(
                        text: "تأكيد كلمة المرور",
                        style: TextStyle(
                          color: Colors.black,
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
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 40),
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("تم إعادة تعيين كلمة المرور بنجاح"),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.pushReplacementNamed(context, '/sign-in');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("فشل في إعادة تعيين كلمة المرور"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text(
                    'حفظ',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFCB34C),
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
