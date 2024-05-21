import '../../Model/mealDetailsModel.dart';

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

