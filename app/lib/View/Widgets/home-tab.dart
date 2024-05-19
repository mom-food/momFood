import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/meal_view_model.dart';
import '../Screens/Home.dart'; // تأكد من استيراد النموذج المناسب هنا

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomSearchBar(
              onSearch: (query) {
                Provider.of<MealViewModel>(context, listen: false).search(query);
              },
            ),
            Expanded(
              child: Consumer<MealViewModel>(
                builder: (context, mealViewModel, child) {
                  if (mealViewModel.meals.isEmpty) {
                    return Center(
                      child: Text('No meals found.'),
                    );
                  } else {
                    return GridView.count(
                      children: mealViewModel.meals.map((meal) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(meal.image, fit: BoxFit.cover),
                                ),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                              ),
                              Text(meal.name),
                              Text(meal.description),
                              Text(
                                '\$${meal.price.toString()}',
                                //Strikethrough
                                style: TextStyle(decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.orange, width: 1),
                          ),
                          alignment: Alignment.center,
                        );
                      }).toList(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 30,
                      padding: const EdgeInsets.all(30),
                      mainAxisSpacing: 30,
                      childAspectRatio: 1 / 3,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
