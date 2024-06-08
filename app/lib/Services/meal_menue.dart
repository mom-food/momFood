import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/meal_model.dart';

class MealService {
  final String baseUrl = 'https://momfood.onrender.com:3000/api/meals';

  Future<Meal> fetchMealById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Meal.fromJson(data);
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}