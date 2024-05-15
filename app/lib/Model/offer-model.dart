import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Meal {
  final String name;
  final double price;
  final String category;
  final String imagePath;

  Meal({
    required this.name,
    required this.price,
    required this.category,
    required this.imagePath,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    print("Trying to parse json");
    print("Object I received: $json");
    // print("Price after parsing: ${double.tryParse(json['price'].toString() ?? "0")}");
    print("DONE");

    return Meal(
      name: json['name'] ?? "Unnamed",
      price: double.tryParse(json['price'].toString() ?? "0") ?? 0,
      category: json['category'] ?? "Unknown",
      imagePath: json['image'],
    );
  }
}
