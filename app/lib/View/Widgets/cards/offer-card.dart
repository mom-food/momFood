import 'dart:ffi';

import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class MealOfferCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String originalPrice;
  final double discountedPrice;

  MealOfferCard({
    required this.imagePath,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
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
                fit: BoxFit.cover,
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

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       originalPriceIconPath,
          //       width: 20,
          //       height: 20,
          //     ),
          //     SizedBox(width: 0),
          //     Text(
          //         originalPrice,
          //         style: TextStyle(
          //           color: AppColors.primary2,
          //         )
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       discountedPriceIconPath,
          //       width: 20,
          //       height: 20,
          //     ),
          //     SizedBox(width: 0),
          //     Text(
          //       discountedPrice,
          //       style: const TextStyle(
          //         decoration: TextDecoration.lineThrough,
          //         color: AppColors.primary1,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
