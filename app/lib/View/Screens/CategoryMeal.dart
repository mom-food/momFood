import 'package:flutter/material.dart';
import '../../Model/mealCategoryModel.dart';
import '../../Services/MealCatecoryServices.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'الأصناف',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
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
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Column(
                    children: [
                      Image.network(
                        category.image,
                        width: 300,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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