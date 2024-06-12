import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/forget-password-view-model.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgetPasswordViewModel(),
      child: const ForgetPasswordContent(),
    );
  }
}

class ForgetPasswordContent extends StatelessWidget {
  const ForgetPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ForgetPasswordViewModel>(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'نسيت كلمة السر',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontFamily: 'Encode Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'يرجى إدخال بريدك الإلكتروني وسنرسل لك رابطًا لإعادة ضبط كلمة المرور',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8C8C8C),
                  fontSize: 15,
                  fontFamily: 'Encode Sans',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.50,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: viewModel.formKey,
                child: TextFormField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    labelText: 'الايميل',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(width: 1),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يرجى إدخال البريد الإلكتروني';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'يرجى إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (viewModel.formKey.currentState!.validate()) {
                    viewModel.resetPassword(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFCB34C),
                  padding: const EdgeInsets.symmetric(horizontal: 86, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'افحص ايميلك ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'ألم تتلق البريد الإلكتروني ؟',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Encode Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (viewModel.formKey.currentState!.validate()) {
                    viewModel.resetPassword(context);
                  }
                },
                child: const Text(
                  'ارسل مجددا',
                  style: TextStyle(
                    color: Color(0xFFA8DF83),
                    fontSize: 15,
                    fontFamily: 'Encode Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}