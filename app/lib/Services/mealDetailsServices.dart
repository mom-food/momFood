import 'dart:convert';

import '../Model/mealDetailsModel.dart';
import 'package:http/http.dart' as http;

class MealDetailsServices {
  static const url = "http://10.0.2.2:3000/api/meals/";

  Future<MealDetailsModel> fetchMealDetails(String id) async {
    final String completeUrl = url+id;
    final data = await _fetchDataFromServer(completeUrl);
    //print(data+'jana');

    if(data!=null) {
      return MealDetailsModel(
          id: data['_id'],
          name: data['name'] ?? 'Unknown',
          image: data['image'] ?? 'No image',
          description: data['description'] ?? 'No description',
          price: data['price'] ?? 0
      );
    }else{
      print('error');
    }
    return data;
  }

  Future<dynamic> _fetchDataFromServer(String completeUrl) async {
    try{
      final response = await http.get(Uri.parse(completeUrl));
      print(completeUrl);
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 404) {
        print('Resource not found');
      }
    }catch(e){
      print('Exception caught: $e');
    }
    return null;
  }
}