import 'package:flutter/cupertino.dart';


class MealCategoryCard extends StatelessWidget {
  final String categoryName;

  MealCategoryCard({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Column(
        children: [
          Image.asset(
            'assets/images/X.png',
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
          )
        ],
      ),
    );
  }
}