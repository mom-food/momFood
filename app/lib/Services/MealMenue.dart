import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/MealMenueModel.dart';

import '../Model/MealModel.dart';  // Update the import path according to your project structure.

class MealService {
  final String baseUrl = 'http://localhost:3000/api/meals';

  Future<Meal> fetchMealById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Meal.fromJson(data);  // Make sure the Meal class has a fromJson method.
    } else {
      throw Exception('Failed to load meal details');
    }
  }

// Add other meal-related methods here, such as fetchMealsByCategory, etc.
}