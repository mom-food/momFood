import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/meal-model.dart';

class MealViewModel extends ChangeNotifier {
  List<Meal> meals = [];

  Future<void> search(String query) async {
    final response = await http.get(Uri.parse('http://192.168.0.194:3000/api/meals?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      meals = mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
      notifyListeners(); // Notify listeners after data is fetched
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  Future<void> fetchMeals() async {
    final response = await http.get(Uri.parse('http://192.168.0.194:3000/api/meals'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      meals = mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
      notifyListeners(); // Notify listeners after data is fetched
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
}
