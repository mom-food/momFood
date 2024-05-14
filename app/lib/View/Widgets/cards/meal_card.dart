import 'package:app/colors.dart';
import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 192,
      decoration: BoxDecoration(
        color: AppColors.backgroundColorLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 8,
          color: AppColors.backgroundColorLight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary2,
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            right: 8,
            top: 6,
            child: Container(
              width: 101,
              height: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://s3-media0.fl.yelpcdn.com/bphoto/E9_oGtysbU9xXX1aeVxoig/o.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 56,
            top: 136,
            child: Container(
              width: 10,
              height: 12,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRa4xaPQAo3oj2JwqaFHV2oxB27mk5SB11LQ3RCtoF-Vg&s"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 11,
            top: 144,
            child: SizedBox(
              width: 57,
              height: 24,
              child: Text(
                '15',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primary1,
                  fontSize: 20,
                  fontFamily: 'FontMAIN', // Use the same family name declared in pubspec.yaml
                  fontWeight: FontWeight.bold,
                  height: 0.05,
                ),
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: 114,
            child: Text(
              'بيتزا الخضار',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'FontMAIN',
                fontWeight: FontWeight.bold,
                height: 0.17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
