import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/offer-model.dart';

class MealViewModel extends ChangeNotifier {
  List<Meal> meals = [];

  Future<void> search(String query) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/meals?query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      print("FETCHING MEALS");
      meals = mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
      print(meals.length);
      print("THOSE ARE THE MEALS");
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
  Future<void> fetchMeals() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/meals'));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      meals = mealsData.map((mealJson) => Meal.fromJson(mealJson)).toList();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }
}
