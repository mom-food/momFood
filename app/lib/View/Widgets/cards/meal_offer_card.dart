

import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class MealOfferCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final String originalPriceIconPath;
  final String discountedPriceIconPath;

  MealOfferCard({
    required this.imagePath,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.originalPriceIconPath,
    required this.discountedPriceIconPath,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 190,
      margin: const EdgeInsets.fromLTRB(0, 0, 20, 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
                width: 85,
                height: 85,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                originalPriceIconPath,
                fit: BoxFit.fill,
                width: 10,
                height: 10,
              ),
              SizedBox(width: 0),
              Text(
                  originalPrice,
                  style: TextStyle(
                    color: AppColors.primary2,
                  )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                discountedPriceIconPath,
                fit: BoxFit.cover,
                width: 10,
                height: 10,
              ),
              SizedBox(width: 0),
              Text(
                discountedPrice,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.primary1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}