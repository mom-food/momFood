class CreateUserRequestBody{
  final String? email;
  final String? name;
  final String? phone;
  final String? password;
  CreateUserRequestBody({required this.email, required this.name, required this.password, required this.phone});

  Map<String,dynamic> toJson()=>{
    'email' :email,
    'name' : name,
    'phone' :phone,
    'password' :password,
  };
}