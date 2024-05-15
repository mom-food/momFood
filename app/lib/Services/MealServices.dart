import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/MealModel.dart';

Future<List<Meal>> fetchMealsByCategory(String categoryId) async {
  print("object");
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/meals/meals/$categoryId'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Meal.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}
