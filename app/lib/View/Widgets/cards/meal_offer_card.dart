import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealOfferCard extends StatelessWidget {
  final String mealId;
  final String imageUrl;
  final String title;
  final String originalPrice;
  final String discountedPrice;

  MealOfferCard({
    required this.mealId,
    required this.imageUrl,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.go("/meals/${mealId}");
        },
        child: Container(
          width: 100,
          height: 220,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 85,
                height: 85,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipOval(
                    child: FadeInImage(
                      image: NetworkImage(imageUrl),
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                constraints: const BoxConstraints(minHeight: 60, maxHeight: 60),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "₪ $originalPrice",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,

                  color: AppColors.primary2,
                ),
              ),
              Text(
                "₪ $discountedPrice",
                style: const TextStyle(
                  color: AppColors.primary1,
                ),
              ),
            ],
          ),
        ));
  }
}
