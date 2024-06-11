import 'package:flutter/foundation.dart';

class OrderModel {
  final bool status;
  final String image;
  final String email;
  final String mealName;
  final double price;

  OrderModel({
    required this.status,
    required this.image,
    required this.email,
    required this.mealName,
    required this.price,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print(json);
    }
    return OrderModel(
      mealName: json['mealName']?.toString() ?? "",
      price: double.tryParse(json['price']?.toString() ?? "0") ?? 0.0,
      image: json['image']?.toString() ?? "",
      email: json['email']?.toString() ?? "",
      status: json['status'] ?? false,
    );
  }
}
