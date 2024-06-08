import 'dart:convert';

import '../Model/meal_details_model.dart';
import 'package:http/http.dart' as http;

class MealDetailsServices {
  static const url = "https://momfood.onrender.com/api/meals/";

  Future<MealDetailsModel> fetchMealDetails(String id) async {
    final String completeUrl = url + id;
    try {
      final response = await http.get(Uri.parse(completeUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Response: $data');  // Debugging line to print API response
        return MealDetailsModel(
          id: data['_id'] ?? '',
          name: data['name'] ?? 'Unknown',
          image: data['image'] ?? 'No image',

          description: data['description'] ?? 'No description',
          price: (data['price'] ?? 0).toDouble(),
        );
      } else {
        throw Exception('Failed to load meal details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception caught while fetching meal details: $e');
    }
  }
}