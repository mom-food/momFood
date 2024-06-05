import 'package:app/Model/order_model.dart';
import 'package:app/Model/user/user_model.dart';
import 'package:app/constants/fb_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  static CreateUserRequestBody? userData = CreateUserRequestBody(
    email: "",
    name: "",
    password: "",
    phone: "",
    orderHistory: [],
  );

  Future<bool> signUp(CreateUserRequestBody request) async {
    try {
      print(request.email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance.createUserWithEmailAndPassword(
        email: request.email!,
        password: request.password!,
      ).then((value) async {
        var db = FirebaseFirestore.instance;
        await db.collection(FbCollections.users).add(request.toJson());
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      print(email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        print("value::::::::::::: $value");
        var querySnapshot = await FirebaseFirestore.instance
            .collection(FbCollections.users)
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          print("aaaaaaaaaaa:: ${querySnapshot.docs.first['email']}");
          userData?.name = querySnapshot.docs.first['name'] ?? "";
          userData?.email = querySnapshot.docs.first['email'] ?? "";
          userData?.phone = querySnapshot.docs.first['phone'] ?? "";
          for (var el in querySnapshot.docs.first['orderHistory'] ?? []) {
            userData?.orderHistory!.add(OrderModel.fromJson(el));
          }
          print("object: ${userData?.orderHistory}");
          return true;
        } else {
          return false;
        }
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> resetPassword(String password, String oobCode) async {
    try {
      FirebaseAuth instance = FirebaseAuth.instance;
      print("Trying out of band code that's $oobCode, setting the password to $password");
      await instance.confirmPasswordReset(code: oobCode, newPassword: password);
      return true;
    } catch (e) {
      print("Couldn't reset password, error: $e");
      return false;
    }
  }
}
