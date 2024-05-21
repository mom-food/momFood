import 'package:app/Model/user/user_model.dart';
import 'package:app/constants/fb_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  Future<bool> signUp(CreateUserRequestBody request) async{
    var db = FirebaseFirestore.instance;
    var x =await db.collection(FbCollections.users).add(request.toJson());

    return true;
  }
}