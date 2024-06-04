import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/meal-model.dart';

class MealViewModel extends ChangeNotifier {
  List<Meal> meals = [];

  Future<void> search(String query) async {
    print('Searching for $query');
    final response = await http.get(Uri.parse('http://localhost:3000/api/meals?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      List<Meal> fetchedMeals = [];
      for (var mealJson in mealsData) {
        try {
          fetchedMeals.add(Meal.fromJson(mealJson));
        } catch (e) {
          print('Error parsing meal json: $e');
        }
      }
      print(fetchedMeals);
      meals = fetchedMeals;
      notifyListeners(); // Notify listeners after data is fetched
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
}
