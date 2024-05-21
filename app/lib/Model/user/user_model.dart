class CreateUserRequestBody{
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  final List? orderHistory;
  CreateUserRequestBody( {required this.email, required this.name, required this.password, required this.phone,this.orderHistory=const []});

  Map<String,dynamic> toJson()=>{
    'email' :email,
    'name' : name,
    'phone' :phone,
    'password' :password,
    'orderHistory' :orderHistory,
  };
}