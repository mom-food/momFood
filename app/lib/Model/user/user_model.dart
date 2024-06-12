import 'package:app/Model/order_model.dart';

class CreateUserRequestBody{
  String? id;
  String? email;
  String? name;
  String? phone;
  String? password;
  List<OrderModel>? orderHistory;
  CreateUserRequestBody( {this.id, required this.email, required this.name, required this.password, required this.phone,this.orderHistory=const []});

  Map<String,dynamic> toJson()=>{
    'email' :email,
    'name' : name,
    'phone' :phone,
    'password' :password,
    'orderHistory' :orderHistory,
  };
}