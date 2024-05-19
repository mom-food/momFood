import 'dart:convert';

import '../Model/mealDetailsModel.dart';
import 'package:http/http.dart' as http;

class MealDetailsServices {
  static const url = "http://10.0.2.2:3000/api/meals/";

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
          imageUrl: data['imageUrl'] ?? 'No imageUrl',
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