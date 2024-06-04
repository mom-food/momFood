import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Model/meal_model.dart';
import '../../Services/meal_services.dart';
import '../Widgets/cards/meal_card.dart';

class MealList extends StatelessWidget {
  final String categoryId;

  MealList({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
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
                  onTap: () {
                    context.go("/mealDetailsScreen/${meal.id}");
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
