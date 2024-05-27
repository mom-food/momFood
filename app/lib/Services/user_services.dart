import 'dart:async';
import 'dart:convert';

import 'package:app/Model/order_model.dart';
import 'package:app/Model/user/user_model.dart';
import 'package:app/constants/fb_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      print(request.email);
      FirebaseAuth instance = FirebaseAuth.instance;
      await instance
          .createUserWithEmailAndPassword(
          email: request.email!, password: request.password!)
          .then(
            (value) async {
          // --------- Save in FireStore
          // var db = FirebaseFirestore.instance;
          // await db.collection(FbCollections.users).add(request.toJson());
          // --------- Save in MongoDB
          final response = await http.post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(request.toJson()),
          );
          if (response.statusCode >= 200 && response.statusCode < 300) {
            isSignedUp = true;
          }
        },
      );
      return isSignedUp;
    } catch (e) {
      print(e);
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
            for(var el in querySnapshot.docs.first['orderHistory'] ?? []) {
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
