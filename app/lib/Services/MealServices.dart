import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/meal-model.dart';

Future<List<Meal>> fetchMealsByCategory(String categoryId) async {
  final response = await http.get(Uri.parse('http://localhost:3000/api/meals/$categoryId'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Meal.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}
