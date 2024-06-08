import 'package:app/View/Screens/category_meal.dart';
import 'package:app/View/Widgets/search-bar.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/cards/meal_offer_card.dart';

class MealOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
        return RefreshIndicator(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSearchBar(onSearch: (string) {
                      viewModel.search(string);
                    }),
                    Text(
                      'العروضات',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...viewModel
                              .getFilteredMeals()
                              .map((meal) => MealOfferCard(
                            title: meal.name,
                            mealId: meal.id,
                            imageUrl: meal.image,
                            originalPrice: meal.price.toStringAsFixed(2),
                            discountedPrice:
                            (meal.price * 0.8).toStringAsFixed(2),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 10), // Adjust the height to fit your design
                    Container(
                      height: MediaQuery.of(context).size.height - 300, // Adjust this value based on your layout
                      child: MealCategoryScreen(),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            onRefresh: () async {
              await viewModel.refresh();
            });
      }),
    );
  }
}

