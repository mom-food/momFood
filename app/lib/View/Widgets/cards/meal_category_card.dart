import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MealCategoryCard extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  MealCategoryCard({required this.categoryName, required this.categoryId, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealList(categoryId: categoryId,),
          ),
        );*/
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Column(
              children: [
                Image.network(
                  categoryImage,
                  width: 300,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  child: Text(
                    categoryName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}