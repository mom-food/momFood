import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app/Model/order_model.dart';
import 'package:app/Model/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserServices extends ChangeNotifier {
  final String url = "http://10.0.2.2:3000/api/users/";
  //
  static CreateUserRequestBody? userData = CreateUserRequestBody(
    email: "",
    name: "",
    password: "",
    phone: "",
    orderHistory: [],
  );
  //
  Future<bool> signUp(CreateUserRequestBody request) async {
    await UserServices.signout();
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
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    await UserServices.signout();
    try {
      print(email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) async {
          print("value::::::::::::: $value");
          // var querySnapshot = await FirebaseFirestore.instance
          //     .collection('users')
          //     .where('email', isEqualTo: email)
          //     .get();
          //
          // if (querySnapshot.docs.isNotEmpty) {
          //   print("aaaaaaaaaaa:: ${querySnapshot.docs.first['email']}");
          //   //
          //   userData?.name = querySnapshot.docs.first['name'] ?? "";
          //   userData?.email = querySnapshot.docs.first['email'] ?? "";
          //   userData?.phone = querySnapshot.docs.first['phone'] ?? "";
          //   for (var el in querySnapshot.docs.first['orderHistory'] ?? []) {
          //     userData?.orderHistory!.add(OrderModel.fromJson(el));
          //   }
          //   print("object: ${userData?.orderHistory}");
          //   return true;
          // } else {
          //   return false;
          // }
          return await getUserByEmail(email);
        },
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> forgetPassword(String email) async {
    FirebaseAuth instance = FirebaseAuth.instance;
    await instance.sendPasswordResetEmail(email: email);
  }

  Future<bool> getUserByEmail(String email) async {
    final response = await http.get(
      Uri.parse(url + email),
      headers: {'Content-Type': 'application/json'},
    );
    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonData = jsonDecode(response.body);
      print("response.body: ${response.body}");
      userData?.id = jsonData['_id'] ?? "";
      userData?.name = jsonData['name'] ?? "";
      userData?.email = jsonData['email'] ?? "";
      userData?.phone = jsonData['phone'] ?? "";
      for (var el in jsonData['orderHistory'] ?? []) {
        userData?.orderHistory!.add(OrderModel.fromJson(el));
      }
      return true;
    }
    return false;
  }

  Future<bool> updateUserByEmail() async {
    final response = await http.patch(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData!.toJson()),
    );
    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonData = jsonDecode(response.body);
      print("response.body: ${response.body}");
      userData?.name = jsonData['name'] ?? "";
      userData?.phone = jsonData['phone'] ?? "";
      for (var el in jsonData['orderHistory'] ?? []) {
        userData?.orderHistory!.add(OrderModel.fromJson(el));
      }
      return true;
    }
    return false;
  }

  static bool isSignedIn() {
    print(userData!.email!);
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.email != null &&
        FirebaseAuth.instance.currentUser!.email!.isNotEmpty &&
        userData != null &&
        userData!.email != null &&
        userData!.email!.trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  static signout() async {
    FirebaseAuth instance = FirebaseAuth.instance;
    await instance.signOut();
  }
}
