import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/mealCategoryModel.dart';
import '../Widgets/cards/meal_category_card.dart';

class MealCategoryScreen extends StatelessWidget {
  final List<String> categories = [
    'معجنات',
    'وجبات سريعة',
    'مشروبات',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'العروضات',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return MealCategoryCard(
            categoryName: categories[index],
          );
        },
      ),
    );
  }
}