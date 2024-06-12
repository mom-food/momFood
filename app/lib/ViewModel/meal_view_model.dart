import 'dart:convert';
import 'dart:math';
import 'package:app/Services/user_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../Model/meal_model.dart';

class MealViewModel extends ChangeNotifier {
  MealViewModel() {
    refresh();
  }
  List<Meal> meals = [];
  List<({Meal meal, int quantity})> cartItems = [];

  String searchQuery = "";

  Future<void> createNewOrder(BuildContext context, List<({Meal meal, int quantity})> items) async {
    if(UserServices.isSignedIn()) {
      List<Map<String, dynamic>> cartItemsCheckout = [];
      for(var e in items) {
        cartItemsCheckout.add({"id": e.meal.id, "quantity": e.quantity});
      }
      if (kDebugMode) {
        print(cartItemsCheckout);
      }
      const String url = "https://momfood.onrender.com/api/orders";
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": UserServices.userData?.id ?? "",
          "status": false,
          "meals": cartItemsCheckout,
        }),
      );
      if (kDebugMode) {
        print("response.statusCode:: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("response.body:: ${response.body}");
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pop("/successful_checkout");
        });
      }

    } else {
      context.go("/onboarding2");
    }
  }

  void addToCart(Meal meal) {
    if (UserServices.isSignedIn()) {
      cartItems.add((meal: meal, quantity: 1));
    } else {
      if (kDebugMode) {
        print("User is not logged in, cannot add to cart.");
      }
    }
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
        }),
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
        }),
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
        }),
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
        }),
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
    await http.get(Uri.parse('https://momfood.onrender.com/api/meals?query='));
    if (response.statusCode == 200) {
      List<dynamic> mealsData = json.decode(response.body);
      List<Meal> fetchedMeals = [];
      for (var mealJson in mealsData) {
        try {
          fetchedMeals.add(Meal.fromJson(mealJson));
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing meal json: $e');
          }
        }
      }
      if (kDebugMode) {
        print("Fetched meals: $fetchedMeals");
      }
      meals = fetchedMeals;
      notifyListeners();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  Future<void> search(String query) async {
    searchQuery = query;
    notifyListeners();
  }
  List<Order> _orderHistory = [];

  List<Order> get orderHistory => _orderHistory;

  void addOrder(double totalPrice, List<({Meal meal, int quantity})> items) {
    _orderHistory.add(Order(totalPrice: totalPrice, items: items));
    notifyListeners();
  }
}

class Order {
  final double totalPrice;
  final List<({Meal meal, int quantity})> items;

  Order({required this.totalPrice, required this.items});
}

