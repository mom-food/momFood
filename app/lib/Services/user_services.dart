import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:app/Model/order_model.dart';
import 'package:app/Model/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static CreateUserRequestBody? userData = CreateUserRequestBody(
    email: "",
    name: "",
    password: "",
    phone: "",
    orderHistory: [],
  );
  //
  Future<bool> signUp(CreateUserRequestBody request) async {
    try {
      bool isSignedUp = false;
      FirebaseAuth instance = FirebaseAuth.instance;
      final userCredential = await instance.createUserWithEmailAndPassword(
              email: request.email!, password: request.password!)
              .then(
            (value) async {
              log('user is ${value.user!.uid}');
              // --------- Save in FireStore
              // var db = FirebaseFirestore.instance;
              // await db.collection(FbCollections.users).add(request.toJson());
              // --------- Save in MongoDB
              final response = await http.post(
                Uri.parse(url),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(request.toJson()),
              );
              log('response ${response.body}');
              if (response.statusCode >= 200 && response.statusCode < 300) {
                isSignedUp = true;
              }
            },
          )
          ;
      final user = instance.currentUser;
      log('user is " ${user?.uid}');
      return user?.uid != null;
      //   return isSignedUp;
=======
      print(request.email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance
          .createUserWithEmailAndPassword(
              email: request.email!, password: request.password!)
          .then(
        (value) async {
          var db = FirebaseFirestore.instance;
          await db.collection(FbCollections.users).add(request.toJson());
        },
      );
      return true;
>>>>>>> origin/password1
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      print(email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) async {
          print("value::::::::::::: $value");
          var querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            print("aaaaaaaaaaa:: ${querySnapshot.docs.first['email']}");
            //
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
        },
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> resetPassword(String password, String oobCode) async {
    try {
      FirebaseAuth instance = FirebaseAuth.instance;

      try {
        print(
            "Trying out of band code that's $oobCode, setting the password to $password");
        await instance.confirmPasswordReset(
            code: oobCode, newPassword: password);
      } catch (e) {
        print("Couldn't reset password, error: $e");
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
