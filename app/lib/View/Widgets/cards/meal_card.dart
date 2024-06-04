import 'package:flutter/material.dart';
import '../../../Model/meal_model.dart';
import '../../../colors.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback? onTap;

  const MealCard({Key? key, required this.meal, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${meal.price.toStringAsFixed(2)}", // Corrected string interpolation
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
            ),
            ),
        );
    }
}