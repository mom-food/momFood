import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/meal_view_model.dart';
import '../../Model/meal_model.dart';
import '../Widgets/search-bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          CustomSearchBar(onSearch: (query) {
            Provider.of<MealViewModel>(context, listen: false).search(query);
          }),
          Expanded(
            child: Consumer<MealViewModel>(
              builder: (context, mealViewModel, child) {
                if (mealViewModel.meals.isEmpty) {
                  return Center(
                    child: Text('No meals found.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: mealViewModel.meals.length,
                    itemBuilder: (context, index) {
                      Meal meal = mealViewModel.meals[index];
                      return ListTile(
                        title: Text(meal.name),
                        subtitle: Text(meal.description),
                        leading: Image.network(meal.image),
                        trailing: Text('\$${meal.price.toString()}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

