import 'package:flutter/material.dart';
import '../../Model/meal_category_model.dart';
import '../../Services/meal_catecory_services.dart';
import '../Widgets/cards/meal_category_card.dart';

class MealCategoryScreen extends StatefulWidget {
  @override
  _MealCategoryScreenState createState() => _MealCategoryScreenState();
}

class _MealCategoryScreenState extends State<MealCategoryScreen> {
  final MealCategoryServices _categoryServices = MealCategoryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            'الأصناف',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<MealCategory>>(
        future: _categoryServices.fetchAllMealCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meal categories found.'));
          } else {
            final mealCategories = snapshot.data!;
            return ListView.builder(
              itemCount: mealCategories.length,
              itemBuilder: (context, index) {
                final category = mealCategories[index];
                return MealCategoryCard(
                  categoryId: category.id,
                  categoryName: category.name,
                  categoryImage: category.image,
                );
              },
            );
          }
        },
      ),
    );
  }
}
