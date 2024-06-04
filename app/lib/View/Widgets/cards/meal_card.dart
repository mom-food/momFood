import 'package:flutter/material.dart';
import '../../../Model/meal-model.dart';
import '../../../colors.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                meal.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              meal.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'FontMAIN',
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${meal.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primary1,
                    fontFamily: 'FontMAIN',
                  ),
                ),
                Flexible(
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRa4xaPQAo3oj2JwqaFHV2oxB27mk5SB11LQ3RCtoF-Vg&s",
                    width: 10,
                    height: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
