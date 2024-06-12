import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthService extends ChangeNotifier {
  late String phoneNumber;
  final GlobalKey<FormState> phoneFormKey = GlobalKey();
  late String verificationId;
  late String otpCode;

  Future<void> register(BuildContext context) async {
    if (!phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      phoneFormKey.currentState!.save();
      submitPhoneNumber(phoneNumber);
    }
  }

  Future<void> submitPhoneNumber(String phoneNumber) async {
    _setLoading(true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+97$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  void _verificationCompleted(PhoneAuthCredential credential) async {
    log('verificationCompleted');
    await _signIn(credential);
  }

  void _verificationFailed(FirebaseAuthException error) {
    log('verificationFailed : ${error.toString()}');
    _setError(error.toString());
  }

  void _codeSent(String verificationId, int? resendToken) {
    log('codeSent');
    this.verificationId = verificationId;
    _setPhoneNumberSubmitted();
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    log('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );

    await _signIn(credential);
  }

  Future<void> _signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      _setOTPVerified();
    } catch (error) {
      _setError(error.toString());
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

  void _setLoading(bool isLoading) {
    // Update the state to loading
    notifyListeners();
  }

  void _setError(String error) {
    // Update the state to error
    notifyListeners();
  }

  void _setPhoneNumberSubmitted() {
    // Update the state to phone number submitted
    notifyListeners();
  }

  void _setOTPVerified() {
    // Update the state to OTP verified
    notifyListeners();
  }
}
