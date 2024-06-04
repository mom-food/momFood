import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/meal_category_model.dart';

class MealCategoryServices {
  static const url = "http://10.0.2.2:3000/api/categories";

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