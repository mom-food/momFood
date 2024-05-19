import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import '../../Model/MealModel.dart';
import '../../Services/MealServices.dart';
import '../Widgets/cards/meal_card.dart';
import '../Screens/FoodDetails.dart';

import 'package:flutter/material.dart';
import '../../Model/MealModel.dart'; // Ensure this model has all needed properties.
import '../../Services/MealServices.dart';
import '../Widgets/cards/meal_card.dart';


class MealList extends StatelessWidget {
  final String categoryId;

  MealList({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Meal>>(
        future: fetchMealsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals found.'));
          } else {
            final meals = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 40.0,
                childAspectRatio: 0.7,
              ),
              padding: EdgeInsets.all(35.0),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return MealCard(
                  meal: meal,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailsPage(mealId: meal.id),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
