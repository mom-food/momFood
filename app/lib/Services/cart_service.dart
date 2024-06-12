import '../Model/meal_details_model.dart';

class Cart {
  final List<MealDetailsModel> items = [];


  void addItem(MealDetailsModel meal) {
    items.add(meal);
  }

  void removeItem(MealDetailsModel meal) {
    items.remove(meal);
  }
}
final List<MealDetailsModel> cartItems = [];
final List<MealDetailsModel> waiting = [];
final List<MealDetailsModel> done = [];