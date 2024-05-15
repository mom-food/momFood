import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Meal {
  final String name;
  final double price;
  final String category;
  final String imagePath;

  Meal({required this.name, required this.price, required this.category,required this.imagePath,});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      price: double.parse(json['price']),
      category: json['category'],
      imagePath: json['imagePath'],

    );
  }
}

Future<List<Meal>> fetchMeals() async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/api/meals/'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Meal.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load meals');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Offer Section'),
        ),
        body: Center(
          child: FutureBuilder<List<Meal>>(
            future: fetchMeals(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final meal = snapshot.data![index];
                    // Assuming 10% discount
                    final discountedPrice = meal.price * 0.9;
                    return ListTile(
                      title: Text(meal.name),
                      subtitle: Text(
                          'Original Price: \$${meal.price}\nDiscounted Price: \$${discountedPrice.toStringAsFixed(2)}'),
                      // Other UI elements for category, image, etc.
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
