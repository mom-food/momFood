// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Category {
//   final String name;
//   final String id;
//   final String image;
//   final double price;
//   final double offer;
//
//   const Category({
//     required this.name,
//     required this.id,
//     required this.image,
//     required this.price,
//     required this.offer,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       name: json['name'],
//       id: json['_id'],
//       image: json['image'],
//       price: (json['price'] ?? 0).toDouble(), // Assuming the price is provided
//       offer: (json['offer'] ?? 0).toDouble(), // Assuming the offer is provided
//     );
//   }
// }
//
// class MomFood with ChangeNotifier {
//   String searchQuery = '';
//   List<Category> categories = [];
//
//   void search(String query) {
//     searchQuery = query;
//     getFilteredCategories();
//     notifyListeners();
//   }
//
//   Future<void> getFilteredCategories() async {
//     final params = <String, String>{
//       'search': searchQuery,
//     };
//
//     final fullUrl = Uri.http('localhost:3000', '/api/categories/search', params);
//
//     var response = await http.get(fullUrl);
//
//     if (response.statusCode == 200) {
//       final List<dynamic> responseBody = jsonDecode(response.body);
//       categories = responseBody.map((category) => Category.fromJson(category)).toList();
//       notifyListeners();
//     }
//   }
// }
