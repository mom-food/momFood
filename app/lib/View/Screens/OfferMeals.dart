import 'package:flutter/material.dart';
import '../Widgets/cards/meal_offer_card.dart';

class MealOfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'العروضات',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // هذا السطر يحذف زر العودة
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MealOfferCard(
              imagePath: 'assets/images/Onboarding1.png',
              title: 'معجنات خبز',
              originalPrice: '10',
              discountedPrice: '55',
              originalPriceIconPath: 'assets/images/icon-shekel.png',
              discountedPriceIconPath: 'assets/images/icon-shekel.png',
            ),
            SizedBox(width: 20),
            MealOfferCard(
              imagePath: 'assets/images/Onboarding1.png',
              title: 'معجنات خبز',
              originalPrice: '10',
              discountedPrice: '55',
              originalPriceIconPath: 'assets/images/icon-shekel.png',
              discountedPriceIconPath: 'assets/images/icon-shekel.png',
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import '../Widgets/cards/meal_offer_card.dart';
//
// class MealOfferScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               'العروضات',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 26,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             MealOfferCard(
//               imagePath: 'assets/images/Onboarding1.png',
//               title: 'معجنات خبز',
//               originalPrice: '10',
//               discountedPrice: '55',
//               originalPriceIconPath: 'assets/images/icon-shekel.png',
//               discountedPriceIconPath: 'assets/images/icon-shekel.png',
//             ),
//             SizedBox(width: 20),
//             MealOfferCard(
//               imagePath: 'assets/images/Onboarding1.png',
//               title: 'معجنات خبز',
//               originalPrice: '10',
//               discountedPrice: '55',
//               originalPriceIconPath: 'assets/images/icon-shekel.png',
//               discountedPriceIconPath: 'assets/images/icon-shekel.png',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
