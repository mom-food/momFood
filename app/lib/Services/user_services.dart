import 'package:app/Model/user/user_model.dart';
import 'package:app/constants/fb_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  Future<bool> signUp(CreateUserRequestBody request) async {
    try{
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
    }catch(e){
      print(e);
    }
    return true;
  }
}
