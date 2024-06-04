import 'package:app/Services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  final String oobCode;

  ResetPassword(this.oobCode);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  validator: (value) {
                    // 6 min
                    if ((value?.length ?? 0) < 6) {
                      return "كلمة المرور يجب أن لا تقل عن ست حروف";
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
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16))
                            ]),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.preview),
                        onPressed: () {
                          setState(() {
                            // _password = "";
                          });
                        },
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    // matched
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "كلمة المرور غير متطابقة";
                    }
                    return null;
                  },
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      hintText: "********",
                      label: RichText(
                        text: TextSpan(
                            text: "تأكيد كلمة المرور",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16))
                            ]),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.preview),
                        onPressed: () {
                          setState(() {
                            // _password = "";
                          });
                        },
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    // Navigator.pushReplacementNamed(context, '/onboarding1');
                    if (!(_formKey.currentState?.validate() ?? true)) {
                      return;
                    }

                      if (await UserServices.resetPassword(
                        _passwordController.text,
                        widget.oobCode,
                      )) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("تم إعادة تعيين كلمة المرور"),
                        ));
                        Navigator.pushReplacementNamed(context, '/onboarding1');
                      }
                      ;

                  },
                  child: Text('حفظ',
                      style: GoogleFonts.ibmPlexSansArabic(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
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
