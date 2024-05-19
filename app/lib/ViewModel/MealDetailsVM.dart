import 'package:app/Model/mealDetailsModel.dart';

import '../Services/mealDetailsServices.dart';

class MealDetailsViewModel {
  final MealDetailsServices _services = MealDetailsServices();

  Future<MealDetailsModel> fetchMealDetails(String id) async {
    return _services.fetchMealDetails(id);
  }
}