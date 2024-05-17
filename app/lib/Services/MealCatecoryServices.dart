import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/mealCategoryModel.dart';

class MealCategoryServices {
  static const url = "http://localhost:3000/api/categories";

  Future<List<MealCategory>> fetchAllMealCategories() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonCategory) => MealCategory.fromJson(jsonCategory)).toList();
      } else {
        throw Exception('Failed to load meal categories');
      }
    } catch (e) {
      rethrow;
    }
  }

}
