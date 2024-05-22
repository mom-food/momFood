import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import '../Model/meal_model.dart';

class MealViewModel extends ChangeNotifier {
  List<Meal> meals = [];
  List<({Meal meal, int quantity})> cartItems = [];

  String searchQuery = "";

  void addToCart(Meal meal) {
    cartItems.add((meal: meal, quantity: 1));
    notifyListeners();
  }

  void increaseQuantity(Meal meal) {
    var item = cartItems.firstWhereOrNull((m) {
      return m.meal.id == meal.id;
    });
    if (item != null) {
      cartItems = [
        ...cartItems.where((m) {
          return m.meal.id != meal.id;
        }).toList(),
        (
          meal: meal,
          quantity: item.quantity + 1,
        ),
      ];
    } else {
      cartItems = [
        ...cartItems,
        (
          meal: meal,
          quantity: 1,
        ),
      ];
    }
    notifyListeners();
  }

  void removeFromCart(Meal meal) {
    var item = cartItems.firstWhereOrNull((m) {
      return m.meal.id == meal.id;
    });
    if (item != null) {
      cartItems = [
        ...cartItems.where((m) {
          return m.meal.id != meal.id;
        }).toList(),
      ];
    }
    notifyListeners();
  }

  void removeAllCartItems() {
    cartItems = [];
    notifyListeners();
  }

  void setQuantity(Meal meal, int quantity) {
    var item = cartItems.firstWhereOrNull((m) {
      return m.meal.id == meal.id;
    });
    if (item != null) {
      cartItems = [
        ...cartItems.where((m) {
          return m.meal.id != meal.id;
        }).toList(),
        (
          meal: meal,
          quantity: quantity,
        ),
      ];
    } else {
      cartItems = [
        ...cartItems,
        (
          meal: meal,
          quantity: quantity,
        ),
      ];
    }

    notifyListeners();
  }

  void decreaseQuantity(Meal meal) {
    var item = cartItems.firstWhereOrNull((m) {
      return m.meal.id == meal.id;
    });
    if (item != null) {
      cartItems = [
        ...cartItems.where((m) {
          return m.meal.id != meal.id;
        }).toList(),
        (
          meal: meal,
          quantity: max(0, item.quantity - 1),
        ),
      ];
    }
    notifyListeners();
  }

  List<Meal> getFilteredMeals() {
    if (searchQuery.isEmpty) {
      return meals;
    } else {
      return meals.where((meal) {
        return meal.name.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
  }

  Future<void> refresh() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/meals?query='));
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
      print("Fetched meals: $fetchedMeals");
      meals = fetchedMeals;
      notifyListeners(); // Notify listeners after data is fetched
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  Future<void> search(String query) async {
    searchQuery = query;
    notifyListeners();
  }
}
