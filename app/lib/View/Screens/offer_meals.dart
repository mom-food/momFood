import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import '../../colors.dart';
import '../Widgets/cards/meal_offer_card.dart';
import '../Widgets/search-bar.dart';
import 'category_meal.dart';

class MealOfferScreen extends StatelessWidget {
  const MealOfferScreen({super.key});

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
                const SizedBox(height: 10),
                const Text(
                  'العروضات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: AppColors.textColor1,
                  ),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10), // Adjust the height to fit your design
                Container(
                  height: MediaQuery.of(context).size.height - 300, // Adjust this value based on your layout
                  child: const MealCategoryScreen(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
