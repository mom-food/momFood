import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:app/View/Widgets/search-bar.dart';
import '../Widgets/cards/meal_offer_card.dart';
import 'category_meal.dart';

class MealOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await viewModel.refresh();
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
              children: [
                CustomSearchBar(onSearch: (string) {
                  viewModel.search(string);
                }),
                SizedBox(height: 10), // Add some space between the search bar and the text
                Text(
                  'العروضات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 10), // Add some space between the text and the horizontal list
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ...viewModel.getFilteredMeals().map(
                            (meal) => MealOfferCard(
                          title: meal.name,
                          mealId: meal.id,
                          imageUrl: meal.image,
                          originalPrice: meal.price.toStringAsFixed(2),
                          discountedPrice:
                          (meal.price * 0.8).toStringAsFixed(2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10), // Adjust the height to fit your design
                Container(
                  height: MediaQuery.of(context).size.height - 300, // Adjust this value based on your layout
                  child: MealCategoryScreen(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
