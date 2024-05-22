class OrderModel {
  // final String id;
  final bool status;
  final String image;
  final String email;
  final String mealName;
  final double price;

  OrderModel({
    // required this.id,
    required this.status,
    required this.image,
    required this.email,
    required this.mealName,
    required this.price,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return OrderModel(
      // id: json['_id']?.toString() ?? "", // Adjust this based on your actual ID field
      mealName: json['mealName']?.toString() ?? "", //optional chaining
      // description: json['description']?.toString()?? "",
      price: double.tryParse(json['price']?.toString() ?? "0") ?? 0.0,
      image: json['image']?.toString() ?? "",
      email: json['email']?.toString() ?? "",
      status: json['status'] ?? false,
    );
  }
}
