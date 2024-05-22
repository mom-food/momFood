import 'package:app/View/Screens/CategoryMeal.dart';
import 'package:app/View/Screens/Home.dart';
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
        automaticallyImplyLeading: false, // هذا السطر يحذف زر العودة
      ),
      body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
        return RefreshIndicator(
            child: Directionality(
              textDirection: TextDirection.rtl,
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
                        ElevatedButton(
                            onPressed: () {
                              viewModel.refresh();
                            },
                            child: Text("click me")),
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
                  SizedBox(height: 0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0), // ضبط الحشو الداخلي
                      child: MealCategoryScreen(),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            onRefresh: () async {
              await viewModel.refresh();
            });
      }),
    );
  }
}
