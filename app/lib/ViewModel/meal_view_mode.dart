// meal_view_model.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/offer-model.dart';

class MealViewModel extends ChangeNotifier {
  // List<dynamic> _meals = [];
  // List<dynamic> get meals => _meals;   throw Exception('Failed to fetch meals');
  Future<List<Meal>> fetchMeals() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/api/meals'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      List<Meal> meals =
          mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
      return meals; // Return the list of meals
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
}
